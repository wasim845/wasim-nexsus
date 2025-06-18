# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
```

# Token Deployment Guide

This guide explains how to deploy the TokenA, TokenB, and TokenSwap contracts to the Nexus network.

## Prerequisites

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file in the contracts directory with your private key:
```
PRIVATE_KEY=your_private_key_here
```

## Deployment Steps

1. Make sure you have enough native tokens in your wallet to cover deployment costs.

2. Deploy the contracts using Hardhat Ignition:
```bash
npx hardhat ignition deploy ./ignition/modules/deploy.ts --network nexus
```

3. After deployment, Ignition will provide you with the addresses of all deployed contracts:
- TokenA
- TokenB
- TokenSwap

## Contract Verification

To verify the contracts on the Nexus network explorer:

```bash
npx hardhat verify --network nexus <TOKEN_A_ADDRESS>
npx hardhat verify --network nexus <TOKEN_B_ADDRESS>
npx hardhat verify --network nexus <TOKENSWAP_ADDRESS> <TOKEN_A_ADDRESS> <TOKEN_B_ADDRESS>
```

## Important Notes

- Keep your private key secure and never commit it to version control
- The initial supply for both tokens is set to 1 million tokens
- The TokenSwap contract is initialized with both token addresses automatically
- Make sure to have the correct RPC URL and chain ID in the hardhat.config.ts file
