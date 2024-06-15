// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IGameConfig.sol";

contract WorldMap is Ownable {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error InvalidNectarValue();
    error InvalidPollenValue();
    error InvalidSapValue();
    error InvalidHealthDeductionValue();
    error HiveOnly();
    error HabitatNotExists();
    error NotEnoughResources();

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event HabitatAdded(
        uint256 habitatId,
        uint256 nectar,
        uint256 pollen,
        uint256 sap,
        uint256 energyDeductionAfterForage,
        uint256 incentiveEarnAfterForage
    );

    /* -------------------------------------------------------------------------- */
    /*  Struct                                                                    */
    /* -------------------------------------------------------------------------- */
    struct HabitatResources {
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
    }

    struct HabitatInfo {
        uint256 lastRefreshTime;
        uint256 energyDeductionAfterForage;
        uint256 incentiveEarnAfterForage;
    }

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_000; // The base denominator for the resources value

    /**
     * Cn ,Cp ,Cs are constants that adjust the scale of resources gathered to fit the game's economy and balance.
     * These constants can be used to fine-tune how rewarding foraging feels in the game
     * Make sure to adjust these constants carefully to ensure the game is not too easy or too hard
     */
    uint256 public Cs = 250_000;
    uint256 public Cn = 250_000;
    uint256 public Cp = 250_000;

    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public currentHabitatId;
    uint256 public resourcesDecreasePercentage = 500; // The percentage of resources that decrease after foraging, default is 5%
    mapping(uint256 => HabitatInfo) public habitatsInfo;
    mapping(uint256 => HabitatResources) public habitatsResources;
    mapping(uint256 => HabitatResources) public initialHabitatResources;

    IBuzzkillAddressProvider public buzzkillAddressProvider;

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
    /*  View Functions                                                                 */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Get the resources in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of nectar, pollen, and sap in the habitat.
     */
    function getHabitatResources(
        uint256 _habitatId
    ) external view returns (uint256, uint256, uint256) {
        HabitatResources storage habitat = habitatsResources[_habitatId];
        return (habitat.nectar, habitat.pollen, habitat.sap);
    }

    /**
     * @dev Get the initial resources in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of nectar, pollen, and sap in the habitat.
     */
    function getAmountEnergyDeductionAfterForage(
        uint256 _habitatId
    ) external view returns (uint256) {
        HabitatInfo storage habitat = habitatsInfo[_habitatId];
        return habitat.energyDeductionAfterForage;
    }

    /**
     * @dev Get the initial resources in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of nectar, pollen, and sap in the habitat.
     */
    function getInitialHabitatResources(
        uint256 _habitatId
    ) external view returns (uint256, uint256, uint256) {
        HabitatResources storage habitat = initialHabitatResources[_habitatId];
        return (habitat.nectar, habitat.pollen, habitat.sap);
    }

    /**
     * @dev Get the amount of incentive earned after foraging in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of incentive earned after foraging.
     */
    function getAmountIncentiveEarnAfterForage(
        uint256 _habitatId
    ) external view returns (uint256) {
        HabitatInfo storage habitat = habitatsInfo[_habitatId];
        return habitat.incentiveEarnAfterForage;
    }

    /* -------------------------------------------------------------------------- */
    /*  Write functions                                                          */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Pseudo-random number generator, consider using Chainlink VRF later on production
     * @return A pseudo-random number between 800 and 1200
     */
    function random() internal view returns (uint256) {
        return
            (uint256(
                keccak256(
                    abi.encodePacked(
                        block.prevrandao,
                        block.timestamp,
                        msg.sender
                    )
                )
            ) % 401) + 800;
    }

    /**
     * @dev Refresh the habitat resource coefficients.
     * @param _habitatId The habitat ID.
     */
    function _refreshResourceCoefficientsIfNeed(uint256 _habitatId) private {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 lastRefreshTime = habitatsInfo[_habitatId].lastRefreshTime;
        uint256 timeElapsed = block.timestamp - lastRefreshTime;
        uint256 refreshInterval = gameConfig.resourcesRefreshInterval();
        if (timeElapsed >= refreshInterval) {
            // Calculate the number of intervals that have passed
            uint256 intervalsPassed = timeElapsed / refreshInterval;
            habitatsInfo[_habitatId].lastRefreshTime +=
                intervalsPassed *
                refreshInterval;

            // Reset to initial values or new values as needed
            habitatsResources[_habitatId] = initialHabitatResources[_habitatId];
        }
    }

    /**
     * @dev Forage resources from a habitat. The amount of resources gathered is based on the bee's foraging skill.
     After each forage, the resources in the habitat decrease by 5% and bee energy is decreased.
     * @param _beeId The ID of the bee.
     * @param _habitatId The ID of the habitat.
     * @return nectarGathered The amount of nectar gathered.
     * pollenGathered The amount of pollen gathered.
     * sapGathered The amount of sap gathered.
     * The constant value ensure that the resources gathered are minimum at 20 quantity.
     */
    function forage(
        uint256 _beeId,
        uint256 _habitatId
    )
        external
        onlyHive
        returns (
            uint256 nectarGathered,
            uint256 pollenGathered,
            uint256 sapGathered
        )
    {
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _beeId
        );

        uint256 forageSkill = beeTraits.forage;

        require(forageSkill > 0, "Bee must have a foraging skill set");

        // Refresh resource coefficients if needed
        _refreshResourceCoefficientsIfNeed(_habitatId);

        HabitatResources storage habitatResources = habitatsResources[
            _habitatId
        ];

        uint256 nectar = habitatResources.nectar;
        uint256 pollen = habitatResources.pollen;
        uint256 sap = habitatResources.sap;

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 minResourcesValue = gameConfig.minResourcesValue();

        // Check if the resources are smaller than the minimum amount
        if (
            nectar < minResourcesValue &&
            pollen < minResourcesValue &&
            sap < minResourcesValue
        ) {
            revert NotEnoughResources();
        }

        uint256 R = random();

        // Calculate the amount of resources gathered and decrease the resources in the habitat
        if (nectar >= minResourcesValue) {
            nectarGathered =
                (forageSkill * nectar * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR);

            if (
                habitatResources.nectar >
                (nectar * resourcesDecreasePercentage) / BASE_DENOMINATOR
            ) {
                habitatResources.nectar -=
                    (nectar * resourcesDecreasePercentage) /
                    BASE_DENOMINATOR;
            } else {
                habitatResources.nectar = 0;
            }
        }

        if (pollen >= minResourcesValue) {
            pollenGathered =
                (forageSkill * pollen * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR);

            if (
                habitatResources.pollen >
                (pollen * resourcesDecreasePercentage) / BASE_DENOMINATOR
            ) {
                habitatResources.pollen -=
                    (pollen * resourcesDecreasePercentage) /
                    BASE_DENOMINATOR;
            } else {
                habitatResources.pollen = 0;
            }
        }

        if (sap >= minResourcesValue) {
            sapGathered =
                (forageSkill * sap * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR);

            if (
                habitatResources.sap >
                (sap * resourcesDecreasePercentage) / BASE_DENOMINATOR
            ) {
                habitatResources.sap -=
                    (sap * resourcesDecreasePercentage) /
                    BASE_DENOMINATOR;
            } else {
                habitatResources.sap = 0;
            }
        }

        return (nectarGathered, pollenGathered, sapGathered);
    }

    /* -------------------------------------------------------------------------- */
    /*  Owner functions                                                           */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Add a habitat to the world map.
     * @param nectar The amount of nectar in the habitat. Range from 1 to 100
     * @param pollen The amount of pollen in the habitat. Range from 1 to 100
     * @param sap The amount of sap in the habitat. Range from 1 to 100
     * @param _energyDeductionAfterForage The energy deduction after foraging.
     * @param _incentiveEarnAfterForage The incentive earned after foraging.
     */
    function addHabitat(
        uint256 nectar,
        uint256 pollen,
        uint256 sap,
        uint256 _energyDeductionAfterForage,
        uint256 _incentiveEarnAfterForage
    ) external onlyOwner {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 minResourcesValue = gameConfig.minResourcesValue();
        uint256 maxResourcesValue = gameConfig.maxResourcesValue();

        if (nectar < minResourcesValue || nectar > maxResourcesValue) {
            revert InvalidNectarValue();
        }
        if (pollen < minResourcesValue || pollen > maxResourcesValue) {
            revert InvalidPollenValue();
        }
        if (sap < minResourcesValue || sap > maxResourcesValue) {
            revert InvalidSapValue();
        }

        uint256 newHabitatId = currentHabitatId;

        // Habitat resources are initialized with the nectar, pollen, and sap values
        habitatsResources[newHabitatId] = HabitatResources(nectar, pollen, sap);
        initialHabitatResources[newHabitatId] = HabitatResources(
            nectar,
            pollen,
            sap
        );
        // Habitat info is initialized with the energy deduction and incentive earned values
        habitatsInfo[newHabitatId] = HabitatInfo(
            block.timestamp,
            _energyDeductionAfterForage,
            _incentiveEarnAfterForage
        );

        currentHabitatId++;

        emit HabitatAdded(
            newHabitatId,
            nectar,
            pollen,
            sap,
            _energyDeductionAfterForage,
            _incentiveEarnAfterForage
        );
    }
}
