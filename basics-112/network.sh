#!/bin/bash

./clear.sh
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx
export VERBOSE=false

CHANNEL_NAME="mychannel"
CLI_DELAY=3
MAX_RETRY=5

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

function createChannel(){
  scripts/createChannel.sh $CHANNEL_NAME $CLI_DELAY $MAX_RETRY $VERBOSE
}

CC_NAME="basic"
CC_SRC_PATH="./asset-transfer-basic/"
CC_SRC_LANGUAGE="javascript"
CC_VERSION="1.0"
CC_SEQUENCE=1
CC_INIT_FCN="NA"
# endorsement policy defaults to "NA". This would allow chaincodes to use the majority default policy.
CC_END_POLICY="NA"
# collection configuration defaults to "NA"
# default for delay between commands
CC_COLL_CONFIG="NA"

createOrganizations
createConnectionProfile
createConsortium
networkUp

createChannel

# Installing node-modules for the chaincode
pushd student-app/chaincode-js
npm install
popd

# Deploy and Invoke the chaincode
bash scripts/deployCC.sh


# Installing node-modules for the application
# pushd student-app/application-js
# npm install
# popd
