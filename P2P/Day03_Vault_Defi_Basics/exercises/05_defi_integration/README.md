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

### SafeERC20 - Why use it?

When interacting with ERC20 tokens, some tokens don't follow the standard exactly. SafeERC20 wraps calls to handle edge cases:

```solidity
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
using SafeERC20 for IERC20;

// Instead of:
token.approve(spender, amount);     // ❌ Can fail silently

// Use:
token.safeIncreaseAllowance(spender, amount);  // ✅ Reverts on failure
token.safeTransfer(to, amount);                // ✅ Reverts on failure
token.safeTransferFrom(from, to, amount);      // ✅ Reverts on failure
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

## ✏️ Exercise 5.2: Uniswap Interfaces (PROVIDED)

Create the file: `src/interfaces/IUniswapV2.sol`

> ⚠️ **These interfaces are provided** - you cannot guess them and they are essential for interacting with Uniswap.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IUniswapV2Router02
 * @notice Simplified Uniswap V2 Router interface
 *
 * @dev Uniswap V2 is simpler than V3 for learning:
 *      - No concentrated liquidity management
 *      - No position NFT
 *      - Single function for swaps
 *
 * Official documentation:
 * https://docs.uniswap.org/contracts/v2/reference/smart-contracts/router-02
 */
interface IUniswapV2Router02 {
    /**
     * @notice Swap an exact amount of input tokens for a minimum of output tokens
     * @param amountIn Exact amount of tokens to send
     * @param amountOutMin Minimum amount of tokens to receive (slippage protection)
     * @param path Swap path: [tokenIn, ..., tokenOut]
     * @param to Address that receives the output tokens
     * @param deadline Timestamp limit to execute the transaction
     * @return amounts Array of amounts: [amountIn, ..., amountOut]
     *
     * Path examples:
     * - [RWRD, POOL] → direct swap RWRD to POOL
     * - [RWRD, WETH, POOL] → swap via WETH if no direct pool
     *
     * Slippage protection:
     * - amountOutMin prevents sandwich attacks
     * - Typically 0.5% to 1% tolerance
     */
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    /**
     * @notice Add liquidity to a pair
     * @param tokenA First token of the pair
     * @param tokenB Second token of the pair
     * @param amountADesired Desired amount of tokenA
     * @param amountBDesired Desired amount of tokenB
     * @param amountAMin Minimum amount of tokenA (slippage)
     * @param amountBMin Minimum amount of tokenB (slippage)
     * @param to Address that receives LP tokens
     * @param deadline Timestamp limit
     * @return amountA Actual amount of tokenA added
     * @return amountB Actual amount of tokenB added
     * @return liquidity Amount of LP tokens received
     */
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    /**
     * @notice Returns the output amount for a given input amount
     * @param amountIn Amount of input tokens
     * @param path Swap path
     * @return amounts Array of amounts at each step
     *
     * Useful for:
     * - Preview a swap before execution
     * - Calculate amountOutMin with slippage
     */
    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    /// @notice Address of the Uniswap V2 factory
    function factory() external pure returns (address);

    /// @notice Address of WETH (Wrapped ETH)
    function WETH() external pure returns (address);
}

/**
 * @title IUniswapV2Factory
 * @notice Uniswap V2 Factory interface
 *
 * @dev The factory manages creation and tracking of liquidity pairs
 */
interface IUniswapV2Factory {
    /**
     * @notice Creates a new liquidity pair
     * @param tokenA First token
     * @param tokenB Second token
     * @return pair Address of the newly created pair
     *
     * Note: The pair is created if it doesn't exist already
     */
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    /**
     * @notice Returns the address of an existing pair
     * @param tokenA First token
     * @param tokenB Second token
     * @return pair Address of the pair (or address(0) if non-existent)
     */
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

/**
 * @title IUniswapV2Pair
 * @notice Uniswap V2 liquidity pair interface
 */
interface IUniswapV2Pair {
    /// @notice Returns the reserves of the pair
    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    /// @notice First token of the pair
    function token0() external view returns (address);

    /// @notice Second token of the pair
    function token1() external view returns (address);
}
```

---

## ✏️ Exercise 5.3: VaultWithHarvest

Create a new vault with the harvest function.

File: `src/VaultWithHarvest.sol`

### Step 1: Imports and Contract Declaration

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IUniswapV2.sol";

