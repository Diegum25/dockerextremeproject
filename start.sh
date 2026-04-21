#!/bin/bash

docker build ./backend/. -t extremebackend:0.1
docker run -p5000:5000 --rm --name "extreme_backend" -d extremebackend:0.1 


exit(){

}