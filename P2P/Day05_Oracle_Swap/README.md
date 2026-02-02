# 🔮 Day 05: The Oracle Swap

Welcome to **Day 05** - the final day!

Today you'll build a **DEX Swap** integrating **Chainlink oracles** for real-world price data.

---

## 🎯 Day Objectives

| # | Topic | Description |
|---|-------|-------------|
| 1 | Chainlink Basics | Understand oracles and price feeds |
| 2 | Price Feed Integration | Integrate ETH/USD oracle |
| 3 | Swap Logic | Implement swap calculations |
| 4 | Security | Handle stale data and protection |
| 5 | Frontend Integration | Connect contract to frontend |

---

## 📁 Project Structure

```
Day05_Oracle_Swap/
├── README.md              ← You are here
├── SETUP.md               ← Installation instructions
├── exercises/
   ├── 01_chainlink_basics/      ← Understanding oracles
   ├── 02_price_feed/            ← Integrating price feed
   ├── 03_swap_logic/            ← Swap logic
   ├── 04_security/              ← Security & stale data
   └── 05_front_integration/     ← Frontend integration
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
| 01 - Chainlink Basics | ~45min |
| 02 - Price Feed | ~1h |
| 03 - Swap Logic | ~1h30 |
| 04 - Security | ~1h |
| 05 - Frontend Integration | ~1h30 |
| **Total** | **~6h** |

---

## 📚 Key Concepts

### What is an Oracle?

An oracle bridges blockchain and real-world data. Smart contracts can't access the internet, so oracles fetch external data (prices, weather, etc.) and put it on-chain.

### Chainlink Price Feeds

Chainlink aggregates prices from multiple sources to prevent manipulation:
- Multiple data providers
- Decentralized node operators
- On-chain verification

### Key Security Considerations

- **Stale data**: Verify price freshness with `updatedAt`
- **Invalid data**: Check for zero/negative prices
- **Circuit breaker**: Ability to pause if oracle fails

---

## 🔐 Security Focus

Oracle manipulation leads to unfair swaps. Key protections:

- Always verify `updatedAt` timestamp
- Set reasonable `staleThreshold`
- Check price validity (> 0)
- Implement pause functionality
- Use `nonReentrant` on swap functions

---

## 📚 Resources

- [Chainlink Data Feeds](https://docs.chain.link/data-feeds)
- [Sepolia Feed Addresses](https://docs.chain.link/data-feeds/price-feeds/addresses)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [DeFi Llama](https://defillama.com/)

---

**Good luck! 🚀**

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
