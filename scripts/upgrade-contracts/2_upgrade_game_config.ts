import hre from "hardhat";

import { getContracts } from "../utils";

const { ethers, upgrades } = hre;

async function main() {
  const network = hre.network.name;
  const contracts = getContracts(network)[network];
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  const GameConfig = await hre.ethers.getContractFactory("GameConfig");
  const gameConfig = await upgrades.upgradeProxy(
    contracts.gameConfig,
    GameConfig,
    {
      txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
    }
  );
  await gameConfig.waitForDeployment();

  console.log(`Deployed Game Config to ${await gameConfig.getAddress()}`);
  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    contracts.gameConfig
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
