FROM ubuntu:22.04

WORKDIR /clientdata

RUN apt update && apt upgrade -y && apt install -y wget

COPY ./client-getdata.sh getdata.sh

CMD sh getdata.sh
