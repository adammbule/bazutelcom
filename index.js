import express from 'express';
import cors from 'cors';
import careersRoute from './routes/careers.js';
import careersRouteV2 from './routes/careersv2.js';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//app.use('/api/careers', careersRoute);
app.use('/api/careers', careersRouteV2);


app.listen(4000, () => {
  console.log('BazuNode running on port 3000');
});
