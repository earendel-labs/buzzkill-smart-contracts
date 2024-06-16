// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "../interfaces/IHoneyDistribution.sol";
import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IHiveManager.sol";
import "../interfaces/IHoney.sol";
import "../interfaces/IGameConfig.sol";

contract HiveManager is Initializable {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error HabitatNotExists();
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
    error HiveNotExists();

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event HiveCreated(uint256 hiveId, uint256 habitatId);
    event NFTStaked(uint256 tokenId);
    event NFTUnstaked(uint256 tokenId);
    event ResourcesCollected(
        uint256 tokenId,
        uint256 hiveId,
        uint256 nectarGathered,
        uint256 pollenGathered,
        uint256 sapGathered,
        uint256 sharedNectar,
        uint256 sharedPollen,
        uint256 sharedSap
    );
    event ForageFinished(
        uint256 tokenId,
        uint256 hiveId,
        uint256 productivityEarned,
        uint256 experienceEarned
    );
    event RaidFinished(
        uint256 tokenId,
        uint256 hiveId,
        uint256 honey,
        uint256 productivityEarned,
        uint256 experienceEarned
    );
    event CollectHoney(uint256 tokenId, uint256 hiveId, uint256 honey);

    /* -------------------------------------------------------------------------- */
    /*  Structs                                                                   */
    /* -------------------------------------------------------------------------- */
    struct BeeStatus {
        address owner;
        uint256 beeId;
        uint256 beeProductivity;
        uint256 beeWorkIncentive;
        uint256 beeDefense;
        uint256 lastClaimedBlock;
    }

    struct Hive {
        uint256 habitatId;
        uint256 numQueens;
        uint256 numWorkers;
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
        uint256 hiveProductivity;
        uint256 hiveDefense;
        uint256 availableHoneyInHive;
        uint256 lastAvailableHoneyUpdateBlock;
        uint256 hiveTotalIncentive;
        uint256 lastBaseIncentiveUpdateBlock;
    }

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_000;
    uint256 public constant ONE_EPOCH = 900; // 1 epoch = 900 blocks

    /* -------------------------------------------------------------------------- */
    /*  State Variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public totalHives;
    mapping(uint256 => Hive) public hives;
    mapping(uint256 => mapping(uint256 => bool)) public isBeeInAction;
    mapping(uint256 => mapping(uint256 => BeeStatus)) public beeStatus;

    IBuzzkillAddressProvider public buzzkillAddressProvider;

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */
    function initialize(address _buzzkillAddressProvider) public initializer {
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifiers                                                                 */
    /* -------------------------------------------------------------------------- */
    modifier onlyOneAction(uint256 hiveId, uint256 tokenId) {
        if (isBeeInAction[hiveId][tokenId]) revert BeeAlreadyInAction();
        isBeeInAction[hiveId][tokenId] = true;
        _;
        isBeeInAction[hiveId][tokenId] = false;
    }

    modifier onlyHive() {
        if (msg.sender != address(this)) {
            revert HiveOnly();
        }
        _;
    }

    /* -------------------------------------------------------------------------- */
    /*  View Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Get the hive resources.
     * @param _hiveId The hive ID.
     * @return The nectar, pollen, and sap resources in the hive.
     */
    function getHiveResources(
        uint256 _hiveId
    ) public view returns (uint256, uint256, uint256) {
        Hive memory hive = hives[_hiveId];
        return (hive.nectar, hive.pollen, hive.sap);
    }

    /**
     * @dev Get the hive pool multiplier. The hive pool multiplier is calculated based on the hive abundance and productivity.
     * @param _hiveId The hive ID.
     * @return The hive pool multiplier.
     */
    function getHivePoolMultiplier(
        uint256 _hiveId
    ) public view returns (uint256) {
        uint256 hiveAbdunace = getHiveAbundance(_hiveId);
        return
            hives[_hiveId].hiveProductivity +
            (hiveAbdunace * 10_000) /
            BASE_DENOMINATOR; // Currently fix constant at 1
    }

    /**
     * @dev Get the hive abundance. The hive abundance is calculated based on the resources in the hive.
     Necatar contributes 20%, pollen contributes 30%, and sap contributes 50%.
     * @param _hiveId The hive ID.
     * @return The hive abundance.
     */
    function getHiveAbundance(uint256 _hiveId) internal view returns (uint256) {
        Hive memory hive = hives[_hiveId];
        return
            ((hive.nectar * 2000) / BASE_DENOMINATOR) +
            ((hive.pollen * 3000) / BASE_DENOMINATOR) +
            ((hive.sap * 5000) / BASE_DENOMINATOR);
    }

    /**
     * @dev Get the available honey in the hive.
     The available honey is calculated based on the hive productivity and the base honey yield. The available honey is updated every epoch.
     * @param _hiveId The hive ID.
     * @return The available honey in the hive.
     */
    function getAvailableHoneyInHive(
        uint256 _hiveId
    ) public view returns (uint256) {
        Hive memory hive = hives[_hiveId];
        if (block.number <= hive.lastAvailableHoneyUpdateBlock) {
            return hive.availableHoneyInHive;
        }
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 hiveMultiplier = getHivePoolMultiplier(_hiveId);
        uint256 baseHoneyYield = gameConfig.baseHoneyYield();
        uint256 epochPassed = (block.number -
            hive.lastAvailableHoneyUpdateBlock) / ONE_EPOCH;
        if (epochPassed == 0) {
            return hive.availableHoneyInHive;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            gameConfig.honeyYieldConstant()) / BASE_DENOMINATOR;

        uint256 currentAvailableHoney = hive.availableHoneyInHive +
            honeyProduced *
            epochPassed;

        return currentAvailableHoney;
    }

    /**
     * @dev Get the user's claimable honey. The claimable honey is calculated based on the user's bee productivity and the hive productivity.
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     * @return The user's claimable honey.
     */
    function getUserClaimableHoney(
        uint256 _hiveId,
        uint256 _tokenId
    ) public view returns (uint256) {
        Hive memory hive = hives[_hiveId];
        uint256 currentAvailableHoney = getAvailableHoneyInHive(_hiveId);
        uint256 lastClaimedBlock = beeStatus[_hiveId][_tokenId]
            .lastClaimedBlock;

        if (lastClaimedBlock == 0 || hive.hiveProductivity == 0) {
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

        uint256 hiveEpochPassed = (block.number -
            hive.lastBaseIncentiveUpdateBlock) / ONE_EPOCH;
        uint256 hiveBaseIncentive = (gameConfig.baseIncentivePerEpoch() *
            hiveEpochPassed *
            (hive.numWorkers + hive.numQueens * 2));
        uint256 _hiveTotalIncentive = hiveBaseIncentive +
            hive.hiveTotalIncentive;

        uint256 claimableHoney = (currentAvailableHoney *
            (getBeeBaseIncentive(_tokenId, lastClaimedBlock) +
                beeStatus[_hiveId][_tokenId].beeWorkIncentive)) /
            _hiveTotalIncentive;

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
     * @param _hiveId The hive ID.
     * @return A pseudo-random number between 10_000 to 12_500 if hive is half-full or lower
        A pseudo-random number between 10_000 to 15_000 if hive is more than half-full
     */
    function randomHiveDefenseBoost(
        uint256 _hiveId
    ) internal view returns (uint256) {
        uint256 totalBees = hives[_hiveId].numQueens +
            hives[_hiveId].numWorkers;

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

    /**
     * @dev Create a new hive.
     * @param habitatId The habitat ID.
     */
    function createHive(uint256 habitatId) external {
        address worldMap = buzzkillAddressProvider.worldMapAddress();
        uint256 maxHabitatId = IWorldMap(worldMap).currentHabitatId();
        if (habitatId >= maxHabitatId) {
            revert HabitatNotExists();
        }
        Hive memory newHive = Hive({
            habitatId: habitatId,
            numQueens: 0,
            numWorkers: 0,
            nectar: 0,
            pollen: 0,
            sap: 0,
            hiveProductivity: 0,
            hiveDefense: 0,
            availableHoneyInHive: 0,
            lastAvailableHoneyUpdateBlock: block.number,
            hiveTotalIncentive: 0,
            lastBaseIncentiveUpdateBlock: block.number
        });
        uint256 newHiveId = totalHives;
        hives[newHiveId] = newHive;
        totalHives++;
        emit HiveCreated(newHiveId, habitatId);
    }

    /**
     * @dev Update the hive defense.
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     */
    function updateHiveDefense(uint256 _hiveId, uint256 _tokenId) external {
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        if (_hiveId >= totalHives) {
            revert HiveNotExists();
        }
        if (
            buzzkillNFT.ownerOf(_tokenId) != address(this) &&
            beeStatus[_hiveId][_tokenId].owner == address(0)
        ) {
            revert BeeNotInHive();
        }

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        hives[_hiveId].hiveDefense -= beeStatus[_hiveId][_tokenId].beeDefense;
        beeStatus[_hiveId][_tokenId].beeDefense = beeTraits.defense;
        hives[_hiveId].hiveDefense += beeTraits.defense;
    }

    function updateHiveProductivity(
        uint256 _hiveId,
        uint256 _tokenId
    ) external {
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        if (_hiveId >= totalHives) {
            revert HiveNotExists();
        }
        if (
            buzzkillNFT.ownerOf(_tokenId) != address(this) &&
            beeStatus[_hiveId][_tokenId].owner == address(0)
        ) {
            revert BeeNotInHive();
        }

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        hives[_hiveId].hiveProductivity -= beeStatus[_hiveId][_tokenId]
            .beeProductivity;
        beeStatus[_hiveId][_tokenId].beeProductivity = beeTraits
            .baseProductivity;
        hives[_hiveId].hiveDefense += beeTraits.defense;
    }

    /**
     * @dev Stake a Bee NFT to the hive. The hive can only have a maximum of 3 queens and 55 workers.
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     */
    function stakeBee(uint256 _hiveId, uint256 _tokenId) external {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        Hive storage hive = hives[_hiveId];
        if (hive.numQueens >= gameConfig.maxQueen()) {
            revert MaxQueenReached();
        }

        if (hive.numWorkers >= gameConfig.maxWorker()) {
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

        _updateHive(_hiveId);

        if (_isQueen(beeType)) {
            hive.numQueens++;
        } else if (_isWorker(beeType)) {
            hive.numWorkers++;
        } else {
            revert InvalidNFTType();
        }

        if (beeStatus[_hiveId][_tokenId].owner != address(0)) {
            revert BeeAlreadyStaked();
        }

        beeStatus[_hiveId][_tokenId] = BeeStatus({
            owner: msg.sender,
            beeId: _tokenId,
            beeProductivity: 0,
            beeWorkIncentive: 0,
            beeDefense: beeTraits.defense,
            lastClaimedBlock: block.number
        });

        hive.hiveDefense += beeTraits.defense;

        buzzkillNFT.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit NFTStaked(_tokenId);
    }

    /**
     * @dev Unstake a Bee NFT from the hive.
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     */
    function unstakeBee(uint256 _hiveId, uint256 _tokenId) external {
        if (msg.sender != beeStatus[_hiveId][_tokenId].owner) {
            revert NotBeeOwner();
        }
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        (, string memory beeType) = buzzkillNFT.tokenIdToCharacteristics(
            _tokenId
        );

        _updateHive(_hiveId);

        Hive storage hive = hives[_hiveId];

        // Check if the bee has claimable honey
        uint256 claimableHoney = getUserClaimableHoney(_hiveId, _tokenId);
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

                hive.availableHoneyInHive -= claimableHoney;

                beeTraits.nectar -= gameConfig.nectarRequiredToClaim();

                buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

                honeyDistribution.distributeHoney(msg.sender, claimableHoney);
            }
        }

        if (_isQueen(beeType)) {
            hive.numQueens--;
        } else if (_isWorker(beeType)) {
            hive.numWorkers--;
        }

        hive.hiveProductivity -= beeStatus[_hiveId][_tokenId].beeProductivity;
        hive.hiveTotalIncentive =
            hive.hiveTotalIncentive -
            getBeeBaseIncentive(
                _tokenId,
                beeStatus[_hiveId][_tokenId].lastClaimedBlock
            ) -
            beeStatus[_hiveId][_tokenId].beeWorkIncentive;
        hive.hiveDefense -= beeStatus[_hiveId][_tokenId].beeDefense;

        if (hive.hiveProductivity == 0 && hive.availableHoneyInHive > 0) {
            hive.lastAvailableHoneyUpdateBlock = block.number;
            hive.availableHoneyInHive = 0;
        }

        beeStatus[_hiveId][_tokenId] = BeeStatus({
            owner: address(0),
            beeId: 0,
            beeProductivity: 0,
            beeWorkIncentive: 0,
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
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     * @param _habitatId The habitat ID from which resources are foraged.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if the bee does not have sufficient energy, or if the bee has already performed an action.
     * Since 5% of the gathered resources are added to the hive, forage function will guarantee return the least amount of 20 each item.
     * E.g: Forage 20 nectar, hive will get 1 nectar and bee will get 19 nectar.
     */
    function forage(
        uint256 _hiveId,
        uint256 _tokenId,
        uint256 _habitatId
    ) external onlyOneAction(_hiveId, _tokenId) {
        BeeStatus storage bee = beeStatus[_hiveId][_tokenId];
        if (msg.sender != bee.owner) {
            revert NotBeeOwner();
        }

        _updateHive(_hiveId);
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 energyDeduction = IWorldMap(
            buzzkillAddressProvider.worldMapAddress()
        ).getAmountEnergyDeductionAfterForage(_habitatId);

        // Call to refresh before forage
        buzzkillNFT.refreshBeeEnergy(_tokenId);

        if (buzzkillNFT.tokenIdToTraits(_tokenId).energy < energyDeduction) {
            revert InsufficientEnergy();
        }

        buzzkillNFT.updateForagingQuestCount(_hiveId, _tokenId);

        // 5% of the gathered resources are added to the hive
        startForageAndCaculateResources(_hiveId, _tokenId, _habitatId);

        IBuzzkillNFT.BeeTraits memory _beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );
        _beeTraits.energy -= energyDeduction;
        _beeTraits.experience += gameConfig.experienceEarnedAfterForage();

        buzzkillNFT.modifyBeeTraits(_tokenId, _beeTraits);

        uint256 incentiveGathered = IWorldMap(
            buzzkillAddressProvider.worldMapAddress()
        ).getAmountIncentiveEarnAfterForage(_habitatId);

        uint256 workIncentiveEarned = (incentiveGathered *
            bee.beeProductivity) / hives[_hiveId].hiveProductivity;

        bee.beeWorkIncentive += workIncentiveEarned;
        hives[_hiveId].hiveTotalIncentive += workIncentiveEarned;

        emit ForageFinished(
            _tokenId,
            _hiveId,
            workIncentiveEarned,
            gameConfig.experienceEarnedAfterForage()
        );
    }

    /**
     * @dev Initiate a raid on another hive using a Bee NFT.
     * This function allows the owner of a Bee NFT to raid another hive, consuming sap, honey, and health while gaining experience.
     * Can only be called once per action per token.
     * @param _hiveId The hive ID.
     * @param _tokenId The Bee NFT token ID.
     * @param _raidedHiveId The id of the hive being raided.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if the bee does not have sufficient sap, honey, or health, or if the bee has already performed an action.
     */
    function startRaid(
        uint256 _hiveId,
        uint256 _tokenId,
        uint256 _raidedHiveId
    ) external onlyOneAction(_hiveId, _tokenId) {
        BeeStatus storage bee = beeStatus[_hiveId][_tokenId];
        if (msg.sender != bee.owner) {
            revert NotBeeOwner();
        }

        _updateHive(_hiveId);

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        checkBeeStatusBeforeRaid(_tokenId);

        uint256 honeyFee = gameConfig.raidHoneyFee();
        if (
            IHoney(buzzkillAddressProvider.honeyAddress()).balanceOf(
                msg.sender
            ) < honeyFee
        ) {
            revert InsufficientHoney();
        }

        IHoneyDistribution honeyDistribution = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        );

        honeyDistribution.burnHoney(msg.sender, honeyFee);

        uint256 amountHoneyRaided = endureRaid(_raidedHiveId, _tokenId);

        IBuzzkillNFT.BeeTraits
            memory beeTraits = caculateBeeStatsAndUpdateQuestAfterRaid(
                _hiveId,
                _tokenId,
                amountHoneyRaided
            );

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        uint256 workIncentiveEarned = (gameConfig.incentiveEarnAfterRaid() *
            bee.beeProductivity) / hives[_hiveId].hiveProductivity;

        bee.beeWorkIncentive += workIncentiveEarned;
        hives[_hiveId].hiveTotalIncentive += workIncentiveEarned;

        emit RaidFinished(
            _tokenId,
            _hiveId,
            amountHoneyRaided,
            workIncentiveEarned,
            beeTraits.experience
        );
    }

    /**
     * @dev Endure a raid initiated by another hive.
     * This function handles the raid mechanics, comparing raid power and hive defense, and deducts honey if the raid is successful.
     * Can only be called by the hive contract.
     * @param _hiveId The hive ID being raided.
     * @param _tokenId The Bee NFT token ID initiating the raid.
     * @return The amount of honey raided.
     * @notice Reverts if the bee is not outside the hive.
     */
    function endureRaid(
        uint256 _hiveId,
        uint256 _tokenId
    ) public onlyHive returns (uint256) {
        if (beeStatus[_hiveId][_tokenId].owner != address(0)) {
            revert BeeMustBeOutsideHive();
        }

        _updateHive(_hiveId);

        Hive storage hive = hives[_hiveId];

        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );

        uint256 raidBoost = randomBeeRaidBoost();
        uint256 hiveDefenseBoost = randomHiveDefenseBoost(_hiveId);

        uint256 caculatedRaidPower = beeTraits.attack * raidBoost;
        uint256 caculatedHiveDefense = hive.hiveDefense * hiveDefenseBoost;

        uint256 amountHoneyRaided;

        if (caculatedRaidPower > caculatedHiveDefense) {
            uint256 _honeyPot = getAvailableHoneyInHive(_hiveId);
            uint256 hiveCapacity = _hiveCapacity(_hiveId);
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
            hive.availableHoneyInHive -= amountHoneyRaided;
        }

        return amountHoneyRaided;
    }

    /**
     */
    function updradeBeeSkills(
        uint256 _hiveId,
        uint256 _tokenId
    ) external onlyOneAction(_hiveId, _tokenId) {
        BeeStatus storage bee = beeStatus[_hiveId][_tokenId];
        if (msg.sender != bee.owner) {
            revert NotBeeOwner();
        }
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        buzzkillNFT.updateUpgradeQuestCount(_hiveId, _tokenId);
    }

    /**
     * @dev Collect the claimable honey for a specific Bee NFT token.
     * This function allows the owner of a Bee NFT to collect the honey it has accumulated.
     * The function checks ownership, ensures there are queen bees, and validates nectar requirements.
     * Can only be called once per action per token.
     * @param _tokenId The Bee NFT token ID.
     * @notice Reverts if the caller is not the owner of the Bee NFT, if there are no queen bees, if there is no honey to collect, or if the bee does not have enough nectar to claim.
     */
    function collectHoney(
        uint256 _hiveId,
        uint256 _tokenId
    ) external onlyOneAction(_hiveId, _tokenId) {
        BeeStatus storage bee = beeStatus[_hiveId][_tokenId];
        if (msg.sender != bee.owner) {
            revert NotBeeOwner();
        }
        Hive storage hive = hives[_hiveId];
        if (hive.numQueens == 0) {
            revert NoQueenBee();
        }

        IHoneyDistribution honeyDistribution = IHoneyDistribution(
            buzzkillAddressProvider.honeyDistributionAddress()
        );
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );

        _updateHive(_hiveId);

        uint256 claimableHoney = getUserClaimableHoney(_hiveId, _tokenId);

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

        uint256 currentBeeBaseIncentive = getBeeBaseIncentive(
            _tokenId,
            bee.lastClaimedBlock
        );
        uint256 beeTotalIncentive = currentBeeBaseIncentive +
            bee.beeWorkIncentive;

        bee.lastClaimedBlock = block.number;
        bee.beeWorkIncentive = 0;
        hive.hiveTotalIncentive -= beeTotalIncentive;

        hive.availableHoneyInHive -= claimableHoney;

        beeTraits.nectar -= gameConfig.nectarRequiredToClaim();

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        honeyDistribution.distributeHoney(msg.sender, claimableHoney);

        emit CollectHoney(_tokenId, _hiveId, claimableHoney);
    }

    /* -------------------------------------------------------------------------- */
    /*  Internal Functions                                                        */
    /* -------------------------------------------------------------------------- */
    function getBeeBaseIncentive(
        uint256 _tokenId,
        uint256 _lastUpdateTimestamp
    ) internal view returns (uint256) {
        uint256 epochPassed = (block.number - _lastUpdateTimestamp) / ONE_EPOCH;
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        (, string memory beeType) = buzzkillNFT.tokenIdToCharacteristics(
            _tokenId
        );
        uint256 currentBeeBaseIncentive;
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        if (_isQueen(beeType)) {
            currentBeeBaseIncentive =
                gameConfig.baseIncentivePerEpoch() *
                epochPassed *
                2;
        } else {
            currentBeeBaseIncentive =
                gameConfig.baseIncentivePerEpoch() *
                epochPassed;
        }
        return currentBeeBaseIncentive;
    }

    function startForageAndCaculateResources(
        uint256 _hiveId,
        uint256 _tokenId,
        uint256 _habitatId
    ) internal {
        Hive storage hive = hives[_hiveId];
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        IBuzzkillNFT.BeeTraits memory beeTraits = buzzkillNFT.tokenIdToTraits(
            _tokenId
        );
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        // Minimum amount for each resource is 20
        (
            uint256 nectarGathered,
            uint256 pollenGathered,
            uint256 sapGathered
        ) = IWorldMap(buzzkillAddressProvider.worldMapAddress()).forage(
                _tokenId,
                _habitatId
            );

        uint256 foragePercentage = gameConfig.foragePercentage();
        uint256 sharedNectar = ((nectarGathered * foragePercentage) /
            BASE_DENOMINATOR) < 1
            ? 1
            : (nectarGathered * foragePercentage) / BASE_DENOMINATOR;
        uint256 sharedPollen = ((pollenGathered * foragePercentage) /
            BASE_DENOMINATOR) < 1
            ? 1
            : (pollenGathered * foragePercentage) / BASE_DENOMINATOR;
        uint256 sharedSap = ((sapGathered * foragePercentage) /
            BASE_DENOMINATOR) < 1
            ? 1
            : (sapGathered * foragePercentage) / BASE_DENOMINATOR;

        hive.nectar += sharedNectar;
        hive.pollen += sharedPollen;
        hive.sap += sharedSap;

        beeTraits.nectar += nectarGathered - sharedNectar;
        beeTraits.pollen += pollenGathered - sharedPollen;
        beeTraits.sap += sapGathered - sharedSap;

        beeTraits.nectar +=
            nectarGathered -
            (nectarGathered * foragePercentage) /
            BASE_DENOMINATOR;

        emit ResourcesCollected(
            _tokenId,
            _hiveId,
            nectarGathered,
            pollenGathered,
            sapGathered,
            sharedNectar,
            sharedPollen,
            sharedSap
        );
    }

    function checkBeeStatusBeforeRaid(uint256 _tokenId) internal view {
        IBuzzkillNFT.BeeTraits memory _beeStatsBeforeRaid = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        ).tokenIdToTraits(_tokenId);

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        if (_beeStatsBeforeRaid.sap < gameConfig.raidSapFee()) {
            revert InsufficientSap();
        }

        if (_beeStatsBeforeRaid.health == 0) {
            revert InsufficientHealth();
        }

        if (
            _beeStatsBeforeRaid.energy <
            gameConfig.baseEnergyDeductionAfterRaid()
        ) {
            revert InsufficientEnergy();
        }
    }

    function caculateBeeStatsAndUpdateQuestAfterRaid(
        uint256 _hiveId,
        uint256 _tokenId,
        uint256 _amountHoneyRaided
    ) internal returns (IBuzzkillNFT.BeeTraits memory _beeTraits) {
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 baseHealthDeductionAfterRaid = gameConfig
            .baseHealthDeductionAfterRaid();

        buzzkillNFT.updateRaidQuestCount(_hiveId, _tokenId);

        if (_amountHoneyRaided > 0) {
            buzzkillNFT.updateRaidSuccessQuestCount(_hiveId, _tokenId);

            _beeTraits = buzzkillNFT.tokenIdToTraits(_tokenId);

            if (_beeTraits.health < baseHealthDeductionAfterRaid) {
                _beeTraits.health = 0;
            } else {
                _beeTraits.health -= baseHealthDeductionAfterRaid;
            }

            uint256 amountHoneyShared = (_amountHoneyRaided * 500) /
                BASE_DENOMINATOR; // Hive take 5% of the raided honey
            hives[_hiveId].availableHoneyInHive += amountHoneyShared;
            _beeTraits.experience += gameConfig
                .experienceEarnedAfterRaidSuccess();

            IHoneyDistribution(
                buzzkillAddressProvider.honeyDistributionAddress()
            ).distributeHoney(
                    msg.sender,
                    _amountHoneyRaided - amountHoneyShared
                );
        } else {
            _beeTraits = buzzkillNFT.tokenIdToTraits(_tokenId);
            if (_beeTraits.health < baseHealthDeductionAfterRaid * 2) {
                _beeTraits.health = 0;
            } else {
                _beeTraits.health -= baseHealthDeductionAfterRaid * 2;
            }
            _beeTraits.energy -= gameConfig.baseEnergyDeductionAfterRaid();
            _beeTraits.experience += gameConfig
                .experienceEarnedAfterRaidFailed();
        }
        _beeTraits.sap -= gameConfig.raidSapFee();
    }

    /* -------------------------------------------------------------------------- */
    /*  Private Functions                                                         */
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
    function _hiveCapacity(uint256 _hiveId) private view returns (uint256) {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        Hive memory hive = hives[_hiveId];
        if (
            hive.numQueens + hive.numWorkers ==
            gameConfig.maxQueen() + gameConfig.maxWorker()
        ) return 2;
        return 1;
    }

    /**
     * @dev Update the hive collective pool of honey and hive stats. The hive collective pool of honey is updated every epoch.
     @param _hiveId The hive ID.
     */
    function _updateHive(uint256 _hiveId) private {
        Hive storage hive = hives[_hiveId];
        if (block.number <= hive.lastAvailableHoneyUpdateBlock) {
            return;
        }

        if (hive.hiveProductivity == 0) {
            hive.lastAvailableHoneyUpdateBlock = block.number;
            return;
        }

        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );

        uint256 hiveMultiplier = getHivePoolMultiplier(_hiveId);
        uint256 baseHoneyYield = gameConfig.baseHoneyYield();
        uint256 epochPassedSinceLastUpdateHoney = (block.number -
            hive.lastAvailableHoneyUpdateBlock) / ONE_EPOCH;

        uint256 epochPassedSinceLastUpdateBaseIncentive = (block.number -
            hive.lastBaseIncentiveUpdateBlock) / ONE_EPOCH;

        if (
            epochPassedSinceLastUpdateHoney == 0 &&
            epochPassedSinceLastUpdateBaseIncentive == 0
        ) {
            return;
        }

        uint256 honeyProduced = (baseHoneyYield *
            hiveMultiplier *
            gameConfig.honeyYieldConstant()) / BASE_DENOMINATOR;

        hive.availableHoneyInHive +=
            honeyProduced *
            epochPassedSinceLastUpdateHoney;

        uint256 baseIncentiveDistribute = gameConfig.baseIncentivePerEpoch() *
            epochPassedSinceLastUpdateBaseIncentive *
            (hive.numWorkers + hive.numQueens * 2);

        hive.hiveTotalIncentive += baseIncentiveDistribute;

        hive.lastAvailableHoneyUpdateBlock = block.number;
        hive.lastBaseIncentiveUpdateBlock = block.number;
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
