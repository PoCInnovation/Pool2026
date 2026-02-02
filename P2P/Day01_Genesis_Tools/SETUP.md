***

# 🛠️ Setup - The Builder's Toolkit

Welcome to the **Blockchain Discovery Pool**.
To build on Ethereum, you need a specific set of tools. Follow this guide carefully to ensure a smooth experience throughout the week.

## 1. Prerequisites (Git & Node)

Before installing Foundry, ensure you have the basics.

- **Git**: [Download Git](https://git-scm.com/downloads)

Check if Git is installed:
```bash
git --version
```

---

## 2. Install Foundry (The Forge) 🔨

[Foundry](https://book.getfoundry.sh/) is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust. It allows you to compile, test, and deploy smart contracts.

### For Mac & Linux
Open your terminal and run:
```bash
curl -L https://foundry.paradigm.xyz | bash
```

### For Windows
You must use **Git Bash** (installed with Git) or **WSL** (Windows Subsystem for Linux) to run the command above. PowerShell might work but is not recommended for beginners.

### ⚠️ Critical Step: Activate Foundry
After the installation, the terminal might tell you to run a command to update your PATH (like `source /...`).
**If you are unsure, simply close your terminal and open a new one.**

Then, finalize the installation by running:
```bash
foundryup
```

Verify the installation:
```bash
forge --version
```
*If it prints a version, you are good to go!*

---

## 3. VS Code Configuration 💻

We strongly recommend **Visual Studio Code**. To make Solidity development pleasant, install these extensions:

1.  **Solidity by Nomic Foundation** (Syntax highlighting & formatting)
    *   [Link to Extension](https://marketplace.visualstudio.com/items?itemName=NomicFoundation.hardhat-solidity)
2.  **Even Better TOML** (To edit `foundry.toml` config files easily)
    *   [Link to Extension](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)

### Auto-Formatting
To have clean code automatically when you save, create a specific configuration:

1.  Create a folder `.vscode` at the root of your project.
2.  Create a file `settings.json` inside.
3.  Paste this content:

```json
{
  "editor.formatOnSave": true,
  "[solidity]": {
    "editor.defaultFormatter": "NomicFoundation.hardhat-solidity"
  },
  "solidity.formatter": "prettier" 
}
```

---

## 4. Wallet & Money 💸

You need a digital wallet to interact with the blockchain.

### Install a Wallet
We recommend **MetaMask** (the standard).
- [Download MetaMask](https://metamask.io/)

> 🛡️ **Security Rule**: Create a **NEW** account inside your wallet dedicated to development. Never use your main account with real money for this pool.

### Get Testnet ETH (Sepolia)
We work on the **Sepolia** network. It uses fake money, but you need to claim it from a "Faucet".
Claim your funds now (it can take time):

1.  **Google Cloud Web3 Faucet** (Fast & Reliable): [Claim here](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
2.  **Alchemy Faucet** (Requires login): [Claim here](https://www.alchemy.com/faucets/ethereum-sepolia)

---

## 5. Create your Project

You are ready to start. Here is how to create a generic Foundry project:

```bash
forge init my_project
cd my_project
```

### Configure Solidity Version
Open the `foundry.toml` file in the root directory and ensure the configuration matches our pool requirements (0.8.20 is stable and supports modern features):

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200
evm_version = "paris"
```

### Dealing with dependencies (OpenZeppelin)
Later in the week, we will use standard libraries (ERC20, ERC721). In Foundry, we install them like this:

```bash
forge install OpenZeppelin/openzeppelin-contracts
```
*Note: The `--no-commit` flag prevents Foundry from creating a git submodule commit automatically, which is often cleaner for beginners.*

---

## Back to the workshop

Everything is ready?
👉 [Go to Day 01](./README.md)