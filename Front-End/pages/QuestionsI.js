import React, { useState, useMemo, useEffect } from "react";
import { FaArrowRight, FaArrowLeft, FaForward } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import Navbar from "../components/navbar";
import UserMenu from "../components/UserMenu";

const QuestionsI = () => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});
  const [currentYear, setCurrentYear] = useState(new Date().getFullYear());

  const navigate = useNavigate();

  const nameQuestion = useMemo(
    () => ({
      id: "name",
      question: "Quel est le nom de votre entreprise ?",
      placeholder: "Entrez le nom de l'entreprise",
      type: "text",
    }),
    []
  );

  const ageQuestion = useMemo(
    () => ({
      id: "age",
      question: "Quel âge a votre entreprise ?",
      placeholder: "Entrez l'âge de votre entreprise en années",
      type: "number",
    }),
    []
  );

  const profitQuestions = useMemo(() => {
    const age = parseInt(answers[ageQuestion.id], 10);
    if (!age || isNaN(age) || age <= 0) return [];

    const questions = [];
    for (let i = 1; i <= age; i++) {
      const year = currentYear - (age - i);
      questions.push({
        id: `profit-${i}`,
        question: `Quels sont les bénéfices de votre entreprise en ${year} ?`,
        placeholder: "Entrez le montant des bénéfices",
        type: "number",
      });
    }
    return questions;
  }, [answers, ageQuestion.id, currentYear]);

  const questions = useMemo(
    () => [nameQuestion, ageQuestion, ...profitQuestions],
    [nameQuestion, ageQuestion, profitQuestions]
  );

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

  useEffect(() => {
    if (questions.length === 0) return;
    if (currentQuestion >= questions.length) {
      setCurrentQuestion(questions.length - 1);
    }
  }, [questions.length, currentQuestion]);

  const handleAnswerChange = (e) => {
    const value = e.target.value;
    setAnswers((prev) => ({
      ...prev,
      [questions[currentQuestion].id]: value,
    }));
  };

  const handlePrevious = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion((prev) => prev - 1);
    }
  };

  const handleSkip = () => {
    // Don't allow skip for name or age questions
    if (
      questions[currentQuestion]?.id === nameQuestion.id ||
      questions[currentQuestion]?.id === ageQuestion.id
    ) {
      return;
    }
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion((prev) => prev + 1);
    }
  };

  const handleNext = async () => {
    const currentId = questions[currentQuestion].id;
    const value = answers[currentId];

    if (
      currentId === ageQuestion.id &&
      (!value || isNaN(value) || value <= 0)
    ) {
      alert("Veuillez entrer un âge valide pour l'entreprise.");
      return;
    }

    if (!value) {
      alert("Veuillez remplir ce champ avant de continuer.");
      return;
    }

    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion((prev) => prev + 1);
    } else {
      // Final step — Submit data
      try {
        const profitData = {};
        for (const key in answers) {
          if (key.startsWith("profit-")) {
            const index = parseInt(key.split("-")[1], 10);
            const age = parseInt(answers[ageQuestion.id], 10);
            const year = currentYear - age + index;
            profitData[year] = parseFloat(answers[key]);
          }
        }

        const response = await fetch("http://localhost:8000/entreprise.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            name: answers[nameQuestion.id],
            age: parseInt(answers[ageQuestion.id], 10),
            profits: profitData
          })
        });

        const data = await response.json();

        if (data.success) {
          try {
            const user = JSON.parse(localStorage.getItem("user"));

            // Mark questionnaire I as completed
            await fetch("http://localhost:8000/mark-completed.php", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({ userId: user.id })
            });

            navigate("/questionsII");
          } catch (err) {
            console.error("Failed to mark questionnaire as completed:", err);
          }
        } else {
          alert("Erreur lors de l'enregistrement : " + data.message);
        }
      } catch (error) {
        console.error("Une erreur s'est produite lors de la soumission:", error);
        alert("Une erreur s'est produite lors de la soumission.");
      }
    }
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu className="mb-10" />
      <div className="flex-1 p-8 overflow-y-auto mt-10">
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
                  width: `${((currentQuestion + 1) / questions.length) * 100}%`,
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
                  disabled={
                    questions[currentQuestion]?.id === nameQuestion.id ||
                    questions[currentQuestion]?.id === ageQuestion.id
                  }
                  className={`px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
                    questions[currentQuestion]?.id === nameQuestion.id ||
                    questions[currentQuestion]?.id === ageQuestion.id
                      ? "bg-gray-200 text-gray-400 cursor-not-allowed"
                      : "bg-gray-200 text-[#003c3c] hover:bg-gray-300"
                  }`}
                >
                  <FaForward className="inline-block mr-2" />
                  Passer
                </button>

                <button
                  onClick={handleNext}
                  className="flex items-center gap-2 px-6 py-3 bg-[#003c3c] text-white rounded-lg font-medium hover:bg-[#003c3c]/90 transition-all duration-300"
                >
                  Suivant
                  <FaArrowRight />
                </button>
              </div>
            </div>
          </div>

          {/* Input for Current Year */}
          <div className="mt-12 text-center">
            <label className="block text-[#003c3c] font-semibold mb-2">
              Année actuelle pour les bénéfices :
            </label>
            <input
              type="number"
              value={currentYear}
              onChange={(e) => setCurrentYear(parseInt(e.target.value, 10))}
              className="w-40 px-4 py-2 border border-[#003c3c]/40 rounded-lg text-[#003c3c] text-center bg-[#f2f1ec] placeholder-[#003c3c]/50 focus:outline-none focus:ring-2 focus:ring-[#003c3c]"
              placeholder="Année"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default QuestionsI;