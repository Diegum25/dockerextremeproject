# Online code race thing

## New Idea

Project where users compete against other to code small C programs that then run on a container with a specific input and a desired output.

Code could be rated with both speed of upload and output.

## Container Setup
``` pre
Host Computer
└── Docker
    ├── Game Frontend (Talks to Backend)
    ├── Game Backend (Talks to Builder, Talks back to Frontend)
    └── Builder (Compiles small snippets and runs them, Talks back to backend)
```

### Game Frontend (node:alpine)
Next app.

Possible integration of local C server.

### Game Backend (node:alpine)
Node app.

Manages game.

Communicates with the builder container sending C code retrieved from a user and also parameters and expects an output.

### Builder (node:latest) [Already has gcc]
Node app & gcc.

Gets small snippets of C code, compiles them and returns the output to the backend.

Also keeps track of users.

## Issues / Notes
* We could diversify the backend runtimes used.