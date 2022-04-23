export PATH=~/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx

COMPOSE_FILE_CA=docker/docker-compose-ca.yaml

# TODO: Network Down Pending

clear

# . scripts/utils.sh

echo "Generating certificates using Fabric CA"
docker-compose -f $COMPOSE_FILE_CA up -d