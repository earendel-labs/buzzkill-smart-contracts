// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "../../interfaces/IBuzzkillAddressProvider.sol";

contract BuzzkillAddressProvider is
    Initializable,
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
    address public honeyDistributionAddress;
    address public gameConfigAddress;

    /* -------------------------------------------------------------------------- */
    /*  Initilize                                                               */
    /* -------------------------------------------------------------------------- */
    function initialize() public initializer {
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

    /**
     * @dev Set the HoneyDistribution contract address.
     * @param _honeyDistributionAddress The HoneyDistribution contract address.
     */
    function setHoneyDistributionAddress(
        address _honeyDistributionAddress
    ) external onlyOwner {
        honeyDistributionAddress = _honeyDistributionAddress;
    }

    /**
     * @dev Set the GameConfig contract address.
     * @param _gameConfigAddress The GameConfig contract address.
     */
    function setGameConfigAddress(
        address _gameConfigAddress
    ) external onlyOwner {
        gameConfigAddress = _gameConfigAddress;
    }
}
