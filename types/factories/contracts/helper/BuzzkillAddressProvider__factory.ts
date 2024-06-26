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
  BuzzkillAddressProvider,
  BuzzkillAddressProviderInterface,
} from "../../../contracts/helper/BuzzkillAddressProvider";

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
    inputs: [],
    name: "buzzkillNFTAddress",
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
    name: "gameConfigAddress",
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
    name: "hiveManagerAddress",
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
    name: "honeyAddress",
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
    name: "honeyDistributionAddress",
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
    name: "initialize",
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
    inputs: [
      {
        internalType: "address",
        name: "_buzzkillNFTAddress",
        type: "address",
      },
    ],
    name: "setBuzzkillNFTAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_gameConfigAddress",
        type: "address",
      },
    ],
    name: "setGameConfigAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_hiveManagerAddress",
        type: "address",
      },
    ],
    name: "setHiveManagerAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_honeyAddress",
        type: "address",
      },
    ],
    name: "setHoneyAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_honeyDistributionAddress",
        type: "address",
      },
    ],
    name: "setHoneyDistributionAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_worldMapAddress",
        type: "address",
      },
    ],
    name: "setWorldMapAddress",
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
  {
    inputs: [],
    name: "worldMapAddress",
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
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b50610650806100206000396000f3fe608060405234801561001057600080fd5b50600436106101005760003560e01c806398194f8811610097578063db9ed21311610066578063db9ed2131461020e578063f2fde38b14610221578063f4a395f014610234578063f54a5e1b1461024757600080fd5b806398194f88146101c2578063b3d8d079146101d5578063bfb3f94a146101e8578063cb6dcbb6146101fb57600080fd5b80638129fc1c116100d35780638129fc1c14610164578063834e679c1461016c5780638da5cb5b1461017f578063928f11a2146101af57600080fd5b806318b5c95414610105578063306f4003146101345780636cfe8a9f14610149578063715018a61461015c575b600080fd5b600554610118906001600160a01b031681565b6040516001600160a01b03909116815260200160405180910390f35b6101476101423660046105ea565b61025a565b005b600454610118906001600160a01b031681565b610147610284565b610147610298565b600054610118906001600160a01b031681565b7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546001600160a01b0316610118565b6101476101bd3660046105ea565b6103a7565b600354610118906001600160a01b031681565b600154610118906001600160a01b031681565b6101476101f63660046105ea565b6103d1565b600254610118906001600160a01b031681565b61014761021c3660046105ea565b6103fb565b61014761022f3660046105ea565b610425565b6101476102423660046105ea565b610468565b6101476102553660046105ea565b610492565b6102626104bc565b600280546001600160a01b0319166001600160a01b0392909216919091179055565b61028c6104bc565b6102966000610517565b565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a008054600160401b810460ff16159067ffffffffffffffff166000811580156102de5750825b905060008267ffffffffffffffff1660011480156102fb5750303b155b905081158015610309575080155b156103275760405163f92ee8a960e01b815260040160405180910390fd5b845467ffffffffffffffff19166001178555831561035157845460ff60401b1916600160401b1785555b61035a33610588565b83156103a057845460ff60401b19168555604051600181527fc7f505b2f371ae2175ee4913f4499e1f2633a7b5936321eed1cdaeb6115181d29060200160405180910390a15b5050505050565b6103af6104bc565b600480546001600160a01b0319166001600160a01b0392909216919091179055565b6103d96104bc565b600080546001600160a01b0319166001600160a01b0392909216919091179055565b6104036104bc565b600180546001600160a01b0319166001600160a01b0392909216919091179055565b61042d6104bc565b6001600160a01b03811661045c57604051631e4fbdf760e01b8152600060048201526024015b60405180910390fd5b61046581610517565b50565b6104706104bc565b600580546001600160a01b0319166001600160a01b0392909216919091179055565b61049a6104bc565b600380546001600160a01b0319166001600160a01b0392909216919091179055565b336104ee7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546001600160a01b031690565b6001600160a01b0316146102965760405163118cdaa760e01b8152336004820152602401610453565b7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c19930080546001600160a01b031981166001600160a01b03848116918217845560405192169182907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a3505050565b610590610599565b610465816105e2565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a0054600160401b900460ff1661029657604051631afcd79f60e31b815260040160405180910390fd5b61042d610599565b6000602082840312156105fc57600080fd5b81356001600160a01b038116811461061357600080fd5b939250505056fea264697066735822122078dc80bcbc3e376b0c6f9e9624e577ee5939fc7756e576e3b33867bc3ff10aab64736f6c63430008180033";

type BuzzkillAddressProviderConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: BuzzkillAddressProviderConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class BuzzkillAddressProvider__factory extends ContractFactory {
  constructor(...args: BuzzkillAddressProviderConstructorParams) {
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
      BuzzkillAddressProvider & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(
    runner: ContractRunner | null
  ): BuzzkillAddressProvider__factory {
    return super.connect(runner) as BuzzkillAddressProvider__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): BuzzkillAddressProviderInterface {
    return new Interface(_abi) as BuzzkillAddressProviderInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): BuzzkillAddressProvider {
    return new Contract(
      address,
      _abi,
      runner
    ) as unknown as BuzzkillAddressProvider;
  }
}
