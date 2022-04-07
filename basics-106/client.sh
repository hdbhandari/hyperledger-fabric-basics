#!/bin/bash

export PATH=${PWD}/../bin:$PATH
export CFG_OUT_PATH=${PWD}/config-out
export FABRIC_CA_CLIENT_HOME=${PWD}/config-out/client

rm -rf ${FABRIC_CA_CLIENT_HOME}
clear

fabric-ca-client enroll -u http://admin:adminpw@localhost:7054

echo
echo "Identity Operations "

fabric-ca-client identity add user --type user --affiliation org1 --maxenrollments 2

fabric-ca-client identity add user1 --json '{"type": "user", "affiliation": "org1" ,"maxenrollments": 2}'

# fabric-ca-client identity modify user --json '{"affiliation": "org2", "attrs": "myAttr=true"}'

fabric-ca-client identity modify user --affiliation org2 --maxenrollments 2 --attrs myAttr=true:ecert

fabric-ca-client identity remove user1

echo
echo "Register Operations "
fabric-ca-client register --id.name user3 --id.secret userpw --id.type user --id.affiliation org2 --id.maxenrollments 3
 
echo
echo "Identities: "

fabric-ca-client identity list
