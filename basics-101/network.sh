#!/bin/bash

export PATH=$PATH:/usr/local/go/bin
go version

# nvm use 16

pushd ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript
yarn install
popd

pushd ~/hyperledger-fabric-basics/basics-101/fabcar/javascript
yarn install
popd

pushd ~/hyperledger-fabric-basics/basics-101/fabcar
./startFabric.sh javascript
popd

pushd ~/hyperledger-fabric-basics/basics-101/fabcar/javascript
node enrollAdmin.js
node registerUser.js
node invoke.js
node query.js
popd