/**
 * @title VaultWithHarvest
 * @notice Advanced DeFi Vault with Uniswap integration for auto-compound rewards
 *
 * @dev Architecture:
 *
 * ┌─────────────────────────────────────────────────────────────────────────┐
 * │                        VAULT ARCHITECTURE                               │
 * │                                                                         │
 * │   1. Users deposit POOL tokens                                          │
 * │   2. Vault receives RWRD tokens as rewards                              │
 * │   3. harvest() swaps RWRD → POOL via Uniswap                            │
 * │   4. Added POOL increases share value                                   │
 * │                                                                         │
 * │   [User] ──deposit()──▶ [Vault] ◀──RWRD rewards                         │
 * │                            │                                            │
 * │                            ▼                                            │
 * │                       harvest()                                         │
 * │                            │                                            │
 * │                            ▼                                            │
 * │                      [Uniswap]                                          │
 * │                    RWRD ──▶ POOL                                        │
 * │                            │                                            │
 * │                            ▼                                            │
 * │                  Ratio shares/POOL ↑                                    │
 * └─────────────────────────────────────────────────────────────────────────┘
 */
contract VaultWithHarvest is ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;
```

### Step 2: State Variables (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                              STATE VARIABLES
    // ═══════════════════════════════════════════════════════════════════════════

    /// @notice Main vault token (POOL) - users deposit this token
    IERC20 public immutable asset;

    /// @notice Reward token (RWRD) - will be swapped to asset
    IERC20 public immutable rewardToken;

    /// @notice Uniswap V2 Router for swaps
    IUniswapV2Router02 public immutable uniswapRouter;

    /// @notice Total shares issued
    uint256 public totalShares;

    /// @notice Mapping of shares per user
    mapping(address => uint256) public sharesOf;

    // ═══════════════════════════════════════════════════════════════════════════
    //                            HARVEST CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════════

    /// @notice Maximum slippage tolerated for swaps (in basis points, 100 = 1%)
    uint256 public maxSlippage = 100; // 1% by default

    /// @notice Last harvest timestamp
    uint256 public lastHarvestTime;

    /// @notice Minimum delay between two harvests (anti-spam)
    uint256 public harvestCooldown = 1 hours;

    /// @notice Total rewards converted to asset
    uint256 public totalHarvested;
```

### Step 3: Events (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                                  EVENTS
    // ═══════════════════════════════════════════════════════════════════════════

    event Deposit(address indexed user, uint256 assets, uint256 shares);
    event Withdraw(address indexed user, uint256 assets, uint256 shares);
    event Harvest(
        address indexed caller,
        uint256 rewardAmount,
        uint256 assetReceived
    );
    event SlippageUpdated(uint256 oldSlippage, uint256 newSlippage);
    event CooldownUpdated(uint256 oldCooldown, uint256 newCooldown);
```

### Step 4: Errors (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                                  ERRORS
    // ═══════════════════════════════════════════════════════════════════════════

    error ZeroAmount();
    error InvalidAddress();
    error InsufficientShares(uint256 requested, uint256 available);
    error NoStakers();
    error ZeroSharesMinted();
    error ZeroAssetsToWithdraw();
    error NoRewardsToHarvest();
    error HarvestCooldownNotMet(uint256 timeRemaining);
    error SlippageTooHigh(uint256 expected, uint256 received);
    error InvalidSlippage();
```

### Step 5: Constructor (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                                CONSTRUCTOR
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * @notice Deploys the vault with Uniswap integration
     * @param asset_ Main token (POOL)
     * @param rewardToken_ Reward token (RWRD)
     * @param uniswapRouter_ Uniswap V2 Router address
     *
     * Uniswap V2 Router addresses:
     * - Ethereum Mainnet: 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
     * - Sepolia Testnet: 0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008 (or deploy your own)
     */
    constructor(
        address asset_,
        address rewardToken_,
        address uniswapRouter_
    ) Ownable(msg.sender) {
        if (asset_ == address(0)) revert InvalidAddress();
        if (rewardToken_ == address(0)) revert InvalidAddress();
        if (uniswapRouter_ == address(0)) revert InvalidAddress();

        asset = IERC20(asset_);
        rewardToken = IERC20(rewardToken_);
        uniswapRouter = IUniswapV2Router02(uniswapRouter_);

        lastHarvestTime = block.timestamp;
    }
