/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumberish,
  BytesLike,
  FunctionFragment,
  Result,
  Interface,
  EventFragment,
  AddressLike,
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedLogDescription,
  TypedListener,
  TypedContractMethod,
} from "../common";

export declare namespace BuzzkillNFT {
  export type BeeTraitsStruct = {
    energy: BigNumberish;
    health: BigNumberish;
    attack: BigNumberish;
    defense: BigNumberish;
    forage: BigNumberish;
    experience: BigNumberish;
    nectar: BigNumberish;
    pollen: BigNumberish;
    sap: BigNumberish;
  };

  export type BeeTraitsStructOutput = [
    energy: bigint,
    health: bigint,
    attack: bigint,
    defense: bigint,
    forage: bigint,
    experience: bigint,
    nectar: bigint,
    pollen: bigint,
    sap: bigint
  ] & {
    energy: bigint;
    health: bigint;
    attack: bigint;
    defense: bigint;
    forage: bigint;
    experience: bigint;
    nectar: bigint;
    pollen: bigint;
    sap: bigint;
  };
}

export interface BuzzkillNFTInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "BASE_DENOMINATOR"
      | "DOMAIN_SEPARATOR"
      | "MAX_FEE"
      | "MAX_SUPPLY"
      | "MIN_FEE"
      | "PERMIT_FOR_ALL_TYPEHASH"
      | "PERMIT_TYPEHASH"
      | "acceptOwnership"
      | "approve"
      | "balanceOf"
      | "burn"
      | "buzzkillAddressProvider"
      | "currentTokenId"
      | "getApproved"
      | "getBeeLevel"
      | "getBeeTraits"
      | "hiveFactory"
      | "isApprovedForAll"
      | "issuer"
      | "minFee"
      | "mintFee"
      | "mintTo"
      | "modifyBeeTraits"
      | "name"
      | "nonceByAddress"
      | "nonces"
      | "owner"
      | "ownerOf"
      | "pause"
      | "paused"
      | "permit"
      | "permitForAll"
      | "queenBeeImage"
      | "refreshBeeEnergy"
      | "refreshBeeHealth"
      | "safeTransferFrom(address,address,uint256)"
      | "safeTransferFrom(address,address,uint256,bytes)"
      | "setApprovalForAll"
      | "setHiveFactoryAddress"
      | "setMintFee"
      | "supportsInterface"
      | "symbol"
      | "tokenByIndex"
      | "tokenIdToCharacteristics"
      | "tokenIdToStatus"
      | "tokenIdToTraits"
      | "tokenOfOwnerByIndex"
      | "tokenURI"
      | "tokenURIs"
      | "totalSupply"
      | "transferFrom"
      | "transferOwnership"
      | "unpause"
      | "withdrawPayments"
      | "workerBeeImage"
  ): FunctionFragment;

  getEvent(
    nameOrSignatureOrTopic:
      | "Approval"
      | "ApprovalForAll"
      | "Fee"
      | "OwnershipTransferred"
      | "Paused"
      | "Transfer"
      | "Unpaused"
  ): EventFragment;

  encodeFunctionData(
    functionFragment: "BASE_DENOMINATOR",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "DOMAIN_SEPARATOR",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "MAX_FEE", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "MAX_SUPPLY",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "MIN_FEE", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "PERMIT_FOR_ALL_TYPEHASH",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "PERMIT_TYPEHASH",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "acceptOwnership",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "approve",
    values: [AddressLike, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "balanceOf",
    values: [AddressLike]
  ): string;
  encodeFunctionData(functionFragment: "burn", values: [BigNumberish]): string;
  encodeFunctionData(
    functionFragment: "buzzkillAddressProvider",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "currentTokenId",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getApproved",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getBeeLevel",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getBeeTraits",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "hiveFactory",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "isApprovedForAll",
    values: [AddressLike, AddressLike]
  ): string;
  encodeFunctionData(functionFragment: "issuer", values?: undefined): string;
  encodeFunctionData(functionFragment: "minFee", values?: undefined): string;
  encodeFunctionData(functionFragment: "mintFee", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "mintTo",
    values: [AddressLike, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "modifyBeeTraits",
    values: [BigNumberish, BuzzkillNFT.BeeTraitsStruct]
  ): string;
  encodeFunctionData(functionFragment: "name", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "nonceByAddress",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "nonces",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "owner", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "ownerOf",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "pause", values?: undefined): string;
  encodeFunctionData(functionFragment: "paused", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "permit",
    values: [AddressLike, BigNumberish, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "permitForAll",
    values: [AddressLike, AddressLike, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "queenBeeImage",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "refreshBeeEnergy",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "refreshBeeHealth",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "safeTransferFrom(address,address,uint256)",
    values: [AddressLike, AddressLike, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "safeTransferFrom(address,address,uint256,bytes)",
    values: [AddressLike, AddressLike, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "setApprovalForAll",
    values: [AddressLike, boolean]
  ): string;
  encodeFunctionData(
    functionFragment: "setHiveFactoryAddress",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "setMintFee",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "supportsInterface",
    values: [BytesLike]
  ): string;
  encodeFunctionData(functionFragment: "symbol", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "tokenByIndex",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenIdToCharacteristics",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenIdToStatus",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenIdToTraits",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenOfOwnerByIndex",
    values: [AddressLike, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenURI",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "tokenURIs",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "totalSupply",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "transferFrom",
    values: [AddressLike, AddressLike, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "transferOwnership",
    values: [AddressLike]
  ): string;
  encodeFunctionData(functionFragment: "unpause", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "withdrawPayments",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "workerBeeImage",
    values?: undefined
  ): string;

  decodeFunctionResult(
    functionFragment: "BASE_DENOMINATOR",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "DOMAIN_SEPARATOR",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "MAX_FEE", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "MAX_SUPPLY", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "MIN_FEE", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "PERMIT_FOR_ALL_TYPEHASH",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "PERMIT_TYPEHASH",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "acceptOwnership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "approve", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "balanceOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "burn", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "buzzkillAddressProvider",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "currentTokenId",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getApproved",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getBeeLevel",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getBeeTraits",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "hiveFactory",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isApprovedForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "issuer", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "minFee", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "mintFee", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "mintTo", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "modifyBeeTraits",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "name", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "nonceByAddress",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "nonces", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "owner", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "ownerOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "pause", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "paused", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "permit", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "permitForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "queenBeeImage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "refreshBeeEnergy",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "refreshBeeHealth",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "safeTransferFrom(address,address,uint256)",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "safeTransferFrom(address,address,uint256,bytes)",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setApprovalForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setHiveFactoryAddress",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "setMintFee", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "supportsInterface",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "symbol", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "tokenByIndex",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "tokenIdToCharacteristics",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "tokenIdToStatus",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "tokenIdToTraits",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "tokenOfOwnerByIndex",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "tokenURI", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "tokenURIs", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "totalSupply",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferFrom",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferOwnership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "unpause", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "withdrawPayments",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "workerBeeImage",
    data: BytesLike
  ): Result;
}

export namespace ApprovalEvent {
  export type InputTuple = [
    owner: AddressLike,
    approved: AddressLike,
    tokenId: BigNumberish
  ];
  export type OutputTuple = [owner: string, approved: string, tokenId: bigint];
  export interface OutputObject {
    owner: string;
    approved: string;
    tokenId: bigint;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace ApprovalForAllEvent {
  export type InputTuple = [
    owner: AddressLike,
    operator: AddressLike,
    approved: boolean
  ];
  export type OutputTuple = [
    owner: string,
    operator: string,
    approved: boolean
  ];
  export interface OutputObject {
    owner: string;
    operator: string;
    approved: boolean;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace FeeEvent {
  export type InputTuple = [
    from: AddressLike,
    to: AddressLike,
    issuer: AddressLike,
    value: BigNumberish
  ];
  export type OutputTuple = [
    from: string,
    to: string,
    issuer: string,
    value: bigint
  ];
  export interface OutputObject {
    from: string;
    to: string;
    issuer: string;
    value: bigint;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace OwnershipTransferredEvent {
  export type InputTuple = [previousOwner: AddressLike, newOwner: AddressLike];
  export type OutputTuple = [previousOwner: string, newOwner: string];
  export interface OutputObject {
    previousOwner: string;
    newOwner: string;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace PausedEvent {
  export type InputTuple = [account: AddressLike];
  export type OutputTuple = [account: string];
  export interface OutputObject {
    account: string;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace TransferEvent {
  export type InputTuple = [
    from: AddressLike,
    to: AddressLike,
    tokenId: BigNumberish
  ];
  export type OutputTuple = [from: string, to: string, tokenId: bigint];
  export interface OutputObject {
    from: string;
    to: string;
    tokenId: bigint;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export namespace UnpausedEvent {
  export type InputTuple = [account: AddressLike];
  export type OutputTuple = [account: string];
  export interface OutputObject {
    account: string;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export interface BuzzkillNFT extends BaseContract {
  connect(runner?: ContractRunner | null): BuzzkillNFT;
  waitForDeployment(): Promise<this>;

  interface: BuzzkillNFTInterface;

  queryFilter<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;
  queryFilter<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;

  on<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  on<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  once<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  once<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  listeners<TCEvent extends TypedContractEvent>(
    event: TCEvent
  ): Promise<Array<TypedListener<TCEvent>>>;
  listeners(eventName?: string): Promise<Array<Listener>>;
  removeAllListeners<TCEvent extends TypedContractEvent>(
    event?: TCEvent
  ): Promise<this>;

  BASE_DENOMINATOR: TypedContractMethod<[], [bigint], "view">;

  DOMAIN_SEPARATOR: TypedContractMethod<[], [string], "view">;

  MAX_FEE: TypedContractMethod<[], [bigint], "view">;

  MAX_SUPPLY: TypedContractMethod<[], [bigint], "view">;

  MIN_FEE: TypedContractMethod<[], [bigint], "view">;

  PERMIT_FOR_ALL_TYPEHASH: TypedContractMethod<[], [string], "view">;

  PERMIT_TYPEHASH: TypedContractMethod<[], [string], "view">;

  acceptOwnership: TypedContractMethod<[], [void], "nonpayable">;

  approve: TypedContractMethod<
    [to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;

  balanceOf: TypedContractMethod<[owner: AddressLike], [bigint], "view">;

  burn: TypedContractMethod<[tokenId: BigNumberish], [void], "nonpayable">;

  buzzkillAddressProvider: TypedContractMethod<[], [string], "view">;

  currentTokenId: TypedContractMethod<[], [bigint], "view">;

  getApproved: TypedContractMethod<[tokenId: BigNumberish], [string], "view">;

  getBeeLevel: TypedContractMethod<[tokenId: BigNumberish], [bigint], "view">;

  getBeeTraits: TypedContractMethod<
    [tokenId: BigNumberish],
    [BuzzkillNFT.BeeTraitsStructOutput],
    "view"
  >;

  hiveFactory: TypedContractMethod<[], [string], "view">;

  isApprovedForAll: TypedContractMethod<
    [owner: AddressLike, operator: AddressLike],
    [boolean],
    "view"
  >;

  issuer: TypedContractMethod<[], [string], "view">;

  minFee: TypedContractMethod<[], [bigint], "view">;

  mintFee: TypedContractMethod<[], [bigint], "view">;

  mintTo: TypedContractMethod<
    [to: AddressLike, _beeType: BigNumberish],
    [bigint],
    "payable"
  >;

  modifyBeeTraits: TypedContractMethod<
    [tokenId: BigNumberish, _beeTraits: BuzzkillNFT.BeeTraitsStruct],
    [void],
    "nonpayable"
  >;

  name: TypedContractMethod<[], [string], "view">;

  nonceByAddress: TypedContractMethod<[owner: AddressLike], [bigint], "view">;

  nonces: TypedContractMethod<[tokenId: BigNumberish], [bigint], "view">;

  owner: TypedContractMethod<[], [string], "view">;

  ownerOf: TypedContractMethod<[tokenId: BigNumberish], [string], "view">;

  pause: TypedContractMethod<[], [void], "nonpayable">;

  paused: TypedContractMethod<[], [boolean], "view">;

  permit: TypedContractMethod<
    [
      spender: AddressLike,
      tokenId: BigNumberish,
      deadline: BigNumberish,
      signature: BytesLike
    ],
    [void],
    "nonpayable"
  >;

  permitForAll: TypedContractMethod<
    [
      owner: AddressLike,
      spender: AddressLike,
      deadline: BigNumberish,
      signature: BytesLike
    ],
    [void],
    "nonpayable"
  >;

  queenBeeImage: TypedContractMethod<[], [string], "view">;

  refreshBeeEnergy: TypedContractMethod<
    [tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;

  refreshBeeHealth: TypedContractMethod<
    [tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;

  "safeTransferFrom(address,address,uint256)": TypedContractMethod<
    [from: AddressLike, to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;

  "safeTransferFrom(address,address,uint256,bytes)": TypedContractMethod<
    [
      from: AddressLike,
      to: AddressLike,
      tokenId: BigNumberish,
      data: BytesLike
    ],
    [void],
    "nonpayable"
  >;

  setApprovalForAll: TypedContractMethod<
    [operator: AddressLike, approved: boolean],
    [void],
    "nonpayable"
  >;

  setHiveFactoryAddress: TypedContractMethod<
    [_hiveFactory: AddressLike],
    [void],
    "nonpayable"
  >;

  setMintFee: TypedContractMethod<
    [_mintFee: BigNumberish],
    [void],
    "nonpayable"
  >;

  supportsInterface: TypedContractMethod<
    [interfaceId: BytesLike],
    [boolean],
    "view"
  >;

  symbol: TypedContractMethod<[], [string], "view">;

  tokenByIndex: TypedContractMethod<[index: BigNumberish], [bigint], "view">;

  tokenIdToCharacteristics: TypedContractMethod<
    [arg0: BigNumberish],
    [[string, string] & { avatar: string; beeType: string }],
    "view"
  >;

  tokenIdToStatus: TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint, bigint] & {
        baseEnergy: bigint;
        baseHealth: bigint;
        lastEnergyRefreshTimestamp: bigint;
        lastHealthRefreshTimestamp: bigint;
      }
    ],
    "view"
  >;

  tokenIdToTraits: TypedContractMethod<
    [arg0: BigNumberish],
    [
      [
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint
      ] & {
        energy: bigint;
        health: bigint;
        attack: bigint;
        defense: bigint;
        forage: bigint;
        experience: bigint;
        nectar: bigint;
        pollen: bigint;
        sap: bigint;
      }
    ],
    "view"
  >;

  tokenOfOwnerByIndex: TypedContractMethod<
    [owner: AddressLike, index: BigNumberish],
    [bigint],
    "view"
  >;

  tokenURI: TypedContractMethod<[tokenId: BigNumberish], [string], "view">;

  tokenURIs: TypedContractMethod<[arg0: BigNumberish], [string], "view">;

  totalSupply: TypedContractMethod<[], [bigint], "view">;

  transferFrom: TypedContractMethod<
    [from: AddressLike, to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;

  transferOwnership: TypedContractMethod<
    [newOwner: AddressLike],
    [void],
    "nonpayable"
  >;

  unpause: TypedContractMethod<[], [void], "nonpayable">;

  withdrawPayments: TypedContractMethod<
    [payee: AddressLike],
    [void],
    "nonpayable"
  >;

  workerBeeImage: TypedContractMethod<[], [string], "view">;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "BASE_DENOMINATOR"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "DOMAIN_SEPARATOR"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "MAX_FEE"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "MAX_SUPPLY"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "MIN_FEE"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "PERMIT_FOR_ALL_TYPEHASH"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "PERMIT_TYPEHASH"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "acceptOwnership"
  ): TypedContractMethod<[], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "approve"
  ): TypedContractMethod<
    [to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "balanceOf"
  ): TypedContractMethod<[owner: AddressLike], [bigint], "view">;
  getFunction(
    nameOrSignature: "burn"
  ): TypedContractMethod<[tokenId: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "buzzkillAddressProvider"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "currentTokenId"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "getApproved"
  ): TypedContractMethod<[tokenId: BigNumberish], [string], "view">;
  getFunction(
    nameOrSignature: "getBeeLevel"
  ): TypedContractMethod<[tokenId: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "getBeeTraits"
  ): TypedContractMethod<
    [tokenId: BigNumberish],
    [BuzzkillNFT.BeeTraitsStructOutput],
    "view"
  >;
  getFunction(
    nameOrSignature: "hiveFactory"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "isApprovedForAll"
  ): TypedContractMethod<
    [owner: AddressLike, operator: AddressLike],
    [boolean],
    "view"
  >;
  getFunction(
    nameOrSignature: "issuer"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "minFee"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "mintFee"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "mintTo"
  ): TypedContractMethod<
    [to: AddressLike, _beeType: BigNumberish],
    [bigint],
    "payable"
  >;
  getFunction(
    nameOrSignature: "modifyBeeTraits"
  ): TypedContractMethod<
    [tokenId: BigNumberish, _beeTraits: BuzzkillNFT.BeeTraitsStruct],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "name"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "nonceByAddress"
  ): TypedContractMethod<[owner: AddressLike], [bigint], "view">;
  getFunction(
    nameOrSignature: "nonces"
  ): TypedContractMethod<[tokenId: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "owner"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "ownerOf"
  ): TypedContractMethod<[tokenId: BigNumberish], [string], "view">;
  getFunction(
    nameOrSignature: "pause"
  ): TypedContractMethod<[], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "paused"
  ): TypedContractMethod<[], [boolean], "view">;
  getFunction(
    nameOrSignature: "permit"
  ): TypedContractMethod<
    [
      spender: AddressLike,
      tokenId: BigNumberish,
      deadline: BigNumberish,
      signature: BytesLike
    ],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "permitForAll"
  ): TypedContractMethod<
    [
      owner: AddressLike,
      spender: AddressLike,
      deadline: BigNumberish,
      signature: BytesLike
    ],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "queenBeeImage"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "refreshBeeEnergy"
  ): TypedContractMethod<[tokenId: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "refreshBeeHealth"
  ): TypedContractMethod<[tokenId: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "safeTransferFrom(address,address,uint256)"
  ): TypedContractMethod<
    [from: AddressLike, to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "safeTransferFrom(address,address,uint256,bytes)"
  ): TypedContractMethod<
    [
      from: AddressLike,
      to: AddressLike,
      tokenId: BigNumberish,
      data: BytesLike
    ],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setApprovalForAll"
  ): TypedContractMethod<
    [operator: AddressLike, approved: boolean],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setHiveFactoryAddress"
  ): TypedContractMethod<[_hiveFactory: AddressLike], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setMintFee"
  ): TypedContractMethod<[_mintFee: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "supportsInterface"
  ): TypedContractMethod<[interfaceId: BytesLike], [boolean], "view">;
  getFunction(
    nameOrSignature: "symbol"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "tokenByIndex"
  ): TypedContractMethod<[index: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "tokenIdToCharacteristics"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [[string, string] & { avatar: string; beeType: string }],
    "view"
  >;
  getFunction(
    nameOrSignature: "tokenIdToStatus"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint, bigint] & {
        baseEnergy: bigint;
        baseHealth: bigint;
        lastEnergyRefreshTimestamp: bigint;
        lastHealthRefreshTimestamp: bigint;
      }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "tokenIdToTraits"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [
      [
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint,
        bigint
      ] & {
        energy: bigint;
        health: bigint;
        attack: bigint;
        defense: bigint;
        forage: bigint;
        experience: bigint;
        nectar: bigint;
        pollen: bigint;
        sap: bigint;
      }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "tokenOfOwnerByIndex"
  ): TypedContractMethod<
    [owner: AddressLike, index: BigNumberish],
    [bigint],
    "view"
  >;
  getFunction(
    nameOrSignature: "tokenURI"
  ): TypedContractMethod<[tokenId: BigNumberish], [string], "view">;
  getFunction(
    nameOrSignature: "tokenURIs"
  ): TypedContractMethod<[arg0: BigNumberish], [string], "view">;
  getFunction(
    nameOrSignature: "totalSupply"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "transferFrom"
  ): TypedContractMethod<
    [from: AddressLike, to: AddressLike, tokenId: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "transferOwnership"
  ): TypedContractMethod<[newOwner: AddressLike], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "unpause"
  ): TypedContractMethod<[], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "withdrawPayments"
  ): TypedContractMethod<[payee: AddressLike], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "workerBeeImage"
  ): TypedContractMethod<[], [string], "view">;

  getEvent(
    key: "Approval"
  ): TypedContractEvent<
    ApprovalEvent.InputTuple,
    ApprovalEvent.OutputTuple,
    ApprovalEvent.OutputObject
  >;
  getEvent(
    key: "ApprovalForAll"
  ): TypedContractEvent<
    ApprovalForAllEvent.InputTuple,
    ApprovalForAllEvent.OutputTuple,
    ApprovalForAllEvent.OutputObject
  >;
  getEvent(
    key: "Fee"
  ): TypedContractEvent<
    FeeEvent.InputTuple,
    FeeEvent.OutputTuple,
    FeeEvent.OutputObject
  >;
  getEvent(
    key: "OwnershipTransferred"
  ): TypedContractEvent<
    OwnershipTransferredEvent.InputTuple,
    OwnershipTransferredEvent.OutputTuple,
    OwnershipTransferredEvent.OutputObject
  >;
  getEvent(
    key: "Paused"
  ): TypedContractEvent<
    PausedEvent.InputTuple,
    PausedEvent.OutputTuple,
    PausedEvent.OutputObject
  >;
  getEvent(
    key: "Transfer"
  ): TypedContractEvent<
    TransferEvent.InputTuple,
    TransferEvent.OutputTuple,
    TransferEvent.OutputObject
  >;
  getEvent(
    key: "Unpaused"
  ): TypedContractEvent<
    UnpausedEvent.InputTuple,
    UnpausedEvent.OutputTuple,
    UnpausedEvent.OutputObject
  >;

  filters: {
    "Approval(address,address,uint256)": TypedContractEvent<
      ApprovalEvent.InputTuple,
      ApprovalEvent.OutputTuple,
      ApprovalEvent.OutputObject
    >;
    Approval: TypedContractEvent<
      ApprovalEvent.InputTuple,
      ApprovalEvent.OutputTuple,
      ApprovalEvent.OutputObject
    >;

    "ApprovalForAll(address,address,bool)": TypedContractEvent<
      ApprovalForAllEvent.InputTuple,
      ApprovalForAllEvent.OutputTuple,
      ApprovalForAllEvent.OutputObject
    >;
    ApprovalForAll: TypedContractEvent<
      ApprovalForAllEvent.InputTuple,
      ApprovalForAllEvent.OutputTuple,
      ApprovalForAllEvent.OutputObject
    >;

    "Fee(address,address,address,uint256)": TypedContractEvent<
      FeeEvent.InputTuple,
      FeeEvent.OutputTuple,
      FeeEvent.OutputObject
    >;
    Fee: TypedContractEvent<
      FeeEvent.InputTuple,
      FeeEvent.OutputTuple,
      FeeEvent.OutputObject
    >;

    "OwnershipTransferred(address,address)": TypedContractEvent<
      OwnershipTransferredEvent.InputTuple,
      OwnershipTransferredEvent.OutputTuple,
      OwnershipTransferredEvent.OutputObject
    >;
    OwnershipTransferred: TypedContractEvent<
      OwnershipTransferredEvent.InputTuple,
      OwnershipTransferredEvent.OutputTuple,
      OwnershipTransferredEvent.OutputObject
    >;

    "Paused(address)": TypedContractEvent<
      PausedEvent.InputTuple,
      PausedEvent.OutputTuple,
      PausedEvent.OutputObject
    >;
    Paused: TypedContractEvent<
      PausedEvent.InputTuple,
      PausedEvent.OutputTuple,
      PausedEvent.OutputObject
    >;

    "Transfer(address,address,uint256)": TypedContractEvent<
      TransferEvent.InputTuple,
      TransferEvent.OutputTuple,
      TransferEvent.OutputObject
    >;
    Transfer: TypedContractEvent<
      TransferEvent.InputTuple,
      TransferEvent.OutputTuple,
      TransferEvent.OutputObject
    >;

    "Unpaused(address)": TypedContractEvent<
      UnpausedEvent.InputTuple,
      UnpausedEvent.OutputTuple,
      UnpausedEvent.OutputObject
    >;
    Unpaused: TypedContractEvent<
      UnpausedEvent.InputTuple,
      UnpausedEvent.OutputTuple,
      UnpausedEvent.OutputObject
    >;
  };
}
