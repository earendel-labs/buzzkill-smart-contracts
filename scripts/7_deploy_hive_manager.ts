import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const HiveManager = await ethers.getContractFactory("HiveManager");
  const hiveManager = await HiveManager.deploy(
    contracts.buzzkillAddressProvider,
    {
      gasLimit: "0x5000000",
      nonce: nonce++,
    }
  );

  await hiveManager.waitForDeployment();

  const hiveManagerContract = await hiveManager.getAddress();

  console.log(
    "Hive Manager contract deployed to address:",
    hiveManagerContract
  );

  saveContract(network, "hiveManager", hiveManagerContract);

  await hre.run("verify:verify", {
    address: hiveManagerContract,
    constructorArguments: [contracts.buzzkillAddressProvider],
  });

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
