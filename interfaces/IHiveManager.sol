// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IHiveManager {
    function updateHiveDefense(uint256 _hiveId, uint256 _tokenId) external;
}
