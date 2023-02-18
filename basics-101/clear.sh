#!/bin/bash

pushd ~/hyperledger-fabric-basics/basics-101/test-network
./network.sh down
popd

rm -r ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/node_modules
rm ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/package-lock.json
rm ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/yarn.lock

rm -r ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/node_modules
rm ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/package-lock.json
rm ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/yarn.lock

pushd ~/hyperledger-fabric-basics
./clean-docker.sh
popd
