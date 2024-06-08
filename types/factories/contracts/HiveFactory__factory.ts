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
import type { NonPayableOverrides } from "../../common";
import type {
  HiveFactory,
  HiveFactoryInterface,
} from "../../contracts/HiveFactory";

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
    name: "HabitatNotExists",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "hiveId",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "address",
        name: "hiveAddress",
        type: "address",
      },
    ],
    name: "HiveCreated",
    type: "event",
  },
  {
    inputs: [],
    name: "buzzkillAddressProvider",
    outputs: [
      {
        internalType: "contract IBuzzkillAddressProvider",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "habitatId",
        type: "uint256",
      },
    ],
    name: "createHive",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "totalHives",
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
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b506040516143f03803806143f083398101604081905261002f91610054565b600180546001600160a01b0319166001600160a01b0392909216919091179055610084565b60006020828403121561006657600080fd5b81516001600160a01b038116811461007d57600080fd5b9392505050565b61435d806100936000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80633c377547146100465780637f7cfc1114610062578063921ca4b11461008d575b600080fd5b61004f60005481565b6040519081526020015b60405180910390f35b610075610070366004610262565b6100a0565b6040516001600160a01b039091168152602001610059565b600154610075906001600160a01b031681565b600080600160009054906101000a90046001600160a01b03166001600160a01b031663cb6dcbb66040518163ffffffff1660e01b8152600401602060405180830381865afa1580156100f6573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061011a919061027b565b90506000816001600160a01b031663eec584ef6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561015c573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061018091906102ab565b90508084106101a25760405163448e246d60e01b815260040160405180910390fd5b60015460405160009186916001600160a01b03909116906101c290610255565b9182526001600160a01b03166020820152604001604051809103906000f0801580156101f2573d6000803e3d6000fd5b506000805491925080610204836102c4565b9091555050600054604080519182526001600160a01b03831660208301527f4814e3c8756085e77cfe7d7894df1b4f12da7531d154d0a0a9f73c119f1af38b910160405180910390a1949350505050565b61403c806102ec83390190565b60006020828403121561027457600080fd5b5035919050565b60006020828403121561028d57600080fd5b81516001600160a01b03811681146102a457600080fd5b9392505050565b6000602082840312156102bd57600080fd5b5051919050565b6000600182016102e457634e487b7160e01b600052601160045260246000fd5b506001019056fe60806040523480156200001157600080fd5b506040516200403c3803806200403c83398101604081905262000034916200006b565b60008054336001600160a01b031991821617909155600192909255600f80549092166001600160a01b0391909116179055620000aa565b600080604083850312156200007f57600080fd5b825160208401519092506001600160a01b03811681146200009f57600080fd5b809150509250929050565b613f8280620000ba6000396000f3fe608060405234801561001057600080fd5b50600436106101da5760003560e01c8063903774ad11610104578063b0f7c7af116100a2578063de5bae0f11610071578063de5bae0f1461043f578063eeb36f7914610448578063f1bc9b5214610450578063f24996141461045857600080fd5b8063b0f7c7af14610411578063bd85958414610424578063c9592e991461042d578063dc90b6661461043657600080fd5b8063962b9d81116100de578063962b9d81146103ed57806399671e61146103f65780639b73f891146103ff5780639d73fcc61461040857600080fd5b8063903774ad14610343578063921ca4b11461035657806395920aad1461036957600080fd5b806341f7fee61161017c578063662377c11161014b578063662377c1146102f0578063706d6ef4146102f9578063877634261461030c5780638f605eec1461031f57600080fd5b806341f7fee61461028e57806357eb3b30146102a15780635aaabe58146102aa5780636055042b146102dd57600080fd5b806308d4ffab116101b857806308d4ffab1461022f578063150b7a021461024457806332304b901461027c5780633b42adee1461028557600080fd5b806302c7086c146101df57806302d05d3f146101fb57806307fbd84b14610226575b600080fd5b6101e860085481565b6040519081526020015b60405180910390f35b60005461020e906001600160a01b031681565b6040516001600160a01b0390911681526020016101f2565b6101e860045481565b61024261023d366004613aaa565b61046b565b005b610263610252366004613ada565b630a85bd0160e11b95945050505050565b6040516001600160e01b031990911681526020016101f2565b6101e8600a5481565b6101e861038481565b6101e861029c366004613b79565b610ec7565b6101e860035481565b6102cd6102b8366004613b79565b600d6020526000908152604090205460ff1681565b60405190151581526020016101f2565b6101e86102eb366004613b79565b61110e565b6101e860065481565b610242610307366004613b92565b611494565b61024261031a366004613b79565b611d87565b600454600554600654604080519384526020840192909252908201526060016101f2565b610242610351366004613b79565b611f60565b600f5461020e906001600160a01b031681565b6103b6610377366004613b79565b600e602052600090815260409020805460018201546002830154600384015460048501546005909501546001600160a01b039094169492939192909186565b604080516001600160a01b0390971687526020870195909552938501929092526060840152608083015260a082015260c0016101f2565b6101e860025481565b6101e8600c5481565b6101e860015481565b6101e860075481565b61024261041f366004613b79565b61240f565b6101e861271081565b6101e860095481565b6101e8600b5481565b6101e860055481565b6101e8612a88565b6101e8612c5a565b610242610466366004613b79565b612c91565b6000828152600d6020526040902054829060ff161561049d576040516380345f6960e01b815260040160405180910390fd5b6000818152600d60209081526040808320805460ff19166001179055858352600e909152902054336001600160a01b03909116146104ee5760405163ba18ada560e01b815260040160405180910390fd5b6104f66131f0565b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa158015610540573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906105649190613bb4565b60405163f3c86ff560e01b8152600481018690529091506000906001600160a01b0383169063f3c86ff59060240161012060405180830381865afa1580156105b0573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906105d49190613c49565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561062b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061064f9190613bb4565b9050806001600160a01b031663c688e25d6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561068f573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906106b39190613cc4565b82610100015110156106d857604051630396460960e61b815260040160405180910390fd5b806001600160a01b031663c688e25d6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610716573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061073a9190613cc4565b826101000181815161074c9190613cf3565b905250600f546040805163b3d8d07960e01b815290516000926001600160a01b03169163b3d8d0799160048083019260209291908290030181865afa158015610799573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906107bd9190613bb4565b905082602001516000036107e4576040516323131deb60e01b815260040160405180910390fd5b6000826001600160a01b031663adfa16476040518163ffffffff1660e01b8152600401602060405180830381865afa158015610824573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906108489190613cc4565b6040516370a0823160e01b815233600482015290915081906001600160a01b038416906370a0823190602401602060405180830381865afa158015610891573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906108b59190613cc4565b10156108d45760405163094c287760e41b815260040160405180910390fd5b600f546040805163130329f160e31b815290516000926001600160a01b0316916398194f889160048083019260209291908290030181865afa15801561091e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906109429190613bb4565b60405163118b8ea160e21b8152336004820152602481018490529091506001600160a01b0382169063462e3a8490604401600060405180830381600087803b15801561098d57600080fd5b505af11580156109a1573d6000803e3d6000fd5b5050604051636055042b60e01b8152600481018c90528a9250600091506001600160a01b03831690636055042b906024016020604051808303816000875af11580156109f1573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610a159190613cc4565b90506000866001600160a01b03166316b24c0b6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610a57573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610a7b9190613cc4565b90508115610bdb578088602001511015610a9b5760006020890152610ab1565b8088602001818151610aad9190613cf3565b9052505b6000612710610ac2846101f4613d06565b610acc9190613d33565b90508060096000828254610ae09190613d47565b92505081905550876001600160a01b03166337a11a636040518163ffffffff1660e01b8152600401602060405180830381865afa158015610b25573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610b499190613cc4565b8960a001818151610b5a9190613d47565b9052506001600160a01b03851663c3ce1d0633610b778487613cf3565b6040516001600160e01b031960e085901b1681526001600160a01b0390921660048301526024820152604401600060405180830381600087803b158015610bbd57600080fd5b505af1158015610bd1573d6000803e3d6000fd5b5050505050610c94565b610be6816002613d06565b88602001511015610bfd5760006020890152610c1d565b610c08816002613d06565b88602001818151610c199190613cf3565b9052505b866001600160a01b031663c8a933366040518163ffffffff1660e01b8152600401602060405180830381865afa158015610c5b573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610c7f9190613cc4565b8860a001818151610c909190613d47565b9052505b866001600160a01b031663dc33615c6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610cd2573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610cf69190613cc4565b60008d8152600e602052604081206002018054909190610d17908490613d47565b92505081905550866001600160a01b031663dc33615c6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610d5c573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610d809190613cc4565b60076000828254610d919190613d47565b90915550506040516350c142e760e11b81526001600160a01b038a169063a18285ce90610dc4908f908c90600401613d5a565b600060405180830381600087803b158015610dde57600080fd5b505af1158015610df2573d6000803e3d6000fd5b505050507fd00d9864c7d10fc441060667d5865560630e257e63b39f5e4c1174fe0d63de978c83896001600160a01b031663dc33615c6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610e57573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610e7b9190613cc4565b60a08c015160408051948552602085019390935291830152606082015260800160405180910390a150505060009687525050600d60205250506040909220805460ff1916905550505050565b600080610ed2612a88565b6000848152600e6020526040902060050154909150801580610ef45750600754155b15610f03575060009392505050565b600f5460408051636cfe8a9f60e01b815290516000926001600160a01b031691636cfe8a9f9160048083019260209291908290030181865afa158015610f4d573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610f719190613bb4565b90504382118015610feb5750806001600160a01b03166387063ead6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610fbb573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610fdf9190613cc4565b610fe98343613cf3565b105b15610ffb57506000949350505050565b6000610384600c544361100e9190613cf3565b6110189190613d33565b90506000600254600261102b9190613d06565b6003546110389190613d47565b82846001600160a01b0316631ffc45a36040518163ffffffff1660e01b8152600401602060405180830381865afa158015611077573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061109b9190613cc4565b6110a59190613d06565b6110af9190613d06565b90506000600b54826110c19190613d47565b6000898152600e60205260408120600301549192509082906110e38b896134aa565b6110ed9190613d47565b6110f79089613d06565b6111019190613d33565b9998505050505050505050565b60008054604080516302d05d3f60e01b8152905133926001600160a01b03169183916302d05d3f916004808201926020929091908290030181865afa15801561115b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061117f9190613bb4565b6001600160a01b0316146111a6576040516329e101a960e01b815260040160405180910390fd5b6000838152600e60205260409020546001600160a01b0316156111dc5760405163f305a0c160e01b815260040160405180910390fd5b6111e46131f0565b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa15801561122e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906112529190613bb4565b60405163f3c86ff560e01b8152600481018690529091506000906001600160a01b0383169063f3c86ff59060240161012060405180830381865afa15801561129e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906112c29190613c49565b905060006112ce61373b565b905060006112da613789565b905060008284604001516112ee9190613d06565b90506000826008546113009190613d06565b9050600081831115611101576000611316612a88565b90506000611322613805565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa158015611379573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061139d9190613bb4565b90506113ab61271080613d06565b60808a01516113ba9085613d06565b6113c5906064613d06565b6113cf9190613d33565b61271083836001600160a01b031663b6d075756040518163ffffffff1660e01b8152600401602060405180830381865afa158015611411573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906114359190613cc4565b61143f9190613d06565b61144b90612710613d06565b6114559190613d33565b61145f9190613d47565b93508284111561146d578293505b836009600082825461147f9190613cf3565b90915550505050509998505050505050505050565b6000828152600d6020526040902054829060ff16156114c6576040516380345f6960e01b815260040160405180910390fd5b6000818152600d60209081526040808320805460ff19166001179055858352600e909152902054336001600160a01b03909116146115175760405163ba18ada560e01b815260040160405180910390fd5b61151f6131f0565b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa158015611569573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061158d9190613bb4565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b031663cb6dcbb66040518163ffffffff1660e01b8152600401602060405180830381865afa1580156115e4573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906116089190613bb4565b6040516339e735fb60e21b8152600481018690529091506000906001600160a01b0383169063e79cd7ec90602401602060405180830381865afa158015611653573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906116779190613cc4565b604051633692c2cd60e21b8152600481018890529091506001600160a01b0384169063da4b0b3490602401600060405180830381600087803b1580156116bc57600080fd5b505af11580156116d0573d6000803e3d6000fd5b505060405163f3c86ff560e01b815260048101899052600092506001600160a01b038616915063f3c86ff59060240161012060405180830381865afa15801561171d573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906117419190613c49565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa158015611798573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906117bc9190613bb4565b905082826000015110156117e3576040516340bdb3cd60e11b815260040160405180910390fd5b604051631c1b5bbd60e21b81526004810189905260248101889052600090819081906001600160a01b0388169063706d6ef4906044016060604051808303816000875af1158015611838573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061185c9190613dc9565b9250925092506000876001600160a01b031663dcda128f8c6040518263ffffffff1660e01b815260040161189291815260200190565b602060405180830381865afa1580156118af573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906118d39190613cc4565b90506000856001600160a01b0316637f50b6fd6040518163ffffffff1660e01b8152600401602060405180830381865afa158015611915573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906119399190613cc4565b9050600161271061194a8388613d06565b6119549190613d33565b10156119975760016004600082825461196d9190613d47565b9091555061197e9050600186613cf3565b8760c00181815161198f9190613d47565b9052506119fb565b6127106119a48287613d06565b6119ae9190613d33565b600460008282546119bf9190613d47565b9091555061271090506119d28287613d06565b6119dc9190613d33565b6119e69086613cf3565b8760c0018181516119f79190613d47565b9052505b6001612710611a0a8387613d06565b611a149190613d33565b1015611a5757600160056000828254611a2d9190613d47565b90915550611a3e9050600185613cf3565b8760e001818151611a4f9190613d47565b905250611abb565b612710611a648286613d06565b611a6e9190613d33565b60056000828254611a7f9190613d47565b909155506127109050611a928286613d06565b611a9c9190613d33565b611aa69085613cf3565b8760e001818151611ab79190613d47565b9052505b6001612710611aca8386613d06565b611ad49190613d33565b1015611b1857600160066000828254611aed9190613d47565b90915550611afe9050600184613cf3565b8761010001818151611b109190613d47565b905250611b7d565b612710611b258285613d06565b611b2f9190613d33565b60066000828254611b409190613d47565b909155506127109050611b538285613d06565b611b5d9190613d33565b611b679084613cf3565b8761010001818151611b799190613d47565b9052505b8160076000828254611b8f9190613d47565b9091555050865188908890611ba5908390613cf3565b91508181525050856001600160a01b031663166ce7456040518163ffffffff1660e01b8152600401602060405180830381865afa158015611bea573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611c0e9190613cc4565b8760a001818151611c1f9190613d47565b90525060008d8152600e602052604081206002018054849290611c43908490613d47565b92505081905550896001600160a01b031663a18285ce8e896040518363ffffffff1660e01b8152600401611c78929190613d5a565b600060405180830381600087803b158015611c9257600080fd5b505af1158015611ca6573d6000803e3d6000fd5b505050507f01b63758d70114c012a53ec5a0738b9dbf8a38f05dae83523858dba22d0122b58d868686868b6001600160a01b031663166ce7456040518163ffffffff1660e01b8152600401602060405180830381865afa158015611d0e573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611d329190613cc4565b604080519687526020870195909552938501929092526060840152608083015260a082015260c00160405180910390a150505060009788525050600d60205250506040909320805460ff191690555050505050565b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa158015611dd1573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611df59190613bb4565b6040516331a9108f60e11b81526004810184905290915030906001600160a01b03831690636352211e90602401602060405180830381865afa158015611e3f573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611e639190613bb4565b6001600160a01b031614611e8a576040516371fa4c1160e01b815260040160405180910390fd5b60405163f3c86ff560e01b8152600481018390526000906001600160a01b0383169063f3c86ff59060240161012060405180830381865afa158015611ed3573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611ef79190613c49565b9050600e60008481526020019081526020016000206004015460086000828254611f219190613cf3565b90915550506060810180516000858152600e602052604081206004019190915590516008805491929091611f56908490613d47565b9091555050505050565b600f5460408051636cfe8a9f60e01b815290516000926001600160a01b031691636cfe8a9f9160048083019260209291908290030181865afa158015611faa573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190611fce9190613bb4565b9050806001600160a01b0316638ccf96d76040518163ffffffff1660e01b8152600401602060405180830381865afa15801561200e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906120329190613cc4565b60025410612056576040516001623dbea360e11b0319815260040160405180910390fd5b806001600160a01b031663945b61236040518163ffffffff1660e01b8152600401602060405180830381865afa158015612094573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906120b89190613cc4565b600354106120d9576040516393c8ce4360e01b815260040160405180910390fd5b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa158015612123573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906121479190613bb4565b60405163b4dc46d960e01b8152600481018590529091506000906001600160a01b0383169063b4dc46d990602401600060405180830381865afa158015612192573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526121ba9190810190613e7c565b60405163f3c86ff560e01b815260048101879052909250600091506001600160a01b0384169063f3c86ff59060240161012060405180830381865afa158015612207573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061222b9190613c49565b90506122356131f0565b61223e82613974565b1561225d576002805490600061225383613ee0565b9190505550612294565b612266826139d0565b1561227b576003805490600061225383613ee0565b60405163adc1f5ed60e01b815260040160405180910390fd5b6000858152600e60205260409020546001600160a01b0316156122ca57604051636c04db0760e01b815260040160405180910390fd5b6040805160c0810182523381526020808201888152600083850181815260608086018381529088018051608088019081524360a089019081528e8652600e909752978420965187546001600160a01b0319166001600160a01b039091161787559351600187015590516002860155516003850155935160048401559051600590920191909155516008805491929091612364908490613d47565b9091555050604051632142170760e11b8152336004820152306024820152604481018690526001600160a01b038416906342842e0e90606401600060405180830381600087803b1580156123b757600080fd5b505af11580156123cb573d6000803e3d6000fd5b505050507f11658f9285ec73fac1515f3a09966dcad7880f985e458acc3c41ac5cb98fc4e88560405161240091815260200190565b60405180910390a15050505050565b6000818152600e60205260409020546001600160a01b031633146124465760405163ba18ada560e01b815260040160405180910390fd5b600f54604080516320d399e760e21b815290516000926001600160a01b03169163834e679c9160048083019260209291908290030181865afa158015612490573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906124b49190613bb4565b60405163b4dc46d960e01b8152600481018490529091506000906001600160a01b0383169063b4dc46d990602401600060405180830381865afa1580156124ff573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526125279190810190613e7c565b9150506125326131f0565b600061253d84610ec7565b905080156128665760405163f3c86ff560e01b8152600481018590526000906001600160a01b0385169063f3c86ff59060240161012060405180830381865afa15801561258e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906125b29190613c49565b905060008160c0015190506000600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa158015612612573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906126369190613bb4565b9050806001600160a01b031663265670e76040518163ffffffff1660e01b8152600401602060405180830381865afa158015612676573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061269a9190613cc4565b82111561286257600f546040805163130329f160e31b815290516000926001600160a01b0316916398194f889160048083019260209291908290030181865afa1580156126eb573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061270f9190613bb4565b905084600960008282546127239190613cf3565b92505081905550816001600160a01b031663265670e76040518163ffffffff1660e01b8152600401602060405180830381865afa158015612768573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061278c9190613cc4565b8460c00181815161279d9190613cf3565b9052506040516350c142e760e11b81526001600160a01b0388169063a18285ce906127ce908b908890600401613d5a565b600060405180830381600087803b1580156127e857600080fd5b505af11580156127fc573d6000803e3d6000fd5b50506040516361e70e8360e11b8152336004820152602481018890526001600160a01b038416925063c3ce1d069150604401600060405180830381600087803b15801561284857600080fd5b505af115801561285c573d6000803e3d6000fd5b50505050505b5050505b61286f82613974565b1561288e576002805490600061288483613ef9565b91905055506128b2565b612897826139d0565b156128b257600380549060006128ac83613ef9565b91905055505b6000848152600e602052604081206002015460078054919290916128d7908490613cf3565b90915550506000848152600e6020526040902060038101546005909101546129009086906134aa565b600b5461290d9190613cf3565b6129179190613cf3565b600b556000848152600e6020526040812060040154600880549192909161293f908490613cf3565b909155505060075415801561295657506000600954115b156129655743600a5560006009555b6040805160c08101825260008082526020808301828152838501838152606085018481526080860185815260a087018681528c8752600e90955294879020955186546001600160a01b0319166001600160a01b039182161787559251600187015590516002860155516003850155915160048085019190915590516005909301929092559151632142170760e11b8152309181019190915233602482015260448101869052908416906342842e0e90606401600060405180830381600087803b158015612a3157600080fd5b505af1158015612a45573d6000803e3d6000fd5b505050507f16700825aa6607ffefaeb83e81057f12d39f973a5e078e2b5244155224c56b8a84604051612a7a91815260200190565b60405180910390a150505050565b6000600a544311612a9a575060095490565b600f5460408051636cfe8a9f60e01b815290516000926001600160a01b031691636cfe8a9f9160048083019260209291908290030181865afa158015612ae4573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612b089190613bb4565b90506000612b14612c5a565b90506000826001600160a01b031663b9e59a076040518163ffffffff1660e01b8152600401602060405180830381865afa158015612b56573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612b7a9190613cc4565b90506000610384600a5443612b8f9190613cf3565b612b999190613d33565b905080600003612baf5760095494505050505090565b6000612710856001600160a01b031663477e8c416040518163ffffffff1660e01b8152600401602060405180830381865afa158015612bf2573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612c169190613cc4565b612c208686613d06565b612c2a9190613d06565b612c349190613d33565b90506000612c428383613d06565b600954612c4f9190613d47565b979650505050505050565b600080612c65613a25565b9050612710612c748282613d06565b612c7e9190613d33565b600754612c8b9190613d47565b91505090565b6000818152600d6020526040902054819060ff1615612cc3576040516380345f6960e01b815260040160405180910390fd5b6000818152600d60209081526040808320805460ff19166001179055848352600e909152902054336001600160a01b0390911614612d145760405163ba18ada560e01b815260040160405180910390fd5b600254600003612d37576040516333d6d53f60e21b815260040160405180910390fd5b600f546040805163130329f160e31b815290516000926001600160a01b0316916398194f889160048083019260209291908290030181865afa158015612d81573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612da59190613bb4565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b031663834e679c6040518163ffffffff1660e01b8152600401602060405180830381865afa158015612dfc573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612e209190613bb4565b9050612e2a6131f0565b6000612e3585610ec7565b905080600003612e5857604051635204d81560e11b815260040160405180910390fd5b60405163f3c86ff560e01b8152600481018690526000906001600160a01b0384169063f3c86ff59060240161012060405180830381865afa158015612ea1573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612ec59190613c49565b905060008160c0015190506000600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa158015612f25573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612f499190613bb4565b9050806001600160a01b031663265670e76040518163ffffffff1660e01b8152600401602060405180830381865afa158015612f89573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190612fad9190613cc4565b821015612fd0576040516001625d3bd160e11b0319815260040160405180910390fd5b6000888152600e6020526040812060050154612fed908a906134aa565b60008a8152600e602052604081206003015491925061300c8284613d47565b60008c8152600e60205260408120436005820155600301819055600b8054929350839290919061303d908490613cf3565b9250508190555086600960008282546130569190613cf3565b92505081905550836001600160a01b031663265670e76040518163ffffffff1660e01b8152600401602060405180830381865afa15801561309b573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906130bf9190613cc4565b8660c0018181516130d09190613cf3565b9052506040516350c142e760e11b81526001600160a01b0389169063a18285ce90613101908e908a90600401613d5a565b600060405180830381600087803b15801561311b57600080fd5b505af115801561312f573d6000803e3d6000fd5b50506040516361e70e8360e11b8152336004820152602481018a90526001600160a01b038c16925063c3ce1d069150604401600060405180830381600087803b15801561317b57600080fd5b505af115801561318f573d6000803e3d6000fd5b5050604080518e8152602081018b90527f6f75ecacb5a6a71b2edb0d2b1664b4c2166ebd637c168379ce7a556739fcb50b935001905060405180910390a150505060009687525050600d60205250506040909220805460ff19169055505050565b600a5443116131fb57565b60075460000361320b5743600a55565b600f5460408051636cfe8a9f60e01b815290516000926001600160a01b031691636cfe8a9f9160048083019260209291908290030181865afa158015613255573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906132799190613bb4565b90506000613285612c5a565b90506000826001600160a01b031663b9e59a076040518163ffffffff1660e01b8152600401602060405180830381865afa1580156132c7573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906132eb9190613cc4565b90506000610384600a54436133009190613cf3565b61330a9190613d33565b90506000610384600c544361331f9190613cf3565b6133299190613d33565b905081158015613337575080155b15613343575050505050565b6000612710866001600160a01b031663477e8c416040518163ffffffff1660e01b8152600401602060405180830381865afa158015613386573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906133aa9190613cc4565b6133b48787613d06565b6133be9190613d06565b6133c89190613d33565b90506133d48382613d06565b600960008282546133e59190613d47565b9091555050600280546000916133fb9190613d06565b6003546134089190613d47565b83886001600160a01b0316631ffc45a36040518163ffffffff1660e01b8152600401602060405180830381865afa158015613447573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061346b9190613cc4565b6134759190613d06565b61347f9190613d06565b905080600b60008282546134939190613d47565b909155505043600a819055600c5550505050505050565b6000806103846134ba8443613cf3565b6134c49190613d33565b90506000600f60009054906101000a90046001600160a01b03166001600160a01b031663834e679c6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561351b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061353f9190613bb4565b60405163b4dc46d960e01b8152600481018790529091506000906001600160a01b0383169063b4dc46d990602401600060405180830381865afa15801561358a573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526135b29190810190613e7c565b915050600080600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561360b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061362f9190613bb4565b905061363a83613974565b156136be5784816001600160a01b0316631ffc45a36040518163ffffffff1660e01b8152600401602060405180830381865afa15801561367e573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906136a29190613cc4565b6136ac9190613d06565b6136b7906002613d06565b915061372e565b84816001600160a01b0316631ffc45a36040518163ffffffff1660e01b8152600401602060405180830381865afa1580156136fd573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906137219190613cc4565b61372b9190613d06565b91505b5093505050505b92915050565b60006109c442443360405160200161375593929190613f10565b6040516020818303038152906040528051906020012060001c6137789190613f38565b61378490612710613d47565b905090565b60008060035460025461379c9190613d47565b9050601d81116137ed576109c44244336040516020016137be93929190613f10565b6040516020818303038152906040528051906020012060001c6137e19190613f38565b612c8b90612710613d47565b6113884244336040516020016137be93929190613f10565b600080600f60009054906101000a90046001600160a01b03166001600160a01b0316636cfe8a9f6040518163ffffffff1660e01b8152600401602060405180830381865afa15801561385b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061387f9190613bb4565b9050806001600160a01b031663945b61236040518163ffffffff1660e01b8152600401602060405180830381865afa1580156138bf573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906138e39190613cc4565b816001600160a01b0316638ccf96d76040518163ffffffff1660e01b8152600401602060405180830381865afa158015613921573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906139459190613cc4565b61394f9190613d47565b60035460025461395f9190613d47565b0361396c57600291505090565b600191505090565b60408051808201909152600581526428bab2b2b760d91b6020918201528151908201206000907ff5f8b21b0fa04f095084b55cc0d7bec4c709a5487f7a1da6ff7c117a2c3f69a5016139c857506001919050565b506000919050565b6040805180820190915260068152652bb7b935b2b960d11b6020918201528151908201206000907f165d4acabed7e70189f8367d5581798fe7782887dab4b20298287a6d308210a4016139c857506001919050565b6000612710600654611388613a3a9190613d06565b613a449190613d33565b612710600554610bb8613a579190613d06565b613a619190613d33565b6127106004546107d0613a749190613d06565b613a7e9190613d33565b613a889190613d47565b6137849190613d47565b6001600160a01b0381168114613aa757600080fd5b50565b60008060408385031215613abd57600080fd5b823591506020830135613acf81613a92565b809150509250929050565b600080600080600060808688031215613af257600080fd5b8535613afd81613a92565b94506020860135613b0d81613a92565b935060408601359250606086013567ffffffffffffffff80821115613b3157600080fd5b818801915088601f830112613b4557600080fd5b813581811115613b5457600080fd5b896020828501011115613b6657600080fd5b9699959850939650602001949392505050565b600060208284031215613b8b57600080fd5b5035919050565b60008060408385031215613ba557600080fd5b50508035926020909101359150565b600060208284031215613bc657600080fd5b8151613bd181613a92565b9392505050565b634e487b7160e01b600052604160045260246000fd5b604051610120810167ffffffffffffffff81118282101715613c1257613c12613bd8565b60405290565b604051601f8201601f1916810167ffffffffffffffff81118282101715613c4157613c41613bd8565b604052919050565b60006101208284031215613c5c57600080fd5b613c64613bee565b825181526020830151602082015260408301516040820152606083015160608201526080830151608082015260a083015160a082015260c083015160c082015260e083015160e08201526101008084015181830152508091505092915050565b600060208284031215613cd657600080fd5b5051919050565b634e487b7160e01b600052601160045260246000fd5b8181038181111561373557613735613cdd565b808202811582820484141761373557613735613cdd565b634e487b7160e01b600052601260045260246000fd5b600082613d4257613d42613d1d565b500490565b8082018082111561373557613735613cdd565b60006101408201905083825282516020830152602083015160408301526040830151606083015260608301516080830152608083015160a083015260a083015160c083015260c083015160e083015260e083015161010081818501528085015161012085015250509392505050565b600080600060608486031215613dde57600080fd5b8351925060208401519150604084015190509250925092565b600082601f830112613e0857600080fd5b815167ffffffffffffffff811115613e2257613e22613bd8565b6020613e36601f8301601f19168201613c18565b8281528582848701011115613e4a57600080fd5b60005b83811015613e68578581018301518282018401528201613e4d565b506000928101909101919091529392505050565b60008060408385031215613e8f57600080fd5b825167ffffffffffffffff80821115613ea757600080fd5b613eb386838701613df7565b93506020850151915080821115613ec957600080fd5b50613ed685828601613df7565b9150509250929050565b600060018201613ef257613ef2613cdd565b5060010190565b600081613f0857613f08613cdd565b506000190190565b928352602083019190915260601b6bffffffffffffffffffffffff1916604082015260540190565b600082613f4757613f47613d1d565b50069056fea2646970667358221220cc8d06106882b0a6f0d3c357abc051d064623d94902a62d7856472b8d32a872064736f6c63430008180033a26469706673582212203f40bf27affb98a9e1b5e2a050ffd8a78526fd3615a877898dc29d11bb3cd6ee64736f6c63430008180033";

type HiveFactoryConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: HiveFactoryConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class HiveFactory__factory extends ContractFactory {
  constructor(...args: HiveFactoryConstructorParams) {
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
      HiveFactory & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): HiveFactory__factory {
    return super.connect(runner) as HiveFactory__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): HiveFactoryInterface {
    return new Interface(_abi) as HiveFactoryInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): HiveFactory {
    return new Contract(address, _abi, runner) as unknown as HiveFactory;
  }
}
