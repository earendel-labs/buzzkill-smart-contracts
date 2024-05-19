// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IBuzzkillNFT.sol";

contract Hive {
    uint256 public constant MAX_QUEEN = 3;
    uint256 public constant MAX_WORKER = 55;
    address public creator;
    uint256 public honeyPot;
    uint256 public habitatId;

    constructor(uint256 _habitatId) {
        creator = msg.sender;
        habitatId = _habitatId;
    }

    function stake() public {}

    function unstake() public {}

    function forage() public {}
    

    function raid() public {}

    function collectHoney() public {}

    function depositHoney(uint256 amount) external {
        honeyPot += amount;
    }

    function withdrawHoney(uint256 amount) external {
        require(amount <= honeyPot, "Insufficient honey balance");
        honeyPot -= amount;
    }
}
