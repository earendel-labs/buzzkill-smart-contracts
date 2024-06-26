 <img width="1000" height="150" top="150" src="./public/buzzkill-logo.svg">

# BuzzKill NFT Staking Game 🐝 • ![solidity](https://img.shields.io/badge/solidity-^0.8.23-lightgrey)

## Project Overview

Welcome to the BuzzKill NFT Staking Game, a unique blockchain-based game on the Viction chain where players stake bee NFTs in various hives to earn VRC25 honey tokens. This project leverages Ethereum Virtual Machine (EVM) capabilities to create an engaging and rewarding experience for NFT enthusiasts.

## Game Mechanics

Players can stake their bee NFTs in different hives. Each hive has unique characteristics that affect the amount of honey tokens players can earn. The longer a bee is staked, the more honey tokens accrue. The variety of hives offers players strategic choices to maximize their rewards. Other in-game mechanics will include raiding other hives for honey, foraging for resources and constructing new buildings in a hive.

## Project Structure

The project is structured into various directories:

- `lib/`: Libraries including `forge-std`, `vrc25`, and `vrc725`.
- `scripts/`: Deployment scripts for game components.
- `src/`: Main Solidity contracts for NFTs, reward tokens, utilities, and the vault.
- `test/`: Test files for the smart contracts.

### Contract Interfaces and Functionality

#### NFT Contract (`BuzzkillNFT`)

- **Purpose**: Represents the bee NFTs using the VRC725 standard
- **Key Functions**:
  - `mintTo`: Mint new NFTs.
  - `burn`: Burn existing NFTs.
  - `withdrawPayments`: Withdraw payments.
  - `upgradeAttack`, `upgradeDefense`, `upgradeForaging`: Enhance bee traits.
  - `initializeBeeTraits`: Set initial traits for a bee.
  - Other administrative functions like `pause`, `unpause`, and price updates.

#### Reward Token Contract (`Honey`)

- **Purpose**: Manages the VRC25 honey tokens.
- **Key Functions**:
  - `mintTo`: Mint honey tokens to an address.
  - `burn`: Burn honey tokens from an address.
  - `setControllers`: Manage controllers of the token.
  - VRC25 functions such as `balanceOf` and `transferFrom` for token balance and transfer.

#### Hive Contract (`Hive`)

- **Purpose**: Handles staking logic and reward distribution.
- **Key Functions**:
  - `stakeBee` and `unstakeBee`: Stake and unstake bees in hives.
  - `collect`: Claim accumulated honey tokens.
  - `getHiveTraits`: Get traits of a specific hive.
  - `raidAHive`: Raid a hive for rewards.
  - Other functions for hive management and reward calculation.
