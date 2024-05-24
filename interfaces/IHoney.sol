// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IVRC25} from "@vrc25/contracts/interfaces/IVRC25.sol";

interface IHoney is IVRC25 {
    function mintTo(address recipient, uint256 amount) external;

    function burn(address recipient, uint256 amount) external;
}
