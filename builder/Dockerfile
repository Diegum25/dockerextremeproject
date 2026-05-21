FROM node:latest

RUN apt-get update

RUN apt-get upgrade -y

WORKDIR /www/builder

COPY package.json .
COPY src/ src/

ARG EXTREME_BUILDER_PORT

ENV EXTREME_BUILDER_PORT=${EXTREME_BUILDER_PORT}

EXPOSE ${EXTREME_BUILDER_PORT}

RUN npm install

CMD npm run dev