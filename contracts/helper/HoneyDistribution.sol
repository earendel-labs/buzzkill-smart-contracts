// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../../interfaces/IHoney.sol";
import "../../interfaces/IBuzzkillAddressProvider.sol";

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
    IBuzzkillAddressProvider private buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(address _buzzkillAddressProvider) Ownable(msg.sender) {
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifiers                                                                 */
    /* -------------------------------------------------------------------------- */
    modifier onlyHive() {
        if (msg.sender != buzzkillAddressProvider.hiveManagerAddress()) {
            revert HiveOnly();
        }
        _;
    }

    /* -------------------------------------------------------------------------- */
    /*  Functions                                                                 */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Distribute a specified amount of honey to a recipient.
     * This function mints new honey tokens and transfers them to the recipient address.
     * Can only be called by the hive.
     * @param recipient The address of the honey recipient.
     * @param amount The amount of honey to be distributed.
     */
    function distributeHoney(
        address recipient,
        uint256 amount
    ) external onlyHive {
        IHoney honey = IHoney(buzzkillAddressProvider.honeyAddress());
        honey.mintTo(recipient, amount);
    }

    /**
     * @dev Burn a specified amount of honey from a recipient.
     * This function burns honey tokens from the recipient address.
     * Can only be called by the hive.
     * @param recipient The address of the honey owner.
     * @param amount The amount of honey to be burned.
     */
    function burnHoney(address recipient, uint256 amount) external onlyHive {
        IHoney honey = IHoney(buzzkillAddressProvider.honeyAddress());
        honey.burn(recipient, amount);
    }
}
