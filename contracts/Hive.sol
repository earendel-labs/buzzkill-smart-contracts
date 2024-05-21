// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../interfaces/IBuzzkillNFT.sol";
import "../interfaces/IWorldMap.sol";
import "../interfaces/IBuzzkillAddressProvider.sol";

contract Hive {
    /* -------------------------------------------------------------------------- */
    /*  Errors                                                                    */
    /* -------------------------------------------------------------------------- */
    error InvalidNFTType();
    error MaxQueenReached();
    error MaxWorkerReached();
    error NotBeeOwner();
    error BeeInAction();
    error InsufficientEnergy();

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event NFTStaked(uint256 tokenId);
    event NFTUnstaked(uint256 tokenId);
    event ForageFinished(
        uint256 tokenId,
        uint256 nectar,
        uint256 pollen,
        uint256 sap
    );

    /* -------------------------------------------------------------------------- */
    /*  Constants                                                                 */
    /* -------------------------------------------------------------------------- */
    uint256 public constant BASE_DENOMINATOR = 10_0000;
    uint256 public constant MAX_QUEEN = 3;
    uint256 public constant MAX_WORKER = 55;
    uint256 public constant FORAGE_PERCENTAGE = 500; // 5% of the gathered resources are added to the hive

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
    mapping(uint256 => bool) public isBeeInAction;
    mapping(uint256 => address) public BeeStakers;
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
        if (isBeeInAction[tokenId]) revert BeeInAction();
        isBeeInAction[tokenId] = true;
        _;
        isBeeInAction[tokenId] = false;
    }

    function stakeNFT(uint256 tokenId) external {
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
            tokenId
        );

        if (_isQueen(beeType)) {
            numQueens++;
        } else if (_isWorker(beeType)) {
            numWorkers++;
        } else {
            revert InvalidNFTType();
        }

        BeeStakers[tokenId] = msg.sender;
        buzzkillNFT.safeTransferFrom(msg.sender, address(this), tokenId);

        emit NFTStaked(tokenId);
    }

    function unstake(uint256 tokenId) external {
        if (msg.sender != BeeStakers[tokenId]) {
            revert NotBeeOwner();
        }
        IBuzzkillNFT buzzkillNFT = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        (, string memory beeType) = buzzkillNFT.tokenIdToCharacteristics(
            tokenId
        );

        if (_isQueen(beeType)) {
            numQueens--;
        } else if (_isWorker(beeType)) {
            numWorkers--;
        }

        BeeStakers[tokenId] = address(0);
        buzzkillNFT.safeTransferFrom(address(this), msg.sender, tokenId);

        emit NFTUnstaked(tokenId);
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
        if (msg.sender != BeeStakers[_tokenId]) {
            revert NotBeeOwner();
        }

        IBuzzkillNFT bee = IBuzzkillNFT(
            buzzkillAddressProvider.buzzkillNFTAddress()
        );
        (
            uint256 _energy,
            uint256 _health,
            uint256 _productivity,
            uint256 _attack,
            uint256 _defense,
            uint256 _forage,
            uint256 _pollen,
            uint256 _sap,
            uint256 _nectar
        ) = bee.tokenIdToTraits(_tokenId);

        IWorldMap worldMap = IWorldMap(
            buzzkillAddressProvider.worldMapAddress()
        );

        uint256 energyDeduction = worldMap.getAmountEnergyDeductionAfterForage(
            _habitatId
        );

        if (_energy < energyDeduction) {
            revert InsufficientEnergy();
        }

        (
            uint256 nectarGathered,
            uint256 pollenGathered,
            uint256 sapGathered
        ) = worldMap.forage(_tokenId, _habitatId);

        // 5% of the gathered resources are added to the hive
        uint256 sharedNectar = (nectarGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;
        uint256 sharedPollen = (pollenGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;
        uint256 sharedSap = (sapGathered * FORAGE_PERCENTAGE) /
            BASE_DENOMINATOR;

        nectar += sharedNectar;
        pollen += sharedPollen;
        sap += sharedSap;

        bee.modifyBeeTraits(
            _tokenId,
            _energy - energyDeduction,
            _health,
            _productivity + 100, // Add productivity after forage
            _attack,
            _defense,
            _forage,
            _pollen + pollenGathered - sharedPollen,
            _sap + sapGathered - sharedSap,
            _nectar + nectarGathered - sharedNectar
        );

        emit ForageFinished(
            _tokenId,
            nectarGathered,
            pollenGathered,
            sapGathered
        );
    }

    function raid() public {}

    function collectHoney() public {}

    function depositHoney(uint256 amount) external {
        honeyPot += amount;
    }

    function withdrawHoney(uint256 amount) external {
        require(amount <= honeyPot, "Insufficient honey balance");
        honeyPot -= amount;
    }

    function _isQueen(string memory beeType) private pure returns (bool) {
        if (keccak256(bytes(beeType)) == keccak256(bytes("Queen"))) {
            return true;
        }
        return false;
    }

    function _isWorker(string memory beeType) private pure returns (bool) {
        if (keccak256(bytes(beeType)) == keccak256(bytes("Worker"))) {
            return true;
        }
        return false;
    }
}
