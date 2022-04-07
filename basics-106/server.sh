#!/bin/bash

export PATH=${PWD}/../bin:$PATH
export FABRIC_CA_SERVER_HOME=${PWD}/config-out/server

rm -rf ${FABRIC_CA_SERVER_HOME}
clear

fabric-ca-server start -b admin:adminpw -n basic-ca --cfg.identities.allowremove




