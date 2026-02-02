# 🪙 Day 02: Assets & Standards (ERC-20, Permit, ERC-721)

Welcome to **Day 02**.

Today, you will create your first **digital assets** on the blockchain: fungible tokens (ERC-20) and NFTs (ERC-721). We will also explore advanced standards that revolutionize the user experience.

---

## 🎯 Day Objectives

| # | Topic | Description |
|---|-------|-------------|
| 1 | Setup & OpenZeppelin | Configure environment with OpenZeppelin |
| 2 | ERC-20 with Permit | Create fungible token with gasless approvals |
| 3 | ERC-721 + IPFS | Deploy NFT collection with decentralized metadata |
| 4 | Advanced Standards | Understand ERC-4626 and ERC-4337 |
| 5 | Deployment & Integration | Deploy contracts on Sepolia and verify on Etherscan |

---

## 📁 Project Structure

```
Day02_Assets_Standards/
├── README.md              ← You are here
├── SETUP.md               ← Installation instructions
├── exercises/
   ├── 01_setup_openzeppelin/
   ├── 02_erc20_permit/
   ├── 03_erc721_nft/
   ├── 04_advanced_standards/
   └── 05_deployment_integration/

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
| 01 - Setup & OpenZeppelin | ~30min |
| 02 - ERC-20 with Permit | ~1h30 |
| 03 - ERC-721 + IPFS | ~1h30 |
| 04 - Advanced Standards | ~30min |
| 05 - Deployment & Integration | ~1h30 |
| **Total** | **~5h30** |

---

## 📚 Key Concepts

### ERC-20: Fungible Tokens

Every token is identical to another. Used for:
- Cryptocurrencies (ETH, USDC)
- Governance tokens (UNI, AAVE)
- Utility tokens

### ERC-20 Permit (EIP-2612)

Gasless approvals! Instead of two transactions (approve + transferFrom), users sign a message off-chain and the protocol executes everything in one transaction.

### ERC-721: Non-Fungible Tokens

Each token is unique. Used for:
- Digital art
- Collectibles
- Game items
- Identity

### IPFS

InterPlanetary File System - decentralized storage for NFT metadata. Files are identified by their content hash (CID), ensuring immutability.

---

## 🔐 Security Focus

- Use OpenZeppelin's audited contracts
- Always use `SafeERC20` for token transfers
- Implement `ReentrancyGuard` on state-changing functions
- ERC20Permit name must match ERC20 name

---

## 📚 Resources

- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [ERC-20 Standard](https://eips.ethereum.org/EIPS/eip-20)
- [ERC-721 Standard](https://eips.ethereum.org/EIPS/eip-721)
- [EIP-2612 Permit](https://eips.ethereum.org/EIPS/eip-2612)
- [IPFS Documentation](https://docs.ipfs.io/)
- [Pinata](https://www.pinata.cloud/) - IPFS pinning service

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
