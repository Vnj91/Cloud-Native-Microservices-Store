import React, { createContext, useState, useContext } from 'react';
import { createUser } from '../services/api';

const AuthContext = createContext();

export const useAuth = () => {
  return useContext(AuthContext);
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  const login = (userData) => {
    // In a real app, you'd verify credentials with the backend
    setUser(userData);
  };

  const logout = () => {
    setUser(null);
  };

  const register = async (username, email) => {
    try {
      const newUser = await createUser({ username, email });
      // Log in the new user automatically after registration
      login(newUser);
      return newUser;
    } catch (error) {
      console.error('Registration failed:', error);
      throw error;
    }
  };

  const value = {
    user,
    login,
    logout,
    register,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
