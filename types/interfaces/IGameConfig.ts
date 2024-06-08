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
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedListener,
  TypedContractMethod,
} from "../common";

export interface IGameConfigInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "Cn"
      | "Cp"
      | "Cs"
      | "amountToLevelUp"
      | "baseHealthDeductionAfterRaid"
      | "baseHoneyRaidReward"
      | "baseHoneyYield"
      | "baseIncentivePerEpoch"
      | "beeEnergyRefreshInterval"
      | "beeHealthRefreshInterval"
      | "claimTimeInterval"
      | "experienceEarnedAfterForage"
      | "experienceEarnedAfterRaidFailed"
      | "experienceEarnedAfterRaidSuccess"
      | "foragePercentage"
      | "honeyYieldConstant"
      | "maxEnergyDeductionValue"
      | "maxQueen"
      | "maxResourcesValue"
      | "maxWorker"
      | "minEnergyDeductionValue"
      | "minResourcesValue"
      | "nectarRequiredToClaim"
      | "productivityEarnAfterRaid"
      | "raidHoneyFee"
      | "raidSapFee"
      | "resourcesRefreshInterval"
      | "setAmountToLevelUp"
      | "setBaseHealthDeductionAfterRaid"
      | "setBaseHoneyRaidReward"
      | "setBaseHoneyYield"
      | "setBaseIncentivePerEpoch"
      | "setBeeEnergyRefreshInterval"
      | "setBeeHealthRefreshInterval"
      | "setClaimTimeInterval"
      | "setCn"
      | "setCp"
      | "setCs"
      | "setExperienceEarnedAfterForage"
      | "setExperienceEarnedAfterRaidFailed"
      | "setExperienceEarnedAfterRaidSuccess"
      | "setForagePercentage"
      | "setHoneyYieldConstant"
      | "setMaxEnergyDeductionValue"
      | "setMaxQueen"
      | "setMaxResourcesValue"
      | "setMaxWorker"
      | "setMinEnergyDeductionValue"
      | "setMinResourcesValue"
      | "setNectarRequiredToClaim"
      | "setProductivityEarnAfterRaid"
      | "setRaidHoneyFee"
      | "setRaidSapFee"
      | "setResourcesRefreshInterval"
  ): FunctionFragment;

  encodeFunctionData(functionFragment: "Cn", values?: undefined): string;
  encodeFunctionData(functionFragment: "Cp", values?: undefined): string;
  encodeFunctionData(functionFragment: "Cs", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "amountToLevelUp",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "baseHealthDeductionAfterRaid",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "baseHoneyRaidReward",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "baseHoneyYield",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "baseIncentivePerEpoch",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "beeEnergyRefreshInterval",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "beeHealthRefreshInterval",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "claimTimeInterval",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "experienceEarnedAfterForage",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "experienceEarnedAfterRaidFailed",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "experienceEarnedAfterRaidSuccess",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "foragePercentage",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "honeyYieldConstant",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "maxEnergyDeductionValue",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "maxQueen", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "maxResourcesValue",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "maxWorker", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "minEnergyDeductionValue",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "minResourcesValue",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "nectarRequiredToClaim",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "productivityEarnAfterRaid",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "raidHoneyFee",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "raidSapFee",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "resourcesRefreshInterval",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "setAmountToLevelUp",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBaseHealthDeductionAfterRaid",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBaseHoneyRaidReward",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBaseHoneyYield",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBaseIncentivePerEpoch",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBeeEnergyRefreshInterval",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setBeeHealthRefreshInterval",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setClaimTimeInterval",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "setCn", values: [BigNumberish]): string;
  encodeFunctionData(functionFragment: "setCp", values: [BigNumberish]): string;
  encodeFunctionData(functionFragment: "setCs", values: [BigNumberish]): string;
  encodeFunctionData(
    functionFragment: "setExperienceEarnedAfterForage",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setExperienceEarnedAfterRaidFailed",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setExperienceEarnedAfterRaidSuccess",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setForagePercentage",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setHoneyYieldConstant",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMaxEnergyDeductionValue",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMaxQueen",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMaxResourcesValue",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMaxWorker",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMinEnergyDeductionValue",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setMinResourcesValue",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setNectarRequiredToClaim",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setProductivityEarnAfterRaid",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setRaidHoneyFee",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setRaidSapFee",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setResourcesRefreshInterval",
    values: [BigNumberish]
  ): string;

  decodeFunctionResult(functionFragment: "Cn", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "Cp", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "Cs", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "amountToLevelUp",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "baseHealthDeductionAfterRaid",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "baseHoneyRaidReward",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "baseHoneyYield",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "baseIncentivePerEpoch",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "beeEnergyRefreshInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "beeHealthRefreshInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "claimTimeInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "experienceEarnedAfterForage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "experienceEarnedAfterRaidFailed",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "experienceEarnedAfterRaidSuccess",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "foragePercentage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "honeyYieldConstant",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "maxEnergyDeductionValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "maxQueen", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "maxResourcesValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "maxWorker", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "minEnergyDeductionValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "minResourcesValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "nectarRequiredToClaim",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "productivityEarnAfterRaid",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "raidHoneyFee",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "raidSapFee", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "resourcesRefreshInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setAmountToLevelUp",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBaseHealthDeductionAfterRaid",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBaseHoneyRaidReward",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBaseHoneyYield",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBaseIncentivePerEpoch",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBeeEnergyRefreshInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setBeeHealthRefreshInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setClaimTimeInterval",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "setCn", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "setCp", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "setCs", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "setExperienceEarnedAfterForage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setExperienceEarnedAfterRaidFailed",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setExperienceEarnedAfterRaidSuccess",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setForagePercentage",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setHoneyYieldConstant",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMaxEnergyDeductionValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMaxQueen",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMaxResourcesValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMaxWorker",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMinEnergyDeductionValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setMinResourcesValue",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setNectarRequiredToClaim",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setProductivityEarnAfterRaid",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setRaidHoneyFee",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setRaidSapFee",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setResourcesRefreshInterval",
    data: BytesLike
  ): Result;
}

