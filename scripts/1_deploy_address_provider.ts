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

  const BuzzkillAddressProvider = await ethers.getContractFactory(
    "BuzzkillAddressProvider"
  );

  // Deploy contract, for the first time deployment
  // Upgradeable contract will deploy: ProxyAdmin, TransparentUpgradeableProxy, and BuzzkillAddressProvider implementation contract
  // So it is important to set nonce properly in order to avoid nonce too low error, if error encountered, try to increase the nonce
  const buzzkillImplementationContract = await upgrades.deployImplementation(
    BuzzkillAddressProvider,
    {
      txOverrides: {
        gasLimit: "0x989680",
        nonce: nonce++,
      },
    }
  );
  
  console.log("Buzzkill Address Provider implementation contract deployed to:", buzzkillImplementationContract);

  await hre.run("verify:verify", {
    address: buzzkillImplementationContract,
    constructorArguments: [],
  });
  
  // Deploy proxy
  const buzzkillAddressProvider = await upgrades.deployProxy(
    BuzzkillAddressProvider,
    [],
    {
      txOverrides: {
        gasLimit: "0x989680",
        nonce: nonce++,
      },
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
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
