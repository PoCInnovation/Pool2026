🌊 P2P Blockchain Discovery Pool 2025
=====================================

Intensive 5-day program to go from novice to developer capable of delivering a complete decentralized micro-economy (token, vault, governance, oracle, frontend integration). The `Day01` to `Day05` folders contain a guided path, following the classic PoC format (intro, description, tasks, docs). Some example code is provided when necessary to unlock understanding, never as a final solution.

Folder Structure
- Day01_Genesis_Tools: environment, storage layout, gas, Sepolia deployment, Etherscan verification.
- Day02_Assets_Standards: ERC-20 + Permit, ERC-721 IPFS, ERC-4626/4337 (theory), frontend integration level 1.
- Day03_Vault_Defi_Basics: staking vault, shares/assets, simple reward, anti-reentrancy, frontend level 2.
- Day04_Governance_DAO: on-chain DAO, snapshots/checkpoints, execution to Vault, frontend level 3.
- Day05_Oracle_Swap: Chainlink ETH/USD oracle, ETH->token swap, stale-check, frontend level 4.

Recommended Prerequisites
- Command line, Git, and VS Code with Solidity extension + Foundry formatter.
- Testnet wallet (Metamask or equivalent) with some Sepolia ETH, Etherscan API key, Sepolia RPC (Alchemy/Infura/other).
- Access to the provided frontend (config file to fill in deployed addresses).

Main Tools
- Foundry (forge, cast, anvil), OpenZeppelin Contracts, Etherscan, Chainlink Data Feeds.

Security First Philosophy
- Each day: a vulnerability, its reproduction and mitigation (CEI patterns, nonReentrant, snapshots, stale-checks, access control).

How to Use This Repository
- Go to the day's folder, follow the steps in order (description → tasks → docs).
- Write your own code, test on anvil then Sepolia, verify on Etherscan, connect the frontend with deployed addresses.
