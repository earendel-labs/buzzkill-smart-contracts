import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  // Setting contract addresses for BuzzkillAddressProvider
  const BuzzkillAddressProvider = await ethers.getContractFactory(
    "BuzzkillAddressProvider"
  );

  const buzzkillAddressProvider = BuzzkillAddressProvider.attach(
    contracts.buzzkillAddressProvider
  ) as any;

  await buzzkillAddressProvider.setHoneyAddress(contracts.honey, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting honey address success!");
  await buzzkillAddressProvider.setHiveManagerAddress(contracts.hiveManager, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting hive manager address success!");
  await buzzkillAddressProvider.setWorldMapAddress(contracts.worldMap, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting world map address success!");
  await buzzkillAddressProvider.setBuzzkillNFTAddress(contracts.buzzkillNFT, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting buzzkill NFT address success!");
  await buzzkillAddressProvider.setHoneyDistributionAddress(
    contracts.honeyDistribution,
    { gasLimit: "0x5000000", nonce: nonce++ }
  );
  console.log("Setting honey distribution address success!");
  await buzzkillAddressProvider.setGameConfigAddress(contracts.gameConfig, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting game config address success!");

  console.log("Setting all contract addresses completed!");

  // Setting controller for Honey contract
  const Honey = await ethers.getContractFactory("Honey");
  const honey = Honey.attach(contracts.honey) as any;

  await honey.setController(contracts.honeyDistribution, true, {
    gasLimit: "0x5000000",
    nonce: nonce++,
  });
  console.log("Setting controller for Honey contract completed!");

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
