// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";
import "../interfaces/IHoneyDistribution.sol";

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
        uint256 productivityEarned
    );
    event RaidFinished(
        uint256 nectar,
        uint256 pollen,
        uint256 sap,
        uint256 productivityEarned
    );
    event CollectHoney(uint256 tokenId, uint256 honey);

    /* -------------------------------------------------------------------------- */
    /*  Structs                                                                   */
    /* -------------------------------------------------------------------------- */
    struct BeeOwner {
        address owner;
        uint256 beeId;
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
    uint256 public constant HONEY_YIELD_CONSTANT = 10_0000; // Set at 1
    uint256 public constant ONE_WEEK = 1 weeks;
    uint256 public constant NECTAR_REQUIRED_TO_CLAIM = 1000;

    /* -------------------------------------------------------------------------- */
    /*  State Variables                                                           */
    /* -------------------------------------------------------------------------- */
    address public creator;
    uint256 public honeyPot;
    uint256 public habitatId;
    uint256 public numQueens;
    uint256 public numWorkers;
    uint256 public nectar;
    uint256 public pollen;
    uint256 public sap;
    uint256 public hiveProductivity;
    uint256 public availableHoneyInHive;
    uint256 public lastAvailableHoneyUpdateBlock;
    mapping(uint256 => bool) public isBeeInAction;
    mapping(uint256 => BeeOwner) public beeOwners;
    mapping(uint256 => uint256) public beeProductivity;

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

    /* -------------------------------------------------------------------------- */
    /*  View Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Get the hive information.
     * @return The number of queens, workers, and the honey pot in the hive.
     */
    function getHiveInfo() public view returns (uint256, uint256, uint256) {
        return (numQueens, numWorkers, honeyPot);
    }

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
            HONEY_YIELD_CONSTANT) / (BASE_DENOMINATOR * BASE_DENOMINATOR);

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
        uint256 lastClaimedBlock = beeOwners[_tokenId].lastClaimedBlock;

        if (lastClaimedBlock == 0) {
            return 0;
        }

        if (
            lastClaimedBlock > block.number &&
            block.number - lastClaimedBlock < ONE_WEEK
        ) {
            return 0;
        }
        uint256 currentBeeProductivity = beeProductivity[_tokenId];

        uint256 claimableHoney = (currentAvailableHoney *
            currentBeeProductivity) / hiveProductivity;

        return claimableHoney;
    }

    /* -------------------------------------------------------------------------- */
    /*  Logic Functions                                                           */
    /* -------------------------------------------------------------------------- */

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

        _updateHive();

        if (_isQueen(beeType)) {
            numQueens++;
        } else if (_isWorker(beeType)) {
            numWorkers++;
        } else {
            revert InvalidNFTType();
        }

        if (beeOwners[_tokenId].owner != address(0)) {
            revert BeeAlreadyStaked();
        }

        beeOwners[_tokenId] = BeeOwner({
            owner: msg.sender,
            beeId: _tokenId,
            lastClaimedBlock: block.number
        });

        beeProductivity[_tokenId] = 0;

        buzzkillNFT.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit NFTStaked(_tokenId);
    }

    /**
     * @dev Unstake a Bee NFT from the hive.
     * @param _tokenId The Bee NFT token ID.
     */
    function unstake(uint256 _tokenId) external {
        if (msg.sender != beeOwners[_tokenId].owner) {
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

        hiveProductivity -= beeProductivity[_tokenId];
        beeOwners[_tokenId] = BeeOwner({
            owner: address(0),
            beeId: 0,
            lastClaimedBlock: 0
        });
        beeProductivity[_tokenId] = 0;

        buzzkillNFT.safeTransferFrom(address(this), msg.sender, _tokenId);

        emit NFTUnstaked(_tokenId);
    }

    /**
        * @dev Forage resources from the habitat. The resources are shared with the hive.
        After foraging, the bee's productivity increases by 100.
        * @param _tokenId The Bee NFT token ID.
        * @param _habitatId The habitat ID.
     */
    function forage(
        uint256 _tokenId,
        uint256 _habitatId
    ) external onlyOneAction(_tokenId) {
        if (msg.sender != beeOwners[_tokenId].owner) {
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
        nectar += (nectarGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
        pollen += (pollenGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
        sap += (sapGathered * FORAGE_PERCENTAGE) / BASE_DENOMINATOR;
        hiveProductivity += productivityEarned;

        beeTraits.energy -= energyDeduction;
        beeTraits.pollen +=
            pollenGathered -
            (pollenGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;
        beeTraits.sap +=
            sapGathered -
            (sapGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;
        beeTraits.nectar +=
            nectarGathered -
            (nectarGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;

        beeProductivity[_tokenId] += productivityEarned;

        buzzkillNFT.modifyBeeTraits(_tokenId, beeTraits);

        emit ForageFinished(
            _tokenId,
            nectarGathered,
            pollenGathered,
            sapGathered,
            productivityEarned
        );
    }

    function raid() public {}

    function collectHoney(uint256 _tokenId) external onlyOneAction(_tokenId) {
        if (msg.sender != beeOwners[_tokenId].owner) {
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

        uint256 currentBeeProductivity = beeProductivity[_tokenId];

        beeOwners[_tokenId].lastClaimedBlock = block.number;
        beeProductivity[_tokenId] = 0;
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
            HONEY_YIELD_CONSTANT) / (BASE_DENOMINATOR * BASE_DENOMINATOR);

        availableHoneyInHive += honeyProduced * epochPassed;

        lastAvailableHoneyUpdateBlock = block.number;
    }
}
