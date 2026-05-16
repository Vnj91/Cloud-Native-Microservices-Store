import React from 'react';
import { Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';
import './ProductCard.css';

const ProductCard = ({ product }) => {
  const { addToCart } = useCart();

  return (
    <div className="product-card">
      <Link to={`/products/${product.id}`} className="product-image-link">
        <img src={product.imageUrl || 'https://via.placeholder.com/300'} alt={product.name} className="product-image" />
      </Link>
      <div className="product-info">
        <h3 className="product-name">
          <Link to={`/products/${product.id}`}>{product.name}</Link>
        </h3>
        <p className="product-price">${product.price.toFixed(2)}</p>
        <button
          onClick={() => addToCart(product)}
          className="add-to-cart-button"
        >
          Add to Cart
        </button>
      </div>
    </div>
  );
};

export default ProductCard;
