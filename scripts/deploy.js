const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contract with account:", deployer.address);

  const SimpleLottery = await hre.ethers.getContractFactory("SimpleLottery");
  const lottery = await SimpleLottery.deploy();

  await lottery.deployed();

  console.log("SimpleLottery deployed to:", lottery.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
