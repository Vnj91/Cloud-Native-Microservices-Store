import React, { createContext, useState, useContext } from 'react';
import { createUser, fetchUsers } from '../services/api';

const AuthContext = createContext();

export const useAuth = () => {
  return useContext(AuthContext);
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  // REAL LOGIN USING BACKEND USERS
  const login = async (email, password) => {
    try {
      const users = await fetchUsers();

      const existingUser = users.find(
        (u) => u.email === email
      );

      if (!existingUser) {
        throw new Error('User not found');
      }

      // TEMPORARY PASSWORD CHECK
      // Your backend currently doesn't expose passwords
      // so this is only mock validation
      setUser(existingUser);

      return existingUser;
    } catch (error) {
      console.error('Login failed:', error);
      throw error;
    }
  };

  const logout = () => {
    setUser(null);
  };

  // REAL REGISTER USING BACKEND
  const register = async (username, email, password) => {
    try {
      const newUser = await createUser({
        username,
        email,
        password,
      });

      setUser(newUser);

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

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};