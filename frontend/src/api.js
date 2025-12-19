import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8001/api', // Update baseURL to match backend API_PREFIX
});

export default api;