// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract WorldMap is Ownable {
    /* -------------------------------------------------------------------------- */
    /*  Struct                                                                    */
    /* -------------------------------------------------------------------------- */
    struct Habitat {
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
    }

    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public habitatId;
    mapping(uint256 => Habitat) public habitats;

    constructor() Ownable(msg.sender) {}

    /* -------------------------------------------------------------------------- */
    /*  Functions                                                                 */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Add a habitat to the world map.
     * @param nectar The amount of nectar in the habitat.
     * @param pollen The amount of pollen in the habitat.
     * @param sap The amount of sap in the habitat.
     */
    function addHabitat(
        uint256 nectar,
        uint256 pollen,
        uint256 sap
    ) external onlyOwner {
        habitats[habitatId] = Habitat(nectar, pollen, sap);
        habitatId++;
    }

    /**
     * @dev Get the resources in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of nectar, pollen, and sap in the habitat.
     */
    function getHabitatResources(
        uint256 _habitatId
    ) external view returns (uint256, uint256, uint256) {
        Habitat storage habitat = habitats[_habitatId];
        return (habitat.nectar, habitat.pollen, habitat.sap);
    }

    function forage() public {}
}
