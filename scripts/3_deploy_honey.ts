import hre from "hardhat";
const { ethers } = hre;

import { saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;

  const Honey = await ethers.getContractFactory("Honey");
  const honey = await Honey.deploy({ gasLimit: "0x5000000", nonce: nonce++ });

  await honey.waitForDeployment();

  const honeyContract = await honey.getAddress();

  console.log("Honey contract deployed to address:", honeyContract);

  saveContract(network, "honey", honeyContract);

  await hre.run("verify:verify", {
    address: honeyContract,
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
