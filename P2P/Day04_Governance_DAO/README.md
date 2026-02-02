# 🗳️ Day 04: Governance (The DAO)

Welcome to **Day 04**.

Today, we will make your protocol **decentralized**. Instead of YOU (the owner) deciding the Vault parameters, token holders will vote.

---

## 🎯 Day Objectives

| # | Topic | Description |
|---|-------|-------------|
| 1 | ERC20Votes | Add voting capabilities to token |
| 2 | Governor | Create the governance contract |
| 3 | Vault Governance | Prepare Vault to be controlled by DAO |
| 4 | Proposals & Voting | Create and vote on proposals |
| 5 | Deployment | Deploy the full governance system on Sepolia |

---

## 📁 Project Structure

```
Day04_Governance_DAO/
├── README.md              ← You are here
├── SETUP.md               ← Installation instructions
├── exercises/
│   ├── 01_erc20_votes/    ← Token with voting power
│   ├── 02_governor/       ← Governor contract
│   ├── 03_vault_governance/
│   ├── 04_proposals_voting/
│   └── 05_deployment_integration/
```

---

## 🚀 How to Work

1. **Read SETUP.md** to configure your environment
2. **Do exercises in order** (01 → 02 → 03 → 04 → 05)
3. **Test** with `forge test`
4. **Check your answers** with correction (only after trying!)

---

## ⏱️ Estimated Time

| Exercise | Duration |
|----------|----------|
| 01 - ERC20Votes | ~1h |
| 02 - Governor | ~1h30 |
| 03 - Vault Governance | ~1h |
| 04 - Proposals & Voting | ~1h30 |
| 05 - Deployment | ~1h |
| **Total** | **~6h** |

---

## 📚 Key Concepts

### The Flash Loan Voting Problem

**Attack scenario:**
1. Alice wants to pass a malicious proposal
2. She borrows 1 million tokens via a flash loan
3. She votes with 1 million votes
4. She repays the flash loan in the same transaction
5. → Result: She influenced the vote without owning tokens!

**Solution: Checkpoints (Snapshots)**

Instead of reading current balance, we read the balance **at the block where the proposal was created**. Since the flash loan happens in a single block, the historical balance remains 0.

### Delegation

Tokens don't vote automatically! Users must **delegate** their voting power:
- `token.delegate(self)` - Activate your own voting power
- `token.delegate(alice)` - Delegate to someone else

### Proposal Lifecycle

```
Pending → Active → Succeeded/Defeated → Executed/Expired
```

1. **Pending**: Waiting for voting delay
2. **Active**: Voting period in progress
3. **Succeeded**: Quorum reached + FOR majority
4. **Defeated**: Quorum not reached or AGAINST majority
5. **Executed**: Actions executed

---

## 🔐 Security Focus

- Checkpoints prevent flash loan voting attacks
- Quorum ensures minimum participation
- Time delays allow users to exit before changes
- Only Governor can call sensitive vault functions

---

## 📚 Resources

- [OpenZeppelin Governor](https://docs.openzeppelin.com/contracts/latest/api/governance)
- [ERC20Votes](https://docs.openzeppelin.com/contracts/latest/api/token/ERC20#ERC20Votes)
- [Compound Governance](https://compound.finance/governance)

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
