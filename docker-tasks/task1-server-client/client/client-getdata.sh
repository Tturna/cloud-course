#!/usr/bin/sh

echo "\nPulling data from server..."
wget "t1server_container/data" -O data
echo "Decompressing..."
tar -xf data
echo "Comparing checksum..."
sha256sum -c checksum
echo "Data:"
cat random.txt
