

const ConsultationNavbar = () => {
    return(
        <div className="flex gap-4 mb-6 flex-wrap justify-center">
                {['Recherche d’ecrit', 'Consultation du compte', 'Grand Livre', 'Transactrice'].map((label, idx) => (
                  <button key={idx} className="bg-[#003c3c] text-white px-16 py-6 rounded-lg hover:bg-[#002b2b]">
                    {label}
                  </button>
                ))}
        </div>
    )
}

export default ConsultationNavbar;