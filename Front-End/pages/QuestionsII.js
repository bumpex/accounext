import React, { useState } from "react";
import { FaArrowRight, FaArrowLeft, FaForward } from "react-icons/fa";
import Navbar from '../components/navbar';

const QuestionsComptes = () => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});

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
      key: "montant_debit",
      question: "Montant Débit",
      placeholder: "Entrez le montant du débit",
      type: "number"
    },
    {
      id: 4,
      key: "montant_credit",
      question: "Montant Crédit",
      placeholder: "Entrez le montant du crédit",
      type: "number"
    }
  ];

  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
    } else {
      submitData();
    }
  };

  const handlePrevious = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion(prev => prev - 1);
    }
  };

  const handleSkip = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
    }
  };

  const handleAnswerChange = (e) => {
    const key = questions[currentQuestion].key;
    setAnswers(prev => ({
      ...prev,
      [key]: e.target.value
    }));
  };

  const submitData = async () => {
    try {
      const response = await fetch("http://localhost:8000/comptes.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          numero_compte: answers.numero_compte || "",
          nom_compte: answers.nom_compte || "",
          montant_debit: parseFloat(answers.montant_debit) || 0,
          montant_credit: parseFloat(answers.montant_credit) || 0
        }),
      });

      const result = await response.json();
      if (result.success) {
        alert("Compte enregistré avec succès !");
        setAnswers({});
        setCurrentQuestion(0);
      } else {
        alert("Erreur: " + result.message);
      }
    } catch (error) {
      alert("Erreur réseau ou serveur.");
      console.error(error);
    }
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <div className="flex-1 p-8 overflow-y-auto">
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

            <div className="mb-8">
              <input
                type={questions[currentQuestion].type}
                value={answers[questions[currentQuestion].key] || ''}
                onChange={handleAnswerChange}
                placeholder={questions[currentQuestion].placeholder}
                className="w-full px-4 py-3 bg-[#f2f1ec] border border-[#083344]/20 rounded-lg text-[#083344] placeholder-[#083344]/50 focus:outline-none focus:ring-2 focus:ring-[#083344] focus:border-transparent transition-all duration-300"
              />
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
