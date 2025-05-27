import { useState, useEffect } from 'react';
import axios from 'axios';
import ConsultationNavbar from '../components/ConsultationNavbar';
import Navbar from '../components/navbar';
import UserMenu from '../components/UserMenu';
import { FaSearch, FaTimes } from 'react-icons/fa';

export default function GrandLivre() {
  const [searchTerm, setSearchTerm] = useState('');
  const [accountData, setAccountData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [suggestions, setSuggestions] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);

  // Fetch account suggestions with debouncing
  useEffect(() => {
    const fetchSuggestions = async () => {
      if (searchTerm.trim().length > 1) {
        try {
          setLoading(true);
          const response = await axios.get(`http://localhost/accounext/get_comptes_grandlivre.php`, {
            params: { query: searchTerm.trim() }
          });
          
          if (Array.isArray(response.data)) {
            setSuggestions(response.data);
          } else {
            setSuggestions([]);
          }
        } catch (err) {
          console.error('Error fetching suggestions:', err);
          setSuggestions([]);
        } finally {
          setLoading(false);
        }
      } else {
        setSuggestions([]);
      }
    };

    const debounceTimer = setTimeout(fetchSuggestions, 300);
    return () => clearTimeout(debounceTimer);
  }, [searchTerm]);

  const fetchAccountData = async (accountNumber) => {
    setLoading(true);
    setError(null);
    try {
      const response = await axios.get(`http://localhost/accounext/grand_livre.php`, {
        params: { accountNumber: accountNumber.trim() }  // Changed from 'query' to 'accountNumber'
      });
      
      if (response.data && response.data.success) {
        // Adjusted to match the expected response format
        setAccountData({
          accountNumber: response.data.data.accountNumber,
          accountName: response.data.data.accountName,
          transactions: response.data.data.transactions || [],
          totalDebit: response.data.data.totalDebit || 0,
          totalCredit: response.data.data.totalCredit || 0,
          balance: Math.abs(response.data.data.balance || 0),
          balanceType: response.data.data.balanceType || 'Créditeur'
        });
      } else {
        setError(response.data?.message || 'Account not found');
      }
    } catch (err) {
      setError(
        err.response?.data?.error || 
        err.message || 
        'Failed to connect to server'
      );
    } finally {
      setLoading(false);
      setShowSuggestions(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    if (searchTerm.trim()) {
      fetchAccountData(searchTerm.trim());
    }
  };

  const handleSuggestionClick = (accountNumber) => {
    setSearchTerm(accountNumber);
    fetchAccountData(accountNumber);
  };

  const clearSearch = () => {
    setSearchTerm('');
    setAccountData(null);
    setError(null);
  };

  return (
    <div className="flex min-h-screen bg-[#f2f1ec]">
      <Navbar />
      <UserMenu />
      <div className="flex-1 overflow-y-auto">
        <div className="p-8">
          <h1 className="text-3xl font-bold text-[#083344] mb-2 text-center">Consultation</h1>
          <div className="w-1/2 h-0.5 bg-[#083344] mx-auto mb-10"></div>

          <ConsultationNavbar />
          
          {/* Enhanced Search Bar */}
          <div className="flex items-center justify-center mb-6">
            <div className="relative w-full max-w-xl">
              <form onSubmit={handleSearch} className="flex items-center gap-2">
                <div className="relative flex-1">
                  <input
                    type="text"
                    placeholder="Search by account number or name"
                    className="w-full px-4 py-3 border border-[#002c3c] rounded-lg text-[#002c3c] focus:outline-none focus:ring-2 focus:ring-[#002c3c] pr-10"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    onFocus={() => setShowSuggestions(true)}
                  />
                  {searchTerm && (
                    <button
                      type="button"
                      onClick={clearSearch}
                      className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
                    >
                      <FaTimes />
                    </button>
                  )}
                </div>
                <button 
                  className="bg-[#002c3c] hover:bg-[#001a23] text-white px-6 py-3 rounded-lg flex items-center gap-2 transition-colors duration-200"
                  type="submit"
                  disabled={loading}
                >
                  <FaSearch /> 
                  {loading ? 'Searching...' : 'Search'}
                </button>
              </form>

              {/* Suggestions Dropdown */}
              {showSuggestions && suggestions.length > 0 && (
                <div className="absolute z-10 mt-1 w-full bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                  {suggestions.map((account, index) => (
                    <div
                      key={index}
                      className="px-4 py-2 hover:bg-gray-100 cursor-pointer flex justify-between"
                      onClick={() => handleSuggestionClick(account.NumeroCompte)}
                    >
                      <span className="font-medium">{account.NumeroCompte}</span>
                      <span className="text-gray-500 truncate ml-2">{account.NomCompte}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
         
          {/* Loading State */}
          {loading && (
            <div className="text-center py-4">
              <div className="inline-block animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-[#002c3c]"></div>
              <p className="mt-2">Loading account data...</p>
            </div>
          )}
          
          {/* Error State */}
          {error && (
            <div className="text-center text-red-500 py-4">
              <p className="font-medium">Error:</p>
              <p>{error}</p>
            </div>
          )}
          
          {/* Account Data Table */}
          {accountData && (
            <div className="overflow-auto border border-gray-300 rounded-lg shadow-sm">
              <table className="min-w-full border-collapse">
                <thead>
                  <tr>
                    <th colSpan="4" className="text-left px-6 py-3 font-semibold bg-gray-100 border-b">
                      Account: {accountData.accountNumber} - {accountData.accountName}
                    </th>
                  </tr>
                  <tr className="bg-gray-200">
                    <th className="border px-6 py-3 font-medium">Date</th>
                    <th className="border px-6 py-3 font-medium">Description</th>
                    <th className="border px-6 py-3 font-medium">Debit</th>
                    <th className="border px-6 py-3 font-medium">Credit</th>
                  </tr>
                </thead>
                <tbody>
                  {accountData.transactions.map((transaction, index) => (
                    <tr key={index} className="hover:bg-gray-50">
                      <td className="border px-6 py-3">{transaction.date}</td>
                      <td className="border px-6 py-3 text-left">{transaction.libelle}</td>
                      <td className="border px-6 py-3 font-mono text-right">
                        {parseFloat(transaction.debit || 0).toFixed(2)}
                      </td>
                      <td className="border px-6 py-3 font-mono text-right">
                        {parseFloat(transaction.credit || 0).toFixed(2)}
                      </td>
                    </tr>
                  ))}
                  {/* Totals */}
                  <tr className="bg-gray-100 font-semibold">
                    <td colSpan="2" className="border px-6 py-3 text-right">Total</td>
                    <td className="border px-6 py-3 font-mono text-right">
                      {parseFloat(accountData.totalDebit || 0).toFixed(2)}
                    </td>
                    <td className="border px-6 py-3 font-mono text-right">
                      {parseFloat(accountData.totalCredit || 0).toFixed(2)}
                    </td>
                  </tr>
                  <tr className="bg-gray-200 font-bold">
                    <td colSpan="2" className="border px-6 py-3 text-right">Balance</td>
                    <td colSpan="2" className={`border px-6 py-3 font-mono text-center ${
                      accountData.balanceType === 'Créditeur' 
                        ? 'bg-green-100 text-green-800' 
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {parseFloat(accountData.balance || 0).toFixed(2)} {accountData.balanceType}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}