export interface IGameConfig extends BaseContract {
  connect(runner?: ContractRunner | null): IGameConfig;
  waitForDeployment(): Promise<this>;

  interface: IGameConfigInterface;

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

  Cn: TypedContractMethod<[], [bigint], "view">;

  Cp: TypedContractMethod<[], [bigint], "view">;

  Cs: TypedContractMethod<[], [bigint], "view">;

  amountToLevelUp: TypedContractMethod<[], [bigint], "view">;

  baseHealthDeductionAfterRaid: TypedContractMethod<[], [bigint], "view">;

  baseHoneyRaidReward: TypedContractMethod<[], [bigint], "view">;

  baseHoneyYield: TypedContractMethod<[], [bigint], "view">;

  baseIncentivePerEpoch: TypedContractMethod<[], [bigint], "view">;

  beeEnergyRefreshInterval: TypedContractMethod<[], [bigint], "view">;

  beeHealthRefreshInterval: TypedContractMethod<[], [bigint], "view">;

  claimTimeInterval: TypedContractMethod<[], [bigint], "view">;

  experienceEarnedAfterForage: TypedContractMethod<[], [bigint], "view">;

  experienceEarnedAfterRaidFailed: TypedContractMethod<[], [bigint], "view">;

  experienceEarnedAfterRaidSuccess: TypedContractMethod<[], [bigint], "view">;

  foragePercentage: TypedContractMethod<[], [bigint], "view">;

  honeyYieldConstant: TypedContractMethod<[], [bigint], "view">;

  maxEnergyDeductionValue: TypedContractMethod<[], [bigint], "view">;

  maxQueen: TypedContractMethod<[], [bigint], "view">;

