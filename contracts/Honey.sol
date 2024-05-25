// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {VRC25} from "@vrc25/contracts/VRC25.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import {Controllable} from "./helper/Controllable.sol";

contract Honey is VRC25, Controllable, ReentrancyGuard {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error ExceededMaxSupply();

    /**
     * @dev The maximum supply of the token.
     */
    uint256 public constant MAX_SUPPLY = 10e9 ether;

    /**
     * @dev Constructor function for the Honey contract.
     * It initializes the contract with the token name, symbol, and decimal places.
     * It also sets the contract owner as the controller.
     */
    constructor() VRC25("HONEY", "HNY", 18) {
        _setController(msg.sender, true);
    }

    /**
     * @dev Mint tokens and assign them to the specified address.
     * Only the contract owner can call this function.
     * Reverts if the total supply exceeds the maximum supply.
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mintTo(
        address to,
        uint256 amount
    ) external onlyController nonReentrant {
        if (totalSupply() + amount > MAX_SUPPLY) {
            revert ExceededMaxSupply();
        }
        super._mint(to, amount);
    }

    /**
     * @dev Burn tokens from the specified address.
     * Only the contract owner can call this function.
     * @param from The address to burn tokens from.
     * @param value The amount of tokens to burn.
     */
    function burn(address from, uint256 value) external onlyController {
        super._burn(from, value);
    }

    /**
     * @dev Set the controller's address state.
     * Only the contract owner can call this function.
     * @param addr The address to set the state for.
     * @param state The state to set.
     */
    function setController(address addr, bool state) external onlyOwner {
        _setController(addr, state);
    }

    /* -------------------------------------------------------------------------- */
    /*  Required Overrides                                                        */
    /* -------------------------------------------------------------------------- */

    // The following functions are overrides required by Solidity.

    /**
     * @dev Estimate the fee for a given value.
     * This function is internal and overrides the base implementation.
     * It calculates the fee by adding the value to the minimum fee.
     * @param value The value to calculate the fee for.
     * @return The estimated fee.
     */
    function _estimateFee(
        uint256 value
    ) internal view override returns (uint256) {
        return value + minFee();
    }
}
