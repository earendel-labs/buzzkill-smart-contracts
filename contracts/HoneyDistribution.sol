// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IHoney.sol";
import "../interfaces/IHive.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";

contract HoneyDistribution {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error HiveOnly();

    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    IBuzzkillAddressProvider private buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(address _buzzkillAddressProvider) {
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifiers                                                                 */
    /* -------------------------------------------------------------------------- */
    modifier onlyHive() {
        IHive hive = IHive(msg.sender);
        if (hive.creator() != buzzkillAddressProvider.hiveFactoryAddress()) {
            revert HiveOnly();
        }
        _;
    }

    /* -------------------------------------------------------------------------- */
    /*  Functions                                                                 */
    /* -------------------------------------------------------------------------- */
    function distributeHoney(
        address recipient,
        uint256 amount
    ) external onlyHive {
        IHoney honey = IHoney(buzzkillAddressProvider.honeyAddress());
        honey.mintTo(recipient, amount);
    }
}
