# Introduction

- Creating network from scratch
- This is project is first part of setting up complete network, here only crypto config and connection profiles are generated
- Will keep the same minimal structure as test-network

# Steps

1. First of all we need to generate crypto-material using either cryptogen tool or by using fabric-ca
2. We will use fabric-ca
3. copy organizations/fabric-ca directory from test-network
4. copy docker/docker-compose-ca.yaml directory from test-network
5. replace all infoln with echo command
6. The network.sh script will be used to perform all the actions
7. The clear.sh is the script to clean the resources
