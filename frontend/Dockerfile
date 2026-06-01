# godot game

FROM archlinux as game

WORKDIR /www/game

RUN pacman -Sy godot --noconfirm

COPY game/ .

# wow what the hell
CMD godot --headless --export-release "Web"

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