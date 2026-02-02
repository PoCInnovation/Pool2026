---

# 🛠️ Setup - Day 04 - Governance (The DAO)

Welcome to **Day 04** of the Blockchain Discovery Pool!
Today, you will build a decentralized governance system (DAO) that allows token holders to vote on your Vault parameters.

## 📋 What You'll Build Today

- **Voting System**: 1 Token = 1 Vote
- **Proposals**: Create proposals to modify the Vault
- **Execution**: Automatically apply voted changes
- **Protection**: Prevent double voting and flash loan attacks

---

## 1. Verify Your Environment 🔍

Before starting, make sure everything is ready from previous days.

### Verify Foundry

```bash
forge --version
```

_If you see a version number, you're good! Otherwise, go back to [Day 01 Setup](../Day01_Genesis_Tools/SETUP.md)._

### Verify Your Project

Your project should contain:

- `foundry.toml` (configuration file)
- `src/` with your contracts from previous days
- `lib/openzeppelin-contracts/` (installed on Day 02)
- `test/` (your tests)

### Verify OpenZeppelin

```bash
forge build
```

If you see "Compiler run successful", OpenZeppelin is correctly configured.

---

## 2. Prerequisites from Previous Days 📦

### Day 02 - Your ERC-20 Token

Your Day 02 token will be used as **voting power**. Each token = 1 vote.

> ⚠️ **Important**: You will need to modify your token to support **checkpoints** (ERC20Votes). This will be done in the README.

### Day 03 - Your Vault

Your Day 03 Vault will be **governed** by the DAO. You will add governable functions in the README.

### Retrieve Your Deployed Addresses

If you have already deployed your contracts:

- `TOKEN_ADDRESS`: Your ERC-20 token address
- `VAULT_ADDRESS`: Your Vault address

---

## 3. Environment and Variables 🔐

### Update Your `.env`

Add the necessary new variables:

```bash
# === Existing variables ===
RPC_SEPOLIA=https://rpc.sepolia.org
PRIVATE_KEY=your_private_key

# === New Day 04 variables ===
# Addresses of your contracts from previous days (if already deployed)
TOKEN_ADDRESS=0x...
VAULT_ADDRESS=0x...

# The Governor address will be filled after deployment
GOVERNANCE_ADDRESS=
```

### Load Variables

```bash
source .env
```

---

## 4. Get Sepolia ETH (if necessary) 💸

Deploying a Governor costs a bit more gas than a simple contract. Make sure you have at least **0.02 Sepolia ETH**.

### Recommended Faucets

- **Google Cloud Web3 Faucet**: [Claim here](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
- **Alchemy POW Faucet**: [Mine here](https://sepolia-faucet.pk910.de/)
- **QuickNode Faucet**: [Claim here](https://faucet.quicknode.com/ethereum/sepolia)

### Verify Your Balance

```bash
cast balance $YOUR_ADDRESS --rpc-url $RPC_SEPOLIA
```

---

## 5. Understand the DAO Architecture 🏛️

Before coding, understand the components you will implement:

### The 3 Components

| Component         | Role                      | What You'll Do                   |
| ----------------- | ------------------------- | ----------------------------------- |
| **Voting Token**  | Gives voting power        | Modify PoolToken with ERC20Votes    |
| **Governor**      | Manages proposals & votes | Create VaultGovernor                |
| **Vault**         | Controlled by DAO         | Add `setWithdrawalFee` function     |

### Governance Flow

```
1. Delegate voting power → delegate(self)
2. Create a proposal → propose(...)
3. Wait for votingDelay → (e.g., 1 block)
4. Vote → castVote(proposalId, support)
5. Wait for votingPeriod → (e.g., 50 blocks on testnet)
6. Execute → execute(...)
7. Vault changes → setWithdrawalFee(newFee)
```

---

## 6. Governance Parameters to Decide 📊

Before implementing, choose your parameters:

| Parameter           | Description                     | Suggested Value (Testnet) |
| ------------------- | ------------------------------- | ------------------------- |
| `votingDelay`       | Delay before voting starts     | 1 block                   |
| `votingPeriod`      | Voting duration in blocks       | 50 blocks (~10 min)       |
| `quorum`            | Minimum % of votes to validate  | 4% of supply               |
| `proposalThreshold` | Minimum tokens to propose       | 0 or 1000 tokens          |

> ⚠️ **In production**, these values would be much higher (e.g., votingPeriod of 1 week).

---

## 7. Required OpenZeppelin Dependencies 📚

You will use these OpenZeppelin modules (already installed on Day 02):

**For the Token:**

- `ERC20Votes`: Adds checkpoints and delegation
- `ERC20Permit`: Gasless approvals (already used Day 02)

**For the Governor:**

- `Governor`: Base of governance
- `GovernorCountingSimple`: Counting For/Against/Abstain
- `GovernorVotes`: Integration with voting token
- `GovernorVotesQuorumFraction`: Quorum based on a % of supply

Verify everything compiles:

```bash
forge build
```

---

## 8. Verify Your Setup ✅

### Checklist

- [ ] Foundry works (`forge --version`)
- [ ] OpenZeppelin installed (`lib/openzeppelin-contracts/`)
- [ ] Day 02 ERC-20 token ready to be modified
- [ ] Day 03 Vault ready to be modified
- [ ] `.env` configured
- [ ] Sepolia ETH available
- [ ] Understand governance flow
- [ ] Governance parameters decided

### Configuration Test

```bash
forge build
```

If everything compiles without errors, you're ready!

---

## 🆘 Troubleshooting

### "forge: command not found"

- Verify Foundry is installed
- Close and reopen your terminal
- Run `foundryup`

### "Cannot find module @openzeppelin"

- Verify that `lib/openzeppelin-contracts/` exists
- Verify the remapping in `foundry.toml`

### "Insufficient funds"

- Verify you're on the Sepolia network
- Request more ETH via a faucet

---

## 🎯 Ready!

Your environment is configured. You have:

- ✅ Foundry and OpenZeppelin functional
- ✅ Environment variables ready
- ✅ Understanding of DAO architecture
- ✅ Governance parameters decided

👉 **Next Step**: Go to [README.md](./README.md) to implement the Governor, create proposals, vote and execute changes on the Vault!

---

**Happy Governing! 🗳️**

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
