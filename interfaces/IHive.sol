// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IHive {
    function creator() external view returns (address);

    function updateHiveDefense(uint256 _tokenId) external;

    function endureRaid(uint256 _tokenId) external returns (uint256);
}
