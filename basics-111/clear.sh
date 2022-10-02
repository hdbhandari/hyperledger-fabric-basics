#!/bin/bash

## This script is just to clean everything, before git push

clear
rm -rf ./organizations/ordererOrganizations
rm -rf ./organizations/peerOrganizations
rm -rf ./organizations/fabric-ca/ordererOrg/msp
rm ./organizations/fabric-ca/ordererOrg/IssuerPublicKey ./organizations/fabric-ca/ordererOrg/IssuerRevocationPublicKey ./organizations/fabric-ca/ordererOrg/fabric-ca-server.db ./organizations/fabric-ca/ordererOrg/ca-cert.pem ./organizations/fabric-ca/ordererOrg/tls-cert.pem

rm -rf ./organizations/fabric-ca/org1/msp
rm ./organizations/fabric-ca/org1/IssuerPublicKey ./organizations/fabric-ca/org1/IssuerRevocationPublicKey ./organizations/fabric-ca/org1/fabric-ca-server.db ./organizations/fabric-ca/org1/ca-cert.pem ./organizations/fabric-ca/org1/tls-cert.pem

rm -rf ./organizations/fabric-ca/org2/msp
rm ./organizations/fabric-ca/org2/IssuerPublicKey ./organizations/fabric-ca/org2/IssuerRevocationPublicKey ./organizations/fabric-ca/org2/fabric-ca-server.db ./organizations/fabric-ca/org2/ca-cert.pem ./organizations/fabric-ca/org2/tls-cert.pem

echo "Stopping Containers"
docker stop $(docker ps -aq)

echo "---------------------------"

echo "Revoving Containers"
docker rm $(docker ps -aq)

rm -rf ./system-genesis-block
rm log.txt

docker volume prune -f
docker network prune -f

echo "Containers: "
docker ps -a

echo "Volume: "
docker volume ls

echo "Networks: "
docker network ls

rm -rf channel-artifacts
rm basic.tar.gz
