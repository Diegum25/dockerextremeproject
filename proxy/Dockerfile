FROM caddy:builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare

ARG EXTREME_PROXY_PORT

ENV EXTREME_PROXY_PORT=${EXTREME_PROXY_PORT}

EXPOSE ${EXTREME_PROXY_PORT}

COPY Caddyfile /etc/caddy/Caddyfile

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]