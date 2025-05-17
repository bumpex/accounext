import React, { useEffect, useState } from 'react';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';
import { FaUsers, FaHandshake, FaWallet, FaChartLine, FaUser, FaStore } from 'react-icons/fa';
import Navbar from './navbar';
import TresorerieNavbar from './TresorerieNavbar';
import UserMenu from './UserMenu';

const Tresorerie = () => {
  const [clients, setClients] = useState([]);
  const [fournisseurs, setFournisseurs] = useState([]);

  const cashFlowData = [
    { month: 'Jan', Debit: 20, Credit: 10 },
    { month: 'Feb', Debit: 35, Credit: 18 },
    { month: 'Mar', Debit: 33, Credit: 22 },
    { month: 'Apr', Debit: 40, Credit: 28 },
    { month: 'May', Debit: 37, Credit: 30 },
  ];

  useEffect(() => {
    fetch('http://localhost:8000/get_clients.php')
      .then(res => res.json())
      .then(data => setClients(data))
      .catch(err => console.error('Error fetching clients:', err));

    fetch('http://localhost:8000/get_fournisseurs.php')
      .then(res => res.json())
      .then(data => setFournisseurs(data))
      .catch(err => console.error('Error fetching fournisseurs:', err));
  }, []);

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 p-8 overflow-y-auto">
        <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Trésorerie</h1>
        <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

        <TresorerieNavbar />

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
                <Line type="monotone" dataKey="Debit" stroke="#083344" strokeWidth={2} />
                <Line type="monotone" dataKey="Credit" stroke="#60A5FA" strokeWidth={2} />
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
                  <span>{client.amount} €</span>
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
                  <span>{fournisseur.amount} €</span>
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
