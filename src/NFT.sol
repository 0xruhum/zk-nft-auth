pragma solidity 0.8.13;

import "solmate/tokens/ERC721.sol";

contract NFT is ERC721 {
  uint tokenID;

  constructor() ERC721("ZK Test", "ZKT") {}

  function mint(address to) external {
    tokenID++;
    _mint(to, tokenID);
  }

  function totalSupply() external view returns (uint) {
    return tokenID;
  }

  function tokenURI(uint id) public view override returns (string memory uri) {}
}
