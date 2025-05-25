import React, { useState, useEffect } from "react";
import { FaArrowRight, FaArrowLeft, FaForward } from "react-icons/fa";
import Navbar from '../components/navbar';
import UserMenu from '../components/UserMenu';

import { useNavigate } from "react-router-dom";

const QuestionsComptes = () => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});
  const [accountSuggestions, setAccountSuggestions] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isLoadingAccounts, setIsLoadingAccounts] = useState(false);
  const [classes, setClasses] = useState([]);
  const navigate = useNavigate(); 

  // Fetch existing accounts and classes from database
  useEffect(() => {
    const fetchData = async () => {
      setIsLoadingAccounts(true);
      try {
        // Fetch accounts
        const accountsResponse = await fetch("http://localhost:8000/accounts.php");
        if (accountsResponse.ok) {
          const accountsData = await accountsResponse.json();
          setAccountSuggestions(accountsData.data || []);
        }

        // Fetch classes
        const classesResponse = await fetch("http://localhost:8000/classes.php");
        if (classesResponse.ok) {
          const classesData = await classesResponse.json();
          setClasses(classesData.data || []);
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setIsLoadingAccounts(false);
      }
    };

    fetchData();
  }, []);

  const questions = [
    {
      id: 1,
      key: "numero_compte",
      question: "N° du compte",
      placeholder: "Entrez le numéro du compte",
      type: "text"
    },
    {
      id: 2,
      key: "nom_compte",
      question: "Nom du compte",
      placeholder: "Entrez le nom du compte",
      type: "text"
    },
    {
      id: 3,
      key: "class_id",
      question: "Classe du compte",
      placeholder: "Sélectionnez la classe",
      type: "select"
    },
    {
      id: 4,
      key: "montant_debit",
      question: "Montant Débit",
      placeholder: "Entrez le montant du débit",
      type: "number"
    },
    {
      id: 5,
      key: "montant_credit",
      question: "Montant Crédit",
      placeholder: "Entrez le montant du crédit",
      type: "number"
    }
  ];

  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
      setShowSuggestions(false);
    } else {
      submitData();
    }
  };

  const handlePrevious = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion(prev => prev - 1);
      setShowSuggestions(false);
    }
  };

  const handleSkip = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
      setShowSuggestions(false);
    }
  };

  const handleAnswerChange = (e) => {
    const key = questions[currentQuestion].key;
    const value = e.target.value;
    
    setAnswers(prev => ({
      ...prev,
      [key]: value
    }));

    // Auto-fill account name when account number is recognized
    if (key === "numero_compte") {
      const matchedAccount = accountSuggestions.find(
        acc => acc.numero_compte === value
      );
      
      if (matchedAccount) {
        setAnswers(prev => ({
          ...prev,
          numero_compte: value,
          nom_compte: matchedAccount.nom_compte,
          class_id: matchedAccount.class_id || ""
        }));
      }

      // Show suggestions if input length > 0
      if (value.length > 0) {
        setShowSuggestions(true);
      } else {
        setShowSuggestions(false);
      }
    }
  };

  const selectSuggestion = (account) => {
    setAnswers({
      ...answers,
      numero_compte: account.numero_compte,
      nom_compte: account.nom_compte,
      class_id: account.class_id || ""
    });
    setShowSuggestions(false);
  };

  const filteredSuggestions = accountSuggestions.filter(account => 
    answers.numero_compte ? account.numero_compte.includes(answers.numero_compte) : false
  );

  const submitData = async () => {
    // Get user from localStorage at the start
    const user = JSON.parse(localStorage.getItem("user"));

    // Validate class_id is selected
    if (!answers.class_id || answers.class_id === "0") {
      alert("Veuillez sélectionner une classe valide (1 à 7)");
      setCurrentQuestion(2); // Jump to class selection
      return;
    }

    try {
      const response = await fetch("http://localhost:8000/comptes.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include", 
        body: JSON.stringify({
          numero_compte: answers.numero_compte || "",
          nom_compte: answers.nom_compte || "",
          class_id: parseInt(answers.class_id) || 0,
          montant_debit: parseFloat(answers.montant_debit) || 0,
          montant_credit: parseFloat(answers.montant_credit) || 0
        }),
      });

      const result = await response.json();

      await fetch("http://localhost:8000/mark-completed-ii.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ userId: user.id })
      });
      if (result.success) {
        alert("Compte enregistré avec succès !");
        setAnswers({});
        setCurrentQuestion(0);
        navigate("/tresorerie");
      } else {
        alert("Erreur: " + result.message + (result.error ? "\n" + result.error : ""));
      }
    } catch (error) {
      alert("Erreur réseau ou serveur." + error.message);
      console.error(error);
    }
  };

  const renderInputField = () => {
    const currentQ = questions[currentQuestion];
    
    if (currentQ.type === "select") {
      return (
        <select
          value={answers[currentQ.key] || ''}
          onChange={handleAnswerChange}
          className="w-full px-4 py-3 bg-[#f2f1ec] border border-[#083344]/20 rounded-lg text-[#083344] placeholder-[#083344]/50 focus:outline-none focus:ring-2 focus:ring-[#083344] focus:border-transparent transition-all duration-300"
        >
          <option value="">Sélectionnez la classe</option>
          {classes.map(cls => (
            <option key={cls.num_Class} value={cls.num_Class}>
              {cls.num_Class} - {cls.nom}
            </option>
          ))}
        </select>
      );
    }

    return (
      <>
        <input
          type={currentQ.type}
          value={answers[currentQ.key] || ''}
          onChange={handleAnswerChange}
          placeholder={currentQ.placeholder}
          className="w-full px-4 py-3 bg-[#f2f1ec] border border-[#083344]/20 rounded-lg text-[#083344] placeholder-[#083344]/50 focus:outline-none focus:ring-2 focus:ring-[#083344] focus:border-transparent transition-all duration-300"
        />
        
        {/* Account number suggestions */}
        {currentQ.key === "numero_compte" && showSuggestions && (
          <div className="absolute z-10 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg max-h-60 overflow-auto">
            {isLoadingAccounts ? (
              <div className="p-2 text-center text-gray-500">Chargement...</div>
            ) : filteredSuggestions.length > 0 ? (
              filteredSuggestions.map((account) => (
                <div
                  key={account.numero_compte}
                  className="p-2 hover:bg-gray-100 cursor-pointer"
                  onClick={() => selectSuggestion(account)}
                >
                  <div className="font-medium">{account.numero_compte}</div>
                  <div className="text-sm text-gray-600">{account.nom_compte}</div>
                </div>
              ))
            ) : (
              <div className="p-2 text-center text-gray-500">Aucun compte trouvé</div>
            )}
          </div>
        )}
      </>
    );
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu className="mb-10" />
      <div className="flex-1 p-8 mt-10 overflow-y-auto">
        <div className="max-w-2xl mx-auto">
          {/* Progress bar */}
          <div className="mb-8">
            <div className="flex justify-between mb-2">
              <span className="text-[#083344]">Question {currentQuestion + 1} sur {questions.length}</span>
              <span className="text-[#083344]">{Math.round(((currentQuestion + 1) / questions.length) * 100)}%</span>
            </div>
            <div className="h-2 bg-[#083344]/10 rounded-full">
              <div
                className="h-full bg-[#083344] rounded-full transition-all duration-500"
                style={{ width: `${((currentQuestion + 1) / questions.length) * 100}%` }}
              ></div>
            </div>
          </div>

          {/* Question Card */}
          <div className="bg-white p-8 rounded-2xl shadow-lg transform transition-all duration-500 hover:scale-[1.02]">
            <h2 className="text-2xl font-bold text-[#083344] mb-6">
              {questions[currentQuestion].question}
            </h2>

            <div className="mb-8 relative">
              {renderInputField()}
            </div>

            {/* Navigation Buttons */}
            <div className="flex justify-between items-center">
              <button
                onClick={handlePrevious}
                disabled={currentQuestion === 0}
                className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
                  currentQuestion === 0
                    ? 'bg-gray-300 cursor-not-allowed text-gray-500'
                    : 'bg-[#083344] text-white hover:bg-[#083344]/90'
                }`}
              >
                <FaArrowLeft />
                Précédent
              </button>

              <div className="flex gap-4">
                <button
                  onClick={handleSkip}
                  className="px-6 py-3 bg-gray-200 text-[#083344] rounded-lg font-medium hover:bg-gray-300 transition-all duration-300"
                >
                  <FaForward className="inline-block mr-2" />
                  Passer
                </button>

                <button
                  onClick={handleNext}
                  className="flex items-center gap-2 px-6 py-3 bg-[#083344] text-white rounded-lg font-medium hover:bg-[#083344]/90 transition-all duration-300"
                >
                  {currentQuestion === questions.length - 1 ? "Terminer" : "Suivant"}
                  <FaArrowRight />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default QuestionsComptes;