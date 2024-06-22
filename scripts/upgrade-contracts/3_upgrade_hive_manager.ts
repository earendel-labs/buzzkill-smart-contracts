import hre from "hardhat";

import { getContracts } from "../utils";

const { ethers, upgrades } = hre;

async function main() {
  const network = hre.network.name;
  const contracts = getContracts(network)[network];
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  const HiveManager = await hre.ethers.getContractFactory("HiveManager");
  const hiveManager = await upgrades.upgradeProxy(
    contracts.hiveManager,
    HiveManager,
    {
      txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
    }
  );
  await hiveManager.waitForDeployment();

  console.log(`Deployed Game Config to ${await hiveManager.getAddress()}`);
  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    contracts.hiveManager
  );
  console.log("Implementation contract address:", implementationAddress);

  await hre.run("verify:verify", {
    address: implementationAddress,
    constructorArguments: [],
  });
  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
