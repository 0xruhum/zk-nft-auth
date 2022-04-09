# !/bin/bash

# deploys the nft contract

forge create \
  --rpc-url "$ROPSTEN_RPC_URL" \
  --private-key "$PRIV" \
  ./src/NFT.sol:NFT
