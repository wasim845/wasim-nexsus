# Nexus Token Swap dApp

A decentralized application (dApp) built with Next.js that enables token swapping on the Nexus network. Users can swap Token A for Token B through a simple, minimal interface.

## Overview

This project demonstrates token swapping functionality on the Nexus blockchain, showcasing essential DeFi interactions like:
- Token approvals and transfers
- Wallet connection
- Transaction signing
- Balance updates
- Multi-step transactions (approve then swap)

## Prerequisites

- Node.js (v18 or higher)
- MetaMask browser extension
- NEX for gas fees
- Some amount of Token A for swapping
- A code editor (VS Code or Cursor recommended)

## Smart Contract Details

The project uses three main smart contracts:

1. TokenA Contract (`contracts/contracts/TokenA.sol`):
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor(uint256 initialSupply) ERC20("Token A", "TKNA") {
        _mint(msg.sender, initialSupply);
    }
}
```

2. TokenB Contract (`contracts/contracts/TokenB.sol`):
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenB is ERC20 {
    constructor(uint256 initialSupply) ERC20("Token B", "TKNB") {
        _mint(msg.sender, initialSupply);
    }
}
```

3. TokenSwap Contract (`contracts/contracts/TokenSwap.sol`):
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    
    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }
    
    function swap(uint256 amount) external returns (bool) {
        require(tokenA.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        require(tokenB.transfer(msg.sender, amount), "Swap failed");
        return true;
    }
}
```

The contracts are deployed at:
- TokenA: `0x5323b008cF0Fef6A7BfdA9b362a7B7b3740E9563`
- TokenB: `0xF0A92F66F90a7F03aD1ae696eB77D3E10cdfC9B8`
- TokenSwap: `0x94D3551627581CDB9DbB29eb513319751B9466dA`

## Installation & Setup

1. Clone and install dependencies:
```bash
git clone <this-repo-url>
cd nexus-swap-example
```

2. Install frontend dependencies:
```bash
cd frontend
npm install
```

3. Start the development server:
```bash
npm run dev
```

## Using the dApp

1. Connect Your Wallet:
   - Ensure MetaMask is installed
   - Click "Connect Wallet" in the dApp
   - Approve the connection in MetaMask

2. Swap Tokens:
   - View your Token A and Token B balances
   - Enter the amount of Token A you want to swap
   - Click "Swap"
   - Approve Token A spending in MetaMask
   - Confirm the swap transaction in MetaMask
   - Wait for transaction confirmations
   - See your updated balances

## Technology Stack

### Frontend
- Next.js 14 (App Router)
- TypeScript for type safety
- Tailwind CSS for styling
- ethers.js v6 for blockchain interaction
- Minimal, clean UI design

### Smart Contracts
- Solidity ^0.8.0
- OpenZeppelin contracts for ERC20 implementation
- Hardhat development environment
- Hardhat Ignition for deployments

## Common Issues & Solutions

1. Transaction Failures:
   - Ensure you have enough NEX for gas
   - Check if you have sufficient Token A balance
   - Verify that you've approved enough tokens for the swap

2. Wallet Connection Issues:
   - Try refreshing the page
   - Ensure MetaMask is unlocked
   - Clear browser cache if persistent

3. Balance Not Updating:
   - Wait for transaction confirmation
   - Refresh the page
   - Check if the transaction was successful on the blockchain explorer

## Development

### Project Structure
```
nexus-swap-example/
├── contracts/
│   ├── contracts/
│   │   ├── TokenA.sol
│   │   ├── TokenB.sol
│   │   └── TokenSwap.sol
│   └── ignition/
│       └── modules/
│           └── deploy.ts
├── frontend/
│   ├── src/
│   │   └── app/
│   │       ├── page.tsx
│   │       └── layout.tsx
│   └── lib/
│       └── deployedAddresses.json
└── README.md
```

### Local Development
1. Make code changes
2. Test contracts with `npx hardhat test`
3. Deploy to Nexus with Hardhat Ignition
4. Update `deployedAddresses.json` with new contract addresses
5. Test frontend with `npm run dev`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Open a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
