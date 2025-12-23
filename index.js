import express from 'express';
import cors from 'cors';
import careersRoute from './routes/careers.js';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/careers', careersRoute);

app.listen(3000, () => {
  console.log('BazuNode running on port 3000');
});
