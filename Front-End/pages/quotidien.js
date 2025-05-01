import { useState } from "react";
import Navbar from "../components/navbar";

export default function Quotidien() {
  const [formData, setFormData] = useState({
    date: '',
    libelle: '',
    justification: null,
    showJustification: true,
    entries: [{
      compteNum: '',
      compteNom: '',
      montant: '',
      type: 'debit'
    }]
  });

  const [fileName, setFileName] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    try {
      const submissionData = new FormData();
      submissionData.append('date', formData.date);
      submissionData.append('libelle', formData.libelle);
      
      formData.entries.forEach((entry, index) => {
        submissionData.append(`entries[${index}][compteNum]`, entry.compteNum);
        submissionData.append(`entries[${index}][compteNom]`, entry.compteNom);
        submissionData.append(`entries[${index}][montant]`, entry.montant);
        submissionData.append(`entries[${index}][type]`, entry.type);
      });

      if (formData.justification) {
        submissionData.append('justification', formData.justification);
      }

      console.log("Form data ready for PHP:", {
        date: formData.date,
        libelle: formData.libelle,
        entries: formData.entries,
        justification: formData.justification?.name || null
      });

      await new Promise(resolve => setTimeout(resolve, 1000));
      
      setFormData({
        date: '',
        libelle: '',
        justification: null,
        showJustification: true,
        entries: [{
          compteNum: '',
          compteNom: '',
          montant: '',
          type: 'debit'
        }]
      });
      setFileName('');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleEntryChange = (index, field, value) => {
    const newEntries = [...formData.entries];
    newEntries[index][field] = value;
    setFormData(prev => ({ ...prev, entries: newEntries }));
  };

  const addNewEntry = () => {
    setFormData(prev => ({
      ...prev,
      entries: [
        ...prev.entries,
        {
          compteNum: '',
          compteNom: '',
          montant: '',
          type: 'debit'
        }
      ]
    }));
  };

  const removeEntry = (index) => {
    if (formData.entries.length > 1) {
      const newEntries = formData.entries.filter((_, i) => i !== index);
      setFormData(prev => ({ ...prev, entries: newEntries }));
    }
  };

  const handleSkipJustification = () => {
    setFormData(prev => ({ ...prev, justification: null, showJustification: false }));
    setFileName('');
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setFormData(prev => ({ ...prev, justification: file }));
      setFileName(file.name);
    }
  };

  const removeFile = () => {
    setFormData(prev => ({ ...prev, justification: null }));
    setFileName('');
  };

  return (
    <div className="flex min-h-screen bg-gray-50">
      <Navbar />
      
      <div className="flex-1 p-6 lg:p-8 ml-0 lg:ml-64 transition-all duration-300">
        <div className="max-w-4xl mx-auto">
          
          <div className="mb-8">
            <h1 className="ml-80 text-2xl md:text-3xl font-bold text-gray-800">Journal Quotidien</h1>
            <p className="ml-64 text-gray-600 mt-2">Enregistrez vos opérations comptables quotidiennes</p>
          </div>
          
          
          <div className="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
            <div className="p-6 md:p-8">
              <h2 className="text-xl font-semibold text-gray-800 mb-6 pb-2 border-b border-gray-100">
                Nouvelle écriture comptable
              </h2>
              
              <form onSubmit={handleSubmit}>
                
                <div className="grid md:grid-cols-2 gap-6 mb-6">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="date">
                      Date de l'opération <span className="text-red-500">*</span>
                    </label>
                    <input
                      id="date"
                      type="date"
                      name="date"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      value={formData.date}
                      onChange={handleInputChange}
                      required
                    />
                  </div>
                  
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1" htmlFor="libelle">
                      Libellé <span className="text-red-500">*</span>
                    </label>
                    <input
                      id="libelle"
                      type="text"
                      name="libelle"
                      className="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                      placeholder="Description de l'opération"
                      value={formData.libelle}
                      onChange={handleInputChange}
                      required
                    />
                  </div>
                </div>
                
                
                <div className="mb-8">
                  <div className="flex justify-between items-center mb-4">
                    <h3 className="text-sm font-medium text-gray-700">Détails des comptes</h3>
                    <button
                      type="button"
                      onClick={addNewEntry}
                      className="flex items-center text-sm text-[#083344] hover:text-blue-800 font-medium"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
                        <path fillRule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clipRule="evenodd" />
                      </svg>
                      Ajouter une ligne
                    </button>
                  </div>
                  
                  <div className="space-y-4">
                    {formData.entries.map((entry, index) => (
                      <div key={index} className="bg-gray-50 rounded-lg p-4 border border-gray-200">
                        <div className="grid md:grid-cols-2 gap-4 mb-3">
                          <div>
                            <label className="block text-xs font-medium text-gray-500 mb-1" htmlFor={`compteNum-${index}`}>
                              Numéro de compte <span className="text-red-500">*</span>
                            </label>
                            <input
                              id={`compteNum-${index}`}
                              type="number"
                              className="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                              placeholder="N° de compte"
                              value={entry.compteNum}
                              onChange={(e) => handleEntryChange(index, 'compteNum', e.target.value)}
                              required
                            />
                          </div>
                          <div>
                            <label className="block text-xs font-medium text-gray-500 mb-1" htmlFor={`compteNom-${index}`}>
                              Nom du compte <span className="text-red-500">*</span>
                            </label>
                            <input
                              id={`compteNom-${index}`}
                              type="text"
                              className="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                              placeholder="Nom du compte"
                              value={entry.compteNom}
                              onChange={(e) => handleEntryChange(index, 'compteNom', e.target.value)}
                              required
                            />
                          </div>
                        </div>
                        
                        <div className="flex items-center">
                          <div className="flex-1 mr-3">
                            <label className="block text-xs font-medium text-gray-500 mb-1" htmlFor={`montant-${index}`}>
                              Montant <span className="text-red-500">*</span>
                            </label>
                            <input
                              id={`montant-${index}`}
                              type="number"
                              step="0.01"
                              className="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                              placeholder="0.00"
                              value={entry.montant}
                              onChange={(e) => handleEntryChange(index, 'montant', e.target.value)}
                              required
                            />
                          </div>
                          <div className="w-28 mr-3">
                            <label className="block text-xs font-medium text-gray-500 mb-1" htmlFor={`type-${index}`}>
                              Type <span className="text-red-500">*</span>
                            </label>
                            <select
                              id={`type-${index}`}
                              className="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                              value={entry.type}
                              onChange={(e) => handleEntryChange(index, 'type', e.target.value)}
                            >
                              <option value="debit">Débit</option>
                              <option value="credit">Crédit</option>
                            </select>
                          </div>
                          {formData.entries.length > 1 && (
                            <button
                              type="button"
                              onClick={() => removeEntry(index)}
                              className="mt-5 text-gray-400 hover:text-red-500 transition-colors"
                              title="Supprimer cette ligne"
                            >
                              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                <path fillRule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clipRule="evenodd" />
                              </svg>
                            </button>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
                
                
                {formData.showJustification && (
                  <div className="mb-8">
                    <div className="flex justify-between items-center mb-3">
                      <label className="block text-sm font-medium text-gray-700">
                        Justification (Pièce jointe)
                      </label>
                      <button
                        type="button"
                        onClick={handleSkipJustification}
                        className="text-sm text-gray-500 hover:text-gray-700"
                      >
                        Passer cette étape
                      </button>
                    </div>
                    
                    {!fileName ? (
                      <div className="flex items-center justify-center px-6 py-8 border-2 border-dashed border-gray-300 rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors cursor-pointer">
                        <label className="flex flex-col items-center space-y-2 cursor-pointer">
                          <svg xmlns="http://www.w3.org/2000/svg" className="h-10 w-10 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                          </svg>
                          <span className="text-sm text-gray-600 font-medium">Glissez-déposez votre fichier ici</span>
                          <span className="text-xs text-gray-500">ou cliquez pour sélectionner</span>
                          <input 
                            id="justification" 
                            type="file" 
                            className="hidden" 
                            onChange={handleFileChange}
                          />
                        </label>
                      </div>
                    ) : (
                      <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg border border-gray-200">
                        <div className="flex items-center">
                          <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 text-blue-500 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                          </svg>
                          <div>
                            <p className="text-sm font-medium text-gray-800 truncate max-w-xs">{fileName}</p>
                            <p className="text-xs text-gray-500">Téléversement réussi</p>
                          </div>
                        </div>
                        <button
                          type="button"
                          onClick={removeFile}
                          className="text-gray-400 hover:text-red-500 transition-colors"
                          title="Supprimer le fichier"
                        >
                          <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                            <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
                          </svg>
                        </button>
                      </div>
                    )}
                  </div>
                )}
                
                
                <div className="flex flex-col-reverse sm:flex-row justify-end space-y-4 sm:space-y-0 space-x-0 sm:space-x-3">
                  <button
                    type="button"
                    onClick={() => {
                      setFormData({
                        date: '',
                        libelle: '',
                        justification: null,
                        showJustification: true,
                        entries: [{
                          compteNum: '',
                          compteNom: '',
                          montant: '',
                          type: 'debit'
                        }]
                      });
                      setFileName('');
                    }}
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
                        Enregistrer
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