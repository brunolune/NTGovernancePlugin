import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      hardfork: "london",
      // base fee of 0 allows use of 0 gas price when testing
      initialBaseFeePerGas: 0,
      // brownie expects calls and transactions to throw on revert
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
    },
    polygon_mumbai: {
      url:
        "https://polygon-mumbai.g.alchemy.com/v2/" +
        process.env.ALCHEMY_MUMBAI_KEY,
      accounts: [process.env.PRIVATE_KEY as string ],
    },
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API,
  },
  gasReporter: {
    enabled: true, //process.env.REPORT_GAS !== undefined,
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    currency: "USD",
    token: "MATIC",
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  
};

export default config;
