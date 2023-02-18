# Introduction

- Learning from a YouTube channel named [easycs](https://www.youtube.com/channel/UCzgDXG_49Fc_8-h5P8tbl8A) and the [Playlist](https://www.youtube.com/watch?v=NXQWVgC0ej8&list=PLDetT9OKlDzQCaCscqCvyRNtuO9lcAh_c)
- Following the [5th video of the playlist](https://youtu.be/azBTd3OYST0?list=PLDetT9OKlDzQCaCscqCvyRNtuO9lcAh_c)
- We will use the official fabcar example and will modify it to the simplest form
- We will use Javascript based SDK and Chaincode

## Commands

- Below command will download fabric version 2.2.2
- Version 2.2.2 is the latest LTS release of Hyperledger Fabric

  `sudo curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`

- It will create a folder named fabric-sample in current directory
- There is folder named test-network, which comes with:
  - Single Network
  - 2 peers
  - 2 Organizations

## Create a new Fabric Environment

- Now we will delete all the unnecessary files and directories and create a minimum directory structure
- Navigate to the directory where above commands were executed

`cp -r ~/fabric-samples/config/ ~/hyperledger-fabric-basics/basics-101/`

`cp -r ~/fabric-samples/fabcar/ ~/hyperledger-fabric-basics/basics-101/`

`cp -r ~/fabric-samples/test-network/ ~/hyperledger-fabric-basics/basics-101/`

`cp -r ~/fabric-samples/chaincode/ ~/hyperledger-fabric-basics/basics-101/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/abstore/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/marbles02`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/marbles02_private/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/sacc/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/external/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/go/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/java`

`rm -rf ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/typescript/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/fabcar/go/`

`rm -rf ~/hyperledger-fabric-basics/basics-101/fabcar/java`

`rm -rf ~/hyperledger-fabric-basics/basics-101/fabcar/typescript/`

`rm ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.editorconfig`

`rm ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.eslintignore`

`rm ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.eslintrc.js`

`rm ~/hyperledger-fabric-basics/basics-101/chaincode/README.md`

`rm ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/.editorconfig`

`rm ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/.eslintignore`

`rm ~/hyperledger-fabric-basics/basics-101/fabcar/javascript/.eslintrc.js`

## Directories

### bin

- This directory is moved one directory up i.e. parallel to basics-xxx directory
- test-network/network.sh file is updated to the new path of bin which is:
  `export PATH=${PWD}/../../bin:$PATH`

### config

- The configuration

### chaincode

- The smart contracts
- we are using javascript chaincode in this example
- Here we need to install the dependancies of chaincode, based on the language of the chaincode we are using. Eg. if we are using JavaScript based chaincode then using NPM we can install required dependancies.

### fabcar

- This folder contains example smart contracts
- It is recommended that users start with the Asset transfer samples and
  tutorials series for the most recent example smart contracts.

| **Smart Contract** | **Description**                                                                                                                                                                   | **Languages**                    |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| [fabcar](fabcar)   | Basic smart contract that allows you to add and change data on the ledger using the Fabric contract API. Also contains an example on how to run chaincode as an external service. | Go, Java, JavaScript, Typescript |

- The SDK implementation of the fabcar, which will be used to call the chaincode
- Below 4 files are part of SDK, later on we will create web services out of these

#### enrollAdmin.js

- This file is used to enroll an Admin

#### registerUser.js

- We will register a user

#### invoke.js

- used to invoke chaincode

#### query.js

- To query chaincode

### Developing the chaincode

- submitTransaction : To write something to Blockchain
- evaluateTransaction : To query something from Blockchain

## Deploying the Chaincode and starting the Network

- First install npm modules in Chaincode and SDK directory
  - `nvm use 16`
  - `cd ~/hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript`
  - `yarn install`
  - `cd ~/hyperledger-fabric-basics/basics-101/fabcar/javascript`
  - `yarn install`
- Find chaincode in
  - basics-101/chaincode/fabcar/javascript/lib/fabcar.js
- Find SDK code in
  - basics-101/fabcar/javascript/invoke.js
  - basics-101/fabcar/javascript/query.js
- Now we can start the Network with below script, available inside SDK
  - `cd ~/hyperledger-fabric-basics/basics-101/fabcar`
  - `./startFabric.sh javascript`
- Above script will also install chaincode and start the network
- Now we can use the SDK to communicate with the Blockchain
  - `cd ~/hyperledger-fabric-basics/basics-101/fabcar/javascript`
- First we will Enroll the admin user, then we will register the user, to invoke chaincode methods
  - `node enrollAdmin.js`
  - `node registerUser.js`
- We can check the in the couchDB if the values are saved from our chaincode
  - [http://localhost:5984/_utils/]
  - username: admin
  - password: adminpw
  - DB name: mychannel_fabcar
- Now, we can invoke the chaincode methods
  - `node invoke.js`
  - `node query.js`
- Sometimes there may be unused volumes or containers hanging around, make sure to clear them manually.
  - `docker ps`
  - `docker rm [container-id]`
  - `docker volume ls`
  - `docker volume rm [volume-id]`

## Deploying chaincode individually

`./network.sh deployCC -ccn fabcar -ccv 1 -cci initLedger -ccl javascript -ccp ../chaincode/fabcar/javascript/`
