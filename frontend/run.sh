#!/bin/sh
if [ "$EXTREME_FRONTEND_MODE" = "dev" ]; then
    npm run dev;
elif [ "$EXTREME_FRONTEND_MODE" = "start" ]; then
    npm run build;
    npm run start;
else
    echo EXTREME_FRONTEND_MODE IS NOT SET OR WAS SET TO AN INCORRECT STRING.
fi