```

### Step 6: Internal Conversion Functions (PROVIDED)

These are the same as Exercise 02:

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                            INTERNAL FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * @dev Converts assets to shares
     */
    function _convertToShares(uint256 assets) internal view returns (uint256) {
        uint256 totalAssets_ = asset.balanceOf(address(this));

        if (totalShares == 0 || totalAssets_ == 0) {
            return assets;
        }

        return (assets * totalShares) / totalAssets_;
    }

    /**
     * @dev Converts shares to assets
     */
    function _convertToAssets(uint256 shares) internal view returns (uint256) {
        if (totalShares == 0) {
            return 0;
        }

        uint256 totalAssets_ = asset.balanceOf(address(this));
        return (shares * totalAssets_) / totalShares;
    }
```

### Step 7: Deposit / Withdraw Functions

> 💡 **Hint:** Reuse the logic from Exercise 02!

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                            DEPOSIT / WITHDRAW
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * @notice Deposits assets and receives shares
     */
    function deposit(
        uint256 assets
    ) external nonReentrant returns (uint256 shares) {
        // TODO: Implement (same as Exercise 02)
        // 1. Check assets > 0
        // 2. Calculate shares with _convertToShares
        // 3. Check shares > 0
        // 4. Update totalShares and sharesOf[msg.sender]
        // 5. Transfer assets from user to vault
        // 6. Emit Deposit event
    }

    /**
     * @notice Withdraws assets by burning shares
     */
    function withdraw(
        uint256 shares
    ) external nonReentrant returns (uint256 assets) {
        // TODO: Implement (same as Exercise 02)
    }

    /**
     * @notice Withdraws all user's assets
     */
    function withdrawAll() external nonReentrant returns (uint256 assets) {
        // TODO: Implement
    }
```

### Step 8: The _getExpectedOutput Helper (PROVIDED)

This function uses `try/catch` which can be complex:

```solidity
    /**
     * @notice Calculates the expected output amount for a swap
     * @param rewardAmount Amount of reward tokens to swap
     * @return expectedAsset Amount of asset tokens expected
     *
     * @dev Uses Uniswap's getAmountsOut to get current price
     */
    function _getExpectedOutput(
        uint256 rewardAmount
    ) internal view returns (uint256) {
        if (rewardAmount == 0) return 0;

        address[] memory path = new address[](2);
        path[0] = address(rewardToken);
        path[1] = address(asset);

        try uniswapRouter.getAmountsOut(rewardAmount, path) returns (
            uint[] memory amounts
        ) {
            return amounts[1]; // amounts[0] = input, amounts[1] = output
        } catch {
            return 0; // Pool doesn't exist or no liquidity
        }
    }
```

---

## 🎯 Step 9: The harvest() Function - YOUR MAIN TASK

This is the **core of the exercise**. Implement the harvest function following the CEI pattern (Checks-Effects-Interactions).

```
harvest() Flow:
                                                              
  ┌──────────────────────────────────────────────────────────┐
  │ 1. CHECKS                                                │
  │    rewardBalance > 0 ?                                   │
  │    cooldown passed ?                                     │
  │    totalShares > 0 ?                                     │
  └─────────────────────────┬────────────────────────────────┘
                            │ ✓
  ┌─────────────────────────▼────────────────────────────────┐
  │ 2. EFFECTS                                               │
  │    lastHarvestTime = now                                 │
  └─────────────────────────┬────────────────────────────────┘
                            │
  ┌─────────────────────────▼────────────────────────────────┐
  │ 3. INTERACTIONS                                          │
  │    ┌──────────┐    approve    ┌─────────────────┐        │
  │    │  Vault   │ ────────────▶ │ Uniswap Router  │        │
  │    │          │               │                 │        │
  │    │   RWRD   │ ────swap────▶ │  RWRD → POOL    │        │
  │    │          │ ◀───────────  │                 │        │
  │    │  +POOL   │    receive    └─────────────────┘        │
  │    └──────────┘                                          │
  └──────────────────────────────────────────────────────────┘
