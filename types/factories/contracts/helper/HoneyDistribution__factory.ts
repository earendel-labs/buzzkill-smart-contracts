/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type {
  Signer,
  AddressLike,
  ContractDeployTransaction,
  ContractRunner,
} from "ethers";
import type { NonPayableOverrides } from "../../../common";
import type {
  HoneyDistribution,
  HoneyDistributionInterface,
} from "../../../contracts/helper/HoneyDistribution";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_buzzkillAddressProvider",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "HiveOnly",
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
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "totalHoneyDistributed",
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
  "0x608060405234801561001057600080fd5b5060405161065138038061065183398101604081905261002f916100d4565b338061005557604051631e4fbdf760e01b81526000600482015260240160405180910390fd5b61005e81610084565b50600280546001600160a01b0319166001600160a01b0392909216919091179055610104565b600080546001600160a01b038381166001600160a01b0319831681178455604051919092169283917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e09190a35050565b6000602082840312156100e657600080fd5b81516001600160a01b03811681146100fd57600080fd5b9392505050565b61053e806101136000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c8063462e3a8414610067578063715018a61461007c57806378c27362146100845780638da5cb5b146100a0578063c3ce1d06146100bb578063f2fde38b146100ce575b600080fd5b61007a61007536600461049b565b6100e1565b005b61007a610263565b61008d60015481565b6040519081526020015b60405180910390f35b6000546040516001600160a01b039091168152602001610097565b61007a6100c936600461049b565b610277565b61007a6100dc3660046104c7565b6103c6565b600260009054906101000a90046001600160a01b03166001600160a01b03166318b5c9546040518163ffffffff1660e01b8152600401602060405180830381865afa158015610134573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061015891906104eb565b6001600160a01b0316336001600160a01b031614610189576040516329e101a960e01b815260040160405180910390fd5b6002546040805163b3d8d07960e01b815290516000926001600160a01b03169163b3d8d0799160048083019260209291908290030181865afa1580156101d3573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906101f791906104eb565b604051632770a7eb60e21b81526001600160a01b0385811660048301526024820185905291925090821690639dc29fac906044015b600060405180830381600087803b15801561024657600080fd5b505af115801561025a573d6000803e3d6000fd5b50505050505050565b61026b610409565b6102756000610436565b565b600260009054906101000a90046001600160a01b03166001600160a01b03166318b5c9546040518163ffffffff1660e01b8152600401602060405180830381865afa1580156102ca573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102ee91906104eb565b6001600160a01b0316336001600160a01b03161461031f576040516329e101a960e01b815260040160405180910390fd5b6002546040805163b3d8d07960e01b815290516000926001600160a01b03169163b3d8d0799160048083019260209291908290030181865afa158015610369573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061038d91906104eb565b6040516308934a5f60e31b81526001600160a01b038581166004830152602482018590529192509082169063449a52f89060440161022c565b6103ce610409565b6001600160a01b0381166103fd57604051631e4fbdf760e01b8152600060048201526024015b60405180910390fd5b61040681610436565b50565b6000546001600160a01b031633146102755760405163118cdaa760e01b81523360048201526024016103f4565b600080546001600160a01b038381166001600160a01b0319831681178455604051919092169283917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e09190a35050565b6001600160a01b038116811461040657600080fd5b600080604083850312156104ae57600080fd5b82356104b981610486565b946020939093013593505050565b6000602082840312156104d957600080fd5b81356104e481610486565b9392505050565b6000602082840312156104fd57600080fd5b81516104e48161048656fea2646970667358221220792e3ae1d545f243f6df433f5c1d1561ce1328830d3bb5187c4c22eaa10a051664736f6c63430008180033";

type HoneyDistributionConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: HoneyDistributionConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class HoneyDistribution__factory extends ContractFactory {
  constructor(...args: HoneyDistributionConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    _buzzkillAddressProvider: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(
      _buzzkillAddressProvider,
      overrides || {}
    );
  }
  override deploy(
    _buzzkillAddressProvider: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ) {
    return super.deploy(_buzzkillAddressProvider, overrides || {}) as Promise<
      HoneyDistribution & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): HoneyDistribution__factory {
    return super.connect(runner) as HoneyDistribution__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): HoneyDistributionInterface {
    return new Interface(_abi) as HoneyDistributionInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): HoneyDistribution {
    return new Contract(address, _abi, runner) as unknown as HoneyDistribution;
  }
}