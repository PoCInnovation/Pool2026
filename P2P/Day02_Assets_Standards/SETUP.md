---

# 🛠️ Setup - Day 02 - Assets & Standards

Welcome to **Day 02** of the Blockchain Discovery Pool!
Today, you'll learn how to create and deploy tokens (ERC-20) and NFTs (ERC-721) on Ethereum. This setup guide will walk you through everything step by step.

## 📋 What You'll Build Today

- **ERC-20 Token** with Permit functionality (gasless approvals)
- **ERC-721 NFT Collection** with IPFS metadata
- **Deploy both contracts** to Sepolia testnet and verify on Etherscan

---

## 1. Verify Your Environment 🔍

Before we start, let's make sure everything from Day 01 is still working.

### Check Foundry Installation

Open your terminal and verify Foundry is installed:

```bash
forge --version
```

_If you see a version number, you're good! If not, go back to [Day 01 Setup](../Day01_Genesis_Tools/SETUP.md) and install Foundry._

### Check Your Project Structure

Make sure you're in your project directory. You should see:

- `foundry.toml` (configuration file)
- `src/` folder (for your contracts)
- `script/` folder (for deployment scripts)
- `test/` folder (for tests)

If you don't have a project yet, create one:

```bash
forge init my_project
cd my_project
```

---

## 2. Get Sepolia ETH (Testnet Money) 💸

To deploy contracts, you need **Sepolia ETH** (fake money for testing). Don't worry if you don't have any yet!

### Why Do You Need Sepolia ETH?

Every transaction on Ethereum costs "gas" (a small fee). On Sepolia testnet, this gas is paid with Sepolia ETH, which is free and has no real value.

### How Much Do You Need?

For today's workshop, you'll need approximately **0.01 - 0.02 Sepolia ETH** to deploy two contracts. This is very little!

### Getting Sepolia ETH from Faucets

**Option 1: Google Cloud Web3 Faucet** (Recommended - Fast & Reliable)

