// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VRC725} from "@vrc725/contracts/VRC725.sol";
import {VRC725Enumerable} from "@vrc725/contracts/extensions/VRC725Enumerable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings as StringsLib} from "@openzeppelin/contracts/utils/Strings.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

import "../interfaces/IHive.sol";

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
        uint256 productivity;
        uint256 attack;
        uint256 defense;
        uint256 forage;
        uint256 pollen;
        uint256 sap;
        uint256 nectar;
    }

    /* -------------------------------------------------------------------------- */
    /* State Variables                                                            */
    /* -------------------------------------------------------------------------- */
    uint256 public constant MAX_SUPPLY = 10_000;
    uint256 public constant MIN_FEE = 0.00044 ether;
    uint256 public constant MAX_FEE = 5 ether;
    uint256 public currentTokenId;
    uint256 public mintFee;
    address public hiveFactory;
    mapping(uint256 => string) public tokenURIs;
    mapping(uint256 => BeeCharacteristics) public tokenIdToCharacteristics;
    mapping(uint256 => BeeTraits) public tokenIdToTraits;

    string public constant workerBeeImage =
        "https://photos.app.goo.gl/6QWvzWw5L3DnijFs6";
    string public constant queenBeeImage =
        "https://photos.app.goo.gl/ddqkjKf6RekQSaYE6";

    /* -------------------------------------------------------------------------- */
    /*  Constructor                                                               */
    /* -------------------------------------------------------------------------- */

    constructor(uint256 _mintFee, address _hiveFactory) {
        if (_mintFee < MIN_FEE) revert MintFeeTooLow();
        if (_mintFee > MAX_FEE) revert MintFeeTooHigh();
        __VRC725_init("Buzzkill", "BZK", msg.sender);
        mintFee = _mintFee;
        hiveFactory = _hiveFactory;
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
    /*  View Functions                                                            */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Generates a bee image in SVG format for a given token ID.
     * @param tokenId The ID of the token.
     * @return The SVG image encoded as a base64 string.
     */
    // function generateBeeImage(
    //     uint256 tokenId
    // ) public view returns (string memory) {
    //     bytes memory svg = abi.encodePacked(
    //         '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
    //         "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
    //         '<rect width="100%" height="100%" fill="black" />',
    //         '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
    //         "Warrior",
    //         "</text>",
    //         '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
    //         "Traits: ",
    //         getTraits(tokenId),
    //         "</text>",
    //         "</svg>"
    //     );
    //     return
    //         string(
    //             abi.encodePacked(
    //                 "data:image/svg+xml;base64,",
    //                 Base64.encode(svg)
    //             )
    //         );
    // }

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
        bytes memory dataURI = abi.encodePacked(
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
            '"',
            '"productivity": "',
            beeTraits.productivity.toString(),
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
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        return tokenURIs[tokenId];
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
                100,
                100,
                100,
                100,
                100,
                100,
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
                200,
                200,
                200,
                200,
                200,
                200,
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

    function modifyBeeTraits(
        uint256 tokenId,
        BeeTraits calldata _beeTraits
    ) public onlyHive {
        require(_exists(tokenId), "Token does not exist");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        tokenIdToTraits[tokenId] = _beeTraits;
        tokenURIs[tokenId] = _getTokenURI(tokenId);
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
