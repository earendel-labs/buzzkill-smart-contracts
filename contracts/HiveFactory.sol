// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Hive} from "./Hive.sol";

import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";

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
    IBuzzkillAddressProvider public buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(address _buzzkillAddressProvider) {
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Functions                                                                 */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Create a new hive.
     * @param habitatId The habitat ID.
     * @return The hive ID.
     */
    function createHive(uint256 habitatId) external returns (address) {
        address worldMap = buzzkillAddressProvider.worldMapAddress();
        uint256 maxHabitatId = IWorldMap(worldMap).currentHabitatId();
        if (habitatId >= maxHabitatId) {
            revert HabitatNotExists();
        }
        Hive newHive = new Hive(habitatId, address(buzzkillAddressProvider));
        totalHives++;
        emit HiveCreated(totalHives, address(newHive));
        return address(newHive);
    }
}
