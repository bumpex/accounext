import React, { useState, useMemo, useEffect } from "react";
import { FaArrowRight, FaArrowLeft, FaForward } from "react-icons/fa";
import Navbar from "../components/navbar";

const QuestionsI = () => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});

  // Define the name question
  const nameQuestion = useMemo(
    () => ({
      id: "name",
      question: "Quelle est le nom de votre entreprise ?",
      placeholder: "Entrez le nom de votre entreprise",
      type: "text"
    }),
    []
  );

  // Define the age question
  const ageQuestion = useMemo(
    () => ({
      id: 1,
      question: "Quelle âge a votre entreprise ?",
      placeholder: "Entrez l'âge de votre entreprise en années",
      type: "number"
    }),
    []
  );

  // Dynamically generate profit questions based on the entered age
  const profitQuestions = useMemo(() => {
    const age = answers[ageQuestion.id];
    if (!age || isNaN(age) || age <= 0) return [];

    const questions = [];
    for (let i = 1; i <= age; i++) {
      questions.push({
        id: `profit-${i}`,
        question: `Quels sont les bénéfices de votre entreprise en ${i}${i === 1 ? "ère" : "ème"} année ?`,
        placeholder: "Entrez le montant des bénéfices",
        type: "number"
      });
    }
    return questions;
  }, [answers, ageQuestion.id]);

  // Build the full questions array: [name question, age question, profit questions]
  const questions = useMemo(
    () => [nameQuestion, ageQuestion, ...profitQuestions],
    [nameQuestion, ageQuestion, profitQuestions]
  );

  // Clear profit answers whenever the age changes
  useEffect(() => {
    setAnswers((prev) => {
      const newAnswers = { ...prev };
      Object.keys(newAnswers).forEach((key) => {
        if (key.startsWith("profit-")) {
          delete newAnswers[key];
        }
      });
      return newAnswers;
    });
  }, [answers[ageQuestion.id]]);

  // Adjust currentQuestion if it's out of bounds after questions array changes
  useEffect(() => {
    if (questions.length === 0) return;
    if (currentQuestion >= questions.length) {
      setCurrentQuestion(questions.length - 1);
    }
  }, [questions.length, currentQuestion]);

  // Handle next button
  const handleNext = () => {
    const currentId = questions[currentQuestion].id;

    if (currentId === "name") {
      const name = answers["name"];
      if (!name || name.trim() === "") {
        alert("Veuillez entrer le nom de votre entreprise.");
        return;
      }
    }

    if (currentId === ageQuestion.id) {
      const age = answers[ageQuestion.id];
      if (!age || isNaN(age) || age <= 0) {
        alert("Veuillez entrer un âge valide pour l'entreprise.");
        return;
      }
    }

    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion((prev) => prev + 1);
    }
  };

  // Handle previous button
  const handlePrevious = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion((prev) => prev - 1);
    }
  };

  // Handle skip button (cannot skip age question)
  const handleSkip = () => {
    if (questions[currentQuestion].id === ageQuestion.id) return;
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion((prev) => prev + 1);
    }
  };

  // Handle input change
  const handleAnswerChange = (e) => {
    const value = e.target.value;
    setAnswers((prev) => ({
      ...prev,
      [questions[currentQuestion].id]: value
    }));
  };


  const handleSubmit = async () => {
  const name = answers["name"];
  const age = parseInt(answers[ageQuestion.id], 10);

  // Gather profits by year
  const profits = {};
  for (let i = 1; i <= age; i++) {
    const profitValue = parseFloat(answers[`profit-${i}`]);
    if (!isNaN(profitValue)) {
      profits[i] = profitValue;
    }
  }

  // Prepare payload
  const payload = { name, age, profits };

  try {
    const res = await fetch("http://localhost:8000/entreprise.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    const result = await res.json();

    if (result.success) {
      alert("Données sauvegardées avec succès !");
      // Optionally reset form or redirect
    } else {
      alert("Erreur lors de la sauvegarde des données.");
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
          <div className="mb-8">
            <div className="flex justify-between mb-2">
              <span className="text-[#003c3c]">
                Question {currentQuestion + 1} sur {questions.length}
              </span>
              <span className="text-[#003c3c]">
                {Math.round(((currentQuestion + 1) / questions.length) * 100)}%
              </span>
            </div>
            <div className="h-2 bg-[#003c3c]/10 rounded-full">
              <div
                className="h-full bg-[#003c3c] rounded-full transition-all duration-500"
                style={{
                  width: `${((currentQuestion + 1) / questions.length) * 100}%`
                }}
              ></div>
            </div>
          </div>

          <div className="bg-white p-8 rounded-2xl shadow-lg transform transition-all duration-500 hover:scale-[1.02]">
            <h2 className="text-2xl font-bold text-[#003c3c] mb-6">
              {questions[currentQuestion]?.question}
            </h2>

            <div className="mb-8">
              <input
                type={questions[currentQuestion]?.type}
                value={answers[questions[currentQuestion]?.id] || ""}
                onChange={handleAnswerChange}
                placeholder={questions[currentQuestion]?.placeholder}
                className="w-full px-4 py-3 bg-[#f2f1ec] border border-[#003c3c]/20 rounded-lg text-[#003c3c] placeholder-[#003c3c]/50 focus:outline-none focus:ring-2 focus:ring-[#003c3c] focus:border-transparent transition-all duration-300"
              />
            </div>

            <div className="flex justify-between items-center">
              <button
                onClick={handlePrevious}
                disabled={currentQuestion === 0}
                className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
                  currentQuestion === 0
                    ? "bg-gray-300 cursor-not-allowed text-gray-500"
                    : "bg-[#003c3c] text-white hover:bg-[#003c3c]/90"
                }`}
              >
                <FaArrowLeft />
                Précédent
              </button>

              <div className="flex gap-4">
                <button
                  onClick={handleSkip}
                  disabled={questions[currentQuestion]?.id === ageQuestion.id}
                  className={`px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
                    questions[currentQuestion]?.id === ageQuestion.id
                      ? "bg-gray-200 text-gray-400 cursor-not-allowed"
                      : "bg-gray-200 text-[#003c3c] hover:bg-gray-300"
                  }`}
                >
                  <FaForward className="inline-block mr-2" />
                  Passer
                </button>

                <button
                  onClick={() => {
                    const isLastQuestion = currentQuestion === questions.length - 1;

                    if (isLastQuestion) {
                      handleSubmit();
                    } else {
                      handleNext();
                    }
                  }}
                  className="flex items-center gap-2 px-6 py-3 bg-[#003c3c] text-white rounded-lg font-medium hover:bg-[#003c3c]/90 transition-all duration-300"
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

export default QuestionsI;