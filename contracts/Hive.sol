// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IHoneyDistribution.sol";
import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IHive.sol";
import "../interfaces/IHoney.sol";
import "../interfaces/IGameConfig.sol";

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
    uint256 public constant BASE_DENOMINATOR = 10_000;
    uint256 public constant ONE_EPOCH = 900; // 1 epoch = 900 blocks

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
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 hiveMultiplier = getHivePoolMultiplier();
        uint256 baseHoneyYield = gameConfig.baseHoneyYield();
        uint256 epochPassed = (block.number - lastAvailableHoneyUpdateBlock) /
            ONE_EPOCH;
        if (epochPassed == 0) {
            return availableHoneyInHive;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            gameConfig.honeyYieldConstant()) / BASE_DENOMINATOR;

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

        if (lastClaimedBlock == 0 || hiveProductivity == 0) {
            return 0;
        }
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        if (
            lastClaimedBlock > block.number &&
            block.number - lastClaimedBlock < gameConfig.claimTimeInterval()
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
    function stakeBee(uint256 _tokenId) external {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        if (numQueens >= gameConfig.maxQueen()) {
            revert MaxQueenReached();
        }

        if (numWorkers >= gameConfig.maxWorker()) {
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
    function unstakeBee(uint256 _tokenId) external {
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

        // Check if the bee has claimable honey
        uint256 claimableHoney = getUserClaimableHoney(_tokenId);
        // If the bee has claimable honey, check if it has enough nectar to claim
        if (claimableHoney > 0) {
            IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT
                .tokenIdToTraits(_tokenId);

            uint256 beeNectar = beeTraits.nectar;
            IGameConfig gameConfig = IGameConfig(
                buzzkillAddressProvider.gameConfigAddress()
            );
            // If nectar is not enough, it miss out the chance to claim honey and will lose it once leave the hive
            if (beeNectar > gameConfig.nectarRequiredToClaim()) {
                IHoneyDistribution honeyDistribution = IHoneyDistribution(
                    buzzkillAddressProvider.honeyDistributionAddress()
                );

                availableHoneyInHive -= claimableHoney;

                beeTraits.nectar -= gameConfig.nectarRequiredToClaim();

                buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

                honeyDistribution.distributeHoney(msg.sender, claimableHoney);
            }
        }

        if (_isQueen(beeType)) {
            numQueens--;
        } else if (_isWorker(beeType)) {
            numWorkers--;
        }

        hiveProductivity -= beeStatus[_tokenId].beeProductivity;
        hiveDefense -= beeStatus[_tokenId].beeDefense;
        if (hiveProductivity == 0 && availableHoneyInHive > 0) {
            lastAvailableHoneyUpdateBlock = block.number;
            availableHoneyInHive = 0;
        }
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
     * Since 5% of the gathered resources are added to the hive, forage function will guarantee return the least amount of 20 each item.
     * E.g: Forage 20 nectar, hive will get 1 nectar and bee will get 19 nectar.
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

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        if (beeTraits.energy < energyDeduction) {
            revert InsufficientEnergy();
        }

        // Minimum amount for each resource is 20
        (
            uint256 nectarGathered,
            uint256 pollenGathered,
            uint256 sapGathered
        ) = worldMap.forage(_tokenId, _habitatId);

        uint256 productivityEarned = worldMap
            .getAmountProductivityBoostAfterForage(_habitatId);

        uint256 foragePercentage = gameConfig.foragePercentage();

        // 5% of the gathered resources are added to the hive
        if (((nectarGathered * foragePercentage) / BASE_DENOMINATOR) < 1) {
            nectar += 1;
            beeTraits.nectar += nectarGathered - 1;
        } else {
            nectar += (nectarGathered * foragePercentage) / BASE_DENOMINATOR;
            beeTraits.nectar +=
                nectarGathered -
                (nectarGathered * foragePercentage) /
                BASE_DENOMINATOR;
        }

        if (((pollenGathered * foragePercentage) / BASE_DENOMINATOR) < 1) {
            pollen += 1;
            beeTraits.pollen += pollenGathered - 1;
        } else {
            pollen += (pollenGathered * foragePercentage) / BASE_DENOMINATOR;
            beeTraits.pollen +=
                pollenGathered -
                (pollenGathered * foragePercentage) /
                BASE_DENOMINATOR;
        }

        if (((sapGathered * foragePercentage) / BASE_DENOMINATOR) < 1) {
            sap += 1;
            beeTraits.sap += sapGathered - 1;
        } else {
            sap += (sapGathered * foragePercentage) / BASE_DENOMINATOR;
            beeTraits.sap +=
                sapGathered -
                (sapGathered * foragePercentage) /
                BASE_DENOMINATOR;
        }

        hiveProductivity += productivityEarned;
        beeTraits.energy -= energyDeduction;
        beeTraits.experience += gameConfig.experienceEarnedAfterForage();

        beeStatus[_tokenId].beeProductivity += productivityEarned;

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        emit ForageFinished(
            _tokenId,
            nectarGathered,
            pollenGathered,
            sapGathered,
            productivityEarned,
            gameConfig.experienceEarnedAfterForage()
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

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        if (beeTraits.sap < gameConfig.raidSapFee()) {
            revert InsufficientSap();
        }

        beeTraits.sap -= gameConfig.raidSapFee();

        IHoney honey = IHoney(buzzkillAddressProvider.honeyAddress());

        if (beeTraits.health == 0) {
            revert InsufficientHealth();
        }
        uint256 honeyFee = gameConfig.raidHoneyFee();
        if (honey.balanceOf(msg.sender) < honeyFee) {
            revert InsufficientHoney();
        }

        IHoneyDistribution honeyDistribution = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        );

        honeyDistribution.burnHoney(msg.sender, honeyFee);

        IHive raidedHive = IHive(_raidedHive);

        uint256 amountHoneyRaided = raidedHive.endureRaid(_tokenId);
        uint256 baseHealthDeductionAfterRaid = gameConfig
            .baseHealthDeductionAfterRaid();

        if (amountHoneyRaided > 0) {
            if (beeTraits.health < baseHealthDeductionAfterRaid) {
                beeTraits.health = 0;
            } else {
                beeTraits.health -= baseHealthDeductionAfterRaid;
            }

            uint256 amountHoneyShared = (amountHoneyRaided * 500) /
                BASE_DENOMINATOR; // Hive take 5% of the raided honey
            availableHoneyInHive += amountHoneyShared;
            beeTraits.experience += gameConfig
                .experienceEarnedAfterRaidSuccess();

            honeyDistribution.distributeHoney(
                msg.sender,
                amountHoneyRaided - amountHoneyShared
            );
        } else {
            if (beeTraits.health < baseHealthDeductionAfterRaid * 2) {
                beeTraits.health = 0;
            } else {
                beeTraits.health -= baseHealthDeductionAfterRaid * 2;
            }
            beeTraits.experience += gameConfig
                .experienceEarnedAfterRaidFailed();
        }

        beeStatus[_tokenId].beeProductivity += gameConfig
            .productivityEarnAfterRaid();
        hiveProductivity += gameConfig.productivityEarnAfterRaid();

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        emit RaidFinished(
            _tokenId,
            amountHoneyRaided,
            gameConfig.productivityEarnAfterRaid(),
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
            IGameConfig gameConfig = IGameConfig(
                buzzkillAddressProvider.gameConfigAddress()
            );
            amountHoneyRaided =
                (gameConfig.baseHoneyRaidReward() * hiveCapacity * 10_000) /
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
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        if (beeNectar < gameConfig.nectarRequiredToClaim()) {
            revert NotEnoughNectarToCollect();
        }

        uint256 currentBeeProductivity = beeStatus[_tokenId].beeProductivity;

        beeStatus[_tokenId].lastClaimedBlock = block.number;
        beeStatus[_tokenId].beeProductivity = 0;
        hiveProductivity -= currentBeeProductivity;

        availableHoneyInHive -= claimableHoney;

        beeTraits.nectar -= gameConfig.nectarRequiredToClaim();

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
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        if (
            numQueens + numWorkers ==
            gameConfig.maxQueen() + gameConfig.maxWorker()
        ) return 2;
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

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 hiveMultiplier = getHivePoolMultiplier();
        uint256 baseHoneyYield = gameConfig.baseHoneyYield();
        uint256 epochPassed = (block.number - lastAvailableHoneyUpdateBlock) /
            ONE_EPOCH;
        if (epochPassed == 0) {
            return;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            gameConfig.honeyYieldConstant()) / BASE_DENOMINATOR;

        availableHoneyInHive += honeyProduced * epochPassed;

        lastAvailableHoneyUpdateBlock = block.number;
    }

    /* -------------------------------------------------------------------------- */
    /*  Implement ERC721Receiver function                                         */
    /* -------------------------------------------------------------------------- */
    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
