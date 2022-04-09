pragma solidity 0.8.13;

import "solmate/tokens/ERC721.sol";
import "openzeppelin/access/Ownable.sol";

contract NFT is ERC721, Ownable {
  constructor() ERC721("ZK Test", "ZKT") {}

  function mint(address to, uint tokenID) external {
    _mint(to, tokenID);
  }

  function tokenURI(uint id) public view override returns (string memory uri) {}
}
