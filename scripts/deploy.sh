# !/bin/bash

# This script deploys the MessageBoard contract to ropsten

forge create --rpc-url "$(ROPSTEN_RPC_URL)" ../src/MessageBoard.sol:MessageBoard