```

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                              HARVEST FUNCTION
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * @notice Converts accumulated reward tokens to asset tokens via Uniswap
     * @return assetReceived Amount of assets added to vault
     *
     * @dev This function is the heart of the DeFi integration:
     *
     * Execution flow:
     * 1. Verify there are rewards to harvest
     * 2. Verify cooldown
     * 3. Calculate acceptable minimum (slippage protection)
     * 4. Approve the router
     * 5. Execute the swap RWRD → POOL
     * 6. The received POOL stays in the vault, increasing the ratio
     *
     * Security:
     * - Slippage protection against sandwich attacks
     * - Cooldown to prevent spam
     * - Anyone can call (decentralized)
     *
     * Note on decentralization:
     * Allowing anyone to call harvest() is a common practice:
     * - "Keepers" or bots can automate the harvest
     * - No dependency on a centralized entity
     * - Works like Yearn, Beefy, etc.
     */
    function harvest() external nonReentrant returns (uint256 assetReceived) {
        // ═══════════════════════════════════════════════════════════════════
        // STEP 1: CHECKS - Pre-conditions verification
        // ═══════════════════════════════════════════════════════════════════

        // TODO: Get the vault's rewardToken balance
        // uint256 rewardBalance = ...
        
        // TODO: Check there are rewards (otherwise revert NoRewardsToHarvest)

        // TODO: Calculate time since last harvest
        // uint256 timeSinceLastHarvest = block.timestamp - lastHarvestTime;
        
        // TODO: Check cooldown (otherwise revert HarvestCooldownNotMet with remaining time)

        // TODO: Check there are stakers (otherwise revert NoStakers)

        // ═══════════════════════════════════════════════════════════════════
        // STEP 2: EFFECTS - State updates
        // ═══════════════════════════════════════════════════════════════════

        // TODO: Update lastHarvestTime to current timestamp

        // ═══════════════════════════════════════════════════════════════════
        // STEP 3: INTERACTIONS - External call to Uniswap
        // ═══════════════════════════════════════════════════════════════════

        // TODO: Calculate acceptable minimum with _getExpectedOutput
        //       and apply slippage: minOutput = expected * (10000 - maxSlippage) / 10000
        // uint256 expectedOutput = _getExpectedOutput(rewardBalance);
        // uint256 minOutput = ...

        // TODO: Approve the Uniswap router to spend reward tokens
        //       Use safeIncreaseAllowance (from SafeERC20)
        // rewardToken.safeIncreaseAllowance(address(uniswapRouter), rewardBalance);

        // TODO: Build the swap path
        // address[] memory path = new address[](2);
        // path[0] = address(rewardToken);
        // path[1] = address(asset);

        // TODO: Record the asset balance BEFORE the swap
        // uint256 assetBalanceBefore = asset.balanceOf(address(this));

        // TODO: Call uniswapRouter.swapExactTokensForTokens(...)
        //       - amountIn: rewardBalance
        //       - amountOutMin: minOutput
        //       - path: path
        //       - to: address(this)
        //       - deadline: block.timestamp

        // TODO: Calculate assetReceived = balance after - balance before

        // TODO: Additional slippage verification
        //       if (assetReceived < minOutput) revert SlippageTooHigh(minOutput, assetReceived);

        // TODO: Update totalHarvested
        // totalHarvested += assetReceived;

        // TODO: Emit the Harvest event
        // emit Harvest(msg.sender, rewardBalance, assetReceived);
    }
```

---

### Step 10: Admin Functions (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                              ADMIN FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════

    /**
     * @notice Updates maximum tolerated slippage
     * @param newSlippage New slippage in basis points (100 = 1%)
     */
    function setMaxSlippage(uint256 newSlippage) external onlyOwner {
        if (newSlippage > 1000) revert InvalidSlippage(); // Max 10%

        uint256 oldSlippage = maxSlippage;
        maxSlippage = newSlippage;

        emit SlippageUpdated(oldSlippage, newSlippage);
    }

    /**
     * @notice Updates cooldown between harvests
     * @param newCooldown New cooldown in seconds
     */
    function setHarvestCooldown(uint256 newCooldown) external onlyOwner {
        uint256 oldCooldown = harvestCooldown;
        harvestCooldown = newCooldown;

        emit CooldownUpdated(oldCooldown, newCooldown);
    }

    /**
     * @notice Recovers tokens sent by mistake (except asset and rewardToken)
     * @param token Token to recover
     * @param to Destination address
     */
    function rescueTokens(address token, address to) external onlyOwner {
        require(token != address(asset), "Cannot rescue asset");
        require(token != address(rewardToken), "Cannot rescue reward token");

        uint256 balance = IERC20(token).balanceOf(address(this));
        IERC20(token).safeTransfer(to, balance);
    }
