// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../interfaces/IHive.sol";
import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";

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
        uint256 productivityBoostAfterForage
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
        uint256 productivityBoostAfterForage;
    }

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_000; // The base denominator for the resources value
    uint256 public constant MAX_RESOURCES_VALUE = 1_000_000; // The maximum density or availability of nectar, pollen, and sap in the environment is 100
    uint256 public constant MIN_RESOURCES_VALUE = 10_000; // The minimum density or availability of nectar, pollen, and sap in the environment is 1
    uint256 public constant MAX_ENERGY_DEDUCTION_VALUE = 5; // The maximum energy deduction value is 5
    uint256 public constant MIN_ENERGY_DEDUCTION_VALUE = 1; // The minimum energy deduction value is 1
    uint256 public constant refreshInterval = 1 days; // Resources refresh every 24 hours

    /**
        Cn ,Cp ,Cs are constants that adjust the scale of resources gathered to fit the game's economy and balance.
        These constants can be used to fine-tune how rewarding foraging feels in the game
     */
    uint256 public Cs = 10_000;
    uint256 public Cn = 10_000;
    uint256 public Cp = 10_000;

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
        IHive hive = IHive(msg.sender);
        if (hive.creator() != buzzkillAddressProvider.hiveFactoryAddress()) {
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
     * @dev Get the amount of productivity boost after foraging in a habitat.
     * @param _habitatId The habitat ID.
     * @return The amount of productivity boost after foraging.
     */
    function getAmountProductivityBoostAfterForage(
        uint256 _habitatId
    ) external view returns (uint256) {
        HabitatInfo storage habitat = habitatsInfo[_habitatId];
        return habitat.productivityBoostAfterForage;
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
        uint256 lastRefreshTime = habitatsInfo[_habitatId].lastRefreshTime;
        uint256 timeElapsed = block.timestamp - lastRefreshTime;

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
     * @return The amount of nectar, pollen, and sap gathered.
     */
    function forage(
        uint256 _beeId,
        uint256 _habitatId
    ) external onlyHive returns (uint256, uint256, uint256) {
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

        // Check if the resources are smaller than the minimum amount
        if (
            nectar < MIN_RESOURCES_VALUE &&
            pollen < MIN_RESOURCES_VALUE &&
            sap < MIN_RESOURCES_VALUE
        ) {
            revert NotEnoughResources();
        }

        uint256 R = random();
        uint256 nectarGathered;
        uint256 pollenGathered;
        uint256 sapGathered;

        // Calculate the amount of resources gathered and decrease the resources in the habitat
        if (nectar >= MIN_RESOURCES_VALUE) {
            nectarGathered =
                (forageSkill * nectar * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR * BASE_DENOMINATOR);

            uint256 decreaseNectar = (nectar * resourcesDecreasePercentage) /
                BASE_DENOMINATOR;
            if (habitatResources.nectar > decreaseNectar) {
                habitatResources.nectar -=
                    (nectar * resourcesDecreasePercentage) /
                    BASE_DENOMINATOR;
            } else {
                habitatResources.nectar = 0;
            }
        }

        if (pollen >= MIN_RESOURCES_VALUE) {
            pollenGathered =
                (forageSkill * pollen * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR * BASE_DENOMINATOR);

            uint256 decreasePollen = (pollen * resourcesDecreasePercentage) /
                BASE_DENOMINATOR;

            if (habitatResources.pollen > decreasePollen) {
                habitatResources.pollen -=
                    (pollen * resourcesDecreasePercentage) /
                    BASE_DENOMINATOR;
            } else {
                habitatResources.pollen = 0;
            }
        }

        if (sap >= MIN_RESOURCES_VALUE) {
            sapGathered =
                (forageSkill * sap * R * Cn) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR * BASE_DENOMINATOR);

            uint256 decreaseSap = (sap * resourcesDecreasePercentage) /
                BASE_DENOMINATOR;

            if (habitatResources.sap > decreaseSap) {
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
     * @param nectar The amount of nectar in the habitat.
     * @param pollen The amount of pollen in the habitat.
     * @param sap The amount of sap in the habitat.
     * @param _energyDeductionAfterForage The energy deduction after foraging.
     * @param _productivityBoostAfterForage The productivity boost after foraging.
     */
    function addHabitat(
        uint256 nectar,
        uint256 pollen,
        uint256 sap,
        uint256 _energyDeductionAfterForage,
        uint256 _productivityBoostAfterForage
    ) external onlyOwner {
        if (nectar < MIN_RESOURCES_VALUE || nectar > MAX_RESOURCES_VALUE) {
            revert InvalidNectarValue();
        }
        if (pollen < MIN_RESOURCES_VALUE || pollen > MAX_RESOURCES_VALUE) {
            revert InvalidPollenValue();
        }
        if (sap < MIN_RESOURCES_VALUE || sap > MAX_RESOURCES_VALUE) {
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
        // Habitat info is initialized with the energy deduction and productivity boost values
        habitatsInfo[newHabitatId] = HabitatInfo(
            block.timestamp,
            _energyDeductionAfterForage,
            _productivityBoostAfterForage
        );

        currentHabitatId++;

        emit HabitatAdded(
            newHabitatId,
            nectar,
            pollen,
            sap,
            _energyDeductionAfterForage,
            _productivityBoostAfterForage
        );
    }

    /**
     * @dev Set the Cs constant.
     * @param _Cs The Cs constant.
     */
    function setCs(uint256 _Cs) external onlyOwner {
        Cs = _Cs;
    }

    /**
     * @dev Set the Cn constant.
     * @param _Cn The Cn constant.
     */
    function setCn(uint256 _Cn) external onlyOwner {
        Cn = _Cn;
    }

    /**
     * @dev Set the Cp constant.
     * @param _Cp The Cp constant.
     */
    function setCp(uint256 _Cp) external onlyOwner {
        Cp = _Cp;
    }
}
