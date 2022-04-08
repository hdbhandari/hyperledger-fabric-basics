# Introduction

1. Learning cryptogen tool
2. Now generating folder structure, will try to keep it in sync with the fabric samples directory

## Directory Structure

```bash
cd hyperledger-fabric-basics/
mkdir basics-103
chmod -R 755 basics-103
cd basics-103/
cd ~
cp -R fabric-samples/bin/ hyperledger-fabric-basics/basics-103
mkdir hyperledger-fabric-basics/basics-103/organizations
mkdir hyperledger-fabric-basics/basics-103/network
echo "" > hyperledger-fabric-basics/basics-103/network.sh
echo "" > hyperledger-fabric-basics/basics-103/network/network.sh
mkdir hyperledger-fabric-basics/basics-103/organizations/cryptogen
echo "" > hyperledger-fabric-basics/basics-103/organizations/cryptogen/crypto-config-orderer.yaml
echo "" > hyperledger-fabric-basics/basics-103/organizations/cryptogen/crypto-config-org1.yaml
echo "" > hyperledger-fabric-basics/basics-103/organizations/cryptogen/crypto-config-org2.yaml
echo "" > hyperledger-fabric-basics/basics-103/organizations/cryptogen/crypto-config-orderer-peer-extend.yaml
```
