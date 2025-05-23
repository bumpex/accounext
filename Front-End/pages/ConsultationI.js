import React from 'react';
import { FaEye, FaFilter, FaSearch } from 'react-icons/fa';
import { FaEquals } from 'react-icons/fa6';
import Navbar from '../components/navbar';
import ConsultationNavbar from '../components/ConsultationNavbar'; 
import UserMenu from '../components/UserMenu';

const ConsultationI = () => {
  
  const mockData = [
    {
      date: '01/01/2024',
      compte: '1111',
      nom: 'Cristiano Ronaldo',
      debit: '10,000',
      credit: '55,000'
    },
    {
      date: '05/02/2024',
      compte: '1111',
      nom: 'Lionel Messi',
      debit: '181,000',
      credit: '5,000'
    }
  ];

  return(
    <div className="flex min-h-screen bg-[#f2f1ec]">
    <Navbar />
    <UserMenu />
    <div className="flex-1 overflow-y-auto">
    <div className="p-8">
      <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
      <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

      {/* Top Nav */}
      <ConsultationNavbar />
      
        
<div className="border border-[#083344] rounded-xl overflow-x-auto shadow-lg mb-8">
  {/* First Table */}
  <table className="w-full text-left border-collapse">
    <thead>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Date</th>
        <th className="px-4 py-3 border-r border-[#cdcdcd] text-center bg-[#08334443] text-[#083344]" colSpan="3">DD / MM / YYYY</th>
      </tr>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan={2}>N° du compte</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan={2}>Nom du compte</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan={2}>Montant</th>
      </tr>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Débit</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Crédit</th>
      </tr>
    </thead>
    <tbody>
      {mockData.map((row, idx) => (
        <tr key={idx} className="bg-white border-t border-[#083344] hover:bg-[#f9fafb]">
          <td className="px-4 py-3 border-r border-[#083344]">{row.compte}</td>
          <td className="px-4 py-3 border-r border-[#083344]">{row.nom}</td>
          <td className="px-4 py-3 border-r border-[#083344]">{row.debit}</td>
          <td className="px-4 py-3">{row.credit}</td>
        </tr>
      ))}
    </tbody>
  </table>

  {/* Second Table (attached seamlessly below) */}
  <table className="w-full text-left border-collapse mt-0">
    <thead>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Libellé</th>
        <th className="px-4 py-3 text-center border border-[#083344] bg-[#08334443] text-[#083344]" colSpan="2">XXXXXXXXXXXXX</th>
        <th className="px-4 py-3 text-center border border-[#083344] bg-[#08334443] text-[#083344]" colSpan="2">
          <button className="w-full bg-[#083344] py-2 px-4 flex items-center justify-center text-white rounded-md hover:bg-[#083344e1] transition-colors">
            <FaEye className="mr-2" /> Afficher Justification
          </button>
        </th>
      </tr>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Date</th>
        <th className="px-4 py-2 text-center border border-[#083344] bg-[#08334443] text-[#083344]" colSpan="4">DD / MM / YYYY</th>
      </tr>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan="2">N° du compte</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" rowSpan="2">Nom du compte</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]" colSpan="3">Montant</th>
      </tr>
      <tr>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Débit</th>
        <th className="px-4 py-2 bg-[#08334443] text-[#083344] text-center border border-[#f2f1ec]">Crédit</th>
      </tr>
    </thead>
    <tbody>
      {mockData.map((row, idx) => (
        <tr key={idx} className="bg-white border-t border-[#083344] hover:bg-[#f9fafb]">
          <td className="px-4 py-3 border-[#083344]">{row.compte}</td>
          <td className="px-4 py-3 border-[#083344]">{row.nom}</td>
          <td className="px-4 py-3 border-[#083344]">{row.debit}</td>
          <td className="px-4 py-3 border-[#083344]">{row.credit}</td>
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

export default ConsultationI;