// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IWorldMap {
    function currentHabitatId() external view returns (uint256);

    function getHabitat(
        uint256 habitatId
    ) external view returns (uint256, uint256, uint256);

    function getAmountEnergyDeductionAfterForage(
        uint256 habitatId
    ) external view returns (uint256);

    function getAmountIncentiveEarnAfterForage(
        uint256 habitatId
    ) external view returns (uint256);

    function forage(
        uint256 tokenId,
        uint256 habitatId
    ) external returns (uint256, uint256, uint256);
}
