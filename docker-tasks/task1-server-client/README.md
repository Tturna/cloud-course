# Usage

Run start-server.sh to build and start the server in a Docker container.
Run start-client.sh to build and start the client in a Docker container.

start-client.sh will attempt to connect to the server container using its defined name
(t1server_container). start-server.sh creates this automatically. If the server can't be
found, the client container will detach in interactive mode and wait. At this point,
any functionality is manual.

start-client.sh takes an optional argument "shell", which will run the client container
in interactive mode.

The server is running an nginx web server on port 80 that serves a tar file. The tar file contains
a text file called "random.txt" which has random content generated when the server's
Docker image is built. It also includes a checksum file generated with sha256sum.

If start-client.sh is ran without arguments and the server is running with expected
specifications, the client will automatically run getdata.sh, which is copied onto
the client container during image build. This script pulls the tar file from the server
using wget. The tar file is decompressed and the checksum file is checked with sha256sum.
The contents of "random.txt" are echoed.

# Manual use and explicit confirmation of functionality

To run the setup without the help scripts, build the "client" and "server" directories
using `docker build`. It is recommended to tag the images for later.

```
docker build ./client/ --tag client
```
```
docker build ./server/ --tag server
```

Create a network for the setup.
```
docker network create netname
```

Run the server in detached mode using the created network with the "servervol" volume mount
and port 80. Name the container "t1server_container" for getdata.sh to work properly. 
Alternatively, modify the getdata.sh script or pull the data manually without relying on
the server container name.
```
docker run -d -v servervol:/serverdata --network netname -p80:80 --name t1server_container server
```

If you named the server container "t1server_container", the client should automatically
get the data file when started. Use the `-t` flag to see the output without attaching to
the client container.
```
docker run -t -v clientvol:/clientdata --network netname --name t1client_container client
```

The client should echo the results automatically. To manually inspect the client or
to manually run getdata.sh, run a new client container in interactive mode and
override the default CMD with sh.
```
docker run -it -v clientvol:/clientdata --network netname client sh
```

*Note:*
This is effectively the same as running `start-client.sh shell`, although the script
uses the "t1net" network.


