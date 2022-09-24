#!/bin/bash

export PATH=${PWD}/../bin:$PATH
./clear.sh

docker-compose -f docker/docker-compose-ca.yaml up -d 2>&1
sleep 1

echo "Fabric-CA container started and now creating org1"

# Loading helpter functions from below file
. organizations/fabric-ca/registerEnroll.sh

# echo "Creating Org1 Identities"
createOrg1

# echo "Creating Org2 Identities"
createOrg2

# echo "Creating Orderer Org Identities"
createOrderer

# echo "Generating CCP files for Org1 and Org2"
./organizations/ccp-generate.sh