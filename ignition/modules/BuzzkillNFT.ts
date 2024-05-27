import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const BuzzkillNFTModule = buildModule("BuzzkillNFTModule", (m) => {
  const buzzkillNFT = m.contract("BuzzkillNFT", [
    1_000_000_000,
    "0x7aB75B488807E6c15F6f5B80279898B52E323B68",
    "0x7aB75B488807E6c15F6f5B80279898B52E323B68",
  ]);

  console.log(buzzkillNFT);

  return { buzzkillNFT };
});

export default BuzzkillNFTModule;
