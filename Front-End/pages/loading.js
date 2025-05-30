import React from 'react';

const LoadingScreen = () => {
  return (
    <div className="fixed inset-0 bg-white bg-opacity-90 flex flex-col items-center justify-center z-50">
            <div className="relative w-48 h-48 mb-8">
                <img 
          src="/media/AccouNext2.png" 
          alt="AccouNext Logo"
          className="w-full h-full object-contain animate-pulse"
        />
        
                <div className="absolute inset-0 flex items-center justify-center">
          <div className="absolute w-full h-full rounded-full border-4 border-[#083344] border-opacity-20 animate-[ping_2s_infinite]"></div>
          <div className="absolute w-full h-full rounded-full border-4 border-[#083344] border-opacity-10 animate-[ping_2s_infinite_0.5s]"></div>
          <div className="absolute w-full h-full rounded-full border-4 border-[#083344] border-opacity-05 animate-[ping_2s_infinite_1s]"></div>
        </div>
      </div>
      
            <div className="text-center">
        <h2 className="text-2xl font-bold text-[#083344] mb-2">AccouNext</h2>
        <p className="text-gray-600 flex justify-center items-center">
          Chargement en cours
          <span className="inline-block ml-1">
            <span className="animate-[bounce_1s_infinite_0ms]">.</span>
            <span className="animate-[bounce_1s_infinite_150ms]">.</span>
            <span className="animate-[bounce_1s_infinite_300ms]">.</span>
          </span>
        </p>
      </div>
      
            <div className="w-64 h-1.5 bg-gray-200 rounded-full overflow-hidden mt-6">
        <div className="h-full bg-[#083344] rounded-full animate-[progressBar_2s_infinite]"></div>
      </div>
    </div>
  );
};

export default LoadingScreen;