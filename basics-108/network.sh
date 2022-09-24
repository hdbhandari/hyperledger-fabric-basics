#!/bin/bash
./clear.sh
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx
export VERBOSE=false

# Starting docker containers for fabric-ca
docker-compose -f docker/docker-compose-ca.yaml up -d 2>&1
sleep 1
echo "Fabric-CA container started and now creating org1"

function createOrganizations(){
  # Loading helpter functions from below file
  . organizations/fabric-ca/registerEnroll.sh

  # echo "Creating Org1, Org2 and Orderer Identities"
  createOrg1
  createOrg2
  createOrderer
}

function createConnectionProfile(){
  # echo "Generating CCP files for Org1 and Org2"
  ./organizations/ccp-generate.sh
}

function createConsortium(){
  echo "Generating Orderer Genesis block"
  # set -x is used for debugging
  set -x
  configtxgen -profile TwoOrgsOrdererGenesis -channelID system-channel -outputBlock ./system-genesis-block/genesis.block
}

function networkUp(){
  docker-compose -f docker/docker-compose-test-net.yaml -f docker/docker-compose-couch.yaml up -d 2>&1
  # docker-compose -f docker/docker-compose-couch.yaml up -d 2>&1

  docker ps -a
  if [ $? -ne 0 ]; then
    fatalln "Unable to start network"
  fi
}

createOrganizations
createConnectionProfile
createConsortium
networkUp