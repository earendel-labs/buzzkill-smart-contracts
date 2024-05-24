// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IHoneyDistribution {
    function baseHoneyYield() external view returns (uint256);

    function distributeHoney(address recipient, uint256 amount) external;

    function burnHoney(address recipient, uint256 amount) external;
}
