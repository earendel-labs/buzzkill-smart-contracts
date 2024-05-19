// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Bee is ERC721 {
    uint256 private _beeCount;

    enum BeeType {
        Queen,
        Worker
    }

    struct BeeData {
        BeeType beeType;
        string name;
        uint256 age;
    }

    mapping(uint256 => BeeData) private _bees;

    constructor() ERC721("Bee", "BEE") {}

    function mintBee(
        BeeType beeType,
        string memory name,
        uint256 age
    ) external {
        uint256 tokenId = _beeCount;
        _safeMint(msg.sender, tokenId);
        _bees[tokenId] = BeeData(beeType, name, age);
        _beeCount++;
    }

    function getBeeData(
        uint256 tokenId
    ) external view returns (BeeData memory) {
        return _bees[tokenId];
    }
}
