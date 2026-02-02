# 🛠️ Exercise 01: Setup & OpenZeppelin

## 🎯 Objective

Configure your environment with OpenZeppelin Contracts to use secure, audited contracts.

---

## 📖 What is OpenZeppelin?

OpenZeppelin is the **gold standard** library for smart contract development:

- ✅ Code audited by security experts
- ✅ Battle-tested by thousands of projects
- ✅ Implements official ERC standards
- ✅ Used by Uniswap, Compound, Aave, and more

**Why use it?** Don't reinvent the wheel. These contracts are more secure than anything you'd write yourself.

---

## 📋 Instructions

### 1.1 Verify Your Environment

```bash
forge --version
forge build
```

If you see "Compiler run successful", you're ready!

---

### 1.2 Configure Remapping

Open `foundry.toml` and add remappings:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200
evm_version = "paris"

# Remapping for OpenZeppelin
remappings = ["@openzeppelin/=lib/openzeppelin-contracts/"]
```

---

### 1.3 Verify Installation

```bash
forge build
```

If you see "Compiler run successful", OpenZeppelin is correctly installed! 🎉

---

## 🔧 OpenZeppelin Contracts Wizard

Before coding, explore the [Contracts Wizard](https://wizard.openzeppelin.com/):

1. Go to https://wizard.openzeppelin.com/
2. Select **ERC20** or **ERC721**
3. Check desired features (Permit, Ownable, etc.)
4. See the generated code

**💡 Tip:** Use the wizard to understand the structure, but code yourself to learn!

---

## 📚 Key OpenZeppelin Contracts

| Contract | Purpose |
|----------|---------|
| `ERC20` | Fungible tokens (like USDC) |
| `ERC721` | NFTs (unique tokens) |
| `ERC20Permit` | Gasless approvals |
| `Ownable` | Access control (owner only) |
| `ReentrancyGuard` | Prevent reentrancy attacks |
| `AccessControl` | Role-based permissions |

---

## 💡 How to Import

```solidity
// Standard ERC20
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// ERC20 with Permit
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// NFT
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Access control
import "@openzeppelin/contracts/access/Ownable.sol";

// Security
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
```

---

## ✅ Validation

- [ ] `forge build` compiles without errors
- [ ] OpenZeppelin contracts installed
- [ ] Remapping configured in `foundry.toml`
- [ ] Explored Contracts Wizard

---

➡️ **Next exercise: [02 - ERC-20 with Permit](../02_erc20_permit/)**
