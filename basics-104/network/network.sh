#!/bin/bash

# Setting path to bin directory
export PATH=${PWD}/../../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx

# Cleaning the directories
rm -rf crypto-config/

## cryptogen tool

cryptogen generate --config=../organizations/cryptogen/crypto-config.yaml

## configtxgen

configtxgen -profile HlfOrdererGenesis -outputBlock ./system-genesis-block/hlf-genesis.block -channelID HlfChannel
