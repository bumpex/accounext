import React from 'react';
import { FaEye, FaFilter, FaSearch } from 'react-icons/fa';
import { FaEquals } from 'react-icons/fa6';
import Navbar from './navbar';

const Consultation = () => {
  
  const mockData = [
    {
      date: '01/01/2024',
      compte: '1111',
      nom: 'YYYYYYY',
      debit: '10,000',
      credit: ''
    },
    {
      date: '05/02/2024',
      compte: '1111',
      nom: 'YYYYYYY',
      debit: '',
      credit: '5,000'
    }
  ];

  return(
    <div className="flex min-h-screen bg-[#f2f1ec]">
    <Navbar />
    <div className="flex-1 overflow-y-auto">
    <div className="p-8">
      <h1 className="text-3xl font-bold text-[#003c3c] mb-6 border-b-2 pb-2 w-fit">Consultation</h1>

      {/* Top Buttons */}
      <div className="flex gap-4 mb-6 flex-wrap">
        {['Recherche d’ecrit', 'Consultation du compte', 'Grand Livre', 'Transactrice'].map((label, idx) => (
          <button key={idx} className="bg-[#003c3c] text-white px-4 py-2 rounded-lg hover:bg-[#002b2b]">
            {label}
          </button>
        ))}
      </div>

      {/* Filter + Search */}
      <div className="flex items-center gap-4 mb-4 flex-wrap">
        <button className="flex items-center gap-2 bg-[#003c3c] text-white px-4 py-2 rounded-lg">
          <FaFilter /> Filter
        </button>
        <button className="flex items-center gap-2 bg-[#003c3c] text-white px-4 py-2 rounded-lg">
          <FaEquals /> Total
        </button>
        <div className="flex items-center gap-2 ml-auto">
          <input
            type="date"
            className="px-3 py-2 border border-[#003c3c] rounded-lg text-[#003c3c]"
          />
          <button className="bg-[#003c3c] text-white px-4 py-2 rounded-lg flex items-center gap-2">
            <FaSearch /> Recherche Date
          </button>
        </div>
      </div>

      {/* Table */}
      <div className="border border-[#003c3c] rounded-lg overflow-x-auto">
        <table className="w-full text-left border-collapse">
          <thead className="bg-[#003c3c] text-white">
            <tr>
              <th className="px-4 py-2">Date</th>
              <th className="px-4 py-2">N° du compte</th>
              <th className="px-4 py-2">Nom du compte</th>
              <th className="px-4 py-2">Débit</th>
              <th className="px-4 py-2">Crédit</th>
              <th className="px-4 py-2">Justificatif</th>
            </tr>
          </thead>
          <tbody>
            {mockData.map((row, idx) => (
              <tr key={idx} className="bg-white border-t border-[#003c3c]/20">
                <td className="px-4 py-3">{row.date}</td>
                <td className="px-4 py-3">{row.compte}</td>
                <td className="px-4 py-3">{row.nom}</td>
                <td className="px-4 py-3">{row.debit}</td>
                <td className="px-4 py-3">{row.credit}</td>
                <td className="px-4 py-3">
                  <button className="flex items-center gap-2 bg-[#003c3c] text-white px-3 py-1.5 rounded-lg hover:bg-[#002b2b]">
                    <FaEye /> Montrer Justificatif
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
    </div>
  </div>
  )
}

export default Consultation;