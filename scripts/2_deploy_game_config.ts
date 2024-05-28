import hre from "hardhat";

import { saveContract } from "./utils";

const { ethers, upgrades } = hre;

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log(
    "Deploying contract with the account:",
    await deployer.getAddress()
  );

  const network = hre.network.name;

  const GameConfig = await ethers.getContractFactory("GameConfig");

  // Deploy contract, for the second script, the ProxyAdmin has already been deployed
  // Then only TransparentUpgradeableProxy and GameConfig implementation contract will be deployed
  // So it is important to set nonce to +2 in order to avoid nonce too low error
  const gameConfig = await upgrades.deployProxy(GameConfig, [], {
    txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
  });

  await gameConfig.waitForDeployment();

  const gameConfigContract = await gameConfig.getAddress();

  saveContract(network, "gameConfig", gameConfigContract);
  console.log("Game Config contract deployed to:", gameConfigContract);

  console.log("Completed!");

  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    gameConfigContract
  );
  console.log("Implementation contract address:", implementationAddress);

  await hre.run("verify:verify", {
    address: implementationAddress,
    constructorArguments: [],
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
