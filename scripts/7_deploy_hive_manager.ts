import hre from "hardhat";
const { ethers, upgrades } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log(
    "Deploying contract with the account:",
    await deployer.getAddress()
  );

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const HiveManager = await ethers.getContractFactory("HiveManager");
  // Deploy contract, for the second script, the ProxyAdmin has already been deployed
  // Then only TransparentUpgradeableProxy and GameConfig implementation contract will be deployed
  // So it is important to set nonce properly in order to avoid nonce too low error
  const hiveManagerImplementationContract = await upgrades.deployImplementation(
    HiveManager,
    {
      txOverrides: {
        gasLimit: "0x989680",
        nonce: nonce++,
      },
    }
  );

  console.log(
    "Hive Manager implementation contract deployed to:",
    hiveManagerImplementationContract
  );

  await hre.run("verify:verify", {
    address: hiveManagerImplementationContract,
    constructorArguments: [],
  });

  // Deploy proxy
  const hiveManager = await upgrades.deployProxy(
    HiveManager,
    [contracts.buzzkillAddressProvider],
    {
      txOverrides: { gasLimit: "0x989680", nonce: nonce++ },
    }
  );

  await hiveManager.waitForDeployment();

  const hiveManagerContract = await hiveManager.getAddress();

  console.log(
    "Hive Manager contract deployed to address:",
    hiveManagerContract
  );

  saveContract(network, "hiveManager", hiveManagerContract);

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
