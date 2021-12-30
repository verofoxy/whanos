#!/bin/bash

# Turn on bash's job control
set -m

# Start docker service in background
/usr/local/bin/dockerd-entrypoint.sh --storage-driver=overlay2 &

# Wait that the docker service is up
while ! docker info; do
  echo "Waiting docker..."
  sleep 3
done

# Import pre-installed images
docker run -d  -p 5000:5000 --name registry registry:2

# Bring docker service back to foreground
fg %1