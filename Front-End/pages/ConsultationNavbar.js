import React from 'react';
import { NavLink } from 'react-router-dom';
import { FaSearch, FaBook, FaFolderOpen, FaExchangeAlt } from 'react-icons/fa';

const tabs = [
  { label: 'Recherche d’ecrit', icon: <FaSearch className="mr-2" />, path: '/ConsultationI' },
  { label: 'Consultation du compte', icon: <FaBook className="mr-2" />, path: '/ConsultationII' },
  { label: 'Grand Livre', icon: <FaFolderOpen className="mr-2" />, path: '/grand-livre' },
  { label: 'Transaction', icon: <FaExchangeAlt className="mr-2" />, path: '/transactrice' },
];

const ConsultationNavbar = () => {
  return (
    <div className="top-[70px] left-0 right-0 flex justify-between gap-4 px-6 py-4 z-50">
      {tabs.map((tab, index) => (
        <NavLink
          key={index}
          to={tab.path}
          className={({ isActive }) =>
            `flex items-center justify-center px-16 py-8 rounded-lg font-medium transition ${
              isActive ? 'bg-[#083344] text-white' : 'bg-gray-200 text-[#083344] hover:bg-[#083344]/10'
            }`
          }
        >
          {tab.icon}
          {tab.label}
        </NavLink>
      ))}
    </div>
  );
};

export default ConsultationNavbar;
