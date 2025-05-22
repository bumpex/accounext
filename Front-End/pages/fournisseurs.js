import { useState } from "react";
import Navbar from "../components/navbar";
import axios from "axios";

import TresorerieNavbar from "../components/TresorerieNavbar";
import UserMenu from "../components/UserMenu";

export default function Fournisseurs() {
  const [formData, setFormData] = useState({
    Nom: '',
    Email: '',
    Telephone: '',
    Adresse: '',
    Solde: '',
    Description: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const HandleAdd = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    try {
      const fournisseurData = new FormData();
      for (const key in formData) {
         fournisseurData.append(key, formData[key]);
      }

      
      const response = await axios({
        method: 'POST',
        url: 'http://localhost:8000/fournisseurs.php',
        data: fournisseurData ,
    })
      
      const data = response.data;
      
      if (data.status === "success") {
        alert("✅  fournisseur ajouté avec succès!");
        
        setFormData({
          Nom: '',
          Email: '',
          Telephone: '',
          Adresse: '',
          Solde: '',
          Description: ''
        });
      } else {
        alert("❌ Erreur: " + (data.message || "Une erreur est survenue"));
      }
    } catch (error) {
      console.error('Erreur:', error);
      alert('❌ Une erreur est survenue lors de la connexion au serveur');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      
      <div className="flex-1 p-8 overflow-y-auto ">
        <div className="mx-auto">
          
          <div className="mb-8 text-center justify-center">
            <h1 className="text-2xl md:text-3xl font-bold text-gray-800">Gestion des fournisseurs</h1>
            <p className="text-gray-600 mt-2">Ajouter un nouveau  fournisseur à votre système</p>
          </div>
          
          
          <TresorerieNavbar />

          <div className="bg-white rounded-xl shadow-md overflow-hidden border px-16 border-gray-100">
            <div className="p-6 md:p-8">
              <h2 className="text-xl font-semibold text-gray-800 mb-6 pb-2 border-b border-gray-100">
                Informations du  fournisseur
              </h2>
              
              <form onSubmit={HandleAdd}>
                <div className="grid md:grid-cols-2 gap-6 mb-6">
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Nom">
                      Nom complet <span className="text-red-500">*</span>
                    </label>
                    <input
                      id="Nom"
                      name="Nom"
                      type="text"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      placeholder="abdelmounaime benalla"
                      value={formData.Nom}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Email">
                      Email
                    </label>
                    <input
                      id="Email"
                      name="Email"
                      type="email"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      placeholder=" fournisseur@example.com"
                      value={formData.Email}
                      onChange={handleChange}
                    />
                  </div>
                  
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Telephone">
                      Téléphone <span className="text-red-500">*</span>
                    </label>
                    <input
                      id="Telephone"
                      name="Telephone"
                      type="tel"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      placeholder="06 12 34 56 78"
                      value={formData.Telephone}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Solde">
                      Solde initial (DH)
                    </label>
                    <input
                      id="Solde"
                      name="Solde"
                      type="number"
                      step="0.01"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      placeholder="0.00"
                      value={formData.Solde}
                      onChange={handleChange}
                    />
                  </div>
                </div>
                
                
                <div className="mb-6">
                  <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Adresse">
                    Adresse
                  </label>
                  <input
                    id="Adresse"
                    name="Adresse"
                    type="text"
                    className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                    placeholder="123 Rue Principale, Casablanca"
                    value={formData.Adresse}
                    onChange={handleChange}
                  />
                </div>
                
               
                <div className="mb-8">
                  <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="Description">
                    Description / Notes
                  </label>
                  <textarea
                    id="Description"
                    name="Description"
                    rows={3}
                    className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                    placeholder="Informations supplémentaires sur le fournisseur..."
                    value={formData.Description}
                    onChange={handleChange}
                  />
                </div>
                
                
                <div className="flex flex-col-reverse sm:flex-row justify-end space-y-4 sm:space-y-0 space-x-0 sm:space-x-3">
                  <button
                    type="button"
                    onClick={() => setFormData({
                      Nom: '',
                      Email: '',
                      Telephone: '',
                      Adresse: '',
                      Solde: '',
                      Description: ''
                    })}
                    className="px-6 py-2.5 rounded-lg border border-gray-300 text-gray-700 font-medium hover:bg-gray-50 transition-colors"
                  >
                    Annuler
                  </button>
                  <button
                    type="submit"
                    className="px-6 py-2.5 rounded-lg bg-[#083344] text-white font-medium hover:bg-blue-700 transition-colors flex items-center justify-center"
                    disabled={isSubmitting}
                  >
                    {isSubmitting ? (
                      <>
                        <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                        Enregistrement...
                      </>
                    ) : (
                      <>
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-2" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                        Ajouter fournisseur
                      </>
                    )}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}