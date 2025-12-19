import React, { useState } from "react";
import axios from "axios";

const ReservationForm = () => {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    check_in: "",
    check_out: "",
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post("/reservations/", formData);
      alert("Reservation created successfully!");
    } catch (error) {
      console.error("Error creating reservation:", error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        name="name"
        placeholder="Name"
        value={formData.name}
        onChange={handleChange}
        required
      />
      <input
        type="email"
        name="email"
        placeholder="Email"
        value={formData.email}
        onChange={handleChange}
        required
      />
      <input
        type="date"
        name="check_in"
        value={formData.check_in}
        onChange={handleChange}
        required
      />
      <input
        type="date"
        name="check_out"
        value={formData.check_out}
        onChange={handleChange}
        required
      />
      <button type="submit">Create Reservation</button>
    </form>
  );
};

export default ReservationForm;