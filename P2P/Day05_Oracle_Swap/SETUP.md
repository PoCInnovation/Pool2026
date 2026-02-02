Day 05 – Setup
==============

Objective
- Prepare the environment to integrate the Chainlink ETH/USD oracle and deploy the swap contract, then connect the frontend level 4.

Prerequisites
- Day 04 completed: ecosystem ready (token, Vault, governance).  
- Sepolia ETH to deploy the Swap and perform some test swaps.  
- Token reserve to deposit in the Swap contract for liquidity.

Steps
1) Get the price feed address  
   - Consult Chainlink Sepolia documentation and note the ETH/USD feed address.  
   - Note the feed's `decimals()` (often 8) for calculation.
2) Dependencies  
   - Chainlink interface `AggregatorV3Interface` (package already present via npm/OZ? Otherwise get the interface via import).  
   - OpenZeppelin already installed.
3) Swap contract parameters  
   - Token address (Day 02 ERC-20).  
   - Token decimals (often 18).  
   - `staleThreshold` (e.g., 1h) to reject stale prices.  
   - Policy on received ETH (treasury or manual return).
4) Environment  
   - `.env` (RPC, private key, Etherscan key) unchanged.  
   - Load variables before deployment (`source .env`).
5) Prepare liquidity  
   - After deployment, transfer tokens to the Swap contract to enable exchanges.  
   - Keep an ETH balance to pay for test transactions.
6) Frontend  
   - Identify the location of `SWAP_ADDRESS` in the frontend config.  
   - Prepare a small amount of testnet ETH to verify the swap UX.

Ready?  
Go to the day's README to implement the oracle + swap logic, deploy, provide liquidity and connect the frontend.
