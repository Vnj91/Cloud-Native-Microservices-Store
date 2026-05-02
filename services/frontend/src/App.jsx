import React, { useEffect, useState } from 'react';
import { Users, Package, ShoppingCart, Activity } from 'lucide-react';

const API_BASE = "http://localhost:8080/api";

function App() {
  const [stats, setStats] = useState({ users: 0, products: 0, orders: [] });

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [u, p, o] = await Promise.all([
          fetch(`${API_BASE}/users`).then(res => res.json()),
          fetch(`${API_BASE}/products`).then(res => res.json()),
          fetch(`${API_BASE}/orders`).then(res => res.json())
        ]);
        setStats({ users: u.length, products: p.length, orders: o });
      } catch (err) {
        console.error("Gateway connection failed", err);
      }
    };
    fetchData();
  }, []);

  return (
    <div className="p-8 bg-gray-50 min-h-screen font-sans">
      <h1 className="text-3xl font-bold mb-8 flex items-center gap-2">
        <Activity className="text-blue-600" /> DevOps Store Dashboard
      </h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <StatCard icon={<Users />} label="Total Users" value={stats.users} color="bg-blue-500" />
        <StatCard icon={<Package />} label="Products" value={stats.products} color="bg-green-500" />
        <StatCard icon={<ShoppingCart />} label="Orders" value={stats.orders.length} color="bg-purple-500" />
      </div>

      <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
        <h2 className="text-xl font-semibold mb-4">Recent Orders</h2>
        <table className="w-full text-left">
          <thead>
            <tr className="border-b text-gray-500">
              <th className="pb-3">Order ID</th>
              <th className="pb-3">Product ID</th>
              <th className="pb-3">Status</th>
            </tr>
          </thead>
          <tbody>
            {stats.orders.map(order => (
              <tr key={order.id} className="border-b last:border-0">
                <td className="py-3 font-mono">#{order.id}</td>
                <td className="py-3">Item {order.productId}</td>
                <td className="py-3"><span className="px-2 py-1 bg-yellow-100 text-yellow-700 rounded text-xs uppercase">{order.status}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function StatCard({ icon, label, value, color }) {
  return (
    <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-200 flex items-center gap-4">
      <div className={`${color} p-3 rounded-lg text-white`}>{icon}</div>
      <div>
        <p className="text-gray-500 text-sm">{label}</p>
        <p className="text-2xl font-bold">{value}</p>
      </div>
    </div>
  );
}

export default App;