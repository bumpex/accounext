import React, { useEffect, useState } from 'react';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';
import { FaUsers, FaHandshake, FaWallet, FaChartLine, FaUser, FaStore } from 'react-icons/fa';
import Navbar from '../components/navbar';
import TresorerieNavbar from '../components/TresorerieNavbar';
import UserMenu from '../components/UserMenu';
import SoldeForm from '../components/SoldeForm'; // Adjust path as needed

const Tresorerie = () => {
  const [clients, setClients] = useState([]);
  const [fournisseurs, setFournisseurs] = useState([]);
  const [cashFlowData, setCashFlowData] = useState([]);
  const [soldeData, setSoldeData] = useState({
    total: 0,
    details: []
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch('http://localhost:8000/get_clients.php')
      .then(res => res.json())
      .then(data => setClients(data))
      .catch(err => console.error('Error fetching clients:', err));
    fetch('http://localhost:8000/get_fournisseurs.php')
      .then(res => res.json())
      .then(data => setFournisseurs(data))
      .catch(err => console.error('Error fetching fournisseurs:', err));
    fetch('http://localhost:8000/get_tresorerie_flux.php')
      .then(res => {
        if (!res.ok) throw new Error("Network response was not ok");
        return res.json();
      })
      .then(data => {
        setCashFlowData(data || []);
        setLoading(false);
      })
      .catch(err => {
        console.error('Error fetching cash flow data:', err);
        setError('Failed to load chart data');
        setLoading(false);
      });
    fetch('http://localhost:8000/get_tresorerie_solde.php')
      .then(res => res.json())
      .then(data => {
        setSoldeData({
          total: data.total || 0,
          details: data.details || []
        });
      })
      .catch(err => console.error('Error fetching solde data:', err));
  }, []);

  const handleSoldeUpdate = (updatedData) => {
    setSoldeData({
      total: updatedData.total,
      details: updatedData.details || []
    });
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 p-8 overflow-y-auto">
        <h1 className="text-2xl md:text-3xl font-bold text-[#083344] mb-6 text-center">Trésorerie</h1>
        <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

        <TresorerieNavbar />

                <div className="grid grid-cols-1 md:grid-cols-12 gap-2 mb-2">
                    <div className="bg-white rounded-2xl p-8 shadow-lg md:col-span-4">
            <h2 className="text-xl font-bold text-[#083344] mb-6 flex items-center gap-2">
              <FaWallet />
              Solde de Trésorerie
            </h2>

            <div className="text-3xl font-bold mb-6">
              {soldeData.total.toLocaleString('fr-FR')} €
            </div>

            <div className="space-y-2">
              {Array.isArray(soldeData.details) && soldeData.details.length > 0 ? (
                soldeData.details.map((acc, idx) => (
                  <p key={idx}>
                    {acc.nom_compte}:{' '}
                    <span className="font-semibold">
                      {acc.solde.toLocaleString('fr-FR')} €
                    </span>
                  </p>
                ))
              ) : (
                <p>Aucune donnée disponible</p>
              )}
            </div>

                                  </div>

                    <div className="bg-white rounded-2xl p-8 shadow-lg md:col-span-8">
            <h2 className="text-xl font-bold text-[#083344] mb-6">Flux de Trésorerie</h2>

            {loading ? (
              <p>Chargement du graphique...</p>
            ) : error ? (
              <p className="text-red-500">{error}</p>
            ) : (
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
            )}
          </div>
        </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
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
                  <span>{parseFloat(client.amount).toLocaleString('fr-FR')} €</span>
                </div>
              ))}
            </div>
          </div>

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
                  <span>{parseFloat(fournisseur.amount).toLocaleString('fr-FR')} €</span>
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