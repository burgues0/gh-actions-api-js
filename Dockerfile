FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install && npm audit fix --force

COPY ./api-js/ .

EXPOSE 3000

CMD ["node", "index.js"]
