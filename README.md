# Online code race thing

## New Idea

Project where users compete against other to code small C programs that then run on a container with a specific input and a desired output.

Code could be rated with both speed of upload and output.

## Running
```sh
docker-compose up --build
```

There are other yaml that you can use in conjuction with the main one to set up volumes so you dont have to rebuild every time.

## Container Setup
``` pre
Host Computer
└── Docker
    ├── Proxy (Exposes Frontend & Backend)
    ├── Game Frontend (Client talks to Backend)
    ├── Game Backend (Talks to Builder, Talks back to Frontend client, Talks to DB)
    ├── Builder (Compiles small snippets and runs them, Talks back to backend)
    └── DB (Talks back to backend) (Not implemented yet)

```

### Proxy (caddy:alpine)
Caddy proxy

### Game Frontend (archlinux:latest -> node:alpine)
Next app.

Game made with godot.

### Game Backend (node:alpine)
Node app.

Manages game.

Communicates with the builder container sending C code retrieved from a user and also parameters and expects an output.

### Builder (node:latest) [Already has gcc]
Node app & gcc.

Gets small snippets of C code, compiles them and returns the output to the backend.

Also keeps track of users.

## Issues / Notes
* hella vulnerable.
