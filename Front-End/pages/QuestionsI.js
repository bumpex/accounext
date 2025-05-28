import React, { useState, useMemo, useEffect } from "react";
import { FaArrowRight, FaArrowLeft, FaForward, FaBuilding, FaCalendarAlt, FaChartLine } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import Navbar from "../components/navbar";
import UserMenu from "../components/UserMenu";
import { motion } from "framer-motion";

const QuestionsI = () => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});
  const [currentYear] = useState((new Date().getFullYear() - 1));
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();

  const nameQuestion = useMemo(
    () => ({
      id: "name",
      question: "Quel est le nom de votre entreprise ?",
      placeholder: "Ex: Entreprise XYZ",
      type: "text",
      icon: <FaBuilding className="text-[#003c3c] text-xl" />,
      validation: (value) => {
        if (!value) return "Ce champ est requis";
        if (value.length < 2) return "Le nom doit contenir au moins 2 caractères";
        return null;
      }
    }),
    []
  );

  const ageQuestion = useMemo(
    () => ({
      id: "age",
      question: "Depuis combien d'années votre entreprise existe-t-elle ?",
      placeholder: "Nombre d'années",
      type: "number",
      icon: <FaCalendarAlt className="text-[#003c3c] text-xl" />,
      validation: (value) => {
        if (!value) return "Ce champ est requis";
        const num = parseInt(value, 10);
        if (isNaN(num)) return "Veuillez entrer un nombre valide";
        if (num <= 0) return "L'âge doit être supérieur à 0";
        if (num > 100) return "L'âge doit être inférieur à 100 ans";
        return null;
      }
    }),
    []
  );

  const profitQuestions = useMemo(() => {
    const age = parseInt(answers[ageQuestion.id], 10);
    if (!age || isNaN(age) || age <= 0) return [];

    return Array.from({ length: age }, (_, i) => {
      const year = currentYear - (age - i - 1);
      return {
        id: `profit-${i}`,
        question: `Quel était le bénéfice net en ${year} ?`,
        placeholder: "Montant en €",
        type: "number",
        icon: <FaChartLine className="text-[#003c3c] text-xl" />,
        year,
        validation: (value) => {
          if (!value) return "Ce champ est requis";
          if (isNaN(parseFloat(value))) return "Veuillez entrer un nombre valide";
          return null;
        }
      };
    });
  }, [answers, ageQuestion.id, currentYear]);

  const questions = useMemo(
    () => [nameQuestion, ageQuestion, ...profitQuestions],
    [nameQuestion, ageQuestion, profitQuestions]
  );

  useEffect(() => {
    // Reset profit questions when age changes
    if (answers[ageQuestion.id]) {
      setAnswers(prev => {
        const newAnswers = { ...prev };
        Object.keys(newAnswers).forEach(key => {
          if (key.startsWith("profit-")) delete newAnswers[key];
        });
        return newAnswers;
      });
    }
  }, [answers[ageQuestion.id]]);

  useEffect(() => {
    if (questions.length > 0 && currentQuestion >= questions.length) {
      setCurrentQuestion(questions.length - 1);
    }
  }, [questions.length, currentQuestion]);

  const validateCurrentQuestion = () => {
    const currentQ = questions[currentQuestion];
    if (!currentQ?.validation) return true;
    
    const error = currentQ.validation(answers[currentQ.id]);
    if (error) {
      setErrors(prev => ({ ...prev, [currentQ.id]: error }));
      return false;
    }
    setErrors(prev => ({ ...prev, [currentQ.id]: undefined }));
    return true;
  };

  const handleAnswerChange = (e) => {
    const { value } = e.target;
    setAnswers(prev => ({
      ...prev,
      [questions[currentQuestion].id]: value,
    }));
    
    // Clear error when typing
    if (errors[questions[currentQuestion].id]) {
      setErrors(prev => ({ ...prev, [questions[currentQuestion].id]: undefined }));
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

  const handleNext = async () => {
    if (!validateCurrentQuestion()) return;

    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
    } else {
      await submitData();
    }
  };

  const submitData = async () => {
    setIsSubmitting(true);
    try {
      // Extract profit data from answers
      const profitData = profitQuestions.map((q, i) => ({
        year: q.year,
        profit: parseFloat(answers[`profit-${i}`]) || 0
      }));

      const response = await fetch("http://localhost:8000/entreprise.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${localStorage.getItem("token")}`
        },
        body: JSON.stringify({
          name: answers[nameQuestion.id],
          age: parseInt(answers[ageQuestion.id], 10),
          profits: profitData
        }),
        credentials: "include"
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Request failed');
      }

      const data = await response.json();
      navigate("/dashboard");
    } catch (error) {
      console.error("Submission error:", error);
      alert(`Error: ${error.message || 'Failed to submit data'}`);
    } finally {
      setIsSubmitting(false);
    }
  };

  const progressPercentage = questions.length > 0 
    ? Math.round(((currentQuestion + 1) / questions.length) * 100)
    : 0;

  return (
    <div className="flex min-h-screen bg-gradient-to-br from-[#f2f1ec] to-[#e0e0d8]">
      <Navbar />
      <UserMenu className="mb-10" />
      
      <div className="flex-1 p-4 md:p-8 overflow-y-auto mt-10">
        <div className="max-w-3xl mx-auto">
          {/* Progress Section */}
          <motion.div 
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-8 bg-white p-6 rounded-xl shadow-md"
          >
            <div className="flex justify-between items-center mb-3">
              <h2 className="text-lg font-semibold text-[#003c3c]">
                Questionnaire Entreprise
              </h2>
              <span className="text-sm font-medium text-[#003c3c]">
                {progressPercentage}% complété
              </span>
            </div>
            
            <div className="h-3 bg-[#003c3c]/10 rounded-full overflow-hidden">
              <motion.div
                className="h-full bg-gradient-to-r from-[#006666] to-[#003c3c] rounded-full"
                initial={{ width: "0%" }}
                animate={{ width: `${progressPercentage}%` }}
                transition={{ duration: 0.5 }}
              />
            </div>
            
            <div className="mt-2 text-right text-sm text-[#003c3c]/70">
              Question {currentQuestion + 1} sur {questions.length}
            </div>
          </motion.div>

          {/* Current Question */}
          {questions.length > 0 && (
            <motion.div
              key={currentQuestion}
              initial={{ opacity: 0, x: 50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -50 }}
              transition={{ duration: 0.3 }}
              className="bg-white p-6 md:p-8 rounded-2xl shadow-lg"
            >
              <div className="flex items-start gap-4 mb-6">
                <div className="p-3 bg-[#003c3c]/10 rounded-full">
                  {questions[currentQuestion].icon}
                </div>
                <div>
                  <h2 className="text-xl md:text-2xl font-bold text-[#003c3c]">
                    {questions[currentQuestion].question}
                  </h2>
                  {questions[currentQuestion].id.startsWith("profit-") && (
                    <p className="text-sm text-[#003c3c]/70 mt-1">
                      Année: {questions[currentQuestion].year}
                    </p>
                  )}
                </div>
              </div>

              <div className="mb-6">
                <input
                  type={questions[currentQuestion].type}
                  value={answers[questions[currentQuestion].id] || ""}
                  onChange={handleAnswerChange}
                  placeholder={questions[currentQuestion].placeholder}
                  className={`w-full px-4 py-3 bg-[#f8f8f6] border rounded-lg text-[#003c3c] placeholder-[#003c3c]/50 focus:outline-none focus:ring-2 transition-all duration-300 ${
                    errors[questions[currentQuestion].id] 
                      ? "border-red-500 focus:ring-red-300" 
                      : "border-[#003c3c]/20 focus:ring-[#003c3c]/50"
                  }`}
                />
                {errors[questions[currentQuestion].id] && (
                  <p className="mt-2 text-sm text-red-600">
                    {errors[questions[currentQuestion].id]}
                  </p>
                )}
              </div>

              <div className="flex flex-col-reverse md:flex-row justify-between items-center gap-4">
                <button
                  onClick={handlePrevious}
                  disabled={currentQuestion === 0}
                  className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
                    currentQuestion === 0
                      ? "bg-gray-200 cursor-not-allowed text-gray-500"
                      : "bg-[#003c3c] text-white hover:bg-[#005555]"
                  }`}
                >
                  <FaArrowLeft />
                  Précédent
                </button>

                <div className="flex gap-3 w-full md:w-auto">
                  {currentQuestion < questions.length - 1 && (
                    <button
                      onClick={handleSkip}
                      disabled={currentQuestion === 0}
                      className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium transition-all ${
                        currentQuestion === 0
                          ? "bg-gray-200 text-gray-400 cursor-not-allowed"
                          : "bg-amber-100 text-amber-800 hover:bg-amber-200"
                      }`}
                    >
                      Passer <FaForward />
                    </button>
                  )}

                  <button
                    onClick={handleNext}
                    disabled={isSubmitting}
                    className={`flex items-center gap-2 px-6 py-3 rounded-lg font-medium text-white transition-all ${
                      isSubmitting
                        ? "bg-[#003c3c]/70 cursor-wait"
                        : "bg-[#003c3c] hover:bg-[#005555]"
                    }`}
                  >
                    {currentQuestion < questions.length - 1 ? (
                      <>
                        Suivant <FaArrowRight />
                      </>
                    ) : isSubmitting ? (
                      "Envoi en cours..."
                    ) : (
                      "Terminer et soumettre"
                    )}
                  </button>
                </div>
              </div>
            </motion.div>
          )}
        </div>
      </div>
    </div>
  );
};

export default QuestionsI;