1. Go to: [Google Cloud Web3 Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
2. Connect your MetaMask wallet
3. Make sure you're on the **Sepolia** network in MetaMask
4. Enter your wallet address (copy it from MetaMask)
5. Click "Request Tokens"
6. Wait a few minutes - you should receive 0.5 Sepolia ETH

**Option 2: Alchemy Faucet** (recommanded)

1. Go to: [Alchemy POW Faucet](https://sepolia-faucet.pk910.de/)
2. Enter your etherum adresse
3. start mining

**Option 3: QuickNode Faucet**

1. Go to: [QuickNode Sepolia Faucet](https://faucet.quicknode.com/ethereum/sepolia)
2. Enter your wallet address
3. Complete the captcha
4. Request tokens

### ⚠️ Important Notes

- Faucets may have rate limits (you can only request once per day/hour)
- Some faucets require you to tweet or share on social media
- If one faucet doesn't work, try another!
- Always double-check you're requesting **Sepolia** ETH, not mainnet ETH

### Verify You Received Sepolia ETH

1. Open MetaMask
2. Make sure you're on the **Sepolia** network (top of MetaMask)
3. You should see your Sepolia ETH balance

---

## 3. Set Up Environment Variables 🔐

You'll need to store sensitive information (like your private key) in a `.env` file. This file should **NEVER** be committed to git!

### Create Your `.env` File

In your project root directory, create a file named `.env`:

```bash
touch .env
```

### Add Your Configuration

Open the `.env` file and add these variables (replace with your actual values):

```bash
# Sepolia RPC Endpoint (use public endpoint - no account needed!)
RPC_SEPOLIA=https://rpc.sepolia.org

# Your wallet's private key (NEVER share this!)
# To get it: MetaMask → Account Details → Export Private Key
PRIVATE_KEY=your_private_key_here_without_0x_prefix

```

### 🔒 Security Warning

- **NEVER** commit your `.env` file to git
- **NEVER** share your private key with anyone
- **NEVER** use your main wallet's private key (create a separate dev wallet!)
- Add `.env` to your `.gitignore` file

### Get a Free RPC Endpoint

You need an RPC endpoint to connect to Sepolia. Here are free options **that don't require any account**:

**Option 1: Public RPC Endpoints** (No account needed - Recommended for beginners)
You can use these public endpoints directly without signing up:

```bash
# Public Sepolia RPC (no account needed)
RPC_SEPOLIA=https://rpc.sepolia.org
```

Or use these alternatives:

- `https://ethereum-sepolia-rpc.publicnode.com` (PublicNode)
- `https://sepolia.gateway.tenderly.co` (Tenderly public gateway)
- `https://sepolia.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161` (Public Infura endpoint)

**Option 2: Create Your Own RPC Endpoint** (Optional - More reliable, requires free account)
If the public endpoints are slow or unreliable, you can create your own:

**Alchemy**:

1. Go to [Alchemy](https://www.alchemy.com/)
2. Sign up for free
3. Create a new app
4. Select "Ethereum" and "Sepolia"
5. Copy the HTTP URL (looks like `https://eth-sepolia.g.alchemy.com/v2/YOUR_KEY`)

**Infura**:

1. Go to [Infura](https://www.infura.io/)
2. Sign up for free
3. Create a new project
4. Select "Ethereum" and "Sepolia"
5. Copy the endpoint URL

> 💡 **Tip**: Start with the public RPC endpoint (`https://rpc.sepolia.org`). It's free, requires no signup, and works perfectly for learning. You can always switch to a custom endpoint later if needed.

### Get Your Etherscan API Key (Optional)

> ⚠️ **Note**: The Etherscan API key is **optional**. You only need it if you want to verify your contracts on Etherscan (which makes your code publicly readable). You can deploy contracts without it!

If you want to verify your contracts on Etherscan:

1. Go to [Etherscan](https://etherscan.io/)
2. Sign up for a free account
3. Go to [API Keys](https://etherscan.io/apis)
4. Create a new API key
5. Copy it to your `.env` file

If you skip this step, you can still deploy your contracts - they just won't be verified on Etherscan (which is fine for learning!).

### Load Environment Variables

Before running any deployment commands, load your environment variables:

```bash
source .env
```

Or if you're using a different shell:

```bash
export $(cat .env | xargs)
```

---

## 4. Install OpenZeppelin Contracts 📦

OpenZeppelin is a library of secure, tested smart contract code. We'll use it to build our ERC-20 and ERC-721 tokens.

### What is OpenZeppelin?

OpenZeppelin Contracts provides reusable, secure smart contract components. Instead of writing everything from scratch, we use their battle-tested code.

### Install the Library

In your project directory, run:

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

This will download the OpenZeppelin contracts into a `lib/` folder in your project.

### Configure Foundry Remappings

Foundry needs to know where to find OpenZeppelin contracts. We do this with "remappings".

Open your `foundry.toml` file and add this line in the `[profile.default]` section:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200
evm_version = "paris"

# Add this remapping line:
remappings = ["@openzeppelin/=lib/openzeppelin-contracts/"]
```

### What Are Remappings?

Remappings tell Foundry: "When you see `@openzeppelin/` in an import, look in `lib/openzeppelin-contracts/`". This allows us to write clean imports like:

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

Instead of:

```solidity
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
```

### Verify the Installation

Build your project to make sure everything works:

```bash
forge build
```

If you see "Compiler run successful", you're all set! 🎉

If you get errors, make sure:

- The remapping is correctly added to `foundry.toml`
- OpenZeppelin was installed successfully (check that `lib/openzeppelin-contracts/` exists)

---

## 5. (Optional) Prepare IPFS for NFTs 🌐

NFTs store their metadata (name, description, image) off-chain. We will use IPFS for decentralized storage.

### What is IPFS?

IPFS is a distributed file system. Each file gets a unique identifier (CID) that never changes.

### Create a Pinata Account (Prerequisite)

> 📌 **Note**: You don't need Pinata immediately. You can use a placeholder to start and configure Pinata when you reach Step 2 of the README (ERC-721).

1. Go to [Pinata.cloud](https://www.pinata.cloud/)
2. Sign up for free
3. Verify your email

### Quick Option: Use a Placeholder

To start quickly, you can use a placeholder:

```bash
BASE_URI="ipfs://QmPlaceholder123/"
```

You will replace this placeholder with a real CID during Step 2 of the [README.md](./README.md) where you will learn to upload your metadata to IPFS.

> 💡 **Tip**: Pinata offers a free tier perfect for learning. Detailed upload instructions are in the README, Step 2 section.

---

## 6. Plan Your Token Design 🎨

Before writing code, think about what you want to build.

### ERC-20 Token Decisions

**Token Name**: What will your token be called?

- Example: "PoolToken", "EconomyToken", "MyToken"

**Token Symbol**: Short abbreviation (usually 3-5 letters)

- Example: "POOL", "ECO", "MTK"

**Decimals**: How many decimal places? (Standard is 18)

- Example: `18` means 1 token = 1,000,000,000,000,000,000 smallest units

**Initial Supply**: How many tokens will exist?

- Example: `1,000,000` tokens minted at deployment
- Or: `0` tokens, with ability to mint later (controlled by owner)

**Minting Policy**: Who can create new tokens?

- Only the owner (you) can mint
- Or: No one can mint after deployment (fixed supply)

### ERC-721 NFT Decisions

**Collection Name**: What is your NFT collection called?

- Example: "PoolNFT", "EconomyNFT", "MyCollection"

**Collection Symbol**: Short abbreviation

- Example: "PNFT", "ECO", "MC"

**Base URI**: Your IPFS CID from step 5

- Example: `ipfs://QmAbCdEf123/`

but DONT WORRY AND PANIC everything will be explained better later

**Minting Policy**: Who can mint NFTs?

- Only the owner (you) can mint
- Or: Anyone can mint (public minting)
- Or: Only addresses with a specific role can mint

**Token ID Strategy**: How will token IDs work?

- Start at 1 and increment: `1, 2, 3, 4...`
- Or: Use a different numbering system

---

## 7. Verify Your Setup ✅

Before moving to the implementation, let's make sure everything is ready:

### Checklist

- [ ] Foundry is installed (`forge --version` works)
- [ ] You have Sepolia ETH in your wallet (check MetaMask)
- [ ] Your `.env` file is created with `RPC_SEPOLIA` and `PRIVATE_KEY`
- [ ] OpenZeppelin is installed (`lib/openzeppelin-contracts/` exists)
- [ ] Remapping is added to `foundry.toml`
- [ ] `forge build` runs successfully
- [ ] (Optional) You have an IPFS base URI ready (or use a placeholder)
- [ ] You've decided on your token names, symbols, and policies

### Test Your Environment

Run this command to make sure Foundry can find OpenZeppelin:

```bash
forge build
```

If you see any errors, go back and check:

- Is OpenZeppelin installed?
- Is the remapping correct in `foundry.toml`?
- Are you in the correct directory?

---

## 🎯 You're Ready!

Everything is set up! You now have:

- ✅ Foundry installed and configured
- ✅ Sepolia ETH for gas fees
- ✅ Environment variables configured (using public RPC - no account needed!)
- ✅ OpenZeppelin Contracts installed
- ✅ (Optional) IPFS metadata ready or placeholder
- ✅ A plan for your tokens

👉 **Next Step**: Go to the [Day 02 README](./README.md) to start implementing your ERC-20 and ERC-721 contracts!

---

## 🆘 Troubleshooting

### "forge: command not found"

- Make sure Foundry is installed (see Day 01 Setup)
- Try closing and reopening your terminal
- Run `foundryup` to update Foundry

### "Insufficient funds" error

- Check you have Sepolia ETH (not mainnet ETH)
- Make sure MetaMask is on Sepolia network
- Request more from a faucet if needed

### "Cannot find module @openzeppelin"

- Make sure you ran `forge install OpenZeppelin/openzeppelin-contracts`
- Check that `lib/openzeppelin-contracts/` exists
- Verify the remapping in `foundry.toml` is correct

### Environment variables not loading

- Make sure your `.env` file is in the project root
- Use `source .env` before running commands
- Check that there are no spaces around the `=` sign in `.env`

### IPFS metadata not showing

- If using a placeholder, this is normal - replace with a real CID later
- Verify your CID is correct (check it on Pinata)
- Make sure the JSON file is uploaded to Pinata
- Check that your base URI ends with `/`
- Verify the file structure: if you uploaded a folder, make sure the CID is the folder CID, not a file CID
- Wait a few minutes - IPFS propagation can take time
- Try accessing your metadata directly: `https://gateway.pinata.cloud/ipfs/YOUR_CID/1.json` (replace YOUR_CID with your actual CID)

### RPC endpoint errors

- Try a different public RPC endpoint from the list
- Check your internet connection
- If using a custom endpoint, verify the URL is correct

---

**Happy Building! 🚀**
