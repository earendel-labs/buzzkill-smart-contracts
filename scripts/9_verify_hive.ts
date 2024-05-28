import hre from "hardhat";

import { getContracts } from "./utils";

async function main() {
  const network = hre.network.name;
  const contracts = getContracts(network)[network];

  const hiveContractAddress = "";
  const habitatId = 0;

  await hre.run("verify:verify", {
    address: hiveContractAddress,
    constructorArguments: [habitatId, contracts.buzzkillAddressProvider],
  });

  console.log("Completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
