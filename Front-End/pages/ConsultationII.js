import React, { useState } from 'react';
import { FaEye, FaFilter, FaSearch } from 'react-icons/fa';
import { FaEquals } from 'react-icons/fa6';
import Navbar from './navbar';
import ConsultationNavbar from './ConsultationNavbar';

const ConsultationII = () => {
  const [searchTerm, setSearchTerm] = useState('');
  
  const mockData = [
    { NumeroCompte: '111', NomCompte: 'Capital social ou personnel', debit: '23,000', credit: '45,000' },
    { NumeroCompte: '1111', NomCompte: 'Capital social', debit: '12,500', credit: '67,300' },
    { NumeroCompte: '1112', NomCompte: 'Fonds de dotation', debit: '5,200', credit: '15,700' },
    { NumeroCompte: '1117', NomCompte: 'Capital personnel', debit: '8,000', credit: '9,500' },
    { NumeroCompte: '11171', NomCompte: 'Capital individuel', debit: '13,200', credit: '10,000' },
    { NumeroCompte: '11175', NomCompte: "Compte de l'exploitant", debit: '7,500', credit: '6,400' },
    { NumeroCompte: '1119', NomCompte: 'Actionnaires, capital souscrit-non appelé', debit: '2,000', credit: '9,000' },
    { NumeroCompte: '112', NomCompte: "Primes d'émission, de fusion et d'apport", debit: '33,000', credit: '22,000' },
    { NumeroCompte: '1121', NomCompte: "Primes d'émission", debit: '5,000', credit: '8,900' },
    { NumeroCompte: '1122', NomCompte: 'Primes de fusion', debit: '6,300', credit: '12,100' },
    { NumeroCompte: '1123', NomCompte: "Primes d'apport", debit: '3,000', credit: '4,000' },
    { NumeroCompte: '113', NomCompte: 'Ecarts de réévaluation', debit: '19,800', credit: '5,600' },
    { NumeroCompte: '1130', NomCompte: 'Ecarts de réévaluation', debit: '1,100', credit: '8,200' },
    { NumeroCompte: '114', NomCompte: 'Réserve légale', debit: '20,000', credit: '18,300' },
    { NumeroCompte: '1151', NomCompte: 'Réserves statutaires ou contractuelles', debit: '4,400', credit: '11,500' },
    { NumeroCompte: '1152', NomCompte: 'Réserves facultatives', debit: '3,800', credit: '6,200' },
    { NumeroCompte: '1155', NomCompte: 'Réserves réglementées', debit: '10,000', credit: '9,900' },
    { NumeroCompte: '116', NomCompte: 'Report à nouveau', debit: '14,000', credit: '5,400' },
    { NumeroCompte: '1161', NomCompte: 'Report à nouveau (solde créditeur)', debit: '9,000', credit: '10,000' },
    { NumeroCompte: '1169', NomCompte: 'Report à nouveau (solde débiteur)', debit: '8,500', credit: '6,300' },
    { NumeroCompte: '118', NomCompte: 'Résultats nets en instance d\'affectation', debit: '6,600', credit: '7,400' },
    { NumeroCompte: '1181', NomCompte: 'Résultats nets en instance d\'affectation (solde créditeur)', debit: '4,700', credit: '9,100' },
    { NumeroCompte: '1189', NomCompte: 'Résultats nets en instance d\'affectation (solde débiteur)', debit: '2,300', credit: '1,900' },
    { NumeroCompte: '119', NomCompte: "Résultat net de l'exercice", debit: '13,700', credit: '12,000' },
    { NumeroCompte: '1191', NomCompte: "Résultat net de l'exercice (solde créditeur)", debit: '7,800', credit: '10,200' },
    { NumeroCompte: '1199', NomCompte: "Résultat net de l'exercice (solde débiteur)", debit: '9,900', credit: '8,800' },
    { NumeroCompte: '1511', NomCompte: 'Provisions pour litiges', debit: '6,300', credit: '11,700' },
    { NumeroCompte: '1512', NomCompte: 'Provisions pour garanties données aux clients', debit: '5,500', credit: '13,600' },
    { NumeroCompte: '1513', NomCompte: 'Provisions pour propre assureur', debit: '4,100', credit: '7,900' },
    { NumeroCompte: '1514', NomCompte: 'Provision pour pertes sur marchés à terme', debit: '3,600', credit: '5,200' },
    { NumeroCompte: '1515', NomCompte: 'Provisions pour amendes, double droits, pénalités', debit: '2,800', credit: '6,700' },
    { NumeroCompte: '1516', NomCompte: 'Provisions pour pertes de change', debit: '3,900', credit: '4,300' },
    { NumeroCompte: '1518', NomCompte: 'Autres provisions pour risques', debit: '5,000', credit: '6,600' }
  ];

  const filteredData = mockData.filter(
    (item) =>
      item.NumeroCompte.includes(searchTerm) ||
      item.NomCompte.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <div className="flex-1 overflow-y-auto">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

          <ConsultationNavbar />

          {/* Filter + Search */}
          <div className="flex items-center gap-4 mb-6 flex-wrap">
            <button className="flex items-center gap-2 bg-[#002c3c] text-white px-4 py-2 rounded-lg">
              <FaFilter /> Filtrer
            </button>
            <button className="flex items-center gap-2 bg-[#002c3c] text-white px-4 py-2 rounded-lg">
              <FaEquals /> Total
            </button>
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
              <thead className="bg-[#002c3c] text-white">
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
                    <tr key={index} className="border-b hover:bg-gray-100">
                      <td className="px-4 py-3 border border-[#083344]">{item.NumeroCompte}</td>
                      <td className="px-4 py-3 border border-[#083344]">{item.NomCompte}</td>
                      <td className="px-4 py-3 border border-[#083344]">{item.debit}</td>
                      <td className="px-4 py-3 border border-[#083344]">{item.credit}</td>
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
