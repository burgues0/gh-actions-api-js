FROM node:25-alpine3.22

WORKDIR /app

COPY package*.json ./

RUN npm install && npm audit fix --force

COPY ./api-js/ .

EXPOSE 3000

CMD ["node", "index.js"]
