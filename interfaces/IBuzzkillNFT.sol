// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IVRC725} from "@vrc725/contracts/interfaces/IVRC725.sol";

interface IBuzzkillNFT is IVRC725 {
    struct BeeTraits {
        uint256 energy;
        uint256 health;
        uint256 attack;
        uint256 defense;
        uint256 forage;
        uint256 baseProductivity;
        uint256 maxProductivity;
        uint256 experience;
        uint256 level;
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
    }

    function currentTokenId() external view returns (uint256);

    function mintFee() external view returns (uint256);

    function hiveFactory() external view returns (address);

    function tokenURIs(uint256 tokenId) external view returns (string memory);

    function tokenIdToCharacteristics(
        uint256 tokenId
    ) external view returns (string memory avatar, string memory beeType);

    function tokenIdToTraits(
        uint256 tokenId
    ) external view returns (BeeTraits memory _beeTraits);

    function modifyBeeTraits(
        uint256 tokenId,
        BeeTraits calldata _beeTraits
    ) external;

    function refreshBeeEnergy(uint256 tokenId) external;

    function refreshBeeHealth(uint256 tokenId) external;

    function updateForagingQuestCount(uint256 hiveId, uint256 tokenId) external;

    function updateRaidQuestCount(uint256 hiveId, uint256 tokenId) external;

    function updateRaidSuccessQuestCount(
        uint256 hiveId,
        uint256 tokenId
    ) external;

    function updateUpgradeQuestCount(uint256 hiveId, uint256 tokenId) external;
}
