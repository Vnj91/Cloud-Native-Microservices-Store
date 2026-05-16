import React from 'react';
import { useCart } from '../context/CartContext';
import { createOrder } from '../services/api';

const CartPage = () => {
  const { cartItems, removeFromCart, updateQuantity, clearCart } = useCart();

  const handleCheckout = async () => {
    // Assuming a logged-in user with ID 1
    const userId = 1; 
    try {
      await Promise.all(
        cartItems.map((item) =>
          createOrder({
            productId: item.id,
            userId,
            quantity: item.quantity,
          })
        )
      );
      alert('Order placed successfully!');
      clearCart();
    } catch (error) {
      console.error('Failed to place order:', error);
      alert('Failed to place order. Please try again.');
    }
  };

  const total = cartItems.reduce(
    (sum, item) => sum + item.price * item.quantity,
    0
  );

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold text-gray-800 mb-8">Shopping Cart</h1>
      {cartItems.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        <div>
          {cartItems.map((item) => (
            <div
              key={item.id}
              className="flex items-center justify-between border-b py-4"
            >
              <div className="flex items-center">
                <img
                  src={item.imageUrl || 'https://via.placeholder.com/100'}
                  alt={item.name}
                  className="w-20 h-20 object-cover rounded-md mr-4"
                />
                <div>
                  <h2 className="text-lg font-semibold">{item.name}</h2>
                  <p className="text-gray-600">${item.price.toFixed(2)}</p>
                </div>
              </div>
              <div className="flex items-center">
                <input
                  type="number"
                  min="1"
                  value={item.quantity}
                  onChange={(e) =>
                    updateQuantity(item.id, parseInt(e.target.value, 10))
                  }
                  className="w-16 text-center border rounded-md mx-4"
                />
                <button
                  onClick={() => removeFromCart(item.id)}
                  className="text-red-500 hover:text-red-700"
                >
                  Remove
                </button>
              </div>
            </div>
          ))}
          <div className="mt-8 flex justify-end items-center">
            <p className="text-2xl font-bold">Total: ${total.toFixed(2)}</p>
            <button
              onClick={handleCheckout}
              className="ml-8 bg-blue-500 text-white px-6 py-3 rounded-md hover:bg-blue-600"
            >
              Checkout
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default CartPage;
