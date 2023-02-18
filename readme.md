# Introduction

- Adding all the exersises which I do while learning Hyperledger Fabric v2.2
- baiscs-101 and basics-102 directories contains trimmed versions of [fabric-samples](https://github.com/hyperledger/fabric-samples/tree/release-2.2) for JavaScript version of Chaincode. The purpose here is just to start the default network and take an overview that how fabric works
- From directory basics-103, one by one concepts are covered
- For rest of the learning exercise i.e. basics-1xx, I will refer bin folder which is parallel to other basic-1xx directories

## Setup

1. Prerequisites:

   - Ubuntu:

      <!-- https://stackoverflow.com/a/14772631/3110474 -->

     `sudo apt-get install build-essential`

   - Install NVM and switch to node 12

     `curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash`

     `nvm ls`

     `nvm use 16`

     `npm i -g yarn`

     `yarn global add node-gyp`

   - Install Golang and update path using below command:

     `export PATH=$PATH:/usr/local/go/bin`

     `source ~/.bashrc`

   - From URL: https://hyperledger-fabric.readthedocs.io/en/release-2.2/install.html run below command, it will install required docker images and also download the fabric-samples on the home directory.

     `cd ~`

     `sudo curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`

     `sudo chmod -R 755 ~/fabric-samples`

     `cp -r ~/fabric-samples/bin ~/hyperledger-fabric-basics`
     
   - After cloning the repo, set the permissions

   `sudo find ~/hyperledger-fabric-basics -name "*.sh" -execdir chmod u+x {} +`
   `sudo chmod -R u+x hyperledger-fabric-basics/bin`
