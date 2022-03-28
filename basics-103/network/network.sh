#!/bin/bash

export PATH=${PWD}/../bin:$PATH

# Generating configuration
cryptogen generate --config=../organizations/cryptogen/crypto-config-orderer.yaml
cryptogen generate --config=../organizations/cryptogen/crypto-config-org1.yaml
cryptogen generate --config=../organizations/cryptogen/crypto-config-org2.yaml

# Extending configuration
cryptogen extend --config=../organizations/cryptogen/crypto-config-orderer-peer-extend.yaml