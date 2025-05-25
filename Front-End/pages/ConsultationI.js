import React, { useEffect, useState } from 'react';
import { FaEye } from 'react-icons/fa';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar';
import UserMenu from '../components/UserMenu';

const ConsultationI = () => {
  const [entries, setEntries] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    fetch('http://localhost:8000/entries.php')
      .then(res => res.json())
      .then(json => {
        if (json.success) {
          setEntries(json.data);
        } else {
          console.error(json.error);
        }
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  // Group entries by journal_entry_id
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

  const goToPrevious = () => {
    if (currentPage > 1) setCurrentPage(currentPage - 1);
  };

  const goToNext = () => {
    if (currentPage < totalPages) setCurrentPage(currentPage + 1);
  };

  if (loading) return <div className="p-8 text-center">Chargement…</div>;

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10" />
          <ConsultationNavbar />

          {paginatedGroups.map(([groupId, records]) => {
            const first = records[0];
            return (
              <div key={groupId} className="border border-[#083344] mt-10 rounded-xl overflow-x-auto shadow-lg mb-10">
                <table className="w-full text-left border-collapse">
                  <thead>
                    <tr>
                      <th className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">
                        {first.libelle || 'Libellé'}
                      </th>
                      <th colSpan="2" className="px-4 py-3 text-center border border-[#083344] bg-gray-200 text-gray-700">
                        {first.compteNom || 'Nom du compte'}
                      </th>
                      <th colSpan="2" className="px-4 py-3 text-center border border-[#083344] bg-gray-200 text-gray-700">
                        {first.justification ? (
                          <a
                            href={`http://localhost/${first.justification}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="w-full inline-flex items-center justify-center text-white bg-[#083344] px-4 py-2 rounded-md hover:bg-[#083344e1] transition-colors"
                          >
                            <FaEye className="mr-2" />
                            Afficher Justification
                          </a>
                        ) : (
                          <span className="text-sm text-gray-500">Aucune justification</span>
                        )}
                      </th>
                    </tr>
                    <tr>
                      <th className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">
                        Date
                      </th>
                      <th colSpan="4" className="px-4 py-2 text-center border border-[#083344] bg-gray-200 text-gray-700">
                        {first.date_operation || 'DD / MM / YYYY'}
                      </th>
                    </tr>
                    <tr>
                      <th rowSpan="2" className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">
                        N° du compte
                      </th>
                      <th rowSpan="2" className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">
                        Nom du compte
                      </th>
                      <th colSpan="2" className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">
                        Montant
                      </th>
                    </tr>
                    <tr>
                      <th className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">Débit</th>
                      <th className="px-4 py-2 bg-gray-200 text-gray-700 text-center border border-[#f2f1ec]">Crédit</th>
                    </tr>
                  </thead>
                  <tbody>
                    {records.map((entry, i) => (
                      <tr key={i} className="bg-white border-t border-[#083344] hover:bg-[#f9fafb]">
                        <td className="px-4 py-3 border-[#083344]">{entry.compteNum}</td>
                        <td className="px-4 py-3 border-[#083344]">{entry.compteNom}</td>
                        <td className="px-4 py-3 border-[#083344] text-center">
                          {entry.type === 'debit' ? `${entry.montant} MAD` : ''}
                        </td>
                        <td className="px-4 py-3 border-[#083344] text-center">
                          {entry.type === 'credit' ? `${entry.montant} MAD` : ''}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            );
          })}

          {/* Pagination Controls */}
          <div className="flex justify-center mt-6 space-x-4">
            <button
              onClick={goToPrevious}
              disabled={currentPage === 1}
              className="px-4 py-2 bg-[#083344] text-white rounded disabled:opacity-50"
            >
              Précédent
            </button>
            <span className="self-center text-[#083344] font-medium">
              Page {currentPage} sur {totalPages}
            </span>
            <button
              onClick={goToNext}
              disabled={currentPage === totalPages}
              className="px-4 py-2 bg-[#083344] text-white rounded disabled:opacity-50"
            >
              Suivant
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConsultationI;
