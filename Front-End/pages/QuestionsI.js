import React, { useEffect, useState } from 'react';
import { FaEye, FaFilter, FaSearch } from 'react-icons/fa';
import { FaEquals } from 'react-icons/fa6';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar';
import UserMenu from '../components/UserMenu';

const ConsultationI = () => {
  const [transactions, setTransactions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterDate, setFilterDate] = useState('');

  // Fetch transactions
  useEffect(() => {
    const fetchTransactions = async () => {
      try {
        let url = 'http://localhost:8000/get_transactions.php';

        const queryParams = new URLSearchParams();
        if (searchTerm) queryParams.append('search', searchTerm);
        if (filterDate) queryParams.append('date', filterDate);
        
        url += '?' + queryParams.toString();

        const res = await fetch(url);
        const result = await res.json();

        if (result.success) {
          setTransactions(result.data);
          setLoading(false);
        } else {
          setError(result.message || 'Échec du chargement des données');
          setLoading(false);
        }
      } catch (err) {
        setError('Impossible de charger les transactions');
        setLoading(false);
        console.error(err);
      }
    };

    fetchTransactions();
  }, [searchTerm, filterDate]);

  if (loading) return <p>Chargement...</p>;
  if (error) return <p className="text-red-500">{error}</p>;

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

          {/* Top Nav */}
          <ConsultationNavbar />

          {/* Search / Filter */}
          <div className="flex justify-end items-center gap-4 mb-6">
            <div className="relative flex items-center">
              <span className="absolute left-3 text-[#002c3c]">
                <FaSearch />
              </span>
              <input
                type="text"
                placeholder="Rechercher par compte ou libellé"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10 pr-4 py-2 border border-[#002c3c] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#083344]"
              />
            </div>
            <input
              type="date"
              value={filterDate}
              onChange={(e) => setFilterDate(e.target.value)}
              className="px-4 py-2 border border-[#002c3c] rounded-lg"
            />
          </div>

          {/* First Table */}
          <div className="border border-[#083344] rounded-xl overflow-x-auto shadow-lg mb-8">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan="2">
                    Date
                  </th>
                  <th className="px-4 py-3 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan="3">
                    DD/MM/YYYY
                  </th>
                </tr>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    N° du compte
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Nom du compte
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan="2">
                    Montant
                  </th>
                </tr>
                <tr>
                  <th></th>
                  <th></th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Débit
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Crédit
                  </th>
                </tr>
              </thead>
              <tbody>
                {transactions.length > 0 ? (
                  transactions.map((row, idx) => (
                    <tr key={idx} className="bg-white border-t border-[#083344] hover:bg-[#f9fafb]">
                      <td className="px-4 py-3 border-r border-[#083344]">{row.compteNum}</td>
                      <td className="px-4 py-3 border-r border-[#083344]">{row.compteNom}</td>
                      <td className="px-4 py-3 border-r border-[#083344]">
                        {row.type === 'Débit' ? row.montant.toLocaleString('fr-FR') : ''}
                      </td>
                      <td className="px-4 py-3">
                        {row.type === 'Crédit' ? row.montant.toLocaleString('fr-FR') : ''}
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="4" className="text-center py-4 text-gray-500">
                      Aucune donnée trouvée.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>

            {/* Second Table */}
            <table className="w-full text-left border-collapse mt-0">
              <thead>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Libellé
                  </th>
                  <th className="px-4 py-3 text-center border border-[#083344] bg-[#08334443] text-[#083344]" colSpan="2">
                    XXXXXXXXXXXXX
                  </th>
                  <th className="px-4 py-3 text-center border border-[#083344] bg-[#08334443] text-[#083344]" colSpan="2">
                    <button className="w-full bg-[#083344] py-2 px-4 flex items-center justify-center text-white rounded-md hover:bg-[#0a475e] transition-colors">
                      <FaEye className="mr-2" /> Afficher Justification
                    </button>
                  </th>
                </tr>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Date
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#083344]" colSpan="4">
                    DD/MM/YYYY
                  </th>
                </tr>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan="2">
                    N° du compte
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan="2">
                    Nom du compte
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan="3">
                    Montant
                  </th>
                </tr>
                <tr>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Débit
                  </th>
                  <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">
                    Crédit
                  </th>
                </tr>
              </thead>
              <tbody>
                {transactions.length > 0 ? (
                  transactions.map((row, idx) => (
                    <tr key={idx} className="bg-white border-t border-[#083344] hover:bg-[#f9fafb]">
                      <td className="px-4 py-3 border-[#083344]">{row.compteNum}</td>
                      <td className="px-4 py-3 border-[#083344]">{row.compteNom}</td>
                      <td className="px-4 py-3 border-[#083344]">
                        {row.type === 'Débit' ? row.montant.toLocaleString('fr-FR') : ''}
                      </td>
                      <td className="px-4 py-3 border-[#083344]">
                        {row.type === 'Crédit' ? row.montant.toLocaleString('fr-FR') : ''}
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="4" className="text-center py-4 text-gray-500">
                      Aucune donnée trouvée.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConsultationI;