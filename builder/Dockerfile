FROM node:latest

RUN apt-get update

RUN apt-get upgrade -y

WORKDIR /builder

COPY package.json .
COPY main.js .

EXPOSE 3000

RUN npm install

CMD npm run run