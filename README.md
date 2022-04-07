# zk-nft-auth

WIP!!!

Contract that should allow one to proof the ownership of a particular NFT without disclosing the token or the address of the owner. Made possible by zkSNARKs.

I'm working on this primarly to get a better understanding of the whole zkSNARK stuff. I don't think this will be production ready anytime soon.

Uses the [circom-ecdsa](https://github.com/0xPARC/circom-ecdsa) library. First, I wanted to create the necessary circuit myself but now that I've seen their solution I'd say that was a little to ambitious :)

## Setup

The phase1 file is >1 GB so it's not included in this repo. Instead, create your own or download one from snarkjs. Should handle 1M constraints.
