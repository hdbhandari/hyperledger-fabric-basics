#!/bin/bash

export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/config
export CFG_OUT_PATH=${PWD}/config-out

# export FABRIC_LOGGING_SPEC=debug
# export ORDERER_GENERAL_LOGLEVEL=debug

clear

# Before generating, deleting existing crypto material, Genesis and channel Tx
rm -rf ${CFG_OUT_PATH}

# Generating Crypto Material
cryptogen generate  --output=${CFG_OUT_PATH}/organizations --config=./config/crypto-config.yaml

# Generating Genesis Block
configtxgen -channelID=apple-channel -profile=AppleOrdererGenesis -outputBlock=${CFG_OUT_PATH}/genesis.block

# Generating Channel Transaction
configtxgen -channelID=apple-channel -profile=apple-channel-profile -outputCreateChannelTx=${CFG_OUT_PATH}/AppleSamsung.channel.tx

# Inspect Genesis Block
mkdir -p ${CFG_OUT_PATH}/json

configtxgen -inspectBlock ${CFG_OUT_PATH}/genesis.block > ${CFG_OUT_PATH}/json/genesis.json

configtxgen -inspectChannelCreateTx ${CFG_OUT_PATH}/AppleSamsung.channel.tx > ${CFG_OUT_PATH}/json/AppleSamsung.channel.json

# Start the orderer
orderer