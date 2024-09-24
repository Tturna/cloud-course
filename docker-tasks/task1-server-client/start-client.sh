#!/usr/bin/sh

docker build ./client/ --tag t1client

if docker container ps | grep -q "t1client_container"; then
    echo "t1client_container is already running. Force removing...";
    docker container rm -f t1client_container;
fi

if docker container ps -a | grep -q "t1client_container"; then
    echo "t1client_container already exists. Force removing...";
    docker container rm -f t1client_container;
fi

if docker volume ls | grep -q "clientvol"; then
    echo "clientvol volume already exists. Removing...";
    docker volume rm clientvol;
fi

if [ $# -gt 0 ]; then
    if [ "$1" == "shell" ]; then
        docker run -it --network t1net -v clientvol:/clientdata --name t1client_container t1client sh;
        exit 0;
    fi
fi

if ! docker container ps | grep -q "t1server_container"; then
    echo "Couldn't find running server \"t1server_container\". Scripts won't autostart.";

    if ! docker network ls | grep -q "t1net"; then
        echo "network \"t1net\" doesn't exist. Creating...";
        docker network create t1net;
    fi

    docker run -dit --network t1net -v clientvol:/clientdata --name t1client_container t1client sh
else
    echo "Starting client (autorunning scripts)...";
    docker run -t --network t1net -v clientvol:/clientdata --name t1client_container t1client;
fi
