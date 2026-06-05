# godot game

FROM barichello/godot-ci:latest as game

WORKDIR /www/game

COPY game/ .

RUN mkdir ./build

# wow what the hell
RUN godot --headless --export-release "Web" "./build/index.html"

# frontend

FROM node:alpine

WORKDIR /www/frontend

ENV NEXT_TELEMETRY_DISABLED=1

EXPOSE ${EXTREME_FRONTEND_PORT}

COPY public/ public/
COPY --from=game /www/game/build/* public/godot-game/
COPY src/ src/
COPY eslint.config.mjs .
COPY next.config.ts .
COPY package.json .
COPY postcss.config.mjs .
COPY tsconfig.json .
COPY run.sh .

RUN npm install

CMD sh run.sh