FROM node:alpine

WORKDIR /www/backend

ARG EXTREME_BACKEND_PORT

EXPOSE ${EXTREME_BACKEND_PORT}
EXPOSE ${EXTREME_BACKEND_WS_PORT}

COPY package.json .
COPY src/ src/

RUN npm install

CMD npm run dev