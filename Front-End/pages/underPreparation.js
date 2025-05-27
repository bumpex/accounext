import { useNavigate } from 'react-router-dom';

export default function ComingSoonPage() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#083344] to-[#0c4b6e] flex flex-col items-center justify-center p-6 text-white">
      <div className="max-w-md w-full bg-white/10 backdrop-blur-sm rounded-xl shadow-2xl overflow-hidden border border-white/20">
        
        <div className="p-8 flex flex-col items-center">
          <img 
            src="/media/AccouNext.png" 
            alt="AccouNext Logo"
            className="h-16 mb-6 object-contain"
          />
          <h1 className="text-3xl font-bold text-center mb-2">Content Under Preparation</h1>
          
        </div>

       
        <div className="px-8 pb-8">
          <div className="h-2 bg-white/20 rounded-full overflow-hidden">
            <div 
              className="h-full bg-white rounded-full animate-pulse"
              style={{
                width: '70%',
                animationDuration: '2s',
                animationTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)'
              }}
            ></div>
          </div>
        </div>

       
        <div className="flex flex-col sm:flex-row gap-4 px-8 pb-8">
          <button
            onClick={() => navigate(-1)}
            className="flex-1 px-6 py-3 bg-white/10 hover:bg-white/20 border border-white/20 rounded-lg transition-all duration-300 font-medium"
          >
            Go Back
          </button>
          <button
            onClick={() => navigate('/dashboard')}
            className="flex-1 px-6 py-3 bg-white text-[#083344] hover:bg-gray-100 rounded-lg transition-all duration-300 font-medium"
          >
            Return Home
          </button>
        </div>

       
        <div className="bg-white/5 p-4 text-center text-sm text-white/60">
          <p>AccouNext © {new Date().getFullYear()} - All rights reserved</p>
        </div>
      </div>
    </div>
  );
}