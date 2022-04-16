// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "openzeppelin/token/ERC721/extensions/IERC721Enumerable.sol";
import "./Verifier.sol";

contract MessageBoard is Verifier {
  IERC721Enumerable nftContract;
  string[] private messages;
  mapping(uint => address) public nullifiers;

  constructor(
    address nftContractAddress
  ) {
    nftContract = IERC721Enumerable(nftContractAddress);
  }

  // should be removed before prod deployment
  function setNFTContract(address c) external {
    nftContract = IERC721Enumerable(c); 
  }

  function postMsg(
    uint[2] calldata a,
    uint[2][2] calldata b,
    uint[2] calldata c,
    uint[5] calldata inputs,
    string calldata message
  ) external {
    uint nullifier = inputs[4];
    require(nullifiers[nullifier] == msg.sender, "nullifier was already used by a different address");

    uint[] memory nftOwners = getNFTOwners();
    for (uint i; i < inputs.length - 1; i++) {
      // we ignore the last public input because that's the nullifier
      require(inputs[i] == nftOwners[i], "input doesn't match actual owners");
    }
    require(verifyProof(a, b, c, inputs), "proof is invalid");
    nullifiers[nullifier] = msg.sender;
    messages.push(message);
  }

  function getNFTOwners() public view returns (uint[] memory) {
    uint numberOfTokens = nftContract.totalSupply();
    uint[] memory nftOwners = new uint[](numberOfTokens);
    // we start at index 1 because there is no token with id `0`
    for (uint i = 1; i < numberOfTokens + 1; i++) {
      nftOwners[i] = (uint256(uint160(nftContract.ownerOf(i))));
    }
    return nftOwners;
  }

  function getMessages() external view returns (string[] memory) {
    return messages;
  }
}
