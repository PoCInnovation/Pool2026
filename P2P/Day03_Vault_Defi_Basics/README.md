# 🏦 Day 03: The Vault - DeFi Basics

Welcome to **Day 03**.

Today you'll build a **DeFi Vault** - the foundation of protocols like Yearn Finance, Aave, and Compound.

---

## 🎯 Day Objectives

| # | Topic | Description |
|---|-------|-------------|
| 1 | Shares | Understand the asset/share relationship |
| 2 | Deposit & Withdraw | Implement secure deposit/withdrawal |
| 3 | Rewards | Add yield distribution |
| 4 | Security | Protect against reentrancy attacks |
| 5 | DeFi Integration | Connect to Uniswap for auto-compound |

---

## 📁 Project Structure

```
Day03_Vault_Defi_Basics/
├── README.md              ← You are here
├── SETUP.md               ← Installation instructions
├── exercises/
   ├── 01_shares/         ← Share exercises
   ├── 02_deposit_withdraw/
   ├── 03_rewards/
   ├── 04_security/
   └── 05_defi_integration/
```

---

## 🚀 How to Work

1. **Read SETUP.md** to configure your environment
2. **Do exercises in order** (01 → 02 → 03 → 04 → 05)
3. **Test** with `forge test`

---

## ⏱️ Estimated Time

| Exercise | Duration |
|----------|----------|
| 01 - Shares | ~1h |
| 02 - Deposit & Withdraw | ~1h30 |
| 03 - Rewards | ~1h |
| 04 - Security | ~1h |
| 05 - DeFi Integration | ~1h30 |
| **Total** | **~6h** |

---

## 📚 Key Concepts

### The Share System

Users don't keep their tokens directly - they receive **shares** representing vault ownership.

```
shares = (assets × totalShares) / totalAssets
assets = (shares × totalAssets) / totalShares
```

### CEI Pattern (Checks-Effects-Interactions)

Essential for security:
1. **Checks** - Validate inputs
2. **Effects** - Update state
3. **Interactions** - External calls

### ReentrancyGuard

Prevents attackers from calling your function recursively during transfers.

---

## 🔐 Security Focus

The Vault holds user funds: **90% of DeFi hacks target vaults**. 

Key protections:
- `nonReentrant` modifier on all state-changing functions
- CEI pattern (update state before transfers)
- SafeERC20 for token transfers
- Input validation

---

## 📚 Resources

- [OZ ReentrancyGuard](https://docs.openzeppelin.com/contracts/latest/api/security#ReentrancyGuard)
- [Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)
- [EIP-4626 Tokenized Vault](https://eips.ethereum.org/EIPS/eip-4626)

---

## Authors

| [<img src="https://github.com/L3yserEpitech.png?size=85" width=85><br><sub>jules lordet</sub>](https://github.com/L3yserEpitech) | [<img src="https://github.com/AurelienDEMEUSY.png?size=85" width=85><br><sub>aurelien demeusy</sub>](https://github.com/AurelienDEMEUSY) |
| :------------------------------------------------------------------------------------------------------------------: |:------------------------------------------------------------------------------------------------------------------: |

<h2 align=center>
Organization
</h2>
<br/>
<p align='center'>
    <a href="https://www.linkedin.com/company/pocinnovation/mycompany/">
        <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white">
    </a>
    <a href="https://www.instagram.com/pocinnovation/">
        <img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white">
    </a>
    <a href="https://twitter.com/PoCInnovation">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white">
    </a>
    <a href="https://discord.com/invite/Yqq2ADGDS7">
        <img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white">
    </a>
</p>
<p align=center>
    <a href="https://www.poc-innovation.fr/">
        <img src="https://img.shields.io/badge/WebSite-1a2b6d?style=for-the-badge&logo=GitHub Sponsors&logoColor=white">
    </a>
</p>

> :rocket: Follow us on our different social networks, and put a star 🌟 on `PoC's` repositories.
