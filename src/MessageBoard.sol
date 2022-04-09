// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "openzeppelin/token/ERC721/extensions/IERC721Enumerable.sol";
import "./Verifier.sol";

contract MessageBoard is Verifier {
  IERC721Enumerable nftContract;
  string[] private messages;

  constructor(
    address nftContractAddress
  ) {
    nftContract = IERC721Enumerable(nftContractAddress);
  }

  function postMsg(
    uint[2] calldata a,
    uint[2][2] calldata b,
    uint[2] calldata c,
    uint[4] calldata inputs,
    string calldata message
  ) external {
    uint[] memory nftOwners = getNFTOwners();
    for (uint i; i < inputs.length; i++) {
      require(inputs[i] == nftOwners[i], "input doesn't match actual owners");
    }
    require(verifyProof(a, b, c, inputs), "proof is invalid");
    messages.push(message);
  }

  function getNFTOwners() public view returns (uint[] memory) {
    uint numberOfTokens = nftContract.totalSupply();
    uint[] memory nftOwners = new uint[](numberOfTokens);
    for (uint i; i < numberOfTokens; i++) {
      nftOwners[i] = (uint256(uint160(nftContract.ownerOf(i))));
    }
    return nftOwners;
  }

  function getMessages() external view returns (string[] memory) {
    return messages;
  }
}
