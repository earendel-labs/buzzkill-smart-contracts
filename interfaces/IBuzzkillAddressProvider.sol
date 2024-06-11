// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IBuzzkillAddressProvider {
    function honeyAddress() external view returns (address);

    function hiveManagerAddress() external view returns (address);

    function buzzkillNFTAddress() external view returns (address);

    function worldMapAddress() external view returns (address);

    function honeyDistributionAddress() external view returns (address);

    function gameConfigAddress() external view returns (address);
}
