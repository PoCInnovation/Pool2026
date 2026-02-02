# 📖 Exercise 05: Frontend Integration

---

## 🎯 Objective

Deploy the contract on Sepolia and connect it to the frontend.

---

## ✏️ Exercise 5.1: Create the Token

The Swap distributes an ERC-20 token. Let's create a simple one.

Create `src/Token.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

---

## ✏️ Exercise 5.2: Deployment Script

Create `script/DeploySwap.s.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Swap.sol";
import "../src/Token.sol";

contract DeploySwap is Script {
    
    // ETH/USD Price Feed on Sepolia
    address constant SEPOLIA_ETH_USD = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy the token
        Token token = new Token("SwapToken", "SWAP", 1_000_000 ether);
        console.log("Token:", address(token));

        // 2. Deploy the Swap
        Swap swap = new Swap(
            SEPOLIA_ETH_USD,
            address(token),
            18,              // tokenDecimals
            1e18,            // tokenPrice = $1
            3600             // staleThreshold = 1h
        );
        console.log("Swap:", address(swap));

        // 3. Send liquidity to Swap
        token.transfer(address(swap), 100_000 ether);
        console.log("Liquidity added: 100,000 tokens");

        vm.stopBroadcast();
    }
}
```

---

## ✏️ Exercise 5.3: Local Test Deployment

Test locally first:

```bash
# Terminal 1: Start local node
anvil

# Terminal 2: Deploy
forge script script/DeploySwap.s.sol --rpc-url http://localhost:8545 --broadcast
```

---

## ✏️ Exercise 5.4: Deploy to Sepolia

```bash
# Create .env file
echo "PRIVATE_KEY=your_private_key" > .env
echo "RPC_SEPOLIA=https://ethereum-sepolia-rpc.publicnode.com" >> .env

# Load variables
source .env

# Deploy
forge script script/DeploySwap.s.sol \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

---

## ✏️ Exercise 5.5: Frontend Configuration

Note deployed addresses and create config:

**JavaScript/TypeScript:**
```typescript
// config.ts
export const SWAP_CONFIG = {
  SWAP_ADDRESS: "0x...",        // Swap address
  TOKEN_ADDRESS: "0x...",       // Token address
  CHAIN_ID: 11155111,           // Sepolia
  
  SWAP_ABI: [
    "function swap() external payable returns (uint256)",
    "function previewSwap(uint256) external view returns (uint256, uint256)",
    "function getCurrentPrice() external view returns (uint256, bool, uint256)",
    "function getTokenLiquidity() external view returns (uint256)"
  ]
};
```

**React/ethers.js example:**
```typescript
import { ethers } from "ethers";
import { SWAP_CONFIG } from "./config";

const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();

const swap = new ethers.Contract(
  SWAP_CONFIG.SWAP_ADDRESS,
  SWAP_CONFIG.SWAP_ABI,
  signer
);

// Preview swap
const [tokensOut] = await swap.previewSwap(ethers.parseEther("0.01"));
console.log("You'll receive:", ethers.formatEther(tokensOut), "tokens");

// Execute swap
const tx = await swap.swap({ value: ethers.parseEther("0.01") });
await tx.wait();
```

---

## ✏️ Exercise 5.6: Test the Swap with CLI

```bash
# See current price
cast call $SWAP_ADDRESS "getCurrentPrice()" --rpc-url $RPC_SEPOLIA

# Preview a swap of 0.01 ETH
cast call $SWAP_ADDRESS "previewSwap(uint256)" 10000000000000000 --rpc-url $RPC_SEPOLIA

# Execute a swap
cast send $SWAP_ADDRESS "swap()" \
  --value 0.01ether \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY

# Check your token balance
cast call $TOKEN_ADDRESS "balanceOf(address)" $YOUR_ADDRESS --rpc-url $RPC_SEPOLIA
```

---

## ✅ Checklist

- [ ] Token deployed
- [ ] Swap deployed with liquidity
- [ ] `getCurrentPrice()` works
- [ ] `swap()` works with small amount
- [ ] Frontend config ready

---

## 🏆 Congratulations!

You have built a **complete DEX swap** with:

- ✅ Chainlink oracle integration
- ✅ Decimal conversion
- ✅ Stale data protection
- ✅ Circuit breaker
- ✅ Sepolia deployment
- ✅ Frontend integration

This is the foundation of protocols like **Chainlink-powered DeFi**! 🎉

---

## 📚 What You've Learned This Week

| Day | Topic | Key Skills |
|-----|-------|------------|
| 1 | Genesis | Solidity basics, testing, deployment |
| 2 | Assets | ERC-20, ERC-721, OpenZeppelin |
| 3 | DeFi | Vaults, shares, rewards |
| 4 | DAO | Governance, voting, proposals |
| 5 | Oracles | Price feeds, swaps, security |

**You are now a blockchain developer!** 🚀
