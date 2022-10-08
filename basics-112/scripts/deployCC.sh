#!/bin/bash

clear
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

## Chaincode parameters
CHANNEL_NAME=mychannel

# CC_NAME=basic
# CC_SEQUENCE=1
# CC_VERSION=1.0
# ORG_CC_VERSION=1.0
# CC_PATH="./asset-transfer-basic/chaincode-javascript/"
# INIT_REQUIRED="NA"

CC_NAME=student
CC_SEQUENCE=1
CC_VERSION=1.0
ORG_CC_VERSION=1.0
CC_PATH="./student-app/chaincode-js/"
INIT_REQUIRED="--init-required"

CC_END_POLICY="NA"
CC_COLL_CONFIG="NA"
CC_LANG=node
CC_INIT_FCN=initLedger
# CC_PATH="./student-app/"
# CC_INIT_FCN_CALL='{"function":"'${CC_INIT_FCN}'","Args":[]}'
CC_INIT_FCN_CALL='{"function":"initLedger","Args":[]}'
# Label Name: Chaincode_Name.Chaincode_Version-Org_specific_version

# Package the chaincode
peer lifecycle chaincode package ${CC_NAME}-${CC_VERSION}.tar.gz --path ${CC_PATH} --lang ${CC_LANG} --label ${CC_NAME}_${CC_VERSION}-${ORG_CC_VERSION}

# Install the chaincode on ORG1
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$PWD/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_TLS_ENABLED=true

peer lifecycle chaincode install ${CC_NAME}-${CC_VERSION}.tar.gz

# This method will initialize PACKAGE_ID variable
queryInstalled() {
  # ORG=$1
  # setGlobals $ORG
  set -x
  peer lifecycle chaincode queryinstalled >&log.txt
  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
  
  echo "Query installed successful on peer0.org1 on channel"
}
queryInstalled

# Approve for org1
ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --package-id ${PACKAGE_ID} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_COLL_CONFIG} ${CC_END_POLICY}

peer lifecycle chaincode checkcommitreadiness --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${CC_VERSION} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_COLL_CONFIG} ${CC_END_POLICY} --output json

################################
# Install the chaincode on ORG2
################################

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_ADDRESS=localhost:9051
export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$PWD/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_TLS_ENABLED=true
peer lifecycle chaincode install ${CC_NAME}-${CC_VERSION}.tar.gz

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --package-id ${PACKAGE_ID} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_END_POLICY} ${CC_COLL_CONFIG} 

# Check commit Readiness for all the orgs

peer lifecycle chaincode checkcommitreadiness --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${CC_VERSION} --sequence ${CC_SEQUENCE} ${INIT_REQUIRED} ${CC_END_POLICY} ${CC_COLL_CONFIG} --output json 
>&log.txt

# Commiting chaincode to org1 & org2
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --sequence ${CC_SEQUENCE} --tls --cafile ${ORDERER_CA} ${INIT_REQUIRED} ${CC_COLL_CONFIG} ${CC_END_POLICY} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} --peerAddresses localhost:7051 --tlsRootCertFiles $PWD/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt >&log.txt

peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name $CC_NAME

printf "\n In this chaincode init is required, so invoking init \n"

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} --peerAddresses localhost:7051 --tlsRootCertFiles $PWD/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --isInit -c ${CC_INIT_FCN_CALL}

printf "\n Adding another student with ID: 103 \n"

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} --peerAddresses localhost:7051 --tlsRootCertFiles $PWD/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --isInit -c '{"function":"createStudent", "Args":["103", "Bharat", "A"]}'

printf "\n Adding new record with inkoke \n"

peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function":"getStudent","Args":["102"]}'

printf "\n Fetching new record with query \n"

peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function":"getStudent","Args":["101"]}'

printf "\n Fetching all students \n"

peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function":"getAllStudents","Args":[]}'