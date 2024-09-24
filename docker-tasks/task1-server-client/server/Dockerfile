FROM nginx:1.27

RUN apt update && apt update -y && apt install -y python3

WORKDIR /serverdata

COPY server-random-text.py ./

RUN python3 server-random-text.py
RUN sha256sum random.txt > checksum
RUN tar -cf data random.txt checksum

COPY nginx.conf /etc/nginx/nginx.conf
