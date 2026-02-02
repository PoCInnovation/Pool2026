# 📖 Exercise 04: Advanced Standards (Theory)

## 🎯 Objective

Understand two standards that will be crucial for the following days.

---

## 📚 ERC-4626: Tokenized Vault

### What is it?

A standard for **vaults** (safes) that tokenize deposited assets. Each deposit generates **shares** representing vault ownership.

### How it works

```
Alice deposits 100 USDC → Receives 100 shares (1:1 ratio at start)
Bob deposits 100 USDC   → Receives 100 shares

Vault now holds: 200 USDC, 200 shares total

The vault earns 10% yield...

Vault now holds: 220 USDC, still 200 shares
Each share is now worth: 220/200 = 1.1 USDC

Alice withdraws her 100 shares → Gets 110 USDC! 🎉
```

### Key Functions

| Function | Purpose |
|----------|---------|
| `deposit(assets)` | Deposit tokens, receive shares |
| `withdraw(shares)` | Burn shares, receive tokens |
| `previewDeposit(assets)` | Preview how many shares you'll get |
| `previewWithdraw(shares)` | Preview how many tokens you'll get |
| `convertToShares(assets)` | Calculate shares for asset amount |
| `convertToAssets(shares)` | Calculate assets for share amount |

### Why it matters

- **Standardization** of DeFi vaults
- **Interoperability** between protocols
- You'll use it on **Day 03** to create your own vault!

### Resources
- [EIP-4626](https://eips.ethereum.org/EIPS/eip-4626)

---

## 📚 ERC-4337: Account Abstraction

### What is it?

A standard to create **smart wallets** without modifying the Ethereum protocol.

### The Problem

Traditional wallets (EOA - Externally Owned Account):
- Controlled by a private key
- Need ETH to pay gas
- Lose key = lose everything
- No account recovery

### The Solution: Smart Wallets

Wallets controlled by smart contracts:
- Custom logic (multi-sig, time locks)
- Pay gas in tokens (not just ETH)
- Social recovery options
- Batch transactions

### Key Components

| Component | Purpose |
|-----------|---------|
| **EntryPoint** | Single entry for all transactions |
| **Bundler** | Groups multiple operations |
| **Paymaster** | Can pay gas for users |
| **Smart Wallet** | Contract-controlled account |

### Why it matters

- **Better UX** - no need for ETH to start
- **Account recovery** - social recovery possible
- **Flexibility** - custom security logic
- You might use it on **Day 04/05**!

### Resources
- [EIP-4337](https://eips.ethereum.org/EIPS/eip-4337)

---

## 📝 Comprehension Questions

Answer these to verify understanding:

**ERC-4626:**
1. What happens to the share/asset ratio when the vault earns yield?
2. Why is standardization important for DeFi?
3. If a vault has 1000 USDC and 500 shares, what is each share worth?

**ERC-4337:**
1. What's the difference between EOA and Smart Wallet?
2. What is a Paymaster?
3. Why would a user want to pay gas in tokens instead of ETH?

---

## ✅ Validation

- [ ] Understand share/asset ratio in ERC-4626
- [ ] Understand how ratio changes with yield
- [ ] Know the difference between EOA and Smart Wallet
- [ ] Understand the role of Paymaster

> 💡 **Note:** You don't need to implement these standards today. Understanding the concepts is enough. You'll use them in the following days!

---

➡️ **Next exercise: [05 - Deployment & Integration](../05_deployment_integration/)**
