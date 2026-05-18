import React from 'react';
import { Link } from 'react-router-dom';
import { ShoppingCart, User, LogOut } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import './Header.css';

const Header = () => {
  const { user, logout } = useAuth();
  const { cartItems } = useCart();

  const cartCount = cartItems.reduce(
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

            {cartCount > 0 && (
              <span className="cart-badge">
                {cartCount}
              </span>
            )}
          </Link>

          {user ? (
            <>
              <span className="nav-link">
                Welcome, {user.email}
              </span>

              <button onClick={logout} className="nav-link logout-btn">
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