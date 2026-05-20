FROM node:alpine

WORKDIR /www/app

COPY package.json .
COPY main.js .

ARG EXTREME_BACKEND_PORT

ENV EXTREME_BACKEND_PORT=${EXTREME_BACKEND_PORT}

EXPOSE ${EXTREME_BACKEND_PORT}

COPY main.js .
COPY package.json .

RUN npm install

CMD npm run dev