// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VRC725} from "@vrc725/contracts/VRC725.sol";
import {VRC725Enumerable} from "@vrc725/contracts/extensions/VRC725Enumerable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings as StringsLib} from "@openzeppelin/contracts/utils/Strings.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

import "../interfaces/IHive.sol";
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
        uint256 experience;
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
    address public hiveFactory;
    IBuzzkillAddressProvider public buzzkillAddressProvider;
    mapping(uint256 => string) public tokenURIs;
    mapping(uint256 => BeeCharacteristics) public tokenIdToCharacteristics;
    mapping(uint256 => BeeTraits) public tokenIdToTraits;
    mapping(uint256 => BeeStatus) public tokenIdToStatus;

    string public constant workerBeeImage =
        "https://photos.app.goo.gl/6QWvzWw5L3DnijFs6";
    string public constant queenBeeImage =
        "https://photos.app.goo.gl/ddqkjKf6RekQSaYE6";

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */

    constructor(
        uint256 _mintFee,
        address _hiveFactory,
        address _buzzkillAddressProvider
    ) {
        if (_mintFee < MIN_FEE) revert MintFeeTooLow();
        if (_mintFee > MAX_FEE) revert MintFeeTooHigh();
        __VRC725_init("Buzzkill", "BZK", msg.sender);
        mintFee = _mintFee;
        hiveFactory = _hiveFactory;
        buzzkillAddressProvider = IBuzzkillAddressProvider(
            _buzzkillAddressProvider
        );
    }

    /* -------------------------------------------------------------------------- */
    /*  Modifier                                                                  */
    /* -------------------------------------------------------------------------- */
    modifier onlyHive() {
        IHive hive = IHive(msg.sender);
        if (hive.creator() != hiveFactory) {
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
                '"energy": "'
            ),
            abi.encodePacked(
                beeTraits.energy.toString(),
                '"',
                '"health": "',
                beeTraits.health.toString(),
                '"',
                '"attack": "',
                beeTraits.attack.toString(),
                '"',
                '"defense": "',
                beeTraits.defense.toString(),
                '"',
                '"forage": "',
                beeTraits.forage.toString(),
                '"',
                '"experience": "',
                beeTraits.experience.toString(),
                '"',
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
     * @param tokenId The ID of the token.
     * @return The bee characteristics.
     */
    function getBeeLevel(uint256 tokenId) public view returns (uint256) {
        IGameConfig gameConfig = IGameConfig(
            buzzkillAddressProvider.gameConfigAddress()
        );
        uint256 beeExperience = tokenIdToTraits[tokenId].experience;

        return beeExperience / gameConfig.amountToLevelUp();
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
                10,
                10,
                1,
                1,
                1,
                0,
                0,
                0,
                0
            );
        } else if (_beeType == 1) {
            tokenIdToCharacteristics[newTokenId] = BeeCharacteristics(
                queenBeeImage,
                "Queen"
            );
            tokenIdToTraits[newTokenId] = BeeTraits(
                20,
                20,
                2,
                2,
                2,
                0,
                0,
                0,
                0
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
     * @param _beeTraits The new traits to set.
     */
    function modifyBeeTraits(
        uint256 tokenId,
        BeeTraits memory _beeTraits
    ) public onlyHive {
        require(_exists(tokenId), "Token does not exist");
        // Hive is holding the NFT
        require(ownerOf(tokenId) == msg.sender, "Not owner");
        // Check if bee can level up
        if (_beeTraits.experience > tokenIdToTraits[tokenId].experience) {
            IGameConfig gameConfig = IGameConfig(
                buzzkillAddressProvider.gameConfigAddress()
            );
            uint256 level = getBeeLevel(tokenId);
            uint256 newLevel = _beeTraits.experience /
                gameConfig.amountToLevelUp();
            if (newLevel > level) {
                // Level up
                _beeTraits.energy += 5;
                _beeTraits.health += 5;
                _beeTraits.attack += 1;
                _beeTraits.defense += 1;
                _beeTraits.forage += 1;
                IHive hive = IHive(msg.sender);
                hive.updateHiveDefense(tokenId);
            }
        }
        tokenIdToTraits[tokenId] = _beeTraits;
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
     * @dev Sets the Hive Factory address for the contract.
     * Only the contract owner can call this function.
     * @param _hiveFactory The new Hive Factory address to set.
     */
    function setHiveFactoryAddress(address _hiveFactory) external onlyOwner {
        hiveFactory = _hiveFactory;
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
