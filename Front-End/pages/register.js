import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { FaEnvelope, FaLock, FaUser, FaEye, FaEyeSlash } from 'react-icons/fa';
import AccountNextLogo from './assets/AccouNext.png';

const Register = () => {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = React.useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = React.useState(false);

  const [formData, setFormData] = React.useState({
    full_name: '',
    email: '',
    password: '',
    confirmPassword: '',
    terms: false,
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (formData.password !== formData.confirmPassword) {
      alert('Passwords do not match');
      return;
    }

    if (!formData.terms) {
      alert('Please accept the Terms & Conditions');
      return;
    }

    try {
      const response = await fetch('http://localhost:8000/register.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          full_name: formData.full_name,
          email: formData.email,
          password: formData.password,
        }),
      });

      const data = await response.json();

      if (data.success) {
        alert('Registration successful!');
        navigate('/login');
      } else {
        alert(data.error || 'Registration failed !!!');
      }
    } catch (error) {
      console.error('Error:', error);
      alert('An error occurred while registering !!!');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#083344] to-[#0a4b63] flex flex-col">
      {/* Logo */}
      <div className="p-6">
        <img src={AccountNextLogo} alt="Accounext Logo" className="h-12" />
      </div>

      {/* Register Form */}
      <div className="flex-1 flex items-center justify-center px-4 mb-12">
        <div className="bg-white/10 backdrop-blur-lg p-8 rounded-2xl shadow-2xl w-full max-w-md transform transition-all duration-500 hover:scale-[1.02]">
          <h2 className="text-3xl font-bold text-center mb-8 text-white">Create Account</h2>

          <form className="space-y-6" onSubmit={handleSubmit}>
            {/* Full Name */}
            <div className="space-y-2">
              <label htmlFor="name" className="block text-sm font-medium text-white/90">Full Name</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaUser className="text-white/70" />
                </div>
                <input
                  type="text"
                  id="name"
                  name="full_name"
                  value={formData.full_name}
                  onChange={handleChange}
                  required
                  className="w-full pl-10 pr-4 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
                  placeholder="Enter your full name"
                />
              </div>
            </div>

            {/* Email */}
            <div className="space-y-2">
              <label htmlFor="email" className="block text-sm font-medium text-white/90">Email</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaEnvelope className="text-white/70" />
                </div>
                <input
                  type="email"
                  id="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  required
                  className="w-full pl-10 pr-4 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
                  placeholder="Enter your email"
                />
              </div>
            </div>

            {/* Password */}
            <div className="space-y-2">
              <label htmlFor="password" className="block text-sm font-medium text-white/90">Password</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaLock className="text-white/70" />
                </div>
                <input
                  type={showPassword ? 'text' : 'password'}
                  id="password"
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  required
                  className="w-full pl-10 pr-12 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
                  placeholder="Create a password"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute inset-y-0 right-0 pr-3 flex items-center text-white/70 hover:text-white transition-colors duration-300"
                >
                  {showPassword ? <FaEyeSlash /> : <FaEye />}
                </button>
              </div>
            </div>

            {/* Confirm Password */}
            <div className="space-y-2">
              <label htmlFor="confirmPassword" className="block text-sm font-medium text-white/90">Confirm Password</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaLock className="text-white/70" />
                </div>
                <input
                  type={showConfirmPassword ? 'text' : 'password'}
                  id="confirmPassword"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  required
                  className="w-full pl-10 pr-12 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
                  placeholder="Confirm your password"
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute inset-y-0 right-0 pr-3 flex items-center text-white/70 hover:text-white transition-colors duration-300"
                >
                  {showConfirmPassword ? <FaEyeSlash /> : <FaEye />}
                </button>
              </div>
            </div>

            {/* Terms & Conditions */}
            <div className="flex items-center">
              <input
                id="terms"
                name="terms"
                type="checkbox"
                checked={formData.terms}
                onChange={handleChange}
                className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                required
              />
              <label htmlFor="terms" className="ml-2 block text-sm text-white/90">
                I accept the <a href="#" className="text-blue-400 hover:text-blue-300">Terms & Conditions</a>
              </label>
            </div>

            {/* Register Button */}
            <button
              type="submit"
              className="w-full bg-blue-500 text-white py-3 rounded-lg font-medium hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2 transition-all duration-300 transform hover:scale-[1.02]"
            >
              Create Account
            </button>
          </form>

          <div className="mt-6 text-center">
            <p className="text-sm text-white/70">
              Already have an account?{' '}
              <Link to="/login" className="text-blue-400 hover:text-blue-300 transition-colors duration-300">
                Sign in
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};


export default Register;