// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/Bee.sol";

contract BeeTest is Test {
    Bee public bee;

    function setUp() public {
        bee = new Bee(block.timestamp + 1 days);
    }

    function testIncrement() public {}
}
