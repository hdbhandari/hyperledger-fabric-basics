#!/bin/bash
clear
# bash scripts/invoke.sh
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
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_ADDRESS=localhost:9051
export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$PWD/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_TLS_ENABLED=true

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA -C ${CHANNEL_NAME} -n ${CC_NAME} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} --peerAddresses localhost:7051 --tlsRootCertFiles $PWD/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt -c '{"function":"createStudent", "Args":["105", "Bharat", "A"]}'

# printf "\n Fetching all students \n"

# peer chaincode query -C ${CHANNEL_NAME} -n ${CC_NAME} -c '{"function":"getAllStudents","Args":[]}'