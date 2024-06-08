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

export interface WorldMapInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "BASE_DENOMINATOR"
      | "Cn"
      | "Cp"
      | "Cs"
      | "addHabitat"
      | "buzzkillAddressProvider"
      | "currentHabitatId"
      | "forage"
      | "getAmountEnergyDeductionAfterForage"
      | "getAmountProductivityBoostAfterForage"
      | "getHabitatResources"
      | "getInitialHabitatResources"
      | "habitatsInfo"
      | "habitatsResources"
      | "initialHabitatResources"
      | "owner"
      | "renounceOwnership"
      | "resourcesDecreasePercentage"
      | "transferOwnership"
  ): FunctionFragment;

  getEvent(
    nameOrSignatureOrTopic: "HabitatAdded" | "OwnershipTransferred"
  ): EventFragment;

  encodeFunctionData(
    functionFragment: "BASE_DENOMINATOR",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "Cn", values?: undefined): string;
  encodeFunctionData(functionFragment: "Cp", values?: undefined): string;
  encodeFunctionData(functionFragment: "Cs", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "addHabitat",
    values: [
      BigNumberish,
      BigNumberish,
      BigNumberish,
      BigNumberish,
      BigNumberish
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "buzzkillAddressProvider",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "currentHabitatId",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "forage",
    values: [BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getAmountEnergyDeductionAfterForage",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getAmountProductivityBoostAfterForage",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getHabitatResources",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getInitialHabitatResources",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "habitatsInfo",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "habitatsResources",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "initialHabitatResources",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "owner", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "renounceOwnership",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "resourcesDecreasePercentage",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "transferOwnership",
    values: [AddressLike]
  ): string;

  decodeFunctionResult(
    functionFragment: "BASE_DENOMINATOR",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "Cn", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "Cp", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "Cs", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "addHabitat", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "buzzkillAddressProvider",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "currentHabitatId",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "forage", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getAmountEnergyDeductionAfterForage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getAmountProductivityBoostAfterForage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getHabitatResources",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getInitialHabitatResources",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "habitatsInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "habitatsResources",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "initialHabitatResources",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "owner", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "renounceOwnership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "resourcesDecreasePercentage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferOwnership",
    data: BytesLike
  ): Result;
}

export namespace HabitatAddedEvent {
  export type InputTuple = [
    habitatId: BigNumberish,
    nectar: BigNumberish,
    pollen: BigNumberish,
    sap: BigNumberish,
    energyDeductionAfterForage: BigNumberish,
    productivityBoostAfterForage: BigNumberish
  ];
  export type OutputTuple = [
    habitatId: bigint,
    nectar: bigint,
    pollen: bigint,
    sap: bigint,
    energyDeductionAfterForage: bigint,
    productivityBoostAfterForage: bigint
  ];
  export interface OutputObject {
    habitatId: bigint;
    nectar: bigint;
    pollen: bigint;
    sap: bigint;
    energyDeductionAfterForage: bigint;
    productivityBoostAfterForage: bigint;
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

export interface WorldMap extends BaseContract {
  connect(runner?: ContractRunner | null): WorldMap;
  waitForDeployment(): Promise<this>;

  interface: WorldMapInterface;

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

  Cn: TypedContractMethod<[], [bigint], "view">;

  Cp: TypedContractMethod<[], [bigint], "view">;

  Cs: TypedContractMethod<[], [bigint], "view">;

  addHabitat: TypedContractMethod<
    [
      nectar: BigNumberish,
      pollen: BigNumberish,
      sap: BigNumberish,
      _energyDeductionAfterForage: BigNumberish,
      _productivityBoostAfterForage: BigNumberish
    ],
    [void],
    "nonpayable"
  >;

  buzzkillAddressProvider: TypedContractMethod<[], [string], "view">;

  currentHabitatId: TypedContractMethod<[], [bigint], "view">;

  forage: TypedContractMethod<
    [_beeId: BigNumberish, _habitatId: BigNumberish],
    [
      [bigint, bigint, bigint] & {
        nectarGathered: bigint;
        pollenGathered: bigint;
        sapGathered: bigint;
      }
    ],
    "nonpayable"
  >;

  getAmountEnergyDeductionAfterForage: TypedContractMethod<
    [_habitatId: BigNumberish],
    [bigint],
    "view"
  >;

  getAmountProductivityBoostAfterForage: TypedContractMethod<
    [_habitatId: BigNumberish],
    [bigint],
    "view"
  >;

  getHabitatResources: TypedContractMethod<
    [_habitatId: BigNumberish],
    [[bigint, bigint, bigint]],
    "view"
  >;

  getInitialHabitatResources: TypedContractMethod<
    [_habitatId: BigNumberish],
    [[bigint, bigint, bigint]],
    "view"
  >;

  habitatsInfo: TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & {
        lastRefreshTime: bigint;
        energyDeductionAfterForage: bigint;
        productivityBoostAfterForage: bigint;
      }
    ],
    "view"
  >;

  habitatsResources: TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & { nectar: bigint; pollen: bigint; sap: bigint }
    ],
    "view"
  >;

  initialHabitatResources: TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & { nectar: bigint; pollen: bigint; sap: bigint }
    ],
    "view"
  >;

  owner: TypedContractMethod<[], [string], "view">;

  renounceOwnership: TypedContractMethod<[], [void], "nonpayable">;

  resourcesDecreasePercentage: TypedContractMethod<[], [bigint], "view">;

  transferOwnership: TypedContractMethod<
    [newOwner: AddressLike],
    [void],
    "nonpayable"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "BASE_DENOMINATOR"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(nameOrSignature: "Cn"): TypedContractMethod<[], [bigint], "view">;
  getFunction(nameOrSignature: "Cp"): TypedContractMethod<[], [bigint], "view">;
  getFunction(nameOrSignature: "Cs"): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "addHabitat"
  ): TypedContractMethod<
    [
      nectar: BigNumberish,
      pollen: BigNumberish,
      sap: BigNumberish,
      _energyDeductionAfterForage: BigNumberish,
      _productivityBoostAfterForage: BigNumberish
    ],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "buzzkillAddressProvider"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "currentHabitatId"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "forage"
  ): TypedContractMethod<
    [_beeId: BigNumberish, _habitatId: BigNumberish],
    [
      [bigint, bigint, bigint] & {
        nectarGathered: bigint;
        pollenGathered: bigint;
        sapGathered: bigint;
      }
    ],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "getAmountEnergyDeductionAfterForage"
  ): TypedContractMethod<[_habitatId: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "getAmountProductivityBoostAfterForage"
  ): TypedContractMethod<[_habitatId: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "getHabitatResources"
  ): TypedContractMethod<
    [_habitatId: BigNumberish],
    [[bigint, bigint, bigint]],
    "view"
  >;
  getFunction(
    nameOrSignature: "getInitialHabitatResources"
  ): TypedContractMethod<
    [_habitatId: BigNumberish],
    [[bigint, bigint, bigint]],
    "view"
  >;
  getFunction(
    nameOrSignature: "habitatsInfo"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & {
        lastRefreshTime: bigint;
        energyDeductionAfterForage: bigint;
        productivityBoostAfterForage: bigint;
      }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "habitatsResources"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & { nectar: bigint; pollen: bigint; sap: bigint }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "initialHabitatResources"
  ): TypedContractMethod<
    [arg0: BigNumberish],
    [
      [bigint, bigint, bigint] & { nectar: bigint; pollen: bigint; sap: bigint }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "owner"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "renounceOwnership"
  ): TypedContractMethod<[], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "resourcesDecreasePercentage"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "transferOwnership"
  ): TypedContractMethod<[newOwner: AddressLike], [void], "nonpayable">;

  getEvent(
    key: "HabitatAdded"
  ): TypedContractEvent<
    HabitatAddedEvent.InputTuple,
    HabitatAddedEvent.OutputTuple,
    HabitatAddedEvent.OutputObject
  >;
  getEvent(
    key: "OwnershipTransferred"
  ): TypedContractEvent<
    OwnershipTransferredEvent.InputTuple,
    OwnershipTransferredEvent.OutputTuple,
    OwnershipTransferredEvent.OutputObject
  >;

  filters: {
    "HabitatAdded(uint256,uint256,uint256,uint256,uint256,uint256)": TypedContractEvent<
      HabitatAddedEvent.InputTuple,
      HabitatAddedEvent.OutputTuple,
      HabitatAddedEvent.OutputObject
    >;
    HabitatAdded: TypedContractEvent<
      HabitatAddedEvent.InputTuple,
      HabitatAddedEvent.OutputTuple,
      HabitatAddedEvent.OutputObject
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
  };
}
