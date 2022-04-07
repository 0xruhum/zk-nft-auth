pragma circom 2.0.0;

include "./node_modules/circomlib/circuits/comparators.circom";

include "./circom-ecdsa/eth_addr.circom";

// This circuit verifies the ownership of an NFT.
// We only have to verify that the caller knows the private key of a particular
// Ethereum address. And we verify that the address is one of the owners
// of the NFTs.
//
// o represents the number of owner addresses
// n & k are part of the PrivKeyToAddr component
template NFT (o, n, k) {
  // arrays containing all the token owners of a NFT contract.
  signal input owners[o];
  signal input address;
  signal input privateKey[k]; // use k here just like the PrivKeyToAddr component does.

  // Verify thathe passed address is an owner of a token.
  var accum = 1;
  for (var i = 0; i < o; i++) {
    accum *= owners[i] - address;
  }
  signal temp;
  temp <-- accum;
  component iszero = IsZero();
  iszero.in <== temp;
  iszero.out === 1;

  // verify that the caller knows the private key of the passed address
  component PrivKeyValidator = PrivKeyToAddr(n, k);
  for (var i = 0; i < k; i++) {
    PrivKeyValidator.privkey[i] <== privateKey[i];
  }
  component eq = IsEqual();
  eq.in[0] <== PrivKeyValidator.addr;
  eq.in[1] <== address;
  eq.out === 1;
}

component main {public [owners]} = NFT(4, 64, 4);
