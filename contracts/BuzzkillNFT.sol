// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VRC725} from "@vrc725/contracts/VRC725.sol";
import {VRC725Enumerable} from "@vrc725/contracts/extensions/VRC725Enumerable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings as StringsLib} from "@openzeppelin/contracts/utils/Strings.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

import "../interfaces/IHiveManager.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IGameConfig.sol";

// 888888b.   888     888 8888888888P 8888888888P 888    d8P  8888888 888      888
// 888  "88b  888     888       d88P        d88P  888   d8P     888   888      888
// 888  .88P  888     888      d88P        d88P   888  d8P      888   888      888
// 8888888K.  888     888     d88P        d88P    888d88K       888   888      888
// 888  "Y88b 888     888    d88P        d88P     8888888b      888   888      888
// 888    888 888     888   d88P        d88P      888  Y88b     888   888      888
// 888   d88P Y88b. .d88P  d88P        d88P       888   Y88b    888   888      888
// 8888888P"   "Y88888P"  d8888888888 d8888888888 888    Y88b 8888888 88888888 88888888

contract BuzzkillNFT is VRC725, VRC725Enumerable, ReentrancyGuard, Pausable {
    /* -------------------------------------------------------------------------- */
    /*  Using lib for variable                                                    */
    /* -------------------------------------------------------------------------- */
    using StringsLib for uint256;

    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error MintFeeTooLow();
    error MintFeeTooHigh();
    error MintFeeNotPaid();
    error MaxSupplyExceeded();
    error WithdrawTransferFailed();
    error HiveOnly();
    error InvalidBeeType();

    /* -------------------------------------------------------------------------- */
    /*  Struct                                                                    */
    /* -------------------------------------------------------------------------- */
    struct BeeCharacteristics {
        string avatar;
        string beeType;
    }

    struct BeeTraits {
        uint256 energy;
        uint256 health;
        uint256 attack;
        uint256 defense;
        uint256 forage;
        uint256 baseProductivity;
        uint256 maxProductivity;
        uint256 experience;
        uint256 level;
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
    }

    struct BeeStatus {
        uint256 baseEnergy;
        uint256 baseHealth;
        uint256 lastEnergyRefreshTimestamp;
        uint256 lastHealthRefreshTimestamp;
    }

    struct Quest {
        uint256 forageCount;
        uint256 raidCount;
        uint256 raidSuccessCount;
        uint256 upgradeCount;
    }

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_000;
    uint256 public constant MAX_SUPPLY = 1_000_000;
    uint256 public constant MIN_FEE = 0.00044 ether; // Min fee on bee created
    uint256 public constant MAX_FEE = 5 ether; // Max fee on bee created

    /* -------------------------------------------------------------------------- */
    /* State Variables                                                            */
    /* -------------------------------------------------------------------------- */
    uint256 public currentTokenId;
    uint256 public mintFee;
    IBuzzkillAddressProvider public buzzkillAddressProvider;
    mapping(uint256 => string) public tokenURIs;
    mapping(uint256 => BeeCharacteristics) public tokenIdToCharacteristics;
    mapping(uint256 => BeeTraits) public tokenIdToTraits;
    mapping(uint256 => BeeStatus) public tokenIdToStatus;
    mapping(uint256 => mapping(uint256 => Quest)) public beeQuestTracking;

    string public constant workerBeeImage =
        "https://photos.app.goo.gl/6QWvzWw5L3DnijFs6";
    string public constant queenBeeImage =
        "https://photos.app.goo.gl/ddqkjKf6RekQSaYE6";

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */

    constructor(uint256 _mintFee, address _buzzkillAddressProvider) {
        if (_mintFee < MIN_FEE) revert MintFeeTooLow();
        if (_mintFee > MAX_FEE) revert MintFeeTooHigh();
        __VRC725_init("Buzzkill", "BZK", msg.sender);
        mintFee = _mintFee;
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifier                                                                  */
    /* -------------------------------------------------------------------------- */
    modifier onlyHive() {
        if (msg.sender != buzzkillAddressProvider.hiveManagerAddress()) {
            revert HiveOnly();
        }
        _;
    }

    /* -------------------------------------------------------------------------- */
    /*  Fallback function                                                         */
    /* -------------------------------------------------------------------------- */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    /* -------------------------------------------------------------------------- */
    /*  View Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Retrieves the token URI for a given token ID.
     * @param tokenId The ID of the token.
     * @return The token URI as a string.
     */
    function _getTokenURI(
        uint256 tokenId
    ) private view returns (string memory) {
        BeeCharacteristics memory beeCharacteristics = tokenIdToCharacteristics[
            tokenId
        ];
        BeeTraits memory beeTraits = tokenIdToTraits[tokenId];
        bytes memory dataURI = bytes.concat(
            abi.encodePacked(
                "{",
                '"name": "Bee #',
                tokenId.toString(),
                '",',
                '"description": "Buzzkill NFT",',
                '"image": "',
                beeCharacteristics.avatar,
                '"',
                '"type": "',
                beeCharacteristics.beeType,
                '"',
                '"energy": "',
                beeTraits.energy.toString(),
                '"',
                '"health": "',
                beeTraits.health.toString(),
                '"'
            ),
            abi.encodePacked(
                '"attack": "',
                beeTraits.attack.toString(),
                '"',
                '"defense": "',
                beeTraits.defense.toString(),
                '"',
                '"forage": "',
                beeTraits.forage.toString(),
                '"',
                '"baseProductivity": "',
                beeTraits.baseProductivity.toString(),
                '"',
                '"maxProductivity": "',
                beeTraits.maxProductivity.toString(),
                '"',
                '"level": "',
                beeTraits.level.toString(),
                "}"
            )
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    /**
     * @dev Retrieves the amount of energy refreshed for a given token ID.
     * @param tokenId The ID of the token.
     * @return The amount of energy refreshed.
     */
    function _amountEnergyRefreshed(
        uint256 tokenId
    ) private view returns (uint256) {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 lastRefresh = tokenIdToStatus[tokenId]
            .lastEnergyRefreshTimestamp;
        uint256 timeSinceLastRefresh = block.timestamp - lastRefresh;

        if (timeSinceLastRefresh < gameConfig.beeEnergyRefreshInterval()) {
            return 0;
        }

        return tokenIdToStatus[tokenId].baseEnergy;
    }

    /**
     * @dev Retrieves the amount of health refreshed for a given token ID.
     * @param tokenId The ID of the token.
     * @return The amount of health refreshed.
     */
    function _amountHealthRefreshed(
        uint256 tokenId
    ) private view returns (uint256) {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 lastRefresh = tokenIdToStatus[tokenId]
            .lastHealthRefreshTimestamp;
        uint256 timeSinceLastRefresh = block.timestamp - lastRefresh;

        if (timeSinceLastRefresh < gameConfig.beeHealthRefreshInterval()) {
            return 0;
        }

        return tokenIdToStatus[tokenId].baseHealth;
    }

    /**
     * @dev Retrieves the token URI for a given token ID.
     * @param tokenId The ID of the token.
     */
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        return tokenURIs[tokenId];
    }

    /**
     * @dev Retrieves the bee characteristics for a given token ID.
     * We have the equation to caculate XP per level: XP = (d x n x (n - 1))/2 with d is differenceBetweenLevels and n is bee level
     * Transform the equation to: n^2 - n - 2XP/d = 0 (Bring the equation to the form ax^2 + bx + c = 0)
     * Quadratic formula: x = (-b ± sqrt(b^2 - 4ac)) / 2a
     * From the base equation, we have: n = (sqrt(8 * XP/d + 1) + 1)/2 using quadratic formula
     * @param tokenId The ID of the token.
     * @return The bee characteristics.
     */
    function getBeeLevel(uint256 tokenId) public view returns (uint256) {
        // Ensure difference between level is not zero to avoid division by zero
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 differenceBetweenLevels = gameConfig.differenceBetweenLevels();
        require(
            differenceBetweenLevels > 0,
            "Difference between level must be greater than zero"
        );

        BeeTraits memory beeTraits = tokenIdToTraits[tokenId];

        // Calculate the discriminant of the quadratic equation
        uint256 discriminant = (8 * beeTraits.experience) /
            differenceBetweenLevels +
            1;

        // Calculate the square root of the discriminant
        uint256 sqrtDiscriminant = sqrt(discriminant);

        // Calculate the value of bee level using the quadratic formula
        uint256 beeLevel = (sqrtDiscriminant + 1) / 2;

        return beeLevel;
    }

    /**
     * @dev Retrieves the bee characteristics for a given token ID.
     * @param tokenId The ID of the token.
     * @return The bee characteristics.
     */
    function getBeeTraits(
        uint256 tokenId
    ) public view returns (BeeTraits memory) {
        return tokenIdToTraits[tokenId];
    }

    /**
     * @dev Retrieves the number of foraging quests for a given bee level.
     * Caculation equation: Qfn = baseNumberOfForagingQuest + (n-1) x 2
     * @param level The level of the bee.
     * @return The number of foraging quests.
     */
    function getForagingNumQuestsForLevel(
        uint256 level
    ) public view returns (uint256) {
        require(level > 0, "Level must be greater than zero");
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        return gameConfig.baseNumberOfForagingQuest() + (level - 1) * 2;
    }

    /**
     * @dev Retrieves the number of raid quests for a given bee level.
     * Caculation equation: Qrn = baseNumberOfRaidQuest + n
     * @param level The level of the bee.
     * @return The number of raid quests.
     */
    function getRaidNumQuestsForLevel(
        uint256 level
    ) public view returns (uint256) {
        require(level > 0, "Level must be greater than zero");
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        return gameConfig.baseNumberOfRaidQuest() + level;
    }

    /**
     * @dev Retrieves the number of raid success quests for a given bee level.
     * Caculation equation: Qrsn = baseNumberOfRaidSuccessQuest + (n-1) / 2
     * @param level The level of the bee.
     * @return The number of raid success quests.
     */
    function getRaidSuccessNumQuestsForLevel(
        uint256 level
    ) public view returns (uint256) {
        require(level > 0, "Level must be greater than zero");
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        return gameConfig.baseNumberOfRaidSuccessQuest() + (level - 1) / 2;
    }

    /**
     * @dev Retrieves the number of upgrade quests for a given bee level.
     * Caculation equation: Qun = baseNumberOfUpgradeQuest + n
     * @param level The level of the bee.
     * @return The number of upgrade quests.
     */
    function getUpgradeNumQuestsForLevel(
        uint256 level
    ) public view returns (uint256) {
        require(level > 0, "Level must be greater than zero");
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        return gameConfig.baseNumberOfUpgradeQuest() + level;
    }

    /* -------------------------------------------------------------------------- */
    /*  Internal Functions                                                        */
    /* -------------------------------------------------------------------------- */
    // Helper function to calculate the square root using the Babylonian method
    function sqrt(uint256 x) internal pure returns (uint256 y) {
        if (x == 0) {
            return 0;
        } else if (x <= 3) {
            return 1;
        }
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }

    function levelUpBeeAndUpdateHiveStatus(
        uint256 _hiveId,
        uint256 _tokenId
    ) internal {
        IHiveManager hiveManager = IHiveManager(
            buzzkillAddressProvider.hiveManagerAddress()
        );
        _upgradeBeeTraitsOnLevelUp(_tokenId);
        hiveManager.updateHiveDefense(_hiveId, _tokenId);
        hiveManager.updateHiveProductivity(_hiveId, _tokenId);
    }

    /* -------------------------------------------------------------------------- */
    /*  Logic Functions                                                           */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Mints a new bee token and assigns it to the specified address.
     * Only the contract owner can call this function.
     * Reverts if the total supply exceeds the maximum supply.
     * @param to The address to mint the token to.
     * @param _beeType The type of bee to mint, either 0 for worker or 1 for queen.
     * @return The ID of the newly minted token.
     */
    function mintTo(
        address to,
        uint256 _beeType
    ) external payable whenNotPaused nonReentrant returns (uint256) {
        if (msg.sender != owner()) {
            if (msg.value != mintFee) revert MintFeeNotPaid();
        }
        uint256 newTokenId = currentTokenId;
        if (newTokenId > MAX_SUPPLY) revert MaxSupplyExceeded();

        _safeMint(to, newTokenId);

        if (_beeType == 0) {
            tokenIdToCharacteristics[newTokenId] = BeeCharacteristics(
                workerBeeImage,
                "Worker"
            );
            tokenIdToTraits[newTokenId] = BeeTraits(
                100, // energy
                10, // health
                1, // attack
                1, // defense
                1, // forage
                20, // baseProductivity
                100, // maxProductivity
                0, // experience
                1, // level
                0, // nectar
                0, // pollen
                0 // sap
            );
        } else if (_beeType == 1) {
            tokenIdToCharacteristics[newTokenId] = BeeCharacteristics(
                queenBeeImage,
                "Queen"
            );
            tokenIdToTraits[newTokenId] = BeeTraits(
                200, // energy
                20, // health
                2, // attack
                2, // defense
                2, // forage
                25, // baseProductivity
                120, // maxProductivity
                0, // experience
                1, // level
                0, // nectar
                0, // pollen
                0 // sap
            );
        } else {
            revert InvalidBeeType();
        }

        tokenURIs[newTokenId] = _getTokenURI(newTokenId);
        currentTokenId++;

        return newTokenId;
    }

    /**
     * @dev Modifies the traits of a bee token.
     * Only the Hive contract can call this function.
     * @param tokenId The ID of the token to modify.
     * @param _newBeeTraits The new traits to set.
     */
    function modifyBeeTraits(
        uint256 hiveId,
        uint256 tokenId,
        BeeTraits memory _newBeeTraits
    ) public onlyHive {
        require(_exists(tokenId), "Token does not exist");
        // Hive is holding the NFT
        require(ownerOf(tokenId) == msg.sender, "Not owner");
        // Get bee traits state before update
        BeeTraits memory prevBeeTraits = tokenIdToTraits[tokenId];
        // Update bee traits, expect level to be the same as the current level
        require(
            _newBeeTraits.level == prevBeeTraits.level,
            "Invalid level value"
        );
        tokenIdToTraits[tokenId] = _newBeeTraits;
        // Check if bee level up
        if (_newBeeTraits.experience > prevBeeTraits.experience) {
            uint256 currentBeeLevel = getBeeLevel(tokenId);
            if (currentBeeLevel > prevBeeTraits.level) {
                _upgradeBeeTraitsOnLevelUp(tokenId);
            }
        }
        IHiveManager hiveManager = IHiveManager(
            buzzkillAddressProvider.hiveManagerAddress()
        );
        if (tokenIdToTraits[tokenId].defense > prevBeeTraits.defense) {
            hiveManager.updateHiveDefense(hiveId, tokenId);
        }
        if (
            tokenIdToTraits[tokenId].baseProductivity >
            prevBeeTraits.baseProductivity
        ) {
            hiveManager.updateHiveProductivity(hiveId, tokenId);
        }
        tokenURIs[tokenId] = _getTokenURI(tokenId);
    }

    /**
     * @dev Refreshes the energy of a bee token. 
     Energy is refreshed each interval. Different bee types have different energy refresh rates.
     * @param tokenId The ID of the token to refresh.
     */
    function refreshBeeEnergy(uint256 tokenId) public {
        require(_exists(tokenId), "Token does not exist");
        BeeTraits storage beeTraits = tokenIdToTraits[tokenId];
        uint256 energyRefreshed = _amountEnergyRefreshed(tokenId);
        if (energyRefreshed > 0) {
            beeTraits.energy = energyRefreshed;
        }
    }

    /**
     * @dev Refreshes the health of a bee token. 
     Health is refreshed each interval. Different bee types have different health refresh rates.
     * @param tokenId The ID of the token to refresh.
     */
    function refreshBeeHealth(uint256 tokenId) public {
        require(_exists(tokenId), "Token does not exist");
        BeeTraits storage beeTraits = tokenIdToTraits[tokenId];
        uint256 healthRefreshed = _amountHealthRefreshed(tokenId);
        if (healthRefreshed > 0) {
            beeTraits.health = healthRefreshed;
        }
    }

    /**
     * @dev Updates the foraging quests progress for a bee.
     * Only the Hive contract can call this function.
     * @param hiveId The ID of the hive.
     * @param tokenId The ID of the token to update.
     */
    function updateForagingQuestCount(
        uint256 hiveId,
        uint256 tokenId
    ) external onlyHive {
        require(_exists(tokenId), "Token does not exist");
        uint256 currentBeeLevel = getBeeLevel(tokenId);
        uint256 accomplishedForagingQuestsBefore = beeQuestTracking[tokenId][
            currentBeeLevel
        ].forageCount;
        uint256 amountQuestsRequired = getForagingNumQuestsForLevel(
            currentBeeLevel
        );

        beeQuestTracking[tokenId][currentBeeLevel].forageCount++;

        if (
            accomplishedForagingQuestsBefore < amountQuestsRequired &&
            beeQuestTracking[tokenId][currentBeeLevel].forageCount >=
            amountQuestsRequired
        ) {
            tokenIdToTraits[tokenId].experience +=
                IGameConfig(buzzkillAddressProvider.gameConfigAddress())
                    .experienceEarnedAfterForage() *
                amountQuestsRequired;
            if (getBeeLevel(tokenId) > currentBeeLevel) {
                levelUpBeeAndUpdateHiveStatus(hiveId, tokenId);
            }
        }
    }

    /**
     * @dev Updates the raid quests progress for a bee.
     * Only the Hive contract can call this function.
     * @param hiveId The ID of the hive.
     * @param tokenId The ID of the token to update.
     */
    function updateRaidQuestCount(
        uint256 hiveId,
        uint256 tokenId
    ) external onlyHive {
        require(_exists(tokenId), "Token does not exist");
        uint256 currentBeeLevel = getBeeLevel(tokenId);
        uint256 accomplishedRaidQuestsBefore = beeQuestTracking[tokenId][
            currentBeeLevel
        ].raidCount;
        uint256 amountQuestsRequired = getRaidNumQuestsForLevel(
            currentBeeLevel
        );

        beeQuestTracking[tokenId][currentBeeLevel].raidCount++;

        if (
            accomplishedRaidQuestsBefore < amountQuestsRequired &&
            beeQuestTracking[tokenId][currentBeeLevel].raidCount >=
            amountQuestsRequired
        ) {
            tokenIdToTraits[tokenId].experience +=
                IGameConfig(buzzkillAddressProvider.gameConfigAddress())
                    .experienceEarnedAfterRaidFailed() *
                amountQuestsRequired;
            if (getBeeLevel(tokenId) > currentBeeLevel) {
                levelUpBeeAndUpdateHiveStatus(hiveId, tokenId);
            }
        }
    }

    /**
     * @dev Updates the raid success quests progress for a bee.
     * Only the Hive contract can call this function.
     * @param hiveId The ID of the hive.
     * @param tokenId The ID of the token to update.
     */
    function updateRaidSuccessQuestCount(
        uint256 hiveId,
        uint256 tokenId
    ) external onlyHive {
        require(_exists(tokenId), "Token does not exist");
        uint256 currentBeeLevel = getBeeLevel(tokenId);
        uint256 accomplishedRaidSuccessQuestsBefore = beeQuestTracking[tokenId][
            currentBeeLevel
        ].raidSuccessCount;
        uint256 amountQuestsRequired = getRaidSuccessNumQuestsForLevel(
            currentBeeLevel
        );

        beeQuestTracking[tokenId][currentBeeLevel].raidSuccessCount++;

        if (
            accomplishedRaidSuccessQuestsBefore < amountQuestsRequired &&
            beeQuestTracking[tokenId][currentBeeLevel].raidSuccessCount >=
            amountQuestsRequired
        ) {
            tokenIdToTraits[tokenId].experience +=
                IGameConfig(buzzkillAddressProvider.gameConfigAddress())
                    .experienceEarnedAfterRaidSuccess() *
                amountQuestsRequired;
            if (getBeeLevel(tokenId) > currentBeeLevel) {
                levelUpBeeAndUpdateHiveStatus(hiveId, tokenId);
            }
        }
    }

    /**
     * @dev Updates the upgrade quests progress for a bee.
     * Only the Hive contract can call this function.
     * @param hiveId The ID of the hive.
     * @param tokenId The ID of the token to update.
     */
    function updateUpgradeQuestCount(
        uint256 hiveId,
        uint256 tokenId
    ) external onlyHive {
        require(_exists(tokenId), "Token does not exist");
        uint256 currentBeeLevel = getBeeLevel(tokenId);
        uint256 accomplishedUpgradeQuestsBefore = beeQuestTracking[tokenId][
            currentBeeLevel
        ].upgradeCount;
        uint256 amountQuestsRequired = getUpgradeNumQuestsForLevel(
            currentBeeLevel
        );

        beeQuestTracking[tokenId][currentBeeLevel].upgradeCount++;

        if (
            accomplishedUpgradeQuestsBefore < amountQuestsRequired &&
            beeQuestTracking[tokenId][currentBeeLevel].upgradeCount >=
            amountQuestsRequired
        ) {
            tokenIdToTraits[tokenId].experience +=
                IGameConfig(buzzkillAddressProvider.gameConfigAddress())
                    .experienceEarnedAfterUpgrade() *
                amountQuestsRequired;
            if (getBeeLevel(tokenId) > currentBeeLevel) {
                levelUpBeeAndUpdateHiveStatus(hiveId, tokenId);
            }
        }
    }

    /* -------------------------------------------------------------------------- */
    /*  Owner Functions                                                           */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Burns a bee token.
     * Only the contract owner can call this function.
     * @param tokenId The ID of the token to burn.
     */
    function burn(uint256 tokenId) external onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _burn(tokenId);
    }

    /**
     * @dev Sets the mint fee for the contract.
     * Only the contract owner can call this function.
     * @param _mintFee The new mint fee to set.
     */
    function setMintFee(uint256 _mintFee) external onlyOwner {
        if (_mintFee < MIN_FEE) revert MintFeeTooLow();
        if (_mintFee > MAX_FEE) revert MintFeeTooHigh();
        mintFee = _mintFee;
    }

    /**
     * @dev Withdraws the contract's balance to the specified address.
     * Only the contract owner can call this function.
     * @param payee The address to withdraw the balance to.
     */
    function withdrawPayments(
        address payable payee
    ) external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) revert WithdrawTransferFailed();
    }

    /**
     * @dev Pauses the contract.
     * Only the contract owner can call this function.
     */
    function pause() external onlyOwner {
        super._pause();
    }

    /**
     * @dev Unpauses the contract.
     * Only the contract owner can call this function.
     */
    function unpause() external onlyOwner {
        super._unpause();
    }

    /* -------------------------------------------------------------------------- */
    /*  Private functions                                                         */
    /* -------------------------------------------------------------------------- */
    function _upgradeBeeTraitsOnLevelUp(uint256 _tokenId) private {
        BeeTraits storage beeTraits = tokenIdToTraits[_tokenId];

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        // Level up
        beeTraits.level = getBeeLevel(_tokenId);
        beeTraits.attack += gameConfig.amountAttackIncreaseOnLevelUp();
        beeTraits.defense += gameConfig.amountDefenseIncreaseOnLevelUp();
        beeTraits.forage += gameConfig.amountForageIncreaseOnLevelUp();
        beeTraits.energy += gameConfig.amountEnergyIncreaseOnLevelUp();
        beeTraits.health += gameConfig.amountHealthIncreaseOnLevelUp();
        beeTraits.maxProductivity += gameConfig
            .amountMaxProductivityIncreaseOnLevelUp();
        if (
            beeTraits.baseProductivity +
                gameConfig.amountBaseProductivityIncreaseOnLevelUp() >
            beeTraits.maxProductivity
        ) {
            beeTraits.baseProductivity = beeTraits.maxProductivity;
        } else {
            beeTraits.baseProductivity += gameConfig
                .amountBaseProductivityIncreaseOnLevelUp();
        }
    }

    /* -------------------------------------------------------------------------- */
    /*  Required Overrides                                                        */
    /* -------------------------------------------------------------------------- */

    // The following functions are overrides required by Solidity.

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(VRC725, VRC725Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal virtual override(VRC725, VRC725Enumerable) {
        super._beforeTokenTransfer(from, to, firstTokenId, batchSize);
    }
}
