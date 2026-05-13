# Online code race thing

## New Idea

Project where users compete against other to code small C programs that then run on a container with a specific input and a desired output.

Code could be rated with both speed of upload and output.

## Container Setup
``` pre
Host Computer
├── Docker
│   ├── Game Frontend
│   ├── Game Backend (Talks to Builder and the Runner container launcher)
│   ├── Builder
│   └── Runners (spawned)
└── Runner container launcher
```

### Game Frontend (node:alpine)
Next app.

Possible integration of local C server.

### Game Backend (node:alpine)
Node app.

Manages game.

Communicates with the builder container and the runner launcher.

### Builder (node:latest)
Node app & GCC.

Gets small snippets of C code.

Should give the output back to the game backend.

### Runners (ubuntu:rolling)
Ubuntu image.

Run the user's program.

### Runner Launcher (host)
Node app.

Communicates with the host's docker to launch runners with the user's program.

## Issues / Notes
* There should also be a way to dockerize the runner launcher.
* Maybe we could use alpine images for both the buider and the runner (they need to have the same runtime libs).
* We could diversify the backend runtimes used.