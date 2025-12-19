import React from "react";
import ReservationForm from "./components/ReservationForm";
import ReservationList from "./components/ReservationList";
import './index.css';

const App = () => {
  return (
    <div className="container">
      <h1>Hotel Reservation System</h1>

      <div className="form-card">
        <h2>Create Reservation</h2>
        <ReservationForm />
      </div>

      <div className="table-card">
        <ReservationList />
      </div>
    </div>
  );
};

export default App;
