// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IVRC725} from "@vrc725/contracts/interfaces/IVRC725.sol";

interface IBuzzkillNFT is IVRC725 {
    function currentTokenId() external view returns (uint256);

    function mintFee() external view returns (uint256);

    function hiveFactory() external view returns (address);

    function tokenURIs(uint256 tokenId) external view returns (string memory);

    function tokenIdToCharacteristics(
        uint256 tokenId
    ) external view returns (string memory avatar, string memory beeType);

    function tokenIdToTraits(
        uint256 tokenId
    )
        external
        view
        returns (
            uint256 energy,
            uint256 health,
            uint256 productivity,
            uint256 attack,
            uint256 defense,
            uint256 forage,
            uint256 pollen,
            uint256 sap,
            uint256 nectar
        );

    function modifyBeeTraits(
        uint256 tokenId,
        uint256 energy,
        uint256 health,
        uint256 productivity,
        uint256 attack,
        uint256 defense,
        uint256 forage,
        uint256 pollen,
        uint256 sap,
        uint256 nectar
    ) external;
}
