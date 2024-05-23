// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IHoney.sol";
import "../interfaces/IHive.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract HoneyDistribution is Ownable {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error HiveOnly();

    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public totalHoneyDistributed;
    uint256 public baseHoneyYield;
    IBuzzkillAddressProvider private buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(address _buzzkillAddressProvider, uint256 _baseHoneyYield) Ownable(msg.sender) {
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
        baseHoneyYield = _baseHoneyYield;
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

    /* -------------------------------------------------------------------------- */
    /*  Owner function                                                            */
    /* -------------------------------------------------------------------------- */
    function setBaseHoneyYield(uint256 _baseHoneyYield) external onlyOwner {
        baseHoneyYield = _baseHoneyYield;
    }
}
