#!/bin/bash

clear

# Stop all containers
docker stop `docker ps -qa`

# Remove all containers
docker rm `docker ps -qa`

# Remove all images
## NOTE: WE DON'T WANT TO DELETE IMAGES ALWAYS
# docker rmi -f `docker images -qa`

# Remove all volumes
docker volume rm $(docker volume ls -qf)

# Remove all networks
docker network rm `docker network ls -q`

# Your installation should now be all fresh and clean.

echo "*********************************"
echo "Everything from Docker is Deleted."
echo "*********************************"

# The following commands should not output any items:
docker ps -a
docker images -a 
docker volume ls

# The following command show only show the default networks:
docker network ls

echo "now running prune"
docker system prune --volumes -f
