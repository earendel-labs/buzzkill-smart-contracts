import { HardhatUserConfig } from "hardhat/types";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-ignition-ethers";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-contract-sizer";
require("dotenv").config();

const privateKey = process.env.PRIVATE_KEY || "";

interface ExtendedHardhatUserConfig extends HardhatUserConfig {
  etherscan?: {
    apiKey: any;
    customChains?: any;
  };
  gasReporter: {
    enabled: boolean;
    currency: string;
    gasPrice: number;
  };
  namedAccounts: any;
}

const config: ExtendedHardhatUserConfig = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    hardhat: {
      gas: 12000000,
      blockGasLimit: 0x1fffffffffffff,
      allowUnlimitedContractSize: true,
      forking: {
        url: `https://rpc.viction.xyz`,
      },
    },
    test_viction: {
      url: `https://rpc-testnet.viction.xyz`,
      accounts: [privateKey],
      chainId: 89,
    },
    viction: {
      url: `https://rpc.viction.xyz`,
      accounts: [privateKey],
      chainId: 88,
    },
    sepolia: {
      accounts: [privateKey as string],
      url: "https://rpc-sepolia.rockx.com/",
      chainId: 11155111,
    },
  },
  etherscan: {
    apiKey: {
      sepolia: "",
      Viction: "tomoscan2023",
      victiontestnet: "tomoscan2023",
    },
    customChains: [
      {
        network: "Viction",
        chainId: 88, // for mainnet
        urls: {
          apiURL: "https://www.vicscan.xyz/api/contract/hardhat/verify", // for mainnet
          browserURL: "https://vicscan.xyz", // for mainnet
        },
      },
      {
        network: "victiontestnet",
        chainId: 89, // for testnet
        urls: {
          apiURL:
            "https://scan-api-testnet.viction.xyz/api/contract/hardhat/verify", // for testnet
          browserURL: "https://www.testnet.vicscan.xyz", // for testnet
        },
      },
    ],
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
  gasReporter: {
    enabled: true,
    currency: "USD",
    gasPrice: 21,
  },
  typechain: {
    outDir: "./types",
    target: "ethers-v6",
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  paths: {
    artifacts: "artifacts",
    cache: "cache",
    sources: "contracts",
    tests: "test",
  },
};

export default config;
