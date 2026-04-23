#!/bin/bash

# you are smart
# you are smart

IMPORTANT='\e[1m\e[7m' # Bold Invert
SUCCESS="\e[1m\e[37m\e[42m" # Bold White GreenBG
MISSTAKE="\e[1m\e[37m\e[101m" # Bold White GreenBG
NC='\e[0m' # Reset

DEVNULL=/dev/null

echo "Building images"

build(){
    echo -n "Building $1... "
    log=$(docker build ./$1/. -t extreme_$1 2>&1 >$DEVNULL)
    if [ $? -eq 0 ]; then
        echo -e "${SUCCESS}Done${NC}"
    else
        echo -e "${MISSTAKE}Error${NC}"
        error=$(echo "$log" | tail -n 1)
        echo -e "${IMPORTANT}${error}${NC}"
        exit 1
    fi
}

build backend
build frontend
build database

echo "Launching containers"

echo -n "Launching backend... "
docker run -p5000:5000 --rm --name "extreme_backend" -d extreme_backend:latest > $DEVNULL

echo -n "Launching frontend... "
docker run -p8080:8080 --rm --name "extreme_frontend" -d extreme_frontend:latest > $DEVNULL

echo -n "Launching database... "
docker run --rm --name "extreme_database" -d extreme_database:latest > $DEVNULL

trap : SIGINT

echo "Server is ready"
echo "CTRL+C to stop"
echo "CTRL+Z to stop fr smh ts pmo son"

while :
do
    sleep 1
done