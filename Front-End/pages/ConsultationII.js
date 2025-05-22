import React, { useState, useEffect } from 'react';
import { FaEye, FaFilter, FaSearch } from 'react-icons/fa';
import { FaEquals } from 'react-icons/fa6';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar';
import UserMenu from '../components/UserMenu';

const ConsultationII = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [comptes, setComptes] = useState([]);
  const [classes, setClasses] = useState([]);
  const [selectedClass, setSelectedClass] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Fetch classes
  useEffect(() => {
    fetch('http://localhost:8000/get_classes.php')
      .then(res => res.json())
      .then(data => {
        setClasses(data);
      })
      .catch(err => console.error('Error fetching classes:', err));
  }, []);

  // Fetch accounts based on selected class
  useEffect(() => {
    let url = 'http://localhost:8000/get_comptes.php';

    if (selectedClass) {
      url += `?class_id=${selectedClass}`;
    }

    fetch(url)
      .then(res => res.json())
      .then(data => {
        setComptes(data);
        setLoading(false);
      })
      .catch(err => {
        setError('Impossible de charger les données');
        setLoading(false);
        console.error('Error fetching comptes:', err);
      });
  }, [selectedClass]);

  // Filter data by search term
  const filteredData = comptes.filter(
    (item) =>
      item.NumeroCompte.includes(searchTerm) ||
      item.NomCompte.toLowerCase().includes(searchTerm.toLowerCase())
  );

  if (loading) return <div>Chargement des comptes...</div>;
  if (error) return <div className="text-red-500">{error}</div>;

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

          <ConsultationNavbar />

          {/* Filter + Search */}
          <div className="flex items-center gap-4 mt-12 mb-6 flex-wrap">
            {/* Filter Dropdown */}
            <div className="relative group">
              <button
                type="button"
                className="flex items-center gap-2 bg-[#002c3c] text-white px-4 py-2 rounded-lg"
              >
                <FaFilter /> Filtrer par Classe
              </button>

              <select
                value={selectedClass}
                onChange={(e) => setSelectedClass(e.target.value)}
                className="absolute left-0 mt-2 w-full bg-white border border-gray-300 rounded-md shadow-lg p-2 z-10"
              >
                <option value="">Toutes les classes</option>
                {classes.map((cls) => (
                  <option key={cls.id} value={cls.id}>
                    {cls.nom}
                  </option>
                ))}
              </select>
            </div>

            {/* Search Input */}
            <div className="flex items-center gap-2 ml-auto relative">
              <span className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#002c3c]">
                <FaSearch />
              </span>
              <input
                type="text"
                placeholder="N° ou Nom du compte"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10 pr-4 py-2 border border-[#002c3c] rounded-lg text-[#002c3c] focus:outline-none focus:ring-2 focus:ring-[#083344] w-64"
              />
            </div>
          </div>

          {/* Table */}
          <div className="border border-[#083344] rounded-xl overflow-x-auto mb-14 shadow-lg">
            <table className="w-full text-left border-collapse">
              <thead className="bg-[#08334443] text-[#083344]">
                <tr>
                  <th className="px-4 py-2 text-center border border-[#f2f1ec]">N° du Compte</th>
                  <th className="px-4 py-2 text-center border border-[#f2f1ec]">Nom du Compte</th>
                  <th className="px-4 py-2 text-center border border-[#f2f1ec]">Débit</th>
                  <th className="px-4 py-2 text-center border border-[#f2f1ec]">Crédit</th>
                </tr>
              </thead>
              <tbody>
                {filteredData.length > 0 ? (
                  filteredData.map((item, index) => (
                    <tr key={index} className="border-b hover:bg-gray-100 bg-white">
                      <td className="px-4 py-3 border border-[#083344]">{item.NumeroCompte}</td>
                      <td className="px-4 py-3 border border-[#083344]">{item.NomCompte}</td>
                      <td className="px-4 py-3 border border-[#083344]">{parseFloat(item.debit).toLocaleString('fr-FR')} €</td>
                      <td className="px-4 py-3 border border-[#083344]">{parseFloat(item.credit).toLocaleString('fr-FR')} €</td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="4" className="text-center py-6 text-gray-500">
                      Aucun compte trouvé.
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

export default ConsultationII;