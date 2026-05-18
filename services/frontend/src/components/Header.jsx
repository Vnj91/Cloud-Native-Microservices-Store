import React from 'react';
import { Link } from 'react-router-dom';
import { ShoppingCart, User, LogOut, UserPlus } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import './Header.css';

const Header = () => {
  const { user, logout } = useAuth();
  const { cartItems } = useCart();

  const totalItems = cartItems.reduce(
    (sum, item) => sum + item.quantity,
    0
  );

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

          <Link to="/cart" className="nav-link cart-link">
            <ShoppingCart size={20} />
            {totalItems > 0 && (
              <span className="cart-badge">
                {totalItems}
              </span>
            )}
          </Link>

          {user ? (
            <>
              <span className="nav-link">
                Welcome, {user.email}
              </span>

              <button
                onClick={logout}
                className="logout-button"
              >
                <LogOut size={20} />
              </button>
            </>
          ) : (
            <>
              <Link to="/login" className="nav-link">
                <User size={20} />
                Login
              </Link>

              <Link to="/register" className="nav-link">
                <UserPlus size={20} />
                Register
              </Link>
            </>
          )}
        </nav>
      </div>
    </header>
  );
};

export default Header;