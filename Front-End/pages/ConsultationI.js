import React, { useEffect, useState } from 'react';
import { FaEye, FaChevronLeft, FaChevronRight } from 'react-icons/fa';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar';
import UserMenu from '../components/UserMenu';
import LoadingScreen from '../components/loading';

const ConsultationI = () => {
  const [entries, setEntries] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [minimumLoadTimePassed, setMinimumLoadTimePassed] = useState(false);
  const itemsPerPage = 5;

  useEffect(() => {
    const timer = setTimeout(() => {
      setMinimumLoadTimePassed(true);
    }, 2000);

    const fetchEntries = async () => {
      try {
        const response = await fetch('http://localhost/accounext/entries.php');
        const json = await response.json();
        
        if (json.success) {
          setEntries(json.data);
        } else {
          console.error(json.error);
        }
      } catch (error) {
        console.error('Fetch error:', error);
      } finally {
        if (minimumLoadTimePassed) {
          setLoading(false);
        }
      }
    };

    fetchEntries();

    return () => clearTimeout(timer);
  }, [minimumLoadTimePassed]);
  const groupedEntries = entries.reduce((acc, entry) => {
    const key = entry.journal_entry_id || `manual-${entry.id}`;
    if (!acc[key]) acc[key] = [];
    acc[key].push(entry);
    return acc;
  }, {});

  const groupedArray = Object.entries(groupedEntries);
  const totalPages = Math.ceil(groupedArray.length / itemsPerPage);
  const paginatedGroups = groupedArray.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  const goToPrevious = () => currentPage > 1 && setCurrentPage(currentPage - 1);
  const goToNext = () => currentPage < totalPages && setCurrentPage(currentPage + 1);
  const showContent = !loading && minimumLoadTimePassed;

  if (!showContent) {
    return (
      <div className="flex min-h-screen bg-[#f2f1ec]">
        <Navbar />
        <UserMenu />
        <LoadingScreen/>
      </div>
    );
  }

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-6 md:p-8">
          <div className="max-w-7xl mx-auto">
                        <div className="text-center mb-10">
              <h1 className="text-3xl font-bold text-[#083344] mb-2">Consultation des Écritures</h1>
              <div className="w-1/2 h-1 bg-[#083344] bg-opacity-30 mx-auto rounded-full"></div>
            </div>
            
            <ConsultationNavbar />
            
                        <div className="mt-8 space-y-8">
              {paginatedGroups.length === 0 ? (
                <div className="text-center py-12 bg-white rounded-xl shadow-sm border border-gray-200">
                  <p className="text-gray-500 text-lg">Aucune écriture trouvée</p>
                </div>
              ) : (
                paginatedGroups.map(([groupId, records]) => {
                  const firstRecord = records[0];
                  const totalDebit = records
                    .filter(r => r.type === 'debit')
                    .reduce((sum, r) => sum + parseFloat(r.montant), 0);
                  const totalCredit = records
                    .filter(r => r.type === 'credit')
                    .reduce((sum, r) => sum + parseFloat(r.montant), 0);
                  const isBalanced = totalDebit.toFixed(2) === totalCredit.toFixed(2);

                  return (
                    <div key={groupId} className="bg-white rounded-xl shadow-sm overflow-hidden border border-gray-200">
                                            <div className="bg-[#083344] text-white p-4 flex justify-between items-center">
                        <div>
                          <h3 className="font-semibold">{firstRecord.libelle || 'Écriture sans libellé'}</h3>
                          <p className="text-sm opacity-80">{firstRecord.date_operation || 'Date inconnue'}</p>
                        </div>
                        {firstRecord.justification ? (
                          <a
                            href={`http://localhost/accounext/${firstRecord.justification}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-2 bg-white text-[#083344] px-3 py-1.5 rounded-md text-sm font-medium hover:bg-gray-100 transition-colors"
                          >
                            <FaEye className="text-[#083344]" />
                            Voir justification
                          </a>
                        ) : (
                          <span className="text-sm opacity-80">Aucune justification</span>
                        )}
                      </div>

                                            <div className="overflow-x-auto">
                        <table className="min-w-full divide-y divide-gray-200">
                          <thead className="bg-gray-50">
                            <tr>
                              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                N° Compte
                              </th>
                              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Nom Compte
                              </th>
                              <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Débit (MAD)
                              </th>
                              <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                Crédit (MAD)
                              </th>
                            </tr>
                          </thead>
                          <tbody className="bg-white divide-y divide-gray-200">
                            {records.map((entry, index) => (
                              <tr key={index} className="hover:bg-gray-50 transition-colors">
                                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                  {entry.compteNum}
                                </td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                  {entry.compteNom}
                                </td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-right font-mono">
                                  {entry.type === 'debit' ? parseFloat(entry.montant).toFixed(2) : '-'}
                                </td>
                                <td className="px-6 py-4 whitespace-nowrap text-sm text-right font-mono">
                                  {entry.type === 'credit' ? parseFloat(entry.montant).toFixed(2) : '-'}
                                </td>
                              </tr>
                            ))}
                          </tbody>
                                                    <tfoot className="bg-gray-50">
                            <tr>
                              <td colSpan="2" className="px-6 py-3 text-sm font-medium text-gray-900 text-right">
                                Totaux:
                              </td>
                              <td className="px-6 py-3 text-sm font-mono text-right">
                                {totalDebit.toFixed(2)}
                              </td>
                              <td className="px-6 py-3 text-sm font-mono text-right">
                                {totalCredit.toFixed(2)}
                              </td>
                            </tr>
                            <tr className={isBalanced ? 'bg-green-50' : 'bg-red-50'}>
                              <td colSpan="2" className="px-6 py-3 text-sm font-medium text-gray-900 text-right">
                                Équilibre:
                              </td>
                              <td colSpan="2" className={`px-6 py-3 text-sm font-mono text-center font-medium ${
                                isBalanced ? 'text-green-600' : 'text-red-600'
                              }`}>
                                {isBalanced ? 'Équilibré' : 'Non équilibré'}
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  );
                })
              )}
            </div>

                        {totalPages > 1 && (
              <div className="mt-8 flex items-center justify-between">
                <button
                  onClick={goToPrevious}
                  disabled={currentPage === 1}
                  className="flex items-center gap-2 px-4 py-2 border border-[#083344] rounded-md text-[#083344] disabled:opacity-50 disabled:cursor-not-allowed hover:bg-[#083344] hover:text-white transition-colors"
                >
                  <FaChevronLeft />
                  Précédent
                </button>
                <span className="text-sm text-gray-600">
                  Page <span className="font-medium">{currentPage}</span> sur <span className="font-medium">{totalPages}</span>
                </span>
                <button
                  onClick={goToNext}
                  disabled={currentPage === totalPages}
                  className="flex items-center gap-2 px-4 py-2 border border-[#083344] rounded-md text-[#083344] disabled:opacity-50 disabled:cursor-not-allowed hover:bg-[#083344] hover:text-white transition-colors"
                >
                  Suivant
                  <FaChevronRight />
                </button>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConsultationI;