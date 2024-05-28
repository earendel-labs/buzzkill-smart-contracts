import hre from "hardhat";

import { getContracts } from "../utils";

const { ethers, upgrades } = hre;

async function main() {
  const network = hre.network.name;
  const contracts = getContracts(network)[network];
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  const BuzzkillAddressProvider = await hre.ethers.getContractFactory(
    "BuzzkillAddressProvider"
  );
  const buzzkillAddressProvider = await upgrades.upgradeProxy(
    contracts.buzzkillAddressProvider,
    BuzzkillAddressProvider,
    {
      txOverrides: { gasLimit: "0x5000000", nonce: nonce + 2 },
    }
  );
  await buzzkillAddressProvider.waitForDeployment();

  console.log(
    `Deployed BuzzkillAddressProvider to ${await buzzkillAddressProvider.getAddress()}`
  );
  // Get the implementation contract address from the proxy
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    contracts.buzzkillAddressProvider
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
