# Online code race thing

## New Idea

Project where users compete against other to code small C programs that then run on a container with a specific input and a desired output.

Code could be rated with both speed of upload and output.

## Running
### Docker
```sh
docker-compose up --build
```

Thats it.

There are other yaml that you can use in conjuction with the main one to set up volumes so you dont have to rebuild every time.

### Locally
With npm on each folder.

```sh
npm install # if you dont have node_modules
npm run dev
```

> [!NOTE]  
> Make sure to set up the variables from or like the .env in the root folder.

> [!NOTE]  
> Make sure to place the game at frontend/public/godot-game.

## Tunneling

An https connection is required for a client to connect.

```sh
npx cloudflared tunnel --url http://localhost:$EXTREME_PROXY_PORT
```

## Container Setup
``` pre
Host Computer
└── Docker
    ├── Game Frontend (Talks to Backend)
    ├── Game Backend (Talks to Builder, Talks back to Frontend, Talks to DB)
    ├── Builder (Compiles small snippets and runs them, Talks back to backend)
    └── DB (Talks back to frontend)

```

### Game Frontend (archlinux -> node:alpine)
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
