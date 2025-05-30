import React, { useState, useEffect } from 'react';
import { FaEye, FaFilter, FaSearch, FaChevronLeft, FaChevronRight } from 'react-icons/fa';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar';
import UserMenu from '../components/UserMenu';
import LoadingScreen from '../components/loading';

const ConsultationII = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [comptes, setComptes] = useState([]);
  const [classes, setClasses] = useState([]);
  const [selectedClass, setSelectedClass] = useState('');
  const [loading, setLoading] = useState(true);
  const [minimumLoadTimePassed, setMinimumLoadTimePassed] = useState(false);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;
  useEffect(() => {
    const timer = setTimeout(() => {
      setMinimumLoadTimePassed(true);
    }, 2000);

    fetch('http://localhost/accounext/get_classes.php')
      .then(res => res.json())
      .then(data => {
        setClasses(data);
      })
      .catch(err => console.error('Error fetching classes:', err));

    return () => clearTimeout(timer);
  }, []);
  useEffect(() => {
    let url = 'http://localhost/accounext/get_comptes.php';
    if (selectedClass) {
      url += `?class_id=${selectedClass}`;
    }

    setLoading(true);
    fetch(url)
      .then(res => res.json())
      .then(data => {
        setComptes(data);
        setCurrentPage(1);
      })
      .catch(err => {
        setError('Impossible de charger les données');
        console.error('Error fetching comptes:', err);
      })
      .finally(() => {
        if (minimumLoadTimePassed) {
          setLoading(false);
        }
      });
  }, [selectedClass, minimumLoadTimePassed]);
  const filteredData = comptes.filter(
    (item) =>
      item.NumeroCompte.includes(searchTerm) ||
      item.NomCompte.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const paginatedData = filteredData.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  const paginate = (pageNumber) => setCurrentPage(pageNumber);

  const getPaginationNumbers = () => {
    const pages = [];
    const maxVisiblePages = 5;
    
    if (totalPages <= maxVisiblePages) {
      for (let i = 1; i <= totalPages; i++) {
        pages.push(i);
      }
    } else {
      pages.push(1);
      
      let start = Math.max(2, currentPage - 1);
      let end = Math.min(totalPages - 1, currentPage + 1);
      
      if (currentPage <= 3) {
        end = 4;
      } else if (currentPage >= totalPages - 2) {
        start = totalPages - 3;
      }
      
      if (start > 2) pages.push('...');
      for (let i = start; i <= end; i++) pages.push(i);
      if (end < totalPages - 1) pages.push('...');
      
      pages.push(totalPages);
    }
    
    return pages;
  };
  const showContent = !loading && minimumLoadTimePassed;

  if (!showContent) {
    return (
      <div className="flex min-h-screen bg-[#f2f1ec]">
        <Navbar />
        <UserMenu />
        <LoadingScreen />
      </div>
    );
  }

  if (error) return <div className="text-red-500 p-4">{error}</div>;

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-6 md:p-8">
          <div className="max-w-7xl mx-auto">
                        <div className="text-center mb-10">
              <h1 className="text-3xl font-bold text-[#083344] mb-2">Consultation des Comptes</h1>
              <div className="w-1/2 h-1 bg-[#083344] bg-opacity-30 mx-auto rounded-full"></div>
            </div>

            <ConsultationNavbar />

                        <div className="flex flex-col md:flex-row items-center justify-between gap-4 mt-8 mb-6">
                            <div className="relative w-full md:w-auto">
                <label className="block text-sm font-medium text-gray-700 mb-1">Filtrer par Classe</label>
                <select
                  value={selectedClass}
                  onChange={(e) => setSelectedClass(e.target.value)}
                  className="block w-full pl-3 pr-10 py-2 text-base border border-[#002c3c] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#083344] sm:text-sm"
                >
                  <option value="">Toutes les classes</option>
                  {classes.map((cls) => (
                    <option key={cls.id} value={cls.id}>
                      {cls.nom}
                    </option>
                  ))}
                </select>
              </div>

                            <div className="relative w-full md:w-64">
                <label className="block text-sm font-medium text-gray-700 mb-1">Rechercher</label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <FaSearch className="text-gray-400" />
                  </div>
                  <input
                    type="text"
                    placeholder="N° ou Nom du compte"
                    value={searchTerm}
                    onChange={(e) => {
                      setSearchTerm(e.target.value);
                      setCurrentPage(1);
                    }}
                    className="block w-full pl-10 pr-3 py-2 border border-[#002c3c] rounded-lg text-[#002c3c] focus:outline-none focus:ring-2 focus:ring-[#083344] sm:text-sm"
                  />
                </div>
              </div>
            </div>

                        <div className="bg-white rounded-xl shadow-sm overflow-hidden border border-gray-200">
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-200">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        N° du Compte
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Nom du Compte
                      </th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Débit (€)
                      </th>
                      <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Crédit (€)
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {paginatedData.length > 0 ? (
                      paginatedData.map((item, index) => (
                        <tr key={index} className="hover:bg-gray-50 transition-colors">
                          <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                            {item.NumeroCompte}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                            {item.NomCompte}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap text-sm text-right font-mono">
                            {parseFloat(item.debit).toLocaleString('fr-FR', { minimumFractionDigits: 2 })}
                          </td>
                          <td className="px-6 py-4 whitespace-nowrap text-sm text-right font-mono">
                            {parseFloat(item.credit).toLocaleString('fr-FR', { minimumFractionDigits: 2 })}
                          </td>
                        </tr>
                      ))
                    ) : (
                      <tr>
                        <td colSpan="4" className="px-6 py-4 text-center text-sm text-gray-500">
                          {searchTerm || selectedClass ? "Aucun compte trouvé" : "Aucune donnée disponible"}
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>

                            {filteredData.length > itemsPerPage && (
                <div className="bg-gray-50 px-6 py-3 flex items-center justify-between border-t border-gray-200">
                  <div className="flex-1 flex justify-between sm:hidden">
                    <button
                      onClick={() => paginate(Math.max(1, currentPage - 1))}
                      disabled={currentPage === 1}
                      className="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 disabled:opacity-50"
                    >
                      Précédent
                    </button>
                    <button
                      onClick={() => paginate(Math.min(totalPages, currentPage + 1))}
                      disabled={currentPage === totalPages}
                      className="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 disabled:opacity-50"
                    >
                      Suivant
                    </button>
                  </div>
                  <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                      <p className="text-sm text-gray-700">
                        Affichage de <span className="font-medium">{(currentPage - 1) * itemsPerPage + 1}</span> à{' '}
                        <span className="font-medium">
                          {Math.min(currentPage * itemsPerPage, filteredData.length)}
                        </span>{' '}
                        sur <span className="font-medium">{filteredData.length}</span> comptes
                      </p>
                    </div>
                    <div>
                      <nav className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                        <button
                          onClick={() => paginate(1)}
                          disabled={currentPage === 1}
                          className="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                        >
                          <span className="sr-only">Première page</span>
                          <FaChevronLeft className="h-3 w-3" />
                          <FaChevronLeft className="h-3 w-3 -ml-1" />
                        </button>
                        <button
                          onClick={() => paginate(Math.max(1, currentPage - 1))}
                          disabled={currentPage === 1}
                          className="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                        >
                          <span className="sr-only">Précédent</span>
                          <FaChevronLeft className="h-3 w-3" />
                        </button>

                        {getPaginationNumbers().map((page, index) => (
                          <button
                            key={index}
                            onClick={() => typeof page === 'number' ? paginate(page) : null}
                            disabled={page === '...'}
                            className={`relative inline-flex items-center px-4 py-2 border text-sm font-medium ${
                              currentPage === page
                                ? 'z-10 bg-[#083344] border-[#083344] text-white'
                                : 'bg-white border-gray-300 text-gray-700 hover:bg-gray-50'
                            } ${page === '...' ? 'cursor-default' : ''}`}
                          >
                            {page}
                          </button>
                        ))}

                        <button
                          onClick={() => paginate(Math.min(totalPages, currentPage + 1))}
                          disabled={currentPage === totalPages}
                          className="relative inline-flex items-center px-2 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                        >
                          <span className="sr-only">Suivant</span>
                          <FaChevronRight className="h-3 w-3" />
                        </button>
                        <button
                          onClick={() => paginate(totalPages)}
                          disabled={currentPage === totalPages}
                          className="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50"
                        >
                          <span className="sr-only">Dernière page</span>
                          <FaChevronRight className="h-3 w-3" />
                          <FaChevronRight className="h-3 w-3 -ml-1" />
                        </button>
                      </nav>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConsultationII;