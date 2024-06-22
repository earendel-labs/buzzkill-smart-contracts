/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Interface, type ContractRunner } from "ethers";
import type {
  IHoneyDistribution,
  IHoneyDistributionInterface,
} from "../../interfaces/IHoneyDistribution";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "burnHoney",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "distributeHoney",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class IHoneyDistribution__factory {
  static readonly abi = _abi;
  static createInterface(): IHoneyDistributionInterface {
    return new Interface(_abi) as IHoneyDistributionInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): IHoneyDistribution {
    return new Contract(address, _abi, runner) as unknown as IHoneyDistribution;
  }
}
