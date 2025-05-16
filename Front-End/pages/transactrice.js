import ConsultationNavbar from './ConsultationNavbar';
import Navbar from '../components/navbar';
import { FaSearch } from 'react-icons/fa';
import { useState, useEffect } from 'react';
import axios from 'axios';

export default function Transactrice() {
  const [showSearchInput, setShowSearchInput] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [transactions, setTransactions] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [filterDate, setFilterDate] = useState('');

  const toggleSearchInput = () => {
    setShowSearchInput(!showSearchInput);
    if (showSearchInput) {
      setSearchTerm('');
    }
  };

  useEffect(() => {
    const fetchTransactions = async () => {
      try {
        setLoading(true);
        const response = await axios.get("http://localhost/accounext/transactrice.php");
        setTransactions(response.data.data || []);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchTransactions();
  }, []);

  const filteredData = transactions.filter((row) => {
    const matchesSearch = row.libelle?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         row.montant?.toString().includes(searchTerm);
    
    const matchesDate = !filterDate || row.date_operation === filterDate;
    
    return matchesSearch && matchesDate;
  });

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <div className="flex-1 overflow-y-auto ml-64">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

          <ConsultationNavbar />
          
          <div className="flex items-center gap-4 mb-6 flex-wrap">
            <div className="flex items-center gap-2">
              <input
                type="date"
                className="px-3 py-2 border border-[#002c3c] rounded-lg text-[#002c3c] focus:outline-none focus:ring-1 focus:ring-[#002c3c]"
                value={filterDate}
                onChange={(e) => setFilterDate(e.target.value)}
              />
              <button
                className="text-[#002c3c] hover:text-[#001a23] px-2 py-1 rounded-lg transition-colors duration-200"
                onClick={() => setFilterDate('')}
              >
                Effacer
              </button>
            </div>
          
            <div className="flex items-center gap-2 ml-auto">
              {showSearchInput && (
                <input
                  type="text"
                  placeholder="Recherche par libellé ou montant"
                  className="px-3 py-2 border border-[#002c3c] rounded-lg text-[#002c3c] w-64 focus:outline-none focus:ring-1 focus:ring-[#002c3c]"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
              )}
              <button 
                className="bg-[#002c3c] hover:bg-[#001a23] text-white px-4 py-2 rounded-lg flex items-center gap-2 transition-colors duration-200"
                onClick={toggleSearchInput}
              >
                <FaSearch /> Recherche
              </button>
            </div>
          </div>

          {error && (
            <div className="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded">
              Erreur: {error}
            </div>
          )}

          {loading ? (
            <div className="text-center py-8">
              <p>Chargement des données...</p>
            </div>
          ) : (
            <div className="overflow-x-auto rounded-lg shadow-md">
              <table className="min-w-full border-collapse">
                <thead className="bg-gray-200">
                  <tr>
                    <th className="px-6 py-4 text-left font-semibold text-gray-700 uppercase tracking-wider border-b border-gray-300 w-[20%]">
                      Date
                    </th>
                    <th className="px-6 py-4 text-left font-semibold text-gray-700 uppercase tracking-wider border-b border-gray-300 w-[60%]">
                      Libellé
                    </th>
                    <th className="px-6 py-4 text-center font-semibold text-gray-700 uppercase tracking-wider border-b border-gray-300 w-[20%]">
                      Montant
                    </th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {filteredData.length > 0 ? (
                    filteredData.map((row) => (
                      <tr key={row.id} className="hover:bg-gray-50 transition-colors duration-150">
                        <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 border-b border-gray-200">
                          {row.date_operation}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-700 border-b border-gray-200">
                          {row.libelle}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-700 border-b border-gray-200 font-mono">
                          {parseFloat(row.montant).toFixed(2)}
                        </td>
                      </tr>
                    ))
                  ) : (
                    <tr>
                      <td colSpan="3" className="text-center p-4 text-gray-500">
                        {searchTerm || filterDate ? "Aucun résultat trouvé" : "Aucune donnée disponible"}
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}