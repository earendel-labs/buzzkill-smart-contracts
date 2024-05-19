// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Hive} from "./Hive.sol";

import "../interfaces/IWorldMap.sol";

contract HiveFactory {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error HabitatNotExists();

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event HiveCreated(uint256 hiveId, address hiveAddress);

    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public totalHives;
    address public worldMap;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(address _worldMap) {
        worldMap = _worldMap;
    }

    /* -------------------------------------------------------------------------- */
    /*  Functions                                                                 */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Create a new hive.
     * @param habitatId The habitat ID.
     * @return The hive ID.
     */
    function createHive(uint256 habitatId) external returns (uint256) {
        uint256 maxHabitatId = IWorldMap(worldMap).habitatId();
        if (habitatId >= maxHabitatId) {
            revert HabitatNotExists();
        }
        Hive newHive = new Hive(habitatId);
        totalHives++;
        emit HiveCreated(totalHives, address(newHive));
        return totalHives;
    }
}
