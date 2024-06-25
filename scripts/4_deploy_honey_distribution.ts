import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const HoneyDistribution = await ethers.getContractFactory(
    "HoneyDistribution"
  );
  const honeyDistribution = await HoneyDistribution.deploy(
    contracts.buzzkillAddressProvider,
    { gasLimit: "0x989680", nonce: nonce++ }
  );

  await honeyDistribution.waitForDeployment();

  const honeyDistributionContract = await honeyDistribution.getAddress();

  console.log(
    "HoneyDistribution contract deployed to address:",
    honeyDistributionContract
  );

  saveContract(network, "honeyDistribution", honeyDistributionContract);

  await hre.run("verify:verify", {
    address: honeyDistributionContract,
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
