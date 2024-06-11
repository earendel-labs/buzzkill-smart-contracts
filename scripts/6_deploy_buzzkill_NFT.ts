import hre from "hardhat";
const { ethers } = hre;

import { getContracts, saveContract } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();
  let nonce = await deployer.getNonce();

  console.log("Deploying contract with the account:", deployer.address);

  const network = hre.network.name;
  const contracts = getContracts(network)[network];
  const MINT_FEE = ethers.parseEther("0.1");

  const BuzzkillNFT = await ethers.getContractFactory("BuzzkillNFT");
  const buzzkillNFT = await BuzzkillNFT.deploy(
    MINT_FEE,
    contracts.hiveFactory,
    contracts.buzzkillAddressProvider,
    {
      gasLimit: "0x5000000",
      nonce: nonce++,
    }
  );

  await buzzkillNFT.waitForDeployment();

  const buzzkillNFTContract = await buzzkillNFT.getAddress();

  console.log(
    "Buzzkill NFT contract deployed to address:",
    buzzkillNFTContract
  );

  saveContract(network, "buzzkillNFT", buzzkillNFTContract);

  await hre.run("verify:verify", {
    address: buzzkillNFTContract,
    constructorArguments: [
      MINT_FEE,
      contracts.hiveFactory,
      contracts.buzzkillAddressProvider,
    ],
  });

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
