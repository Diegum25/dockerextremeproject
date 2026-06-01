FROM node:latest

RUN apt-get update

RUN apt-get upgrade -y

WORKDIR /www/builder

COPY package.json .
COPY src/ src/

EXPOSE ${EXTREME_BUILDER_PORT}

RUN npm install

CMD npm run dev