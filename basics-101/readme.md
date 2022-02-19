# Introduction

- Learning from a YouTube channel named [easycs](https://www.youtube.com/channel/UCzgDXG_49Fc_8-h5P8tbl8A) and the [Playlist](https://www.youtube.com/watch?v=NXQWVgC0ej8&list=PLDetT9OKlDzQCaCscqCvyRNtuO9lcAh_c)
- Following the [5th video of the playlist](https://youtu.be/azBTd3OYST0?list=PLDetT9OKlDzQCaCscqCvyRNtuO9lcAh_c)
- We will use the official fabcar example and will modify it to the simplest form
- We will use Javascript based SDK and Chaincode

## Commands

- Below command will download fabric version 2.2.2 which is the latest LTS release of Hyperledger Fabric
  `curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`
- It will create a folder named fabric-sample in current directory
- There is folder named test-network,which comes with:
  - Single Network
  - 2 peers
  - 2 Organizations

## Create a new Fabric Environment

- Now we will delete all the unnecessary files and directories and create a minimum directory structure

`sudo cp -r fabric-samples/bin/ hyperledger-fabric-basics/basics-101/`

`sudo cp -r fabric-samples/config/ hyperledger-fabric-basics/basics-101/`

`sudo cp -r fabric-samples/fabcar/ hyperledger-fabric-basics/basics-101/`

`sudo cp -r fabric-samples/test-network/ hyperledger-fabric-basics/basics-101/`

`sudo cp -r fabric-samples/chaincode/ hyperledger-fabric-basics/basics-101/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/abstore/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/marbles02`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/marbles02_private/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/sacc/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/fabcar/external/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/fabcar/go/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/fabcar/java`

`sudo rm -rf hyperledger-fabric-basics/basics-101/chaincode/fabcar/typescript/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/fabcar/go/`

`sudo rm -rf hyperledger-fabric-basics/basics-101/fabcar/java`

`sudo rm -rf hyperledger-fabric-basics/basics-101/fabcar/typescript/`

`sudo rm hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.editorconfig`

`sudo rm hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.eslintignore`

`sudo rm hyperledger-fabric-basics/basics-101/chaincode/fabcar/javascript/.eslintrc.js`

`sudo rm /home/hdb/hyperledger-fabric-basics/basics-101/chaincode/README.md`

## Directories

### bin

- contains the binaries files

### config

- The configuration

### chaincode

- The smart contracts
- we are using javascript chaincode in this example
- need to run `npm i`

### fabcar

This folder contains example smart contracts. It is recommended that users start with the Asset transfer samples and tutorials series for the most recent example smart contracts.

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

### Make changes into the chaincode

- submitTransaction : To write something to Blockchain
- evaluateTransaction : To query something from Blockchain

## Developing Chaincode

- First install npm modules in Chaincode and SDK directory
  - basics-101/chaincode/fabcar/javascript
  - basics-101/fabcar/javascript
- Find chaincode in
  - basics-101/chaincode/fabcar/javascript/lib/fabcar.js
- Find updated SDK code in
  - basics-101/fabcar/javascript/invoke.js
  - basics-101/fabcar/javascript/query.js
- Now we can start the Network with below script, available inside SDK
  - `cd ~`
  - `cd hyperledger-fabric-basics/basics-101/fabcar`
  - `sudo ./startFabric.sh javascript`
- Above script will also install chaincode and start the network
- Now we can use the SDK to communicate with the Blockchain
  - `cd ~`
  - `cd hyperledger-fabric-basics/basics-101/fabcar/javascript`
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
