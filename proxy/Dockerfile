FROM caddy:builder

RUN xcaddy build --with github.com/mholt/caddy-l4

EXPOSE ${EXTREME_PROXY_PORT}

COPY Caddyfile /etc/caddy/Caddyfile

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]