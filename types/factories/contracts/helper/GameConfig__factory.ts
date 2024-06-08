/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type { Signer, ContractDeployTransaction, ContractRunner } from "ethers";
import type { NonPayableOverrides } from "../../../common";
import type {
  GameConfig,
  GameConfigInterface,
} from "../../../contracts/helper/GameConfig";

const _abi = [
  {
    inputs: [],
    name: "InvalidInitialization",
    type: "error",
  },
  {
    inputs: [],
    name: "NotInitializing",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
    ],
    name: "OwnableInvalidOwner",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "OwnableUnauthorizedAccount",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newAmountToLevelUp",
        type: "uint256",
      },
    ],
    name: "AmountToLevelUpChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newBaseHealthDeductionAfterRaid",
        type: "uint256",
      },
    ],
    name: "BaseHealthDeductionAfterRaidChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newBaseHoneyRaidReward",
        type: "uint256",
      },
    ],
    name: "BaseHoneyRaidRewardChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newBeeEnergyRefreshInterval",
        type: "uint256",
      },
    ],
    name: "BeeEnergyRefreshIntervalChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newBeeHealthRefreshInterval",
        type: "uint256",
      },
    ],
    name: "BeeHealthRefreshIntervalChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newClaimTimeInterval",
        type: "uint256",
      },
    ],
    name: "ClaimTimeIntervalChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newCn",
        type: "uint256",
      },
    ],
    name: "CnChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newCp",
        type: "uint256",
      },
    ],
    name: "CpChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newCs",
        type: "uint256",
      },
    ],
    name: "CsChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newExperienceEarnedAfterForage",
        type: "uint256",
      },
    ],
    name: "ExperienceEarnedAfterForageChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newExperienceEarnedAfterRaidFailed",
        type: "uint256",
      },
    ],
    name: "ExperienceEarnedAfterRaidFailedChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newExperienceEarnedAfterRaidSuccess",
        type: "uint256",
      },
    ],
    name: "ExperienceEarnedAfterRaidSuccessChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newForagePercentage",
        type: "uint256",
      },
    ],
    name: "ForagePercentageChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newHoneyYieldConstant",
        type: "uint256",
      },
    ],
    name: "HoneyYieldConstantChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint64",
        name: "version",
        type: "uint64",
      },
    ],
    name: "Initialized",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMaxEnergyDeductionValue",
        type: "uint256",
      },
    ],
    name: "MaxEnergyDeductionValueChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMaxQueen",
        type: "uint256",
      },
    ],
    name: "MaxQueenChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMaxResourcesValue",
        type: "uint256",
      },
    ],
    name: "MaxResourcesValueChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMaxWorker",
        type: "uint256",
      },
    ],
    name: "MaxWorkerChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMinEnergyDeductionValue",
        type: "uint256",
      },
    ],
    name: "MinEnergyDeductionValueChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newMinResourcesValue",
        type: "uint256",
      },
    ],
    name: "MinResourcesValueChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newNectarRequiredToClaim",
        type: "uint256",
      },
    ],
    name: "NectarRequiredToClaimChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "previousOwner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "OwnershipTransferred",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newProductivityEarnAfterRaid",
        type: "uint256",
      },
    ],
    name: "ProductivityEarnAfterRaidChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newRaidHoneyFee",
        type: "uint256",
      },
    ],
    name: "RaidHoneyFeeChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newRaidSapFee",
        type: "uint256",
      },
    ],
    name: "RaidSapFeeChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "newResourcesRefreshInterval",
        type: "uint256",
      },
    ],
    name: "ResourcesRefreshIntervalChanged",
    type: "event",
  },
  {
    inputs: [],
    name: "Cn",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "Cp",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "Cs",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "amountToLevelUp",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "baseHealthDeductionAfterRaid",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "baseHoneyRaidReward",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "baseHoneyYield",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "baseIncentivePerEpoch",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "beeEnergyRefreshInterval",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "beeHealthRefreshInterval",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "claimTimeInterval",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "experienceEarnedAfterForage",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "experienceEarnedAfterRaidFailed",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "experienceEarnedAfterRaidSuccess",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "foragePercentage",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "honeyYieldConstant",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "initialize",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "maxEnergyDeductionValue",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "maxQueen",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "maxResourcesValue",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "maxWorker",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "minEnergyDeductionValue",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "minResourcesValue",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "nectarRequiredToClaim",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "productivityEarnAfterRaid",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "raidHoneyFee",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "raidSapFee",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "resourcesRefreshInterval",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_amountToLevelUp",
        type: "uint256",
      },
    ],
    name: "setAmountToLevelUp",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_baseHealthDeductionAfterRaid",
        type: "uint256",
      },
    ],
    name: "setBaseHealthDeductionAfterRaid",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_baseHoneyRaidReward",
        type: "uint256",
      },
    ],
    name: "setBaseHoneyRaidReward",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_baseHoneyYield",
        type: "uint256",
      },
    ],
    name: "setBaseHoneyYield",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_baseIncentivePerEpoch",
        type: "uint256",
      },
    ],
    name: "setBaseIncentivePerEpoch",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_beeEnergyRefreshInterval",
        type: "uint256",
      },
    ],
    name: "setBeeEnergyRefreshInterval",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_beeHealthRefreshInterval",
        type: "uint256",
      },
    ],
    name: "setBeeHealthRefreshInterval",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_claimTimeInterval",
        type: "uint256",
      },
    ],
    name: "setClaimTimeInterval",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_Cn",
        type: "uint256",
      },
    ],
    name: "setCn",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_Cp",
        type: "uint256",
      },
    ],
    name: "setCp",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_Cs",
        type: "uint256",
      },
    ],
    name: "setCs",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_experienceEarnedAfterForage",
        type: "uint256",
      },
    ],
    name: "setExperienceEarnedAfterForage",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_experienceEarnedAfterRaidFailed",
        type: "uint256",
      },
    ],
    name: "setExperienceEarnedAfterRaidFailed",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_experienceEarnedAfterRaidSuccess",
        type: "uint256",
      },
    ],
    name: "setExperienceEarnedAfterRaidSuccess",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_foragePercentage",
        type: "uint256",
      },
    ],
    name: "setForagePercentage",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_honeyYieldConstant",
        type: "uint256",
      },
    ],
    name: "setHoneyYieldConstant",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_maxEnergyDeductionValue",
        type: "uint256",
      },
    ],
    name: "setMaxEnergyDeductionValue",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_maxQueen",
        type: "uint256",
      },
    ],
    name: "setMaxQueen",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_maxResourcesValue",
        type: "uint256",
      },
    ],
    name: "setMaxResourcesValue",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_maxWorker",
        type: "uint256",
      },
    ],
    name: "setMaxWorker",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_minEnergyDeductionValue",
        type: "uint256",
      },
    ],
    name: "setMinEnergyDeductionValue",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_minResourcesValue",
        type: "uint256",
      },
    ],
    name: "setMinResourcesValue",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_nectarRequiredToClaim",
        type: "uint256",
      },
    ],
    name: "setNectarRequiredToClaim",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_productivityEarnAfterRaid",
        type: "uint256",
      },
    ],
    name: "setProductivityEarnAfterRaid",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_raidHoneyFee",
        type: "uint256",
      },
    ],
    name: "setRaidHoneyFee",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_raidSapFee",
        type: "uint256",
      },
    ],
    name: "setRaidSapFee",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_resourcesRefreshInterval",
        type: "uint256",
      },
    ],
    name: "setResourcesRefreshInterval",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "transferOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b506110c1806100206000396000f3fe608060405234801561001057600080fd5b506004361061038e5760003560e01c806387063ead116101de578063bfcce4f61161010f578063d656ccd6116100ad578063eeeb7ad21161007c578063eeeb7ad2146106c1578063f2fde38b146106ca578063f8ac2843146106dd578063ff2c4b03146106e657600080fd5b8063d656ccd614610689578063d9403d161461069c578063dc33615c146106af578063e35ef3b4146106b857600080fd5b8063c8a93336116100e9578063c8a9333614610647578063ca7f790a14610650578063cabae1a514610663578063d375a9b41461067657600080fd5b8063bfcce4f614610618578063c3cee85b1461062b578063c688e25d1461063e57600080fd5b8063b6d075751161017c578063b96d7e9211610156578063b96d7e92146105ea578063b9e59a07146105fd578063ba7f387814610606578063bcd47fc01461060f57600080fd5b8063b6d07575146105c5578063b6f9cf6a146105ce578063b7de13c1146105d757600080fd5b80638ff0ae37116101b85780638ff0ae3714610597578063945b6123146105a05780639a1aa197146105a9578063adfa1647146105bc57600080fd5b806387063ead1461054b5780638ccf96d7146105545780638da5cb5b1461055d57600080fd5b80633cf4766b116102c357806364a817bf116102615780637f19b63c116102305780637f19b63c146105145780637f50b6fd146105275780638129fc1c146105305780638454964a1461053857600080fd5b806364a817bf146104d3578063715018a6146104e657806371cc9f84146104ee5780637391c4431461050157600080fd5b80634c5bd4a11161029d5780634c5bd4a114610487578063591bd0051461049a5780635ce7e020146104ad578063646216e4146104c057600080fd5b80633cf4766b1461046c5780633d6e3e6514610475578063477e8c411461047e57600080fd5b8063265670e7116103305780632bb16c1e1161030a5780632bb16c1e1461042a5780632e4157a21461043d57806337a11a631461045057806337b769b91461045957600080fd5b8063265670e714610405578063290059951461040e5780632aa26b3c1461042157600080fd5b80630c52bbbc1161036c5780630c52bbbc146103ce578063166ce745146103ea57806316b24c0b146103f35780631ffc45a3146103fc57600080fd5b806305657e371461039357806308e388fd146103a85780630a232149146103bb575b600080fd5b6103a66103a1366004611042565b6106f9565b005b6103a66103b6366004611042565b61073d565b6103a66103c9366004611042565b61077a565b6103d760155481565b6040519081526020015b60405180910390f35b6103d760095481565b6103d7600c5481565b6103d760175481565b6103d760085481565b6103a661041c366004611042565b6107b7565b6103d760005481565b6103a6610438366004611042565b6107f4565b6103a661044b366004611042565b610831565b6103d7600b5481565b6103a6610467366004611042565b61086e565b6103d760115481565b6103d760015481565b6103d760075481565b6103a6610495366004611042565b6108ab565b6103a66104a8366004611042565b6108e8565b6103a66104bb366004611042565b610925565b6103a66104ce366004611042565b610932565b6103a66104e1366004611042565b61096f565b6103a66109ac565b6103a66104fc366004611042565b6109c0565b6103a661050f366004611042565b6109fd565b6103a6610522366004611042565b610a3a565b6103d760055481565b6103a6610a77565b6103a6610546366004611042565b610c25565b6103d760065481565b6103d760035481565b7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546040516001600160a01b0390911681526020016103e1565b6103d760025481565b6103d760045481565b6103a66105b7366004611042565b610c62565b6103d7600d5481565b6103d7600f5481565b6103d760185481565b6103a66105e5366004611042565b610c9f565b6103a66105f8366004611042565b610cac565b6103d760165481565b6103d7601a5481565b6103d760145481565b6103a6610626366004611042565b610ce9565b6103a6610639366004611042565b610d26565b6103d7600e5481565b6103d7600a5481565b6103a661065e366004611042565b610d63565b6103a6610671366004611042565b610da0565b6103a6610684366004611042565b610ddd565b6103a6610697366004611042565b610e1a565b6103a66106aa366004611042565b610e57565b6103d760105481565b6103d760195481565b6103d760135481565b6103a66106d836600461105b565b610e94565b6103d760125481565b6103a66106f4366004611042565b610ed7565b610701610f14565b60048190556040518181527facde2766dd9eadbc2048ec6df042a0936d90cd33e001208c8d67178b71659f04906020015b60405180910390a150565b610745610f14565b600d8190556040518181527fae2c222c862b4f99f464f4ec1139235115b8af76ca1d549d522ec24a1dd1185e90602001610732565b610782610f14565b60028190556040518181527f23ce6c0b03287ba198c044954569964448f7592f31cb440a0af6f03f2cf807b690602001610732565b6107bf610f14565b600a8190556040518181527f0afd5f9d14537a9ab54988defa08e7dba8a7271114f2c659ff964462509d32ee90602001610732565b6107fc610f14565b601a8190556040518181527fe8178b6234ca6e8722b598550f4812863f24666d11be0cf90888a4d742de769290602001610732565b610839610f14565b60038190556040518181527f49f2206a0e7b2869449ef5811e305726864b18da1f7518a483f992a8caeb290890602001610732565b610876610f14565b60118190556040518181527fe9150848e042d928d5abcf8253e2c1e765ebfb694373fea6baadf38cb660ba6990602001610732565b6108b3610f14565b600b8190556040518181527ffb0b0afd7f18b8148d17d12c3fde1e6dcaebed6e9d0f74c7f2f8fc06a43cd23690602001610732565b6108f0610f14565b60198190556040518181527f3b6d88b7545a257675b7563e084f4872308dc11e39297157aef24d36e579059a90602001610732565b61092d610f14565b601755565b61093a610f14565b60068190556040518181527f74554d08a65764ce3fdf443a333eddd368b2c716d9e661c0049d99eaf4fd333690602001610732565b610977610f14565b60158190556040518181527f4ee50028b6e404f0f8853cd723ed638dfe11a02f31edf100ba689040c386cb2090602001610732565b6109b4610f14565b6109be6000610f6f565b565b6109c8610f14565b60188190556040518181527f282b23c71f5a94df850ea42e0728094bf316b90ffda3f690e0ccbe90125843bb90602001610732565b610a05610f14565b600f8190556040518181527f4a974ed13d8a08353ce9900ff624982773a6289f21bdb3a2f2ecca062979893290602001610732565b610a42610f14565b60128190556040518181527f672d0592dd1f0ee85645ceed655fc8cbb16bd616e45ec2caeaf16299e6be94a590602001610732565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a008054600160401b810460ff16159067ffffffffffffffff16600081158015610abd5750825b905060008267ffffffffffffffff166001148015610ada5750303b155b905081158015610ae8575080155b15610b065760405163f92ee8a960e01b815260040160405180910390fd5b845467ffffffffffffffff191660011785558315610b3057845460ff60401b1916600160401b1785555b610b3933610fe0565b6201518060008190556001818155606460028190556003805560376004556101f4600590815562093a80600655620186a06007556103e860085560146009819055600a808055601e600b55600c839055678ac7230489e80000600d819055600e859055600f556010556011929092556012839055601355908155601591909155670de0b6b3a76400006016556017556161a860188190556019819055601a558315610c1e57845460ff60401b19168555604051600181527fc7f505b2f371ae2175ee4913f4499e1f2633a7b5936321eed1cdaeb6115181d29060200160405180910390a15b5050505050565b610c2d610f14565b60098190556040518181527f84d1f8d2c9ba454b06df43183ae338b2b5a74577165a4f6da4bf9fb1c97150b990602001610732565b610c6a610f14565b60008190556040518181527f22fe2223e14ea505e8019060275c616c925fe1b70ac950d69710607cae7dbdb490602001610732565b610ca7610f14565b601655565b610cb4610f14565b60078190556040518181527f6f22eee821d9a1be7f38eb2bb9dd0079d15218a35ae8b2a76edb58da09745bfa90602001610732565b610cf1610f14565b60108190556040518181527f37922645ead4cf90188f0a4bbaf4d7024527062c6dbb7935e2b0c5dd5e93a14c90602001610732565b610d2e610f14565b60148190556040518181527f72d13688fb5cfd8d2a1274e1ed6f2632dfe603cd82d672d443fc6b0c05030a9b90602001610732565b610d6b610f14565b60088190556040518181527f2ff566136cf6fdd04afd45f5a82fd17dfe63d4c97ab769b17cc58a970ff836a090602001610732565b610da8610f14565b60058190556040518181527fc0f54bca20d00cc23e3a07d08226264ab44cfa8047b5f1811e03337a46370b8a90602001610732565b610de5610f14565b60018190556040518181527ffb17b2d1826d4e33039da2bf34ab0fe52c237879b381da3eddfe3a2a3c5f225890602001610732565b610e22610f14565b60138190556040518181527f23957cd2dc14a1aedfe6601744a9b208807bffe4891fb3726e7c618f8686b24090602001610732565b610e5f610f14565b600c8190556040518181527fe8a9347956404e5db33e93654506ddb13e7c6308729fddabd3b46aed46b8e41c90602001610732565b610e9c610f14565b6001600160a01b038116610ecb57604051631e4fbdf760e01b8152600060048201526024015b60405180910390fd5b610ed481610f6f565b50565b610edf610f14565b600e8190556040518181527f6783c913461f586fec289f9970953a3374484aa9a21f174d64d14ddb8c87963390602001610732565b33610f467f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546001600160a01b031690565b6001600160a01b0316146109be5760405163118cdaa760e01b8152336004820152602401610ec2565b7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c19930080546001600160a01b031981166001600160a01b03848116918217845560405192169182907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a3505050565b610fe8610ff1565b610ed48161103a565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a0054600160401b900460ff166109be57604051631afcd79f60e31b815260040160405180910390fd5b610e9c610ff1565b60006020828403121561105457600080fd5b5035919050565b60006020828403121561106d57600080fd5b81356001600160a01b038116811461108457600080fd5b939250505056fea26469706673582212200f7d8a61e45ff40c69481f3283da578099ef500901647b6971c92747080ab76264736f6c63430008180033";

type GameConfigConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: GameConfigConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class GameConfig__factory extends ContractFactory {
  constructor(...args: GameConfigConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(overrides || {});
  }
  override deploy(overrides?: NonPayableOverrides & { from?: string }) {
    return super.deploy(overrides || {}) as Promise<
      GameConfig & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): GameConfig__factory {
    return super.connect(runner) as GameConfig__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): GameConfigInterface {
    return new Interface(_abi) as GameConfigInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): GameConfig {
    return new Contract(address, _abi, runner) as unknown as GameConfig;
  }
}
