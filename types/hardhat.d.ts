/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { ethers } from "ethers";
import {
  DeployContractOptions,
  FactoryOptions,
  HardhatEthersHelpers as HardhatEthersHelpersBase,
} from "@nomicfoundation/hardhat-ethers/types";

import * as Contracts from ".";

declare module "hardhat/types/runtime" {
  interface HardhatEthersHelpers extends HardhatEthersHelpersBase {
    getContractFactory(
      name: "OwnableUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.OwnableUpgradeable__factory>;
    getContractFactory(
      name: "Initializable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Initializable__factory>;
    getContractFactory(
      name: "ContextUpgradeable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ContextUpgradeable__factory>;
    getContractFactory(
      name: "Ownable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Ownable__factory>;
    getContractFactory(
      name: "Math",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Math__factory>;
    getContractFactory(
      name: "Pausable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Pausable__factory>;
    getContractFactory(
      name: "ReentrancyGuard",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ReentrancyGuard__factory>;
    getContractFactory(
      name: "Strings",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Strings__factory>;
    getContractFactory(
      name: "IERC165",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC165__factory>;
    getContractFactory(
      name: "IVRC25",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IVRC25__factory>;
    getContractFactory(
      name: "VRC25",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.VRC25__factory>;
    getContractFactory(
      name: "VRC725Enumerable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.VRC725Enumerable__factory>;
    getContractFactory(
      name: "IERC1271",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC1271__factory>;
    getContractFactory(
      name: "IERC165",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC165__factory>;
    getContractFactory(
      name: "IERC4494",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC4494__factory>;
    getContractFactory(
      name: "IERC721",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721__factory>;
    getContractFactory(
      name: "IERC721Enumerable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721Enumerable__factory>;
    getContractFactory(
      name: "IERC721Metadata",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721Metadata__factory>;
    getContractFactory(
      name: "IERC721Receiver",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IERC721Receiver__factory>;
    getContractFactory(
      name: "IVRC725",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IVRC725__factory>;
    getContractFactory(
      name: "ECDSA",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ECDSA__factory>;
    getContractFactory(
      name: "ERC165",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.ERC165__factory>;
    getContractFactory(
      name: "VRC725",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.VRC725__factory>;
    getContractFactory(
      name: "BuzzkillNFT",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.BuzzkillNFT__factory>;
    getContractFactory(
      name: "BuzzkillAddressProvider",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.BuzzkillAddressProvider__factory>;
    getContractFactory(
      name: "Controllable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Controllable__factory>;
    getContractFactory(
      name: "GameConfig",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.GameConfig__factory>;
    getContractFactory(
      name: "HoneyDistribution",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.HoneyDistribution__factory>;
    getContractFactory(
      name: "HiveManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.HiveManager__factory>;
    getContractFactory(
      name: "Honey",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Honey__factory>;
    getContractFactory(
      name: "WorldMap",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.WorldMap__factory>;
    getContractFactory(
      name: "IBuzzkillAddressProvider",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IBuzzkillAddressProvider__factory>;
    getContractFactory(
      name: "IBuzzkillNFT",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IBuzzkillNFT__factory>;
    getContractFactory(
      name: "IGameConfig",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IGameConfig__factory>;
    getContractFactory(
      name: "IHiveManager",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IHiveManager__factory>;
    getContractFactory(
      name: "IHoney",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IHoney__factory>;
    getContractFactory(
      name: "IHoneyDistribution",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IHoneyDistribution__factory>;
    getContractFactory(
      name: "IWorldMap",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.IWorldMap__factory>;

    getContractAt(
      name: "OwnableUpgradeable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.OwnableUpgradeable>;
    getContractAt(
      name: "Initializable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Initializable>;
    getContractAt(
      name: "ContextUpgradeable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.ContextUpgradeable>;
    getContractAt(
      name: "Ownable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Ownable>;
    getContractAt(
      name: "Math",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Math>;
    getContractAt(
      name: "Pausable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Pausable>;
    getContractAt(
      name: "ReentrancyGuard",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.ReentrancyGuard>;
    getContractAt(
      name: "Strings",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Strings>;
    getContractAt(
      name: "IERC165",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC165>;
    getContractAt(
      name: "IVRC25",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IVRC25>;
    getContractAt(
      name: "VRC25",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.VRC25>;
    getContractAt(
      name: "VRC725Enumerable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.VRC725Enumerable>;
    getContractAt(
      name: "IERC1271",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC1271>;
    getContractAt(
      name: "IERC165",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC165>;
    getContractAt(
      name: "IERC4494",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC4494>;
    getContractAt(
      name: "IERC721",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721>;
    getContractAt(
      name: "IERC721Enumerable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721Enumerable>;
    getContractAt(
      name: "IERC721Metadata",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721Metadata>;
    getContractAt(
      name: "IERC721Receiver",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IERC721Receiver>;
    getContractAt(
      name: "IVRC725",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IVRC725>;
    getContractAt(
      name: "ECDSA",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.ECDSA>;
    getContractAt(
      name: "ERC165",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.ERC165>;
    getContractAt(
      name: "VRC725",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.VRC725>;
    getContractAt(
      name: "BuzzkillNFT",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.BuzzkillNFT>;
    getContractAt(
      name: "BuzzkillAddressProvider",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.BuzzkillAddressProvider>;
    getContractAt(
      name: "Controllable",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Controllable>;
    getContractAt(
      name: "GameConfig",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.GameConfig>;
    getContractAt(
      name: "HoneyDistribution",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.HoneyDistribution>;
    getContractAt(
      name: "HiveManager",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.HiveManager>;
    getContractAt(
      name: "Honey",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.Honey>;
    getContractAt(
      name: "WorldMap",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.WorldMap>;
    getContractAt(
      name: "IBuzzkillAddressProvider",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IBuzzkillAddressProvider>;
    getContractAt(
      name: "IBuzzkillNFT",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IBuzzkillNFT>;
    getContractAt(
      name: "IGameConfig",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IGameConfig>;
    getContractAt(
      name: "IHiveManager",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IHiveManager>;
    getContractAt(
      name: "IHoney",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IHoney>;
    getContractAt(
      name: "IHoneyDistribution",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IHoneyDistribution>;
    getContractAt(
      name: "IWorldMap",
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<Contracts.IWorldMap>;

    deployContract(
      name: "OwnableUpgradeable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.OwnableUpgradeable>;
    deployContract(
      name: "Initializable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Initializable>;
    deployContract(
      name: "ContextUpgradeable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ContextUpgradeable>;
    deployContract(
      name: "Ownable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Ownable>;
    deployContract(
      name: "Math",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Math>;
    deployContract(
      name: "Pausable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Pausable>;
    deployContract(
      name: "ReentrancyGuard",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ReentrancyGuard>;
    deployContract(
      name: "Strings",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Strings>;
    deployContract(
      name: "IERC165",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC165>;
    deployContract(
      name: "IVRC25",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IVRC25>;
    deployContract(
      name: "VRC25",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC25>;
    deployContract(
      name: "VRC725Enumerable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC725Enumerable>;
    deployContract(
      name: "IERC1271",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC1271>;
    deployContract(
      name: "IERC165",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC165>;
    deployContract(
      name: "IERC4494",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC4494>;
    deployContract(
      name: "IERC721",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721>;
    deployContract(
      name: "IERC721Enumerable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Enumerable>;
    deployContract(
      name: "IERC721Metadata",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Metadata>;
    deployContract(
      name: "IERC721Receiver",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Receiver>;
    deployContract(
      name: "IVRC725",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IVRC725>;
    deployContract(
      name: "ECDSA",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ECDSA>;
    deployContract(
      name: "ERC165",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ERC165>;
    deployContract(
      name: "VRC725",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC725>;
    deployContract(
      name: "BuzzkillNFT",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.BuzzkillNFT>;
    deployContract(
      name: "BuzzkillAddressProvider",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.BuzzkillAddressProvider>;
    deployContract(
      name: "Controllable",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Controllable>;
    deployContract(
      name: "GameConfig",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.GameConfig>;
    deployContract(
      name: "HoneyDistribution",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.HoneyDistribution>;
    deployContract(
      name: "HiveManager",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.HiveManager>;
    deployContract(
      name: "Honey",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Honey>;
    deployContract(
      name: "WorldMap",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.WorldMap>;
    deployContract(
      name: "IBuzzkillAddressProvider",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IBuzzkillAddressProvider>;
    deployContract(
      name: "IBuzzkillNFT",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IBuzzkillNFT>;
    deployContract(
      name: "IGameConfig",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IGameConfig>;
    deployContract(
      name: "IHiveManager",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHiveManager>;
    deployContract(
      name: "IHoney",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHoney>;
    deployContract(
      name: "IHoneyDistribution",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHoneyDistribution>;
    deployContract(
      name: "IWorldMap",
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IWorldMap>;

    deployContract(
      name: "OwnableUpgradeable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.OwnableUpgradeable>;
    deployContract(
      name: "Initializable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Initializable>;
    deployContract(
      name: "ContextUpgradeable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ContextUpgradeable>;
    deployContract(
      name: "Ownable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Ownable>;
    deployContract(
      name: "Math",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Math>;
    deployContract(
      name: "Pausable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Pausable>;
    deployContract(
      name: "ReentrancyGuard",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ReentrancyGuard>;
    deployContract(
      name: "Strings",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Strings>;
    deployContract(
      name: "IERC165",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC165>;
    deployContract(
      name: "IVRC25",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IVRC25>;
    deployContract(
      name: "VRC25",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC25>;
    deployContract(
      name: "VRC725Enumerable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC725Enumerable>;
    deployContract(
      name: "IERC1271",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC1271>;
    deployContract(
      name: "IERC165",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC165>;
    deployContract(
      name: "IERC4494",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC4494>;
    deployContract(
      name: "IERC721",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721>;
    deployContract(
      name: "IERC721Enumerable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Enumerable>;
    deployContract(
      name: "IERC721Metadata",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Metadata>;
    deployContract(
      name: "IERC721Receiver",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IERC721Receiver>;
    deployContract(
      name: "IVRC725",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IVRC725>;
    deployContract(
      name: "ECDSA",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ECDSA>;
    deployContract(
      name: "ERC165",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.ERC165>;
    deployContract(
      name: "VRC725",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.VRC725>;
    deployContract(
      name: "BuzzkillNFT",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.BuzzkillNFT>;
    deployContract(
      name: "BuzzkillAddressProvider",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.BuzzkillAddressProvider>;
    deployContract(
      name: "Controllable",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Controllable>;
    deployContract(
      name: "GameConfig",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.GameConfig>;
    deployContract(
      name: "HoneyDistribution",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.HoneyDistribution>;
    deployContract(
      name: "HiveManager",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.HiveManager>;
    deployContract(
      name: "Honey",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.Honey>;
    deployContract(
      name: "WorldMap",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.WorldMap>;
    deployContract(
      name: "IBuzzkillAddressProvider",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IBuzzkillAddressProvider>;
    deployContract(
      name: "IBuzzkillNFT",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IBuzzkillNFT>;
    deployContract(
      name: "IGameConfig",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IGameConfig>;
    deployContract(
      name: "IHiveManager",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHiveManager>;
    deployContract(
      name: "IHoney",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHoney>;
    deployContract(
      name: "IHoneyDistribution",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IHoneyDistribution>;
    deployContract(
      name: "IWorldMap",
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<Contracts.IWorldMap>;

    // default types
    getContractFactory(
      name: string,
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<ethers.ContractFactory>;
    getContractFactory(
      abi: any[],
      bytecode: ethers.BytesLike,
      signer?: ethers.Signer
    ): Promise<ethers.ContractFactory>;
    getContractAt(
      nameOrAbi: string | any[],
      address: string | ethers.Addressable,
      signer?: ethers.Signer
    ): Promise<ethers.Contract>;
    deployContract(
      name: string,
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<ethers.Contract>;
    deployContract(
      name: string,
      args: any[],
      signerOrOptions?: ethers.Signer | DeployContractOptions
    ): Promise<ethers.Contract>;
  }
}
