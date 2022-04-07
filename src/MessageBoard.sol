// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "openzeppelin/token/ERC721/extensions/IERC721Enumerable.sol";
import "./Verifier.sol";

contract MessageBoard is Verifier {
  // owner address as uints, see constructor
  uint[] private nftOwners;
  string[] private messages;

  constructor(
    address nftContractAddress
  ) {
    IERC721Enumerable nftContract = IERC721Enumerable(nftContractAddress);
    uint numberOfTokens = nftContract.totalSupply();
    for (uint i; i < numberOfTokens; i++) {
      nftOwners.push(uint256(uint160(nftContract.ownerOf(i))));
    }
  }

  function getNFTOwners() external view returns (uint[] memory) {
    return nftOwners;
  }

  function getMessages() external view returns (string[] memory) {
    return messages;
  }

  function postMsg(
    uint[2] calldata a,
    uint[2][2] calldata b,
    uint[2] calldata c,
    uint[4] calldata inputs,
    string calldata message
  ) external {
    for (uint i; i < inputs.length; i++) {
      require(inputs[i] == nftOwners[i], "input doesn't match actual owners");
    }
    require(verifyProof(a, b, c, inputs), "proof is invalid");
    messages.push(message);
  }
}
