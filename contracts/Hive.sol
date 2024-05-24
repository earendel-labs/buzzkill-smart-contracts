// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IHoneyDistribution.sol";
import "../interfaces/IHive.sol";
import "../interfaces/IHoney.sol";

contract Hive {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error InvalidNFTType();
    error MaxQueenReached();
    error MaxWorkerReached();
    error NotBeeOwner();
    error BeeAlreadyInAction();
    error InsufficientEnergy();
    error BeeAlreadyStaked();
    error NoHoneyToCollect();
    error NoQueenBee();
    error NotEnoughNectarToCollect();
    error HiveOnly();
    error BeeNotInHive();
    error BeeMustBeOutsideHive();
    error InsufficientHealth();
    error InsufficientHoney();
    error InsufficientSap();

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event NFTStaked(uint256 tokenId);
    event NFTUnstaked(uint256 tokenId);
    event ForageFinished(
        uint256 tokenId,
        uint256 nectar,
        uint256 pollen,
        uint256 sap,
        uint256 productivityEarned,
        uint256 experienceEarned
    );
    event RaidFinished(
        uint256 tokenId,
        uint256 honey,
        uint256 productivityEarned,
        uint256 experienceEarned
    );
    event CollectHoney(uint256 tokenId, uint256 honey);

    /* -------------------------------------------------------------------------- */
    /*  Structs                                                                   */
    /* -------------------------------------------------------------------------- */
    struct BeeStatus {
        address owner;
        uint256 beeId;
        uint256 beeProductivity;
        uint256 beeDefense;
        uint256 lastClaimedBlock;
    }

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_0000;
    uint256 public constant MAX_QUEEN = 3;
    uint256 public constant MAX_WORKER = 55;
    uint256 public constant FORAGE_PERCENTAGE = 500; // 5% of the gathered resources are added to the hive
    uint256 public constant ONE_EPOCH = 900; // 1 epoch = 900 blocks
    uint256 public constant ONE_WEEK = 1 weeks;
    uint256 public constant HONEY_YIELD_CONSTANT = 10_0000; // Set at 1
    uint256 public constant NECTAR_REQUIRED_TO_CLAIM = 100; // Required at least 100 nectar to claim honey
    uint256 public constant EXPERIENCE_EARNED_AFTER_FORAGE = 20; // 20 experience points earned after foraging
    uint256 public constant EXPERIENCE_EARNED_AFTER_RAID_FAILED = 10; // 10 experience points earned after a failed raid
    uint256 public constant EXPERIENCE_EARNED_AFTER_RAID_SUCCESS = 30; // 30 experience points earned after a successful raid
    uint256 public constant BASE_HEALTH_DEDUCTION_AFTER_RAID = 5; // 5 HP deducted after a raid
    uint256 public constant RAID_HONEY_FEE = 10 ether; // 10 $HONEY paid for one raid
    uint256 public constant RAID_SAP_FEE = 1; // 1 sap for one raid
    uint256 public constant BASE_HONEY_RAID_REWARD = 10 ether; // base honey earn for one raid success is 10 $HONEY
    uint256 public constant PRODUCTIVITY_EARN_AFTER_RAID = 10; // 10 productivity points earned after a raid

    /* -------------------------------------------------------------------------- */
    /*  State Variables                                                           */
    /* -------------------------------------------------------------------------- */
    address public creator;
    uint256 public habitatId;
    uint256 public numQueens;
    uint256 public numWorkers;
    uint256 public nectar;
    uint256 public pollen;
    uint256 public sap;
    uint256 public hiveProductivity;
    uint256 public hiveDefense;
    uint256 public availableHoneyInHive;
    uint256 public lastAvailableHoneyUpdateBlock;
    mapping(uint256 => bool) public isBeeInAction;
    mapping(uint256 => BeeStatus) public beeStatus;

    IBuzzkillAddressProvider public buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    constructor(uint256 _habitatId, address _buzzkillAddressProvider) {
        creator = msg.sender;
        habitatId = _habitatId;
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifiers                                                                 */
    /* -------------------------------------------------------------------------- */
    modifier onlyOneAction(uint256 tokenId) {
        if (isBeeInAction[tokenId]) revert BeeAlreadyInAction();
        isBeeInAction[tokenId] = true;
        _;
        isBeeInAction[tokenId] = false;
    }

    modifier onlyHive() {
        IHive hive = IHive(msg.sender);
        if (hive.creator() != creator) {
            revert HiveOnly();
        }
        _;
    }

    /* -------------------------------------------------------------------------- */
    /*  View Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Get the hive resources.
     * @return The nectar, pollen, and sap resources in the hive.
     */
    function getHiveResources()
        public
        view
        returns (uint256, uint256, uint256)
    {
        return (nectar, pollen, sap);
    }

    /**
     * @dev Get the hive pool multiplier. The hive pool multiplier is calculated based on the hive abundance and productivity.
     * @return The hive pool multiplier.
     */
    function getHivePoolMultiplier() public view returns (uint256) {
        uint256 hiveAbdunace = getHiveAbdunace();
        return hiveProductivity + (hiveAbdunace * 10_000) / BASE_DENOMINATOR; // Currently fix constant at 1
    }

    /**
     * @dev Get the hive abundance. The hive abundance is calculated based on the resources in the hive.
     Necatar contributes 20%, pollen contributes 30%, and sap contributes 50%.
     * @return The hive abundance.
     */
    function getHiveAbdunace() internal view returns (uint256) {
        return
            ((nectar * 2000) / BASE_DENOMINATOR) +
            ((pollen * 3000) / BASE_DENOMINATOR) +
            ((sap * 5000) / BASE_DENOMINATOR);
    }

    /**
     * @dev Get the available honey in the hive.
     The available honey is calculated based on the hive productivity and the base honey yield. The available honey is updated every epoch.
     * @return The available honey in the hive.
     */
    function getAvailableHoneyInHive() public view returns (uint256) {
        if (block.number <= lastAvailableHoneyUpdateBlock) {
            return availableHoneyInHive;
        }

        uint256 hiveMultiplier = getHivePoolMultiplier();
        uint256 baseHoneyYield = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        ).baseHoneyYield();
        uint256 epochPassed = (block.number - lastAvailableHoneyUpdateBlock) /
            ONE_EPOCH;
        if (epochPassed == 0) {
            return availableHoneyInHive;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            HONEY_YIELD_CONSTANT) / BASE_DENOMINATOR;

        uint256 currentAvailableHoney = availableHoneyInHive +
            honeyProduced *
            epochPassed;

        return currentAvailableHoney;
    }

    /**
     * @dev Get the user's claimable honey. The claimable honey is calculated based on the user's bee productivity and the hive productivity.
     * @param _tokenId The Bee NFT token ID.
     * @return The user's claimable honey.
     */
    function getUserClaimableHoney(
        uint256 _tokenId
    ) public view returns (uint256) {
        uint256 currentAvailableHoney = getAvailableHoneyInHive();
        uint256 lastClaimedBlock = beeStatus[_tokenId].lastClaimedBlock;

        if (lastClaimedBlock == 0) {
            return 0;
        }

        if (
            lastClaimedBlock > block.number &&
            block.number - lastClaimedBlock < ONE_WEEK
        ) {
            return 0;
        }
        uint256 currentBeeProductivity = beeStatus[_tokenId].beeProductivity;

        uint256 claimableHoney = (currentAvailableHoney *
            currentBeeProductivity) / hiveProductivity;

        return claimableHoney;
    }

    /**
     * @dev Pseudo-random number generator, consider using Chainlink VRF later on production
     * @return A pseudo-random number between 10_000 and 12_500
     */
    function randomBeeRaidBoost() internal view returns (uint256) {
        return
            (uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao,
                        msg.sender
                    )
                )
            ) % 2500) + 10_000;
    }

    /**
     * @dev Pseudo-random number generator, consider using Chainlink VRF later on production
     * @return A pseudo-random number between 10_000 to 12_500 if hive is half-full or lower
        A pseudo-random number between 10_000 to 15_000 if hive is more than half-full
     */
    function randomHiveDefenseBoost() internal view returns (uint256) {
        uint256 totalBees = numQueens + numWorkers;

        if (totalBees <= 29) {
            return
                (uint256(
                    keccak256(
                        abi.encodePacked(
                            block.timestamp,
                            block.prevrandao,
                            msg.sender
                        )
                    )
                ) % 2500) + 10_000;
        } else {
            return
                (uint256(
                    keccak256(
                        abi.encodePacked(
                            block.timestamp,
                            block.prevrandao,
                            msg.sender
                        )
                    )
                ) % 5000) + 10_000;
        }
    }

    /* -------------------------------------------------------------------------- */
    /*  Logic Functions                                                           */
    /* -------------------------------------------------------------------------- */

    function updateHiveDefense(uint256 _tokenId) external {
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        if (buzzkillNFT.ownerOf(_tokenId) != address(this)) {
            revert BeeNotInHive();
        }

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        hiveDefense -= beeStatus[_tokenId].beeDefense;
        beeStatus[_tokenId].beeDefense = beeTraits.defense;
        hiveDefense += beeTraits.defense;
    }

    /**
     * @dev Stake a Bee NFT to the hive. The hive can only have a maximum of 3 queens and 55 workers.
     * @param _tokenId The Bee NFT token ID.
     */
    function stakeNFT(uint256 _tokenId) external {
        if (numQueens >= MAX_QUEEN) {
            revert MaxQueenReached();
        }

        if (numWorkers >= MAX_WORKER) {
            revert MaxWorkerReached();
        }

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        ); // Interface to interact with the Buzzkill NFT contract
        (, string memory beeType) = buzzkillNFT.tokenIdToCharacteristics(
            _tokenId
        );

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        _updateHive();

        if (_isQueen(beeType)) {
            numQueens++;
        } else if (_isWorker(beeType)) {
            numWorkers++;
        } else {
            revert InvalidNFTType();
        }

        if (beeStatus[_tokenId].owner != address(0)) {
            revert BeeAlreadyStaked();
        }

        beeStatus[_tokenId] = BeeStatus({
            owner: msg.sender,
            beeId: _tokenId,
            beeProductivity: 0,
            beeDefense: beeTraits.defense,
            lastClaimedBlock: block.number
        });

        hiveDefense += beeTraits.defense;

        buzzkillNFT.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit NFTStaked(_tokenId);
    }

    /**
     * @dev Unstake a Bee NFT from the hive.
     * @param _tokenId The Bee NFT token ID.
     */
    function unstake(uint256 _tokenId) external {
        if (msg.sender != beeStatus[_tokenId].owner) {
            revert NotBeeOwner();
        }
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        (, string memory beeType) = buzzkillNFT.tokenIdToCharacteristics(
            _tokenId
        );

        _updateHive();

        if (_isQueen(beeType)) {
            numQueens--;
        } else if (_isWorker(beeType)) {
            numWorkers--;
        }

        hiveProductivity -= beeStatus[_tokenId].beeProductivity;
        hiveDefense -= beeStatus[_tokenId].beeDefense;
        beeStatus[_tokenId] = BeeStatus({
            owner: address(0),
            beeId: 0,
            beeProductivity: 0,
            beeDefense: 0,
            lastClaimedBlock: 0
        });

        buzzkillNFT.safeTransferFrom(address(this), msg.sender, _tokenId);

        emit NFTUnstaked(_tokenId);
    }

    /**
     * @dev Forage resources from the specified habitat using a Bee NFT.
     * This function allows the owner of a Bee NFT to forage nectar, pollen, and sap from a habitat.
     * Part of the gathered resources and productivity boost are added to the hive.
     * Can only be called once per action per token.
     * Energy is required to perform this action.
     * @param _tokenId The Bee NFT token ID.
     * @param _habitatId The habitat ID from which resources are foraged.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if the bee does not have sufficient energy, or if the bee has already performed an action.
     */
    function forage(
        uint256 _tokenId,
        uint256 _habitatId
    ) external onlyOneAction(_tokenId) {
        if (msg.sender != beeStatus[_tokenId].owner) {
            revert NotBeeOwner();
        }

        _updateHive();

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IWorldMap worldMap = IWorldMap(
            buzzkillAddressProvider.worldMapAddress()
        );

        uint256 energyDeduction = worldMap.getAmountEnergyDeductionAfterForage(
            _habitatId
        );

        buzzkillNFT.refreshBeeEnergy(_tokenId);

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        if (beeTraits.energy < energyDeduction) {
            revert InsufficientEnergy();
        }

        (
            uint256 nectarGathered,
            uint256 pollenGathered,
            uint256 sapGathered
        ) = worldMap.forage(_tokenId, _habitatId);

        uint256 productivityEarned = worldMap
            .getAmountProductivityBoostAfterForage(_habitatId);

        // 5% of the gathered resources are added to the hive
        if ((nectarGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR < 1) {
            if (nectarGathered == 1) {
                beeTraits.nectar += nectarGathered;
            } else {
                nectar += 1;
                beeTraits.nectar += nectarGathered - 1;
            }
        } else {
            nectar += (nectarGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
            beeTraits.nectar +=
                nectarGathered -
                (nectarGathered * FORAGE_PERCENTAGE) /
                BASE_DENOMINATOR;
        }

        if ((pollenGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR < 1) {
            if (pollenGathered == 1) {
                beeTraits.pollen += pollenGathered;
            } else {
                pollen += 1;
                beeTraits.pollen += pollenGathered - 1;
            }
        } else {
            pollen += (pollenGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
            beeTraits.pollen +=
                pollenGathered -
                (pollenGathered * FORAGE_PERCENTAGE) /
                BASE_DENOMINATOR;
        }

        if ((sapGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR < 1) {
            if (sapGathered == 1) {
                beeTraits.sap += sapGathered;
            } else {
                sap += 1;
                beeTraits.sap += sapGathered - 1;
            }
        } else {
            sap += (sapGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
            beeTraits.sap +=
                sapGathered -
                (sapGathered * FORAGE_PERCENTAGE) /
                BASE_DENOMINATOR;
        }

        hiveProductivity += productivityEarned;
        beeTraits.energy -= energyDeduction;
        beeTraits.experience += EXPERIENCE_EARNED_AFTER_FORAGE;

        beeStatus[_tokenId].beeProductivity += productivityEarned;

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        emit ForageFinished(
            _tokenId,
            nectarGathered,
            pollenGathered,
            sapGathered,
            productivityEarned,
            EXPERIENCE_EARNED_AFTER_FORAGE
        );
    }

    /**
     * @dev Initiate a raid on another hive using a Bee NFT.
     * This function allows the owner of a Bee NFT to raid another hive, consuming sap, honey, and health while gaining experience.
     * Can only be called once per action per token.
     * @param _tokenId The Bee NFT token ID.
     * @param _raidedHive The address of the hive being raided.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if the bee does not have sufficient sap, honey, or health, or if the bee has already performed an action.
     */
    function startRaid(
        uint256 _tokenId,
        address _raidedHive
    ) external onlyOneAction(_tokenId) {
        if (msg.sender != beeStatus[_tokenId].owner) {
            revert NotBeeOwner();
        }

        _updateHive();

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        if (beeTraits.sap < RAID_SAP_FEE) {
            revert InsufficientSap();
        }

        IHoney honey = IHoney(buzzkillAddressProvider.honeyAddress());

        if (beeTraits.health == 0) {
            revert InsufficientHealth();
        }

        if (honey.balanceOf(msg.sender) < RAID_HONEY_FEE) {
            revert InsufficientHoney();
        }

        honey.burn(msg.sender, RAID_HONEY_FEE);

        IHive raidedHive = IHive(_raidedHive);

        uint256 amountHoneyRaided = raidedHive.endureRaid(_tokenId);

        if (amountHoneyRaided > 0) {
            if (beeTraits.health < BASE_HEALTH_DEDUCTION_AFTER_RAID) {
                beeTraits.health = 0;
            } else {
                beeTraits.health -= BASE_HEALTH_DEDUCTION_AFTER_RAID;
            }

            uint256 amountHoneyShared = (amountHoneyRaided * 500) /
                BASE_DENOMINATOR; // Hive take 5% of the raided honey
            availableHoneyInHive += amountHoneyShared;
            beeTraits.experience += EXPERIENCE_EARNED_AFTER_RAID_SUCCESS;

            IHoneyDistribution honeyDistribution = IHoneyDistribution(
                buzzkillAddressProvider.honeyDistributionAddress()
            );
            honeyDistribution.distributeHoney(
                msg.sender,
                amountHoneyRaided - amountHoneyShared
            );
        } else {
            if (beeTraits.health < BASE_HEALTH_DEDUCTION_AFTER_RAID * 2) {
                beeTraits.health = 0;
            } else {
                beeTraits.health -= BASE_HEALTH_DEDUCTION_AFTER_RAID * 2;
            }
            beeTraits.experience += EXPERIENCE_EARNED_AFTER_RAID_FAILED;
        }

        beeStatus[_tokenId].beeProductivity += PRODUCTIVITY_EARN_AFTER_RAID;
        hiveProductivity += PRODUCTIVITY_EARN_AFTER_RAID;

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        emit RaidFinished(
            _tokenId,
            amountHoneyRaided,
            PRODUCTIVITY_EARN_AFTER_RAID,
            beeTraits.experience
        );
    }

    /**
     * @dev Endure a raid initiated by another hive.
     * This function handles the raid mechanics, comparing raid power and hive defense, and deducts honey if the raid is successful.
     * Can only be called by the hive contract.
     * @param _tokenId The Bee NFT token ID initiating the raid.
     * @return The amount of honey successfully raided.
     * @notice Reverts if the bee is not outside the hive.
     */
    function endureRaid(uint256 _tokenId) external onlyHive returns (uint256) {
        if (beeStatus[_tokenId].owner != address(0)) {
            revert BeeMustBeOutsideHive();
        }

        _updateHive();

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        uint256 raidBoost = randomBeeRaidBoost();
        uint256 hiveDefenseBoost = randomHiveDefenseBoost();

        uint256 caculatedRaidPower = beeTraits.attack * raidBoost;
        uint256 caculatedHiveDefense = hiveDefense * hiveDefenseBoost;

        uint256 amountHoneyRaided;

        if (caculatedRaidPower > caculatedHiveDefense) {
            uint256 _honeyPot = getAvailableHoneyInHive();
            uint256 hiveCapacity = _hiveCapacity();
            // Formular: Honey = Base * Capacity * Constant1 + HivePool * Forage * Constant2
            // Constant1 is currrently 1 and Constant2 is currently 0.01
            amountHoneyRaided =
                (BASE_HONEY_RAID_REWARD * hiveCapacity * 10_000) /
                BASE_DENOMINATOR +
                (_honeyPot * beeTraits.forage * 100) /
                (BASE_DENOMINATOR * BASE_DENOMINATOR);
            if (amountHoneyRaided > _honeyPot) {
                amountHoneyRaided = _honeyPot;
            }
            availableHoneyInHive -= amountHoneyRaided;
        }

        return amountHoneyRaided;
    }

    /**
     * @dev Collect the claimable honey for a specific Bee NFT token.
     * This function allows the owner of a Bee NFT to collect the honey it has accumulated.
     * The function checks ownership, ensures there are queen bees, and validates nectar requirements.
     * Can only be called once per action per token.
     * @param _tokenId The Bee NFT token ID.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if there are no queen bees, if there is no honey to collect, or if the bee does not have enough nectar to claim.
     */
    function collectHoney(uint256 _tokenId) external onlyOneAction(_tokenId) {
        if (msg.sender != beeStatus[_tokenId].owner) {
            revert NotBeeOwner();
        }

        if (numQueens == 0) {
            revert NoQueenBee();
        }

        IHoneyDistribution honeyDistribution = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        );
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        _updateHive();

        uint256 claimableHoney = getUserClaimableHoney(_tokenId);

        if (claimableHoney == 0) {
            revert NoHoneyToCollect();
        }

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        uint256 beeNectar = beeTraits.nectar;

        if (beeNectar < NECTAR_REQUIRED_TO_CLAIM) {
            revert NotEnoughNectarToCollect();
        }

        uint256 currentBeeProductivity = beeStatus[_tokenId].beeProductivity;

        beeStatus[_tokenId].lastClaimedBlock = block.number;
        beeStatus[_tokenId].beeProductivity = 0;
        hiveProductivity -= currentBeeProductivity;

        availableHoneyInHive -= claimableHoney;

        beeTraits.nectar -= NECTAR_REQUIRED_TO_CLAIM;

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        honeyDistribution.distributeHoney(msg.sender, claimableHoney);

        emit CollectHoney(_tokenId, claimableHoney);
    }

    /* -------------------------------------------------------------------------- */
    /*  Private Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Check if the bee is a queen.
     * @param beeType The bee type.
     * @return bool True if the bee is a queen, false otherwise.
     */
    function _isQueen(string memory beeType) private pure returns (bool) {
        if (keccak256(bytes(beeType)) == keccak256(bytes("Queen"))) {
            return true;
        }
        return false;
    }

    /**
     * @dev Check if the bee is a worker.
     * @param beeType The bee type.
     * @return bool True if the bee is a worker, false otherwise.
     */
    function _isWorker(string memory beeType) private pure returns (bool) {
        if (keccak256(bytes(beeType)) == keccak256(bytes("Worker"))) {
            return true;
        }
        return false;
    }

    /**
     * @dev Get the hive capacity.
     * @return The hive capacity.
     */
    function _hiveCapacity() private view returns (uint256) {
        if (numQueens + numWorkers == MAX_QUEEN + MAX_WORKER) return 2;
        return 1;
    }

    /**
     * @dev Update the hive collective pool of honey. The hive collective pool of honey is updated every epoch.
     */
    function _updateHive() private {
        if (block.number <= lastAvailableHoneyUpdateBlock) {
            return;
        }

        if (hiveProductivity == 0) {
            lastAvailableHoneyUpdateBlock = block.number;
            return;
        }

        uint256 hiveMultiplier = getHivePoolMultiplier();
        uint256 baseHoneyYield = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        ).baseHoneyYield();
        uint256 epochPassed = (block.number - lastAvailableHoneyUpdateBlock) /
            ONE_EPOCH;
        if (epochPassed == 0) {
            return;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            HONEY_YIELD_CONSTANT) / BASE_DENOMINATOR;

        availableHoneyInHive += honeyProduced * epochPassed;

        lastAvailableHoneyUpdateBlock = block.number;
    }
}
