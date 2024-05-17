import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-contract-sizer";

import "dotenv/config";

const privateKey = process.env.PRIVATE_KEY || "";
const ethApiKey = process.env.ETHEREUM_API_KEY || "";

const config: HardhatUserConfig = {
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
      gasPrice: 1000000000,
      timeout: 20000,
    },
    viction: {
      url: `https://rpc.viction.xyz`,
      accounts: [privateKey],
      chainId: 88,
    },
  },
  etherscan: {
    apiKey: ethApiKey,
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
