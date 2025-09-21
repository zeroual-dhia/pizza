const express = require('express');
const app = express();
const userRoutes = require('./routes/user');

app.use(express.json());

// Routes
app.use('/api', userRoutes);

const PORT = 5000;
app.listen(PORT, () => console.log(` Server running on port ${PORT}`));