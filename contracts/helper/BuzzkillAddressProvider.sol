// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import "../../interfaces/IBuzzkillAddressProvider.sol";

contract BuzzkillAddressProvider is
    OwnableUpgradeable,
    IBuzzkillAddressProvider
{
    /* -------------------------------------------------------------------------- */
    /*  State Variables                                                           */
    /* -------------------------------------------------------------------------- */
    address public buzzkillNFTAddress;
    address public honeyAddress;
    address public hiveFactoryAddress;
    address public worldMapAddress;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor() {
        __Ownable_init(msg.sender);
    }

    /* -------------------------------------------------------------------------- */
    /*  Owner functions                                                           */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Set the Buzzkill NFT contract address.
     * @param _buzzkillNFTAddress The Buzzkill NFT contract address.
     */
    function setBuzzkillNFTAddress(
        address _buzzkillNFTAddress
    ) external onlyOwner {
        buzzkillNFTAddress = _buzzkillNFTAddress;
    }

    /**
     * @dev Set the Honey contract address.
     * @param _honeyAddress The Honey contract address.
     */
    function setHoneyAddress(address _honeyAddress) external onlyOwner {
        honeyAddress = _honeyAddress;
    }

    /**
     * @dev Set the HiveFactory contract address.
     * @param _hiveFactoryAddress The HiveFactory contract address.
     */
    function setHiveFactoryAddress(
        address _hiveFactoryAddress
    ) external onlyOwner {
        hiveFactoryAddress = _hiveFactoryAddress;
    }

    /**
     * @dev Set the WorldMap contract address.
     * @param _worldMapAddress The WorldMap contract address.
     */
    function setWorldMapAddress(address _worldMapAddress) external onlyOwner {
        worldMapAddress = _worldMapAddress;
    }
}
