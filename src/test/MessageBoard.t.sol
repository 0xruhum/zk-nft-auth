// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "openzeppelin/mocks/ERC721Mock.sol";
import "ds-test/test.sol";
import "./utils/VM.sol";
import "../MessageBoard.sol";

contract MessageBoardTest is DSTest {
    VM internal constant vm = VM(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    MessageBoard internal msgBoard;

    function setUp() public {
      // We need the mock NFT for the message board
      ERC721Mock nft = new ERC721Mock("test", "t");
      nft.mint(vm.addr(1), 0);
      nft.mint(vm.addr(2), 1);
      nft.mint(vm.addr(3), 2);
      nft.mint(vm.addr(4), 3);

      msgBoard = new MessageBoard(address(nft));
    }

    function testPostMsg() public {
      uint[4] memory nftOwners = getNFTOwners();
      uint[2] memory a = [0x29503277f3cc111ee2258e6fa025dff7f69b0673a5bf8f175c8330f7db80b339, 0x0ef054ed60087ceee051f499226a59ce5d81c23a3bfeaf00cfd474f557345503];
      uint[2][2] memory b = [[0x20a18e639c1a4cce62cb08e1d7d298c53e1615dd3e5cdea4ec603723523c42de,
0x1ae8cc67b9b4a1af0219fd307452a5fc42541f6e4ac5d06fdaadd4ca7938edeb],[0x2d060021d94992a439f280203323da335f05b7959b389ae9285e9b69a6b61830, 0x1b282935477b0610c6b281b053481472d58a56d5f232dfb921655cace498a47b]];
      uint[2] memory c = [0x2927b358c2eb446128ebd10fc8901b8250b6ff726d89e5be46fc328a3b5b2664, 0x08bc7c46289f63029f03b04116667a65e5c9f1c76a1b22ac6ebcf5653136a38f];
      msgBoard.postMsg(
        a,
        b,
        c,
        nftOwners,
        "Hello World!"
      );
    }

    function getNFTOwners() internal returns (uint[4] memory) {
      uint[4] memory result;
      uint[] memory nftOwners = msgBoard.getNFTOwners(); 
      for (uint i; i < nftOwners.length; i++) {
        result[i] = nftOwners[i];
      }
      return result;
    }
}

