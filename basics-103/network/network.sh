#!/bin/bash

export PATH=${PWD}/../../bin:$PATH

clear

rm -rf ./crypto-config/

# Generating configuration
## crypto-config is the default directory name

cryptogen generate --config=../organizations/cryptogen/crypto-config-orderer.yaml --output=./crypto-config
cryptogen generate --config=../organizations/cryptogen/crypto-config-org1.yaml --output=./crypto-config
cryptogen generate --config=../organizations/cryptogen/crypto-config-org2.yaml --output=./crypto-config

# Extending configuration
cryptogen extend --config=../organizations/cryptogen/crypto-config-orderer-peer-extend.yaml --input=./crypto-config