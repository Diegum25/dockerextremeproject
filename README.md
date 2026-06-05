# Online code race thing

## Idea

Project where users compete against other to code small C programs that then run on a container with a specific input and a desired output.

Code could be rated with both speed of upload and output.

## Running
Edit `CLOUDFLARED_TOKEN` and `CLOUDFLARED_DOMAIN` in `.env` to your cloudflared token and website domain. Or you could ask me for mine.

```sh
# Cloudflared tunnel token

CLOUDFLARED_TOKEN=yourtoken

# Your domain

CLOUDFLARED_DOMAIN=yourdomain.com
```

Then to build and run the containers use docker compose.

```sh
docker-compose -f docker-compose.yaml -f docker-compose.tunnel.yaml up --build
```

Or to test locally.

```sh
docker-compose up --build
```

There are other yaml that you can use in conjuction with the main one to set up volumes so you dont have to rebuild every time.

## Container Setup
``` pre
Host Computer
└── Docker
    ├── Tunnel (Exposes Proxy to the www)
    ├── Proxy (Exposes Frontend & Backend)
    ├── Game Frontend (Client talks to Backend)
    ├── Game Backend (Talks to Builder, Talks back to Frontend client, Talks to DB)
    ├── Builder (Compiles small snippets and runs them, Talks back to backend)
    └── DB (Talks back to backend) (Not implemented yet)
```

### Tunnel (cloudflare/cloudflared:latest)
Cloudflared tunnel.

### Proxy (caddy:alpine)
Caddy proxy.

### Game Frontend (barichello/godot-ci:latest -> node:alpine)
Next app.

Game made with godot.

### Game Backend (node:alpine)
Node app.

Manages game with websockets.

### Builder (node:latest) [Already has gcc]
Node app & gcc.

Gets small snippets of C code, compiles them and returns the output to the backend.

Also keeps track of users.

## Issues / Notes
* hella vulnerable.
* Frontend always takes a long time to compile, and its not the game's fault.
* Nodemon crash doesn't stop the service.
* Everything is being run as root
