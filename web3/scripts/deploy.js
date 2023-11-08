const hre = require("hardhat");

async function main() {
  //Staking Contract

  const tokenStaking = await hre.ethers.deployContract("TokenStaking");
  await tokenStaking.waitForDeployment();

  //Token CONTRACT
  const theblockchaincoders = await hre.ethers.deployContract("Theblockchaincoders");
  await theblockchaincoders.waitForDeployment();

  //Contract Address
  console.log(` STACKING: ${tokenStaking.target}`);
  console.log(` TOKEN: ${theblockchaincoders.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