```

### Step 11: View Functions (PROVIDED)

```solidity
    // ═══════════════════════════════════════════════════════════════════════════
    //                              VIEW FUNCTIONS
    // ═══════════════════════════════════════════════════════════════════════════

    /// @notice Total assets in the vault
    function totalAssets() public view returns (uint256) {
        return asset.balanceOf(address(this));
    }

    /// @notice Preview number of shares for a deposit
    function previewDeposit(uint256 assets) external view returns (uint256) {
        return _convertToShares(assets);
    }

    /// @notice Preview assets for a withdrawal
    function previewWithdraw(uint256 shares) external view returns (uint256) {
        return _convertToAssets(shares);
    }

    /// @notice Current ratio (multiplied by 1e18)
    function currentRatio() external view returns (uint256) {
        if (totalShares == 0) {
            return 1e18;
        }
        return (totalAssets() * 1e18) / totalShares;
    }

    /// @notice Value of user's shares in assets
    function assetsOf(address user) external view returns (uint256) {
        return _convertToAssets(sharesOf[user]);
    }

    /// @notice Amount of reward tokens pending harvest
    function pendingHarvest() external view returns (uint256) {
        return rewardToken.balanceOf(address(this));
    }

    /// @notice Estimate assets we would get from harvesting now
    function previewHarvest() external view returns (uint256) {
        uint256 rewardBalance = rewardToken.balanceOf(address(this));
        return _getExpectedOutput(rewardBalance);
    }

    /// @notice Time remaining until next possible harvest
    function timeUntilNextHarvest() external view returns (uint256) {
        uint256 timeSinceLastHarvest = block.timestamp - lastHarvestTime;
        if (timeSinceLastHarvest >= harvestCooldown) {
            return 0;
        }
        return harvestCooldown - timeSinceLastHarvest;
    }
}
```

---

## ✏️ Exercise 5.4: Integration Test

File: `test/VaultWithHarvest.t.sol`

Create a mock of the Uniswap router and test:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VaultWithHarvest.sol";
import "../src/PoolToken.sol";      // From Exercise 01
import "../src/RewardToken.sol";    // From Exercise 5.1

/**
 * @notice Mock Uniswap Router for testing
 * @dev Simulates swap behavior with a fixed ratio
 */
contract MockUniswapRouter {
    uint256 public swapRatio = 100; // 1 RWRD = 1 POOL (100%)

    function setSwapRatio(uint256 _ratio) external {
        swapRatio = _ratio;
    }

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts) {
        require(deadline >= block.timestamp, "Expired");
        
        IERC20 tokenIn = IERC20(path[0]);
        IERC20 tokenOut = IERC20(path[1]);
        
        // Calculate output based on ratio
        uint256 amountOut = (amountIn * swapRatio) / 100;
        require(amountOut >= amountOutMin, "Slippage");
        
        // Transfer tokens
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        tokenOut.transfer(to, amountOut);
        
        amounts = new uint[](2);
        amounts[0] = amountIn;
        amounts[1] = amountOut;
    }

    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts) {
        amounts = new uint[](2);
        amounts[0] = amountIn;
        amounts[1] = (amountIn * swapRatio) / 100;
    }
}

contract VaultWithHarvestTest is Test {
    VaultWithHarvest vault;
    PoolToken poolToken;
    RewardToken rewardToken;
    MockUniswapRouter router;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        // Deploy tokens
        poolToken = new PoolToken(1_000_000e18);
        rewardToken = new RewardToken(1_000_000e18);
        
        // Deploy mock router
        router = new MockUniswapRouter();
        
        // Fund router with POOL tokens for swaps
        poolToken.transfer(address(router), 100_000e18);
        
        // Deploy vault
        vault = new VaultWithHarvest(
            address(poolToken),
            address(rewardToken),
            address(router)
        );
        
        // Setup users
        poolToken.transfer(alice, 10_000e18);
        poolToken.transfer(bob, 10_000e18);
    }

    function testHarvestIncreasesRatio() public {
        // 1. Alice deposits 1000 POOL
        vm.startPrank(alice);
        poolToken.approve(address(vault), 1000e18);
        vault.deposit(1000e18);
        vm.stopPrank();

        uint256 ratioBefore = vault.currentRatio();

        // 2. Send 100 RWRD to vault (simulate rewards)
        rewardToken.transfer(address(vault), 100e18);

        // 3. Wait for cooldown
        vm.warp(block.timestamp + 1 hours);

        // 4. Call harvest()
        vault.harvest();

        // 5. Verify ratio has increased
        uint256 ratioAfter = vault.currentRatio();
        assertGt(ratioAfter, ratioBefore, "Ratio should increase after harvest");

        // 6. Verify Alice can withdraw more than her initial deposit
        vm.prank(alice);
        uint256 aliceShares = vault.sharesOf(alice);
        uint256 aliceAssets = vault.previewWithdraw(aliceShares);
        assertGt(aliceAssets, 1000e18, "Alice should have more assets than deposited");
    }

    // TODO: Add more tests
    // - testHarvestRevertsWithNoRewards
    // - testHarvestRevertsDuringCooldown
    // - testHarvestRevertsWithNoStakers
    // - testSlippageProtection
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
| Token approval | `safeIncreaseAllowance` instead of `approve` |

---

## ✅ Validation Criteria

- [ ] RewardToken deployable with mint function
- [ ] Uniswap interfaces correctly copied
- [ ] VaultWithHarvest deploys correctly
- [ ] `deposit()` and `withdraw()` work
- [ ] `harvest()` swaps rewards to assets
- [ ] Slippage protection implemented
- [ ] Cooldown respected
- [ ] All tests pass

---

## 📝 Summary: What to Implement

| Component | Status | Difficulty |
|-----------|--------|------------|
| Interfaces Uniswap | ✅ PROVIDED | - |
| Events | ✅ PROVIDED | - |
| Errors | ✅ PROVIDED | - |
| Constructor | ✅ PROVIDED | - |
| View functions | ✅ PROVIDED | - |
| Admin functions | ✅ PROVIDED | - |
| `_convertToShares/Assets` | ✅ PROVIDED | - |
| `_getExpectedOutput` | ✅ PROVIDED | - |
| `deposit()` | 🔨 TO IMPLEMENT | ⭐ Easy (reuse Ex02) |
| `withdraw()` | 🔨 TO IMPLEMENT | ⭐ Easy (reuse Ex02) |
| `withdrawAll()` | 🔨 TO IMPLEMENT | ⭐ Easy |
| **`harvest()`** | 🎯 **TO IMPLEMENT** | ⭐⭐⭐ Main focus |

---

## 🎯 Bonus: Real Deployment on Sepolia

If you want to go further and test in real conditions, follow these steps!

### Prerequisites

```bash
# 1. Configure environment variables
export PRIVATE_KEY_TEST=0x...                    # Your testnet private key
export RPC_SEPOLIA=https://sepolia.drpc.org

