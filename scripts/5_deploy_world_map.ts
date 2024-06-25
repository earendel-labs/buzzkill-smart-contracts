import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const WorldMap = await ethers.getContractFactory("WorldMap");
  const worldMap = await WorldMap.deploy(contracts.buzzkillAddressProvider, {
    gasLimit: "0x989680",
    nonce: nonce++,
  });

  await worldMap.waitForDeployment();

  const worldMapContract = await worldMap.getAddress();

  console.log("WorldMap contract deployed to address:", worldMapContract);

  saveContract(network, "worldMap", worldMapContract);

  await hre.run("verify:verify", {
    address: worldMapContract,
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
