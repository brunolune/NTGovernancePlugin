import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const getNTTokenVotingSetup = await ethers.getContractFactory("NTTokenVotingSetup");
  const NTTokenVotingSetup = await getNTTokenVotingSetup.deploy();

  await NTTokenVotingSetup.deployed();

  console.log("NTTokenVotingSetup address:", NTTokenVotingSetup.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

//Deployments and verifications:
/* (base) bruno@gram:~/Documents/Aragon/NTGovernancePlugin$ npx hardhat run --network polygon_mumbai  scripts/deploy_ntgovernance.ts
Deploying contracts with the account: 0xE60930Dd528485BA57F4a17b02209877C2A9bFaC
Account balance: 4643869941725654359
NTTokenVotingSetup address: 0x4A0862795A79302FB102d5dba42ed7160a6AB08b */

//npx hardhat verify --contract 'contracts/NTTokenVotingSetup.sol:NTTokenVotingSetup' --network polygon_mumbai "0x4A0862795A79302FB102d5dba42ed7160a6AB08b"
//-> Successfully verified contract NTTokenVotingSetup on Etherscan.
//   https://mumbai.polygonscan.com/address/0x4A0862795A79302FB102d5dba42ed7160a6AB08b#code
//npx hardhat verify --contract 'contracts/NTGovernanceERC20.sol:NTGovernanceERC20' --network polygon_mumbai "0xb4B6296383B72d2Df461601E42787b8edD698BcA" --constructor-args 'scripts/NTGovernanceERC20-args.js'
//-> Successfully verified contract NTGovernanceERC20 on Etherscan.
//   https://mumbai.polygonscan.com/address/0xb4B6296383B72d2Df461601E42787b8edD698BcA#code