# 2. Get Sepolia ETH from a faucet
# https://sepoliafaucet.com/
# https://www.alchemy.com/faucets/ethereum-sepolia

# 3. export PoolToken first (from day 2)
export POOL_TOKEN_ADDRESS=0x...  # Address from deployment
```

---

### Exercise 5.5: Deployment Script (PROVIDED)

Create the file: `script/DeployDeFiVault.s.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VaultWithHarvest.sol";
import "../src/RewardToken.sol";
import "../src/interfaces/IUniswapV2.sol";

/**
 * @title DeployDeFiVault
 * @notice Complete deployment script for Vault + Uniswap system
 *
 * @dev This script deploys:
 *      1. RewardToken (RWRD)
 *      2. VaultWithHarvest
 *      3. Configures Uniswap pool (if needed)
 *
 * Usage:
 * ```bash
 * forge script script/DeployDeFiVault.s.sol:DeployDeFiVault \
 *   --rpc-url $RPC_SEPOLIA \
 *   --broadcast \
 *   --verify
 * ```
 */
contract DeployDeFiVault is Script {
    // Uniswap V2 addresses per network
    // Note: On Sepolia, you may need to deploy your own router
    // or use a fork like SushiSwap
    address constant UNISWAP_V2_ROUTER_SEPOLIA =
        0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008;

    function run() external {
        // ═══════════════════════════════════════════════════════════════════
        //                         CONFIGURATION
        // ═══════════════════════════════════════════════════════════════════

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address poolTokenAddress = vm.envAddress("POOL_TOKEN_ADDRESS");

        // Uniswap Router (use env variable or default)
        address uniswapRouter;
        try vm.envAddress("UNISWAP_ROUTER") returns (address router) {
            uniswapRouter = router;
        } catch {
            uniswapRouter = UNISWAP_V2_ROUTER_SEPOLIA;
        }
        
        // Initial RewardToken supply
        uint256 rewardTokenSupply = 1_000_000 ether;

        vm.startBroadcast(deployerPrivateKey);

        // ═══════════════════════════════════════════════════════════════════
        //                      DEPLOY REWARD TOKEN
        // ═══════════════════════════════════════════════════════════════════

        console.log("Deploying RewardToken...");
        RewardToken rewardToken = new RewardToken(rewardTokenSupply);
        console.log("RewardToken deployed at:", address(rewardToken));
        console.log("  Symbol:", rewardToken.symbol());
        console.log("  Total Supply:", rewardTokenSupply / 1e18, "RWRD");

        // ═══════════════════════════════════════════════════════════════════
        //                         DEPLOY VAULT
        // ═══════════════════════════════════════════════════════════════════

        console.log("\nDeploying VaultWithHarvest...");
        VaultWithHarvest vault = new VaultWithHarvest(
            poolTokenAddress,
            address(rewardToken),
            uniswapRouter
        );
        console.log("VaultWithHarvest deployed at:", address(vault));
        console.log("  Asset (POOL):", poolTokenAddress);
        console.log("  Reward Token (RWRD):", address(rewardToken));
        console.log("  Uniswap Router:", uniswapRouter);

        // ═══════════════════════════════════════════════════════════════════
        //                         SUMMARY
        // ═══════════════════════════════════════════════════════════════════

        console.log("\n========================================");
        console.log("           DEPLOYMENT SUMMARY           ");
        console.log("========================================");
        console.log("RewardToken (RWRD):", address(rewardToken));
        console.log("VaultWithHarvest:  ", address(vault));
        console.log("========================================");
        console.log("\nNEXT STEPS:");
        console.log("1. Create Uniswap pool: POOL/RWRD");
        console.log("2. Add initial liquidity");
        console.log("3. Test deposit/harvest flow");
        console.log("========================================");

        vm.stopBroadcast();
    }
}

