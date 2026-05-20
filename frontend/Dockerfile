FROM node:alpine

WORKDIR /www/frontend

ARG EXTREME_FRONTEND_PORT

ENV EXTREME_FRONTEND_PORT=${EXTREME_FRONTEND_PORT}

EXPOSE ${EXTREME_FRONTEND_PORT}

COPY public/ public/
COPY src/ src/
COPY eslint.config.mjs .
COPY next.config.ts .
COPY package.json .
COPY postcss.config.mjs .
COPY tsconfig.json .


RUN npm install

CMD npm run dev
