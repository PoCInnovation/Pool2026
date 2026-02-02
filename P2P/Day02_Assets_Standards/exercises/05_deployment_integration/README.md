# 🚀 Exercise 05: Deployment & Verification

## 🎯 Objective

Deploy your contracts on Sepolia and verify them on Etherscan.

---

## 📋 Prerequisites

- `.env` configured with RPC_URL and PRIVATE_KEY
- Sepolia ETH in your wallet
- PoolToken and PoolNFT contracts complete

---

## 📋 Instructions

### 5.1 Prepare Environment

```bash
source .env

# Check your balance
cast balance $YOUR_ADDRESS --rpc-url $RPC_SEPOLIA
```

---

### 5.2 Deploy PoolToken

**Direct deployment:**
```bash
forge create src/PoolToken.sol:PoolToken \
  --constructor-args 1000000000000000000000000 \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY \
  --broadcast
```

**💡 Note:** `1000000000000000000000000` = 1,000,000 tokens with 18 decimals

**Or use a deployment script:**

Create `script/DeployPoolToken.s.sol`:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/PoolToken.sol";

contract DeployPoolToken is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        uint256 initialSupply = 1_000_000 ether;  // 1M tokens
        PoolToken token = new PoolToken(initialSupply);

        console.log("PoolToken deployed at:", address(token));

        vm.stopBroadcast();
    }
}
```

Deploy with script:
```bash
forge script script/DeployPoolToken.s.sol:DeployPoolToken \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

**📝 Copy the contract address!**

---

### 5.3 Deploy PoolNFT

```bash
forge create src/PoolNFT.sol:PoolNFT \
  --constructor-args "ipfs://YOUR_CID_HERE/" \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY \
  --broadcast
```

**📝 Copy the contract address!**

---

### 5.4 Verify Contracts on Etherscan

**Option 1: Automatic (if you have API key)**
```bash
forge verify-contract <CONTRACT_ADDRESS> src/PoolToken.sol:PoolToken \
  --chain sepolia \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

**Option 2: Manual**
```bash
forge flatten src/PoolToken.sol > PoolToken.flat.sol
```

Then on Etherscan:
- Contract → Verify and Publish
- Compiler: 0.8.20, Optimization: Yes, Runs: 200, EVM: paris
- Paste flattened code

---

### 5.5 Verify Everything Works

**PoolToken:**
```bash
# Check total supply
cast call <TOKEN_ADDRESS> "totalSupply()" --rpc-url $RPC_SEPOLIA

# Check your balance
cast call <TOKEN_ADDRESS> "balanceOf(address)" $YOUR_ADDRESS --rpc-url $RPC_SEPOLIA

# Add token to MetaMask: Import tokens → Custom Token → Paste address
```

**PoolNFT:**
```bash
# Check baseURI
cast call <NFT_ADDRESS> "baseURI()" --rpc-url $RPC_SEPOLIA

# Mint a test NFT
cast send <NFT_ADDRESS> "mint(address)" $YOUR_ADDRESS \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY

# Check tokenURI
cast call <NFT_ADDRESS> "tokenURI(uint256)" 1 --rpc-url $RPC_SEPOLIA
```


---

## 🔒 Security Checklist

Before celebrating, verify these security aspects:

| Check | Status |
|-------|--------|
| Only owner can mint tokens | ✓ |
| Only owner can mint NFTs | ✓ |
| ReentrancyGuard on NFT mint | ✓ |
| ERC20Permit name matches | ✓ |
| No sensitive data on-chain | ✓ |

---

## ✅ Validation

- [ ] PoolToken deployed on Sepolia
- [ ] PoolNFT deployed on Sepolia
- [ ] Both contracts verified on Etherscan
- [ ] Token visible in MetaMask (Import tokens → Custom Token)
- [ ] NFT minted successfully via CLI
- [ ] IPFS metadata accessible

---

## 🏁 Day 02 Complete!

**Congratulations!** You have:
1. ✅ Created an ERC-20 token with Permit
2. ✅ Deployed an NFT collection with IPFS metadata
3. ✅ Understood ERC-4626 and ERC-4337
4. ✅ Deployed contracts on Sepolia and verified on Etherscan
5. ✅ Interacted with contracts via CLI (cast)

**Tomorrow:** We create a **DeFi Vault** to earn yield on your tokens! 🚀
