import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const HiveFactory = await ethers.getContractFactory("HiveFactory");
  const hiveFactory = await HiveFactory.deploy(
    contracts.buzzkillAddressProvider,
    {
      gasLimit: "0x5000000",
      nonce: nonce++,
    }
  );

  await hiveFactory.waitForDeployment();

  const hiveFactoryContract = await hiveFactory.getAddress();

  console.log(
    "Hive Factory contract deployed to address:",
    hiveFactoryContract
  );

  saveContract(network, "hiveFactory", hiveFactoryContract);

  await hre.run("verify:verify", {
    address: hiveFactoryContract,
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
