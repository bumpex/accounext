import React from 'react';
import { FaSearch, FaBook, FaFolderOpen, FaExchangeAlt } from 'react-icons/fa';

const ConsultationNavbar = () => {
  const buttons = [
    { label: 'Recherche d’ecrit', icon: <FaSearch /> },
    { label: 'Consultation du compte', icon: <FaBook /> },
    { label: 'Grand Livre', icon: <FaFolderOpen /> },
    { label: 'Transactrice', icon: <FaExchangeAlt /> }
  ];

  return (
    <div className="flex gap-4 mb-12 flex-wrap justify-center">
      {buttons.map((btn, idx) => (
        <button
          key={idx}
          className="bg-[#003c3c] text-white px-12 py-6 rounded-lg flex items-center gap-2 hover:bg-[#002b2b]"
        >
          <span className="text-lg">{btn.icon}</span>
          <span>{btn.label}</span>
        </button>
      ))}
    </div>
  );
};

export default ConsultationNavbar;
