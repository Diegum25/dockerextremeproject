#!/bin/bash

# you are smart
# you are smart

IMPORTANT='\e[1m\e[7m' # Bold Invert
SUCCESS="\e[1m\e[37m\e[42m" # Bold White GreenBG
MISSTAKE="\e[1m\e[37m\e[101m" # Bold White RedBG
BLINK="\e[5m" # Blink idk how to make it stop though

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

echo

echo "Launching containers"

echo "Launching backend... "
docker run -p5000:5000 --rm --name "extreme_backend" -d extreme_backend:latest > $DEVNULL

echo "Launching frontend... "
docker run -p3000:3000 --rm --name "extreme_frontend" -d extreme_frontend:latest > $DEVNULL

echo "Launching database... "
docker run --rm --name "extreme_database" -d extreme_database:latest > $DEVNULL

echo

STOPING=0

dockerStop(){
    trap : SIGINT # <- not working
    echo -n -e "\n${BLINK}Stoping...${NC} "
    docker stop extreme_backend extreme_database extreme_frontend > $DEVNULL
    echo -e "${SUCCESS}Done${NC}"
    STOPING=1
}

trap dockerStop SIGINT

echo "Server is ready"
echo "CTRL+C to stop"

echo 

docker container ls

while [ $STOPING -ne 1 ]
do
    sleep 1
done