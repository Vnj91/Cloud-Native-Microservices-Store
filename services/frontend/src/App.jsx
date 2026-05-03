import React, { useEffect, useState } from 'react';
import { Users, Package, ShoppingCart, Activity, BarChart as BarChartIcon } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import './App.css';

const API_BASE = import.meta.env.VITE_API_BASE || "http://localhost:8080/api";

function App() {
  const [stats, setStats] = useState({ users: 0, products: 0, orders: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [u, p, o] = await Promise.all([
          fetch(`${API_BASE}/users`).then(res => res.json()),
          fetch(`${API_BASE}/products`).then(res => res.json()),
          fetch(`${API_BASE}/orders`).then(res => res.json())
        ]);
        setStats({ users: u.length, products: p.length, orders: o });
        setError(null);
      } catch (err) {
        console.error("Gateway connection failed", err);
        setError("Failed to connect to the API gateway. Please ensure it's running and accessible.");
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  const orderData = stats.orders.reduce((acc, order) => {
    const key = `Product ${order.productId}`;
    const existing = acc.find(item => item.name === key);
    if (existing) {
      existing.orders++;
    } else {
      acc.push({ name: key, orders: 1 });
    }
    return acc;
  }, []);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-xl font-semibold">Loading Dashboard...</div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-red-50">
        <div className="text-xl font-semibold text-red-600 p-8 bg-white shadow-lg rounded-lg">{error}</div>
      </div>
    )
  }

  return (
    <div className="container p-8">
      <header className="mb-10">
        <h1 className="text-4xl font-bold text-gray-800 flex items-center gap-3">
          <Activity className="text-indigo-600" size={40} /> 
          <span>DevOps Store Analytics</span>
        </h1>
        <p className="text-gray-500 mt-1">Real-time insights into your microservices-based store.</p>
      </header>
      
      <div className="dashboard-grid">
        <StatCard icon={<Users />} label="Total Users" value={stats.users} color="blue" />
        <StatCard icon={<Package />} label="Available Products" value={stats.products} color="green" />
        <StatCard icon={<ShoppingCart />} label="Total Orders" value={stats.orders.length} color="purple" />
      </div>

      <div className="chart-container">
        <h2 className="text-2xl font-semibold mb-6 flex items-center gap-2">
          <BarChartIcon />
          Orders per Product
        </h2>
        <div style={{ width: '100%', height: 350 }}>
          <ResponsiveContainer>
            <BarChart data={orderData} margin={{ top: 5, right: 20, left: -10, bottom: 5 }}>
              <CartesianGrid strokeDasharray="3 3" stroke="var(--border)" />
              <XAxis dataKey="name" stroke="var(--text)" />
              <YAxis allowDecimals={false} stroke="var(--text)" />
              <Tooltip 
                contentStyle={{ 
                  backgroundColor: 'var(--bg)', 
                  border: '1px solid var(--border)',
                  color: 'var(--text-h)'
                }} 
              />
              <Legend />
              <Bar dataKey="orders" fill="var(--accent)" name="Number of Orders" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
}

function StatCard({ icon, label, value, color }) {
  return (
    <div className="stat-card">
      <div className={`icon-wrapper ${color}`}>
        {React.cloneElement(icon, { size: 28 })}
      </div>
      <div>
        <p className="label">{label}</p>
        <p className="value">{value}</p>
      </div>
    </div>
  );
}

export default App;