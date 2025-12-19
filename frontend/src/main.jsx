import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import './index.css';
import App from './App';
import JobList from './components/JobList';
import JobForm from './components/JobForm';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/jobs" element={<JobList />} />
        <Route path="/create-job" element={<JobForm />} />
      </Routes>
    </Router>
  </React.StrictMode>
);
