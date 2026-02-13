const express = require('express');
const cors = require('cors');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors({
  origin: '*',
  methods: ['GET'],
  allowedHeaders: ['Content-Type']
}));

app.use(express.json());

const NBU_EXCHANGE_SITE = 'https://bank.gov.ua/NBU_Exchange/exchange_site';

app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'NBU Proxy Server is running' });
});

app.get('/api/exchange', async (req, res) => {
  try {
    const { start, end, valcode, sort, order } = req.query;

    if (!start || !end) {
      return res.status(400).json({
        error: 'Missing required parameters',
        message: 'start and end are required'
      });
    }

    let url = `${NBU_EXCHANGE_SITE}?start=${start}&end=${end}&json`;

    if (valcode) url += `&valcode=${valcode}`;
    if (sort) url += `&sort=${sort}`;
    if (order) url += `&order=${order}`;

    const response = await axios.get(url);
    res.json(response.data);
  } catch (error) {
    console.error('Error fetching exchange rates:', error.message);
    res.status(error.response?.status || 500).json({
      error: 'Failed to fetch exchange rates',
      message: error.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`Proxy Server running on http://localhost:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/health`);
});
