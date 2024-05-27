import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-ignition-ethers";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-contract-sizer";
require("dotenv").config();

const privateKey = process.env.PRIVATE_KEY || "";

interface ExtendedHardhatUserConfig extends HardhatUserConfig {
  etherscan?: {
    apiKey: string;
  };
  gasReporter: {
    enabled: boolean;
    currency: string;
    gasPrice: number;
  };
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
    apiKey: "tomoscan2023",
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
};

export default config;
