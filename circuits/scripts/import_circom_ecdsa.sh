# !/bin/bash

LIB_DIR=./circom-ecdsa

# Expects the circom-ecdsa repo to be cloned and ready in "../lib/circom-ecdsa"
if [ -d "$LIB_DIR" ]; then
  rm -rf "$LIB_DIR"
fi

if [ ! -d "$LIB_DIR" ]; then
    mkdir -p "$LIB_DIR"
fi

cp -r ../lib/circom-ecdsa/circuits/* "$LIB_DIR"/