/**
 * @title CreateUniswapPool
 * @notice Script to create and initialize POOL/RWRD Uniswap pool
 *
 * Usage:
 * ```bash
 * export REWARD_TOKEN_ADDRESS=0x...
 *
 * forge script script/DeployDeFiVault.s.sol:CreateUniswapPool \
 *   --rpc-url $RPC_SEPOLIA \
 *   --broadcast
 * ```
 */
contract CreateUniswapPool is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address poolToken = vm.envAddress("POOL_TOKEN_ADDRESS");
        address rewardToken = vm.envAddress("REWARD_TOKEN_ADDRESS");
        address routerAddress = vm.envAddress("UNISWAP_ROUTER");

        // Initial liquidity amounts
        uint256 poolAmount = 10_000 ether;   // 10,000 POOL
        uint256 rewardAmount = 10_000 ether; // 10,000 RWRD

        IUniswapV2Router02 router = IUniswapV2Router02(routerAddress);

        vm.startBroadcast(deployerPrivateKey);

        // Approve the router
        IERC20(poolToken).approve(routerAddress, poolAmount);
        IERC20(rewardToken).approve(routerAddress, rewardAmount);

        console.log("Adding liquidity to Uniswap...");
        console.log("  POOL amount:", poolAmount / 1e18);
        console.log("  RWRD amount:", rewardAmount / 1e18);

        // Add liquidity (creates the pair if it doesn't exist)
        (uint amountA, uint amountB, uint liquidity) = router.addLiquidity(
            poolToken,
            rewardToken,
            poolAmount,
            rewardAmount,
            (poolAmount * 95) / 100,   // 5% slippage
            (rewardAmount * 95) / 100,
            msg.sender,
            block.timestamp + 300
        );

        console.log("\nLiquidity added successfully!");
        console.log("  POOL deposited:", amountA / 1e18);
        console.log("  RWRD deposited:", amountB / 1e18);
        console.log("  LP tokens received:", liquidity / 1e18);

        // Get pair address
        IUniswapV2Factory factory = IUniswapV2Factory(router.factory());
        address pair = factory.getPair(poolToken, rewardToken);
        console.log("\nPair address:", pair);

        vm.stopBroadcast();
    }
}

/**
 * @title TestHarvestFlow
 * @notice Script to test complete deposit → reward → harvest flow
 */
