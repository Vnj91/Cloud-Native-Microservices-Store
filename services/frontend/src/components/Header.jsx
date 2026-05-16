import React from 'react';
import { Link } from 'react-router-dom';
import { ShoppingCart, User, LogOut } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import './Header.css';

const Header = () => {
  const { user, logout } = useAuth();

  return (
    <header className="site-header">
      <div className="container header-content">
        <Link to="/" className="logo">
          DevOps Store
        </Link>
        <nav className="main-nav">
          <Link to="/products" className="nav-link">
            Products
          </Link>
          <Link to="/cart" className="nav-link">
            <ShoppingCart size={20} />
          </Link>
          {user ? (
            <>
              <span className="nav-link">Welcome, {user.email}</span>
              <button onClick={logout} className="nav-link">
                <LogOut size={20} />
              </button>
            </>
          ) : (
            <Link to="/login" className="nav-link">
              <User size={20} />
            </Link>
          )}
        </nav>
      </div>
    </header>
  );
};

export default Header;
