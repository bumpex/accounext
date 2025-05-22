import React from 'react';
import { NavLink } from 'react-router-dom';
import {
  FaUsers,
  FaHandshake,
  FaChartLine,
  FaStore
} from 'react-icons/fa';

const tabs = [
  { label: 'Vue d’ensemble', icon: <FaChartLine className="mr-2" />, path: '/tresorerie' },
  { label: 'Clients', icon: <FaUsers className="mr-2" />, path: '/clients' },
  { label: 'Fournisseurs', icon: <FaStore className="mr-2" />, path: '/fournisseurs' },
  { label: 'Transaction', icon: <FaHandshake className="mr-2" />, path: '/transaction' },
];

const TresorerieNavbar = () => {
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


export default TresorerieNavbar;