contract TestHarvestFlow is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address vaultAddress = vm.envAddress("VAULT_ADDRESS");
        address poolToken = vm.envAddress("POOL_TOKEN_ADDRESS");
        address rewardToken = vm.envAddress("REWARD_TOKEN_ADDRESS");

        // Calculate the actual deployer address from private key
        // IMPORTANT: msg.sender doesn't work correctly in view calls during broadcast!
        address deployer = vm.addr(deployerPrivateKey);

        VaultWithHarvest vault = VaultWithHarvest(vaultAddress);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deposit
        console.log("1. Depositing 100 POOL...");
        console.log("   Deployer address:", deployer);
        IERC20(poolToken).approve(vaultAddress, 100 ether);
        uint256 shares = vault.deposit(100 ether);
        console.log("   Shares received:", shares / 1e18);

        // 2. Simulate sending rewards
        console.log("\n2. Sending 10 RWRD as rewards...");
        IERC20(rewardToken).transfer(vaultAddress, 10 ether);
        console.log("   Pending harvest:", vault.pendingHarvest() / 1e18, "RWRD");
        console.log("   Preview harvest:", vault.previewHarvest() / 1e18, "POOL");

        // 3. Harvest
        console.log("\n3. Harvesting...");
        uint256 harvested = vault.harvest();
        console.log("   POOL received:", harvested / 1e18);
        console.log("   New ratio:", vault.currentRatio() / 1e16, "% of initial");

        // 4. Check value - Use deployer address instead of msg.sender!
        uint256 userAssets = vault.assetsOf(deployer);
        console.log("\n4. Final state:");
        console.log("   Total assets:", vault.totalAssets() / 1e18, "POOL");
        console.log("   Your assets:", userAssets / 1e18, "POOL");
        
        // Safe subtraction to avoid underflow
        if (userAssets > 100 ether) {
            console.log("   Profit:", (userAssets - 100 ether) / 1e18, "POOL");
        } else {
            console.log("   Profit: 0 POOL (or loss)");
        }

        vm.stopBroadcast();
    }
}
```

---

### Step-by-Step Deployment Guide

#### Step 1: Deploy RewardToken and Vault

```bash
# Make sure you have these environment variables set
export PRIVATE_KEY_TEST=0x...
export RPC_SEPOLIA=https://...
export POOL_TOKEN_ADDRESS=0x...  # From Exercise day 2

# Deploy RewardToken + Vault
forge script script/DeployDeFiVault.s.sol:DeployDeFiVault \
  --rpc-url $RPC_SEPOLIA \
  --broadcast

# Save the addresses from the output
export REWARD_TOKEN_ADDRESS=0x...  # From deployment logs
export VAULT_ADDRESS=0x...         # From deployment logs
```

#### Step 2: Create Uniswap Pool with Liquidity

```bash
# Set the router address (Sepolia)
export UNISWAP_ROUTER=0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008

# Create pool and add liquidity
forge script script/DeployDeFiVault.s.sol:CreateUniswapPool \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

> ⚠️ **Note:** Make sure you have enough POOL and RWRD tokens in your wallet before running this script!

#### Step 3: Test the Complete Flow

```bash
# Test deposit → reward → harvest
forge script script/DeployDeFiVault.s.sol:TestHarvestFlow \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

---

### Manual Testing with Cast

You can also test individual functions:

```bash
# Check pending rewards
cast call $VAULT_ADDRESS "pendingHarvest()" --rpc-url $RPC_SEPOLIA

# Preview harvest output
cast call $VAULT_ADDRESS "previewHarvest()" --rpc-url $RPC_SEPOLIA

# Check time until next harvest
cast call $VAULT_ADDRESS "timeUntilNextHarvest()" --rpc-url $RPC_SEPOLIA

# Execute harvest
cast send $VAULT_ADDRESS "harvest()" \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY_TEST

# Check your assets
cast call $VAULT_ADDRESS "assetsOf(address)" YOUR_ADDRESS --rpc-url $RPC_SEPOLIA
```

---

### Troubleshooting

| Issue | Solution |
|-------|----------|
| "Pool doesn't exist" | Run `CreateUniswapPool` script first |
| "Insufficient allowance" | Make sure to approve tokens before deposit |
| "Cooldown not met" | Wait 1 hour between harvests (or modify in tests) |
| "No rewards to harvest" | Send RWRD tokens to the vault first |
| "Slippage too high" | Increase `maxSlippage` or add more liquidity |

---

## 🏆 Congratulations!

You have built a **complete DeFi vault** with:
- ✅ Share system
- ✅ Secure Deposit/Withdraw
- ✅ Reward distribution
- ✅ Reentrancy protection
- ✅ Uniswap integration
- ✅ Slippage protection
- ✅ Anti-spam cooldown

This is the core of protocols like **Yearn Finance**! 🎉
