const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  console.log("Deploying contracts...");

  // Deploy TokenA (6-decimals)
  const TokenA = await hre.ethers.getContractFactory("TokenA");
  const tokenA = await TokenA.deploy();
  await tokenA.waitForDeployment();
  const tokenAAddress = await tokenA.getAddress();
  console.log(`TokenA deployed to: ${tokenAAddress}`);

  // Deploy TokenB (18-decimals)
  const TokenB = await hre.ethers.getContractFactory("TokenB");
  const tokenB = await TokenB.deploy();
  await tokenB.waitForDeployment();
  const tokenBAddress = await tokenB.getAddress();
  console.log(`TokenB deployed to: ${tokenBAddress}`);

  // Deploy TokenSwap
  const TokenSwap = await hre.ethers.getContractFactory("TokenSwap");
  const tokenSwap = await TokenSwap.deploy(tokenBAddress, tokenAAddress);
  await tokenSwap.waitForDeployment();
  const tokenSwapAddress = await tokenSwap.getAddress();
  console.log(`TokenSwap deployed to: ${tokenSwapAddress}`);

  // Save addresses to file
  const addresses = {
    TokenA: tokenAAddress,
    TokenB: tokenBAddress,
    TokenSwap: tokenSwapAddress,
  };

  const filePath = path.join(__dirname, "..", "deployedAddresses.json");
  fs.writeFileSync(filePath, JSON.stringify(addresses, null, 2));
  console.log(`Addresses saved to deployedAddresses.json`);
}

main().catch((error) => {
  console.error("Deployment failed:", error);
  process.exitCode = 1;
});
