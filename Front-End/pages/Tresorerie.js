import React from 'react';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';
import { FaUsers, FaHandshake, FaWallet, FaChartLine, FaUser, FaStore } from 'react-icons/fa';
import Navbar from './navbar';

const Tresorerie = () => {
  const cashFlowData = [
    { month: 'Jan', cashIn: 20, cashOut: 10 },
    { month: 'Feb', cashIn: 35, cashOut: 18 },
    { month: 'Mar', cashIn: 33, cashOut: 22 },
    { month: 'Apr', cashIn: 40, cashOut: 28 },
    { month: 'May', cashIn: 37, cashOut: 30 },
  ];

  const clients = [
    { name: 'Kylian Mbappé', amount: '12 000€' },
    { name: 'Erling Haaland', amount: '8 500€' },
    { name: 'Vinícius Jr.', amount: '6 200€' },
    { name: 'Kevin De Bruyne', amount: '14 000€' },
    { name: 'Mohamed Salah', amount: '5 750€' },
  ];

  const fournisseurs = [
    { name: 'Lionel Messi', amount: '7 300€' },
    { name: 'Cristiano Ronaldo', amount: '5 000€' },
    { name: 'Neymar Jr.', amount: '6 700€' },
    { name: 'Antoine Griezmann', amount: '4 800€' },
    { name: 'Robert Lewandowski', amount: '9 000€' },
  ];

  const tabs = [
    { label: 'Vue d’ensemble', icon: <FaChartLine className="mr-2" /> },
    { label: 'Clients', icon: <FaUsers className="mr-2" /> },
    { label: 'Fournisseurs', icon: <FaStore className="mr-2" /> },
    { label: 'Transactrice', icon: <FaHandshake className="mr-2" /> },
  ];

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <div className="flex-1 p-8 overflow-y-auto">
        <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Trésorerie</h1>
        <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

        {/* Tabs with icons */}
        <div className="w-full justify-between flex gap-4 mb-8">
          {tabs.map((tab, index) => (
            <button
              key={index}
              className="flex items-center justify-center px-16 py-7 rounded-lg bg-[#083344] text-white font-medium hover:bg-[#083344]/90 transition"
            >
              {tab.icon}
              {tab.label}
            </button>
          ))}
        </div>

        {/* Cards */}
        <div className="grid grid-cols-1 md:grid-cols-12 gap-4 mb-2">
          {/* Solde de trésorerie */}
          <div className="bg-white rounded-2xl p-8 shadow-lg md:col-span-4">
            <h2 className="text-xl font-bold text-[#083344] mb-6 flex items-center gap-2">
              <FaWallet />
              Solde de Trésorerie
            </h2>
            <div className="text-3xl font-bold mb-6">123456789 €</div>
            <div className="space-y-2">
              <p>Banque: <span className="font-semibold">12345,67 €</span></p>
              <p>Caisse: <span className="font-semibold">12567,89 €</span></p>
            </div>
          </div>

          {/* Flux de trésorerie */}
          <div className="bg-white rounded-2xl p-8 shadow-lg md:col-span-8">
            <h2 className="text-xl font-bold text-[#083344] mb-6">Flux de Trésorerie (5 derniers mois)</h2>
            <ResponsiveContainer width="100%" height={250}>
              <LineChart data={cashFlowData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip />
                <Line type="monotone" dataKey="cashIn" stroke="#083344" strokeWidth={2} />
                <Line type="monotone" dataKey="cashOut" stroke="#60A5FA" strokeWidth={2} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Clients and Fournisseurs */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
          {/* Clients */}
          <div className="bg-white rounded-2xl p-8 shadow-lg">
            <h2 className="text-xl font-bold text-[#083344] mb-6 flex items-center gap-2">
              <FaUsers />
              Clients
            </h2>
            <div className="space-y-4">
              {clients.map((client, idx) => (
                <div key={idx} className="flex justify-between text-[#083344] font-medium items-center">
                  <div className="flex items-center gap-2">
                    <FaUser className="text-[#083344]" />
                    <span>{client.name}</span>
                  </div>
                  <span>{client.amount}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Fournisseurs */}
          <div className="bg-white rounded-2xl p-8 shadow-lg">
            <h2 className="text-xl font-bold text-[#083344] mb-6 flex items-center gap-2">
              <FaStore />
              Fournisseurs
            </h2>
            <div className="space-y-4">
              {fournisseurs.map((fournisseur, idx) => (
                <div key={idx} className="flex justify-between text-[#083344] font-medium items-center">
                  <div className="flex items-center gap-2">
                    <FaUser className="text-[#083344]" />
                    <span>{fournisseur.name}</span>
                  </div>
                  <span>{fournisseur.amount}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Tresorerie;
