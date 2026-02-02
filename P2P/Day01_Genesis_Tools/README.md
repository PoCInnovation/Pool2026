# 🌊 Day 01: Genesis & Solidity Basics

Welcome to **Day 01**.

Today, we're not just going to "make code work". We're going to dissect the Solidity language and understand how the Blockchain stores your data.

---

## 🎯 Day Objectives

| # | Topic | Description |
|---|-------|-------------|
| 1 | Basics | Learn Solidity syntax and fundamental concepts |
| 2 | Profile System | Create a complete user profile system |
| 3 | Deployment | Deploy and discover blockchain transparency |
| 4 | Gas Optimization | Optimize your contracts to reduce fees |
| 5 | CLI Interaction | Interact with your contracts via terminal |

---

## 📁 Project Structure

```
Day01_Genesis_Tools/
├── README.md              ← You are here
├── SETUP.md               ← Installation instructions
├── exercises/
   ├── 01_basics/         ← Basic Solidity syntax
   ├── 02_profile_system/ ← Profile system (practical exercise)
   ├── 03_deployment/     ← Deployment & transparency
   ├── 04_gas_optimization/
   └── 05_cli_interaction/

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
| 01 - Basics | ~2h |
| 02 - Profile System | ~1h30 |
| 03 - Deployment | ~1h |
| 04 - Gas Optimization | ~45min |
| 05 - CLI Interaction | ~45min |
| **Total** | **~6h** |

---

## 📚 Key Concepts You'll Learn

### Variables & Visibility
- `public`, `private`, `internal`, `external`
- Basic types: `uint256`, `int256`, `address`, `bool`, `string`
- Advanced types: `mapping`, `array`, `struct`, `enum`

### Functions
- `view` - reads state, doesn't modify
- `pure` - no state access
- `payable` - can receive ETH
- Modifiers for access control

### Security Patterns
- Custom errors (gas efficient)
- Events for logging
- Modifiers for access control
- CEI pattern (Checks-Effects-Interactions)

### Tools
- Foundry (forge, cast)
- Deployment to Sepolia
- Contract verification on Etherscan

---

## 🔐 Important Security Lesson

**`private` in Solidity does NOT mean hidden!**

All blockchain data is public. `private` only means "not accessible by other contracts via function calls". Anyone can read your "private" variables using storage inspection tools.

**Never store on-chain:**
- Passwords
- API keys
- Private keys
- Any sensitive data

---

## 📚 Resources

- [Solidity by Example](https://solidity-by-example.org/)
- [Foundry Book](https://book.getfoundry.sh/)
- [Etherscan](https://etherscan.io/)
- [Sepolia Faucet](https://sepoliafaucet.com/)

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
