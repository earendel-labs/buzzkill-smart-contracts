import hre from "hardhat";

import { saveContract } from "./utils";

const { ethers, upgrades } = hre;

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contracts with the account:", deployer.getAddress());

  const network = hre.network.name;

  const BuzzkillAddressProvider = await ethers.getContractFactory(
    "BuzzkillAddressProvider"
  );

  // Deploy contract
  const buzzkillAddressProvider = await upgrades.deployProxy(
    BuzzkillAddressProvider,
    [],
    {
      txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
    }
  );
  await buzzkillAddressProvider.waitForDeployment();
  const buzzkillAddressProviderContract =
    await buzzkillAddressProvider.getAddress();
  saveContract(
    network,
    "buzzkillAddressProvider",
    buzzkillAddressProviderContract
  );
  console.log(
    "Buzzkill Address Provider contract deployed to:",
    buzzkillAddressProviderContract
  );

  console.log("Completed!");

  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    buzzkillAddressProviderContract
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
