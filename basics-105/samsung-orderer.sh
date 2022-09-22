export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/config/samsung-orderer

export FABRIC_LOGGING_SPEC=debug
export ORDERER_GENERAL_LOGLEVEL=debug

clear

# Start the orderer
orderer