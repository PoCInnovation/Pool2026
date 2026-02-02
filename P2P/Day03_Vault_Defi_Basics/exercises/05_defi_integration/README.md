# 📖 Exercise 05: DeFi Integration - Uniswap

---

## 🎓 Lesson: Auto-Compound with Uniswap

In real DeFi protocols, rewards are often distributed in a **different token** than the main asset.

**Examples:**
- Curve gives CRV to liquidity providers
- Aave gives AAVE to stakers
- SushiSwap gives SUSHI to farmers

### The Auto-Compound Pattern

```
1. Vault receives RWRD (reward tokens)
2. harvest() swaps RWRD → POOL via Uniswap
3. The POOL received stays in the vault
4. The shares/assets ratio increases!
```

```
┌─────────┐     RWRD      ┌─────────┐
│ Protocol│ ─────────────▶│  Vault  │
└─────────┘               │         │
                          │ harvest │
                          │    │    │
                          └────┼────┘
                               │
                               ▼
                         ┌───────────┐
                         │  Uniswap  │
                         │           │
                         │ RWRD→POOL │
                         └─────┬─────┘
                               │
                               ▼
                         POOL added
                         to vault
                         ratio ↑
```

---

## 🔑 Uniswap V2: The Basics

Uniswap V2 uses **liquidity pools** to exchange tokens.

### Key Function: swapExactTokensForTokens

```solidity
function swapExactTokensForTokens(
    uint amountIn,        // Exact amount to swap
    uint amountOutMin,    // Minimum to receive (slippage protection)
    address[] path,       // Path: [tokenIn, tokenOut]
    address to,           // Recipient
    uint deadline         // Timestamp limit
) external returns (uint[] amounts);
```

### Slippage Protection

Slippage = difference between expected price and actual price.

```solidity
// Calculate acceptable minimum (1% tolerance)
uint256 expectedOut = getAmountsOut(amountIn, path)[1];
uint256 minOut = expectedOut * 99 / 100;  // 1% max slippage
```

---

## ✏️ Exercise 5.1: Create the RewardToken

File: `src/RewardToken.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// TODO: Imports

/**
 * @title RewardToken
 * @notice ERC-20 token used as reward
 */
contract RewardToken /* TODO: inherit ERC20, Ownable */ {
    
    // TODO: Constructor with initial supply
    
    /**
     * @notice Mint new tokens (owner only)
     */
    function mint(address to, uint256 amount) external onlyOwner {
        // TODO: Implement
    }
}
```

---

## ✏️ Exercise 5.2: Uniswap Interface

File: `src/interfaces/IUniswapV2Router.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IUniswapV2Router02
 * @notice Simplified Uniswap V2 Router interface
 */
interface IUniswapV2Router02 {
    
    // TODO: Add swapExactTokensForTokens
    
    // TODO: Add getAmountsOut (for preview)
    
    // TODO: Add addLiquidity (to create the pool)
}
```

---

## ✏️ Exercise 5.3: VaultWithHarvest

Create a new vault with the harvest function:

File: `src/VaultWithHarvest.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// TODO: Imports

contract VaultWithHarvest is ReentrancyGuard, Ownable {
    
    IERC20 public immutable asset;        // Main token (POOL)
    IERC20 public immutable rewardToken;  // Reward token (RWRD)
    IUniswapV2Router02 public immutable uniswapRouter;
    
    uint256 public totalShares;
    mapping(address => uint256) public sharesOf;
    
    // Harvest configuration
    uint256 public maxSlippage = 100;     // 1% in basis points
    uint256 public lastHarvestTime;
    uint256 public harvestCooldown = 1 hours;
    
    // TODO: Events
    
    // TODO: Constructor
    
    // TODO: deposit, withdraw (reuse logic from exercise 02)
    
    /**
     * @notice Convert rewards to assets via Uniswap
     * @return assetReceived Amount of assets added to vault
     * @dev TODO:
     *   1. Verify there are rewards (rewardToken.balanceOf(this) > 0)
     *   2. Verify cooldown
     *   3. Calculate acceptable minimum (slippage)
     *   4. Approve the router
     *   5. Execute the swap
     *   6. Emit Harvest event
     */
    function harvest() external nonReentrant returns (uint256 assetReceived) {
        // TODO: Implement
    }
    
    // TODO: View functions (pendingHarvest, previewHarvest, etc.)
}
```

---

## ✏️ Exercise 5.4: Integration Test

File: `test/VaultWithHarvest.t.sol`

Create a mock of the Uniswap router and test:

```solidity
function testHarvestIncreasesRatio() public {
    // 1. Alice deposits 1000 POOL
    // 2. Send 100 RWRD to vault (simulate rewards)
    // 3. Call harvest()
    // 4. Verify ratio has increased
    // 5. Verify Alice can withdraw more than her initial deposit
}
```

---

## 🔐 Security Points

| Risk | Protection |
|------|------------|
| Sandwich Attack | `maxSlippage` limits acceptable loss |
| Harvest spam | `harvestCooldown` enforces delay |
| Reentrancy | `nonReentrant` on harvest |
| Front-running | `deadline` on swaps |

---

## ✅ Validation Criteria

- [ ] RewardToken deployable
- [ ] Uniswap interface correct
- [ ] harvest() works with mock
- [ ] Slippage protection implemented
- [ ] Cooldown respected
- [ ] Tests pass

---

## 🎯 Bonus: Real Deployment

If you want to go further:

1. Deploy on Sepolia
2. Create a real Uniswap pool (POOL/RWRD)
3. Test harvest in real conditions

```bash
# Deploy
forge script script/DeployVault.s.sol --rpc-url $RPC_SEPOLIA --broadcast

# Create pool on app.uniswap.org (Sepolia)

# Test harvest
cast send $VAULT "harvest()" --rpc-url $RPC_SEPOLIA --private-key $PRIVATE_KEY
```

---

## 🏆 Congratulations!

You have built a **complete DeFi vault** with:
- ✅ Share system
- ✅ Secure Deposit/Withdraw
- ✅ Reward distribution
- ✅ Reentrancy protection
- ✅ Uniswap integration

This is the core of protocols like **Yearn Finance**! 🎉