  maxResourcesValue: TypedContractMethod<[], [bigint], "view">;

  maxWorker: TypedContractMethod<[], [bigint], "view">;

  minEnergyDeductionValue: TypedContractMethod<[], [bigint], "view">;

  minResourcesValue: TypedContractMethod<[], [bigint], "view">;

  nectarRequiredToClaim: TypedContractMethod<[], [bigint], "view">;

  productivityEarnAfterRaid: TypedContractMethod<[], [bigint], "view">;

  raidHoneyFee: TypedContractMethod<[], [bigint], "view">;

  raidSapFee: TypedContractMethod<[], [bigint], "view">;

  resourcesRefreshInterval: TypedContractMethod<[], [bigint], "view">;

  setAmountToLevelUp: TypedContractMethod<
    [_amountToLevelUp: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBaseHealthDeductionAfterRaid: TypedContractMethod<
    [_baseHealthDeductionAfterRaid: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBaseHoneyRaidReward: TypedContractMethod<
    [_baseHoneyRaidReward: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBaseHoneyYield: TypedContractMethod<
    [_baseHoneyYield: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBaseIncentivePerEpoch: TypedContractMethod<
    [_baseIncentivePerEpoch: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBeeEnergyRefreshInterval: TypedContractMethod<
    [_beeEnergyRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;

  setBeeHealthRefreshInterval: TypedContractMethod<
    [_beeHealthRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;

  setClaimTimeInterval: TypedContractMethod<
    [_claimTimeInterval: BigNumberish],
    [void],
    "nonpayable"
  >;

  setCn: TypedContractMethod<[_Cn: BigNumberish], [void], "nonpayable">;

  setCp: TypedContractMethod<[_Cp: BigNumberish], [void], "nonpayable">;

  setCs: TypedContractMethod<[_Cs: BigNumberish], [void], "nonpayable">;

  setExperienceEarnedAfterForage: TypedContractMethod<
    [_experienceEarnedAfterForage: BigNumberish],
    [void],
    "nonpayable"
  >;

  setExperienceEarnedAfterRaidFailed: TypedContractMethod<
    [_experienceEarnedAfterRaidFailed: BigNumberish],
    [void],
    "nonpayable"
  >;

  setExperienceEarnedAfterRaidSuccess: TypedContractMethod<
    [_experienceEarnedAfterRaidSuccess: BigNumberish],
    [void],
    "nonpayable"
  >;

  setForagePercentage: TypedContractMethod<
    [_foragePercentage: BigNumberish],
    [void],
    "nonpayable"
  >;

  setHoneyYieldConstant: TypedContractMethod<
    [_honeyYieldConstant: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMaxEnergyDeductionValue: TypedContractMethod<
    [_maxEnergyDeductionValue: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMaxQueen: TypedContractMethod<
    [_maxQueen: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMaxResourcesValue: TypedContractMethod<
    [_maxResourcesValue: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMaxWorker: TypedContractMethod<
    [_maxWorker: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMinEnergyDeductionValue: TypedContractMethod<
    [_minEnergyDeductionValue: BigNumberish],
    [void],
    "nonpayable"
  >;

  setMinResourcesValue: TypedContractMethod<
    [_minResourcesValue: BigNumberish],
    [void],
    "nonpayable"
  >;

  setNectarRequiredToClaim: TypedContractMethod<
    [_nectarRequiredToClaim: BigNumberish],
    [void],
    "nonpayable"
  >;

  setProductivityEarnAfterRaid: TypedContractMethod<
    [_productivityEarnAfterRaid: BigNumberish],
    [void],
    "nonpayable"
  >;

  setRaidHoneyFee: TypedContractMethod<
    [_raidHoneyFee: BigNumberish],
    [void],
    "nonpayable"
  >;

  setRaidSapFee: TypedContractMethod<
    [_raidSapFee: BigNumberish],
    [void],
    "nonpayable"
  >;

  setResourcesRefreshInterval: TypedContractMethod<
    [_resourcesRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(nameOrSignature: "Cn"): TypedContractMethod<[], [bigint], "view">;
  getFunction(nameOrSignature: "Cp"): TypedContractMethod<[], [bigint], "view">;
  getFunction(nameOrSignature: "Cs"): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "amountToLevelUp"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "baseHealthDeductionAfterRaid"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "baseHoneyRaidReward"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "baseHoneyYield"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "baseIncentivePerEpoch"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "beeEnergyRefreshInterval"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "beeHealthRefreshInterval"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "claimTimeInterval"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "experienceEarnedAfterForage"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "experienceEarnedAfterRaidFailed"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "experienceEarnedAfterRaidSuccess"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "foragePercentage"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "honeyYieldConstant"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "maxEnergyDeductionValue"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "maxQueen"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "maxResourcesValue"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "maxWorker"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "minEnergyDeductionValue"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "minResourcesValue"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "nectarRequiredToClaim"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "productivityEarnAfterRaid"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "raidHoneyFee"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "raidSapFee"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "resourcesRefreshInterval"
  ): TypedContractMethod<[], [bigint], "view">;
  getFunction(
    nameOrSignature: "setAmountToLevelUp"
  ): TypedContractMethod<
    [_amountToLevelUp: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setBaseHealthDeductionAfterRaid"
  ): TypedContractMethod<
    [_baseHealthDeductionAfterRaid: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setBaseHoneyRaidReward"
  ): TypedContractMethod<
    [_baseHoneyRaidReward: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setBaseHoneyYield"
  ): TypedContractMethod<[_baseHoneyYield: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setBaseIncentivePerEpoch"
  ): TypedContractMethod<
    [_baseIncentivePerEpoch: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setBeeEnergyRefreshInterval"
  ): TypedContractMethod<
    [_beeEnergyRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setBeeHealthRefreshInterval"
  ): TypedContractMethod<
    [_beeHealthRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setClaimTimeInterval"
  ): TypedContractMethod<
    [_claimTimeInterval: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setCn"
  ): TypedContractMethod<[_Cn: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setCp"
  ): TypedContractMethod<[_Cp: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setCs"
  ): TypedContractMethod<[_Cs: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setExperienceEarnedAfterForage"
  ): TypedContractMethod<
    [_experienceEarnedAfterForage: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setExperienceEarnedAfterRaidFailed"
  ): TypedContractMethod<
    [_experienceEarnedAfterRaidFailed: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setExperienceEarnedAfterRaidSuccess"
  ): TypedContractMethod<
    [_experienceEarnedAfterRaidSuccess: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setForagePercentage"
  ): TypedContractMethod<
    [_foragePercentage: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setHoneyYieldConstant"
  ): TypedContractMethod<
    [_honeyYieldConstant: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setMaxEnergyDeductionValue"
  ): TypedContractMethod<
    [_maxEnergyDeductionValue: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setMaxQueen"
  ): TypedContractMethod<[_maxQueen: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setMaxResourcesValue"
  ): TypedContractMethod<
    [_maxResourcesValue: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setMaxWorker"
  ): TypedContractMethod<[_maxWorker: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setMinEnergyDeductionValue"
  ): TypedContractMethod<
    [_minEnergyDeductionValue: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setMinResourcesValue"
  ): TypedContractMethod<
    [_minResourcesValue: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setNectarRequiredToClaim"
  ): TypedContractMethod<
    [_nectarRequiredToClaim: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setProductivityEarnAfterRaid"
  ): TypedContractMethod<
    [_productivityEarnAfterRaid: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setRaidHoneyFee"
  ): TypedContractMethod<[_raidHoneyFee: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setRaidSapFee"
  ): TypedContractMethod<[_raidSapFee: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "setResourcesRefreshInterval"
  ): TypedContractMethod<
    [_resourcesRefreshInterval: BigNumberish],
    [void],
    "nonpayable"
  >;

  filters: {};
}