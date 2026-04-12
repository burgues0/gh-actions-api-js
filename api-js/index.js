import express from 'express';
import helmet from 'helmet';
import router from './router.js';
import db from './database.js';

const app = express();
const port = 3000;

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true,
  },
}));
app.use((req, res, next) => {
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
  res.setHeader('Pragma', 'no-cache');
  res.setHeader('Expires', '0');
  next();
});
app.use(express.json());
app.use('/', router);

try {
    await db.authenticate();
    console.log("Eba!");
} catch (error) {
    console.log("Não eba...");
}

app.listen(port, () => {
    console.log(`Rodando na porta ${port}.`);
});