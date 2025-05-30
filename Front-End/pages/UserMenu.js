import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaUserCircle, FaSignOutAlt } from 'react-icons/fa';

const UserMenu = () => {
  const navigate = useNavigate();
  const user = JSON.parse(localStorage.getItem('user'));

  const handleLogout = () => {
    localStorage.removeItem('user');
    navigate('/login');
  };

  if (!user) return null;

  return (
    <div className="flex items-center justify-end gap-4 text-[083344] px-6 py-4 absolute top-2 right-0">
        <div className="flex items-center gap-1">
            <FaUserCircle className="text-2xl" />
            <span className="text-sm font-medium">{user.full_name}</span>

        </div>
        <div className="flex items-center">
            <button
                onClick={handleLogout}
                className="flex items-center gap-2 text-sm bg-red-500 hover:bg-red-600 px-3 py-1.5 rounded-lg transition"
            >
                <FaSignOutAlt />
                Déconnexion
            </button>
        </div>
    </div>
  );
};

export default UserMenu;
