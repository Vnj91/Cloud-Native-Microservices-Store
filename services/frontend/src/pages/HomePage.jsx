import React from 'react';
import { Link } from 'react-router-dom';
import './HomePage.css';

const HomePage = () => {
  return (
    <div className="homepage-container">
      <div className="hero-section">
        <h1 className="hero-title">Welcome to the DevOps Store</h1>
        <p className="hero-subtitle">
          Your one-stop shop for the best tools and resources.
        </p>
        <Link to="/products">
          <button className="hero-button">
            Shop Now
          </button>
        </Link>
      </div>
    </div>
  );
};

export default HomePage;
