# starting image, as small as possible
FROM alpine:3.19

# working directory
WORKDIR /usr/src/app

# copy local file to container's internal directory
# first parameter is local relative path, second parameter is container internal path relative to work dir defined above
COPY hello.sh ./

# Adding required exec rights
# RUN chmod +x hello.sh

# Instead of creating an image that only includes hello.sh, then opening the container instance,
# adding a new file, then committing that container into a new image, we can just change the
# original Dockerfile, which is much less cumbersome.
RUN touch lisays.txt

# When the container is started, execute our file
# Only one CMD command can be given in a Dockerfile
CMD ./hello.sh
