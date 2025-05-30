import Navbar from "../components/navbar";
import UserMenu from "../components/UserMenu";
import { FaHistory, FaChartLine, FaMoneyBillWave, FaPiggyBank } from "react-icons/fa";
import { Bar } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
import { useEffect, useState } from 'react';
import axios from 'axios';



ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

export default function Dashboard() {
  const [entreprise, setEntreprise] = useState({});
  const [benefices, setBenefices] = useState([]);
  const [comptes, setComptes] = useState([]);
  const [historique, setHistorique] = useState([]);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({
    banque: 0,
    caisse: 0,
    resultat: 0
  });
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        
        const [
          entrepriseRes, 
          beneficesRes, 
          comptesRes, 
          historiqueRes
        ] = await Promise.all([
          axios.get("http://localhost/accounext/entreprise.php"),
          axios.get("http://localhost/accounext/benefices.php"),
          axios.get("http://localhost/accounext/comptes.php"),
          axios.get("http://localhost/accounext/historique.php")
        ]);

        setEntreprise(entrepriseRes.data.data || {});
        setBenefices(beneficesRes.data.data || []);
        setComptes(comptesRes.data.data || []);
        setHistorique(historiqueRes.data.data || []);

        const banque = comptesRes.data.data.find(c => c.numero_compte === '5141')?.montant_debit || 0;
        const caisse = comptesRes.data.data.find(c => c.numero_compte === '5161')?.montant_debit || 0;
        const resultat = comptesRes.data.data.find(c => c.numero_compte === '8800')?.montant_debit || 0;
        

        setStats({
          banque: banque.toLocaleString('fr-FR', { minimumFractionDigits: 2 }),
          caisse: caisse.toLocaleString('fr-FR', { minimumFractionDigits: 2 }),
          resultat: resultat.toLocaleString('fr-FR', { minimumFractionDigits: 2 })
        });

      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);
  const chartData = {
    labels: benefices.map(item => item.annee),
    datasets: [
      {
        label: 'Bénéfices (en DH)',
        data: benefices.map(item => item.montant),
        backgroundColor: '#083344',
        borderColor: '#083344',
        borderWidth: 1,
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        text: `Évolution des bénéfices de ${entreprise.nom || "l'entreprise"}`,
        font: {
          size: 16
        }
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        title: {
          display: true,
          text: 'Montant (DH)'
        },
        ticks: {
          callback: function(value) {
            return value.toLocaleString('fr-FR') + ' DH';
          }
        }
      },
      x: {
        title: {
          display: true,
          text: 'Année'
        }
      }
    }
  };
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = comptes.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(comptes.length / itemsPerPage);

  const paginate = (pageNumber) => setCurrentPage(pageNumber);
  const getPaginationNumbers = () => {
    const pageNumbers = [];
    const maxVisiblePages = 9;
    const halfVisiblePages = Math.floor(maxVisiblePages / 2);

    if (totalPages <= maxVisiblePages) {
      for (let i = 1; i <= totalPages; i++) {
        pageNumbers.push(i);
      }
    } else {
      if (currentPage <= halfVisiblePages + 1) {
        for (let i = 1; i <= maxVisiblePages - 1; i++) {
          pageNumbers.push(i);
        }
        pageNumbers.push('...');
        pageNumbers.push(totalPages);
      } else if (currentPage >= totalPages - halfVisiblePages) {
        pageNumbers.push(1);
        pageNumbers.push('...');
        for (let i = totalPages - (maxVisiblePages - 2); i <= totalPages; i++) {
          pageNumbers.push(i);
        }
      } else {
        pageNumbers.push(1);
        pageNumbers.push('...');
        const start = currentPage - halfVisiblePages + 2;
        const end = currentPage + halfVisiblePages - 2;
        for (let i = start; i <= end; i++) {
          pageNumbers.push(i);
        }
        pageNumbers.push('...');
        pageNumbers.push(totalPages);
      }
    }

    return pageNumbers;
  };

  return (
    <div className="min-h-screen bg-gray-50 flex">
  <Navbar />
  <div className="flex-1 flex flex-col">
    <UserMenu />
    <div className="flex-1 p-6 lg:p-8 overflow-y-auto">
       
        <div className="mb-8 text-center">
          <h1 className="text-3xl font-bold text-[#083344]">
            {entreprise.nom || "Tableau de Bord"}
          </h1>
          {entreprise.age_annee && (
            <p className="text-gray-600">Fondée il y a {entreprise.age_annee} ans</p>
          )}
        </div>

       
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
          <div className="bg-[#083344] p-4 rounded-lg shadow-md text-center">
            <div className="flex items-center justify-center gap-2 mb-2">
              <FaMoneyBillWave className="text-white text-xl" />
              <h2 className="text-lg font-semibold text-white">Banque</h2>
            </div>
            <p className="text-gray-300">{loading ? '...' : stats.banque} DH</p>
          </div>
          <div className="bg-[#083344] p-4 rounded-lg shadow-md text-center">
            <div className="flex items-center justify-center gap-2 mb-2">
              <FaPiggyBank className="text-white text-xl" />
              <h2 className="text-lg font-semibold text-white">Caisse</h2>
            </div>
            <p className="text-gray-300">{loading ? '...' : stats.caisse} DH</p>
          </div>
          <div className="bg-[#083344] p-4 rounded-lg shadow-md text-center">
            <h2 className="text-lg font-semibold text-white">Résultat</h2>
            <p className={`text-lg ${stats.resultat >= 0 ? 'text-green-300' : 'text-red-300'}`}>
              {loading ? '...' : stats.resultat} DH
            </p>
          </div>
        </div>

                <div className="bg-white p-6 rounded-lg shadow-md mb-8 max-w-4xl mx-auto">
          <div className="flex items-center justify-center gap-2 mb-4">
            <FaChartLine className="text-[#083344] text-xl" />
            <h2 className="text-xl font-semibold text-gray-800">Performance Financière</h2>
          </div>
          
          {loading ? (
            <div className="text-center py-8">Chargement des données...</div>
          ) : benefices.length > 0 ? (
            <div className="h-80 w-full">
              <Bar data={chartData} options={chartOptions} />
            </div>
          ) : (
            <div className="text-center py-8 text-gray-500">
              Aucune donnée de bénéfices disponible
            </div>
          )}
        </div>

                <div className="mb-8">
          <div className="flex justify-center mb-4">
            <h2 className="text-2xl font-semibold text-gray-800 border-b pb-2 border-gray-300 flex items-center gap-2">
              <FaHistory className="text-[#083344]" />
              Dernières Opérations
            </h2>
          </div>
          <div className="overflow-x-auto">
            <table className="min-w-full border border-gray-300 text-sm text-left">
              <thead className="bg-gray-100">
                <tr>
                  <th className="px-4 py-2 border">Date</th>
                  <th className="px-4 py-2 border">Libellé</th>
                  <th className="px-4 py-2 border">Montant</th>
                  <th className="px-4 py-2 border">Type</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan="4" className="text-center p-4">Chargement...</td>
                  </tr>
                ) : historique.length > 0 ? (
                  historique.map((op, index) => (
                    <tr key={index} className="hover:bg-gray-50">
                      <td className="px-4 py-2 border">{op.date_operation}</td>
                      <td className="px-4 py-2 border">{op.libelle}</td>
                      <td className="px-4 py-2 border text-right font-mono">
                        {parseFloat(op.montant).toLocaleString('fr-FR', { minimumFractionDigits: 2 })} DH
                      </td>
                      <td className="px-4 py-2 border">
                        <span className={`px-2 py-1 rounded-full text-xs ${
                          op.type === 'debit' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'
                        }`}>
                          {op.type === 'debit' ? 'Débit' : 'Crédit'}
                        </span>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="4" className="text-center p-4 text-gray-500">
                      Aucune opération récente
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>

                <div className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-800 mb-4 text-center">
            Plan Comptable
          </h2>
          <div className="overflow-x-auto">
            <table className="min-w-full border border-gray-300 text-sm text-left">
              <thead className="bg-gray-100">
                <tr>
                  <th className="px-4 py-2 border">N° Compte</th>
                  <th className="px-4 py-2 border">Nom Compte</th>
                  <th className="px-4 py-2 border">Débit Initial</th>
                  <th className="px-4 py-2 border">Crédit Initial</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan="4" className="text-center p-4">Chargement...</td>
                  </tr>
                ) : currentItems.length > 0 ? (
                  currentItems.map((compte) => (
                    <tr key={compte.numero_compte} className="hover:bg-gray-50">
                      <td className="px-4 py-2 border font-mono">{compte.numero_compte}</td>
                      <td className="px-4 py-2 border">{compte.nom_compte}</td>
                      <td className="px-4 py-2 border text-right font-mono">
                        {parseFloat(compte.montant_debit).toLocaleString('fr-FR', { minimumFractionDigits: 2 })} DH
                      </td>
                      <td className="px-4 py-2 border text-right font-mono">
                        {parseFloat(compte.montant_credit).toLocaleString('fr-FR', { minimumFractionDigits: 2 })} DH
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="4" className="text-center p-4 text-gray-500">
                      Aucun compte enregistré
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
          
                    {comptes.length > itemsPerPage && (
            <div className="flex justify-center mt-4">
              <nav className="inline-flex rounded-md shadow">
                <ul className="flex list-none items-center">
                                    <li>
                    <button
                      onClick={() => paginate(Math.max(1, currentPage - 1))}
                      disabled={currentPage === 1}
                      className="px-3 py-1 mx-1 rounded-md bg-white text-[#083344] hover:bg-gray-100 disabled:opacity-50"
                    >
                      &lt;
                    </button>
                  </li>

                                    {getPaginationNumbers().map((number, index) => (
                    <li key={index}>
                      {number === '...' ? (
                        <span className="px-2 py-1">...</span>
                      ) : (
                        <button
                          onClick={() => paginate(number)}
                          className={`px-3 py-1 mx-1 rounded-md ${
                            currentPage === number 
                              ? 'bg-[#083344] text-white' 
                              : 'bg-white text-[#083344] hover:bg-gray-100'
                          }`}
                        >
                          {number}
                        </button>
                      )}
                    </li>
                  ))}

                                    <li>
                    <button
                      onClick={() => paginate(Math.min(totalPages, currentPage + 1))}
                      disabled={currentPage === totalPages}
                      className="px-3 py-1 mx-1 rounded-md bg-white text-[#083344] hover:bg-gray-100 disabled:opacity-50"
                    >
                      &gt;
                    </button>
                  </li>
                </ul>
              </nav>
            </div>
          )}
        </div>
      </div>
    </div>
    </div>
  );
}