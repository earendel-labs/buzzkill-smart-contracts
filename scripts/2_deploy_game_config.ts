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
  // So it is important to set nonce properly in order to avoid nonce too low error, if error encountered, try to increase the nonce
  const gameConfigImplementationContract = await upgrades.deployImplementation(
    GameConfig,
    {
      txOverrides: {
        gasLimit: "0x989680",
        nonce: nonce++,
      },
    }
  );

  console.log(
    "Game Config implementation contract deployed to:",
    gameConfigImplementationContract
  );

  await hre.run("verify:verify", {
    address: gameConfigImplementationContract,
    constructorArguments: [],
  });

  // Deploy proxy
  const gameConfig = await upgrades.deployProxy(GameConfig, [], {
    txOverrides: { gasLimit: "0x989680", nonce: nonce++ },
  });

  await gameConfig.waitForDeployment();

  const gameConfigContract = await gameConfig.getAddress();

  saveContract(network, "gameConfig", gameConfigContract);
  console.log("Game Config contract deployed to:", gameConfigContract);

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
