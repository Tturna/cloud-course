#!/usr/bin/sh

docker build ./server/ --tag t1server

if ! docker network ls | grep -q "t1net"; then
    echo "network \"t1net\" doesn't exist. Creating...";
    docker network create t1net;
fi

if docker container ps | grep -q "t1server_container"; then
    echo "t1server_container is already running. Force removing...";
    docker container rm -f t1server_container;
fi

if docker container ps -a | grep -q "t1server_container"; then
    echo "t1server_container already exists. Force removing...";
    docker container rm -f t1server_container;
fi

echo "Starting server..."
docker run -d --network t1net -v servervol:/serverdata --name t1server_container -p80:80 t1server:latest
echo "Listening on port 80..."
