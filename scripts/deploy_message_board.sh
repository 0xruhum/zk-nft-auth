# !/bin/bash

# This script deploys the MessageBoard contract to ropsten
# constructor arg is the address of the NFT on ropsten

forge create \
  --rpc-url "$ROPSTEN_RPC_URL" \
  --private-key "$PRIV" \
  ./src/MessageBoard.sol:MessageBoard \
  --constructor-args 0x62d7960b54cf1f5e20b402b077797a555727d400
