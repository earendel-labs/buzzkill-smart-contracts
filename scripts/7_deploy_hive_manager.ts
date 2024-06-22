import hre from "hardhat";
const { ethers, upgrades } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const HiveManager = await ethers.getContractFactory("HiveManager");
  // Deploy contract, for the second script, the ProxyAdmin has already been deployed
  // Then only TransparentUpgradeableProxy and GameConfig implementation contract will be deployed
  // So it is important to set nonce to +2 in order to avoid nonce too low error
  const hiveManager = await upgrades.deployProxy(
    HiveManager,
    [contracts.buzzkillAddressProvider],
    {
      txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
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

  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    hiveManagerContract
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
