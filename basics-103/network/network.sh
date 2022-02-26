#!/bin/bash

../../bin/cryptogen generate --config=../organizations/cryptogen/crypto-config-orderer.yaml

../../bin/cryptogen generate --config=../organizations/cryptogen/crypto-config-org1.yaml

../../bin/cryptogen generate --config=../organizations/cryptogen/crypto-config-org2.yaml

../../bin/cryptogen extend --config=../organizations/cryptogen/crypto-config-orderer-peer-extend.yaml