# 🚀 Exercise 03: Deployment & Blockchain Transparency

## 🎯 Objective

Deploy your `SmartContract` on Sepolia and discover that even `private` variables are visible on the blockchain!

---

## 📖 The Big Reveal

**You think `private` means hidden? Think again!**

In Solidity, `private` only means "not accessible by other contracts". All data on the blockchain is **public and readable** by anyone who knows where to look.

---

## 📋 Prerequisites

1. All your tests pass: `forge test -vvvv`
2. You have Sepolia ETH (get from faucet)
3. Your `.env` file is configured

---

## 📋 Instructions

### 3.1 Deployment Preparation

**Step 1: Get your Private Key**

- **Option A (MetaMask):** Menu → Account details → Show private key
- **Option B (From mnemonic):** 
  ```bash
  cast wallet private-key --mnemonic "your twelve words here..."
  ```

> ⚠️ **Warning:** Never share your private key!

**Step 2: Create your `.env` file:**

```ini
RPC_URL=https://ethereum-sepolia-rpc.publicnode.com
PRIVATE_KEY=your_private_key_here_without_quotes
# Optional: for automatic verification after deploy
ETHERSCAN_API_KEY=your_etherscan_api_key
```

**Step 3: Load environment variables:**

```bash
source .env
```

---

### 3.2 Deploy Your Contract

```bash
forge create src/SmartContract.sol:SmartContract \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify
```

**💡 Command breakdown:**
| Flag | Purpose |
|------|---------|
| `forge create` | Compile and deploy |
| `src/SmartContract.sol:SmartContract` | File path:ContractName |
| `--rpc-url` | Blockchain node URL |
| `--private-key` | Signs the transaction |
| `--broadcast` | Actually sends tx (without it, just simulates) |
| `--verify` | Verify the contract on Etherscan after deploy (requires `ETHERSCAN_API_KEY` in `.env`) |

**📝 Copy the deployed contract address!**

> **Note:** If you don't have an Etherscan API key, omit `--verify` and use the manual verification steps below.

---

### 3.3 Verify on Etherscan

To interact with your contract on Etherscan, you must verify it.

**Option A – Automatic (if you used `--verify`):** With `ETHERSCAN_API_KEY` set, the contract is verified right after deploy. You can skip the steps below.

**Option B – Manual:** If you didn't use `--verify`, flatten the contract and verify on Etherscan:

**Step 1: Flatten the contract:**
```bash
forge flatten src/SmartContract.sol > SmartContract.flat.sol
```

**Step 2: On Etherscan** (`https://sepolia.etherscan.io/address/<YOUR_ADDRESS>`):

1. **Contract** tab → **Verify and Publish**
2. **Compiler Type:** `Solidity (Single file)`
3. **Compiler Version:** `v0.8.20`
4. **License:** `MIT`
5. **Optimization:** `Yes`
6. **Runs:** `200`
7. **EVM Version:** `paris`
8. Paste contents of `SmartContract.flat.sol`

---

### 3.4 The Hack - Proving Transparency

Now go to the **Read Contract** tab on Etherscan.

You can see `public` variables like `halfAnswerOfLife`. But you don't see `_youAreACheater`? It's marked `private`!

**But wait... let's hack it!**

**💡 How storage works:**
Variables are stored in 32-byte "slots". We can read ANY slot!

```bash
# Try different slots (0, 1, 2, etc.)
cast storage <CONTRACT_ADDRESS> 0 --rpc-url $RPC_URL
cast storage <CONTRACT_ADDRESS> 1 --rpc-url $RPC_URL
cast storage <CONTRACT_ADDRESS> 2 --rpc-url $RPC_URL
# ... keep trying until you find -42 in hex!
```

**💡 Hint:** -42 in two's complement hex is `0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd6`

---

## 🔐 Security Lesson

**Critical takeaway:**

`private` in Solidity **doesn't mean hidden** - it only means "not accessible by other contracts via function calls".

**All data on the blockchain is public and readable!**

**NEVER store on-chain:**
- Passwords
- API keys
- Private keys
- Any sensitive data

---

## ✅ Validation

- [ ] Contract deployed on Sepolia
- [ ] Contract verified on Etherscan
- [ ] Found the "private" variable using `cast storage`
- [ ] Understand why `private` doesn't mean hidden

---

➡️ **Next exercise: [04 - Gas Optimization](../04_gas_optimization/)**
