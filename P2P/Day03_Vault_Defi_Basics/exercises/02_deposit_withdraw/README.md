# 📖 Exercise 02: Deposit & Withdraw

---

## 🎓 Lesson: The CEI Pattern

To secure functions that manipulate tokens, we use the **CEI** pattern:

```
C - Checks       → Verify conditions
E - Effects      → Modify internal state
I - Interactions → External calls (transfers)
```

### Why This Order?

The order protects against **reentrancy attacks**. If a malicious contract calls your function during a transfer, the state has already been updated.

```solidity
// ❌ DANGEROUS - State modified AFTER transfer
function withdraw(uint256 amount) external {
    token.transfer(msg.sender, amount);  // Interaction
    balance[msg.sender] -= amount;        // Effect (too late!)
}

// ✅ SECURE - State modified BEFORE transfer
function withdraw(uint256 amount) external {
    balance[msg.sender] -= amount;        // Effect (first)
    token.transfer(msg.sender, amount);   // Interaction (after)
}
```

---

## 🔑 Key Functions

### `deposit(uint256 assets)`

1. **Check**: `assets > 0`
2. **Effect**: Calculate shares, update `totalShares` and `sharesOf[user]`
3. **Interaction**: `transferFrom(user, vault, assets)`

### `withdraw(uint256 shares)`

1. **Check**: `shares > 0`, user has enough shares
2. **Effect**: Calculate assets, update balances
3. **Interaction**: `transfer(user, assets)`

---

## ✏️ Exercise 2.1: Vault Structure

Complete `src/Vault.sol` with:

- Required OpenZeppelin imports
- State variables
- Events
- Constructor

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// TODO: Imports (IERC20, SafeERC20, ReentrancyGuard, Ownable)

contract Vault /* TODO: inherit from contracts */ {
    // TODO: using SafeERC20 for IERC20
    
    // State variables
    // TODO: asset (IERC20, immutable)
    // TODO: totalShares
    // TODO: mapping sharesOf
    
    // Events
    // TODO: Deposit(address indexed user, uint256 assets, uint256 shares)
    // TODO: Withdraw(address indexed user, uint256 assets, uint256 shares)
    
    // Constructor
    // TODO: Takes asset address and initializes
}
```

---

## ✏️ Exercise 2.2: Deposit Function

Implement the `deposit` function:

```solidity
/**
 * @notice Deposit assets and receive shares
 * @param assets Amount to deposit
 * @return shares Number of shares received
 */
function deposit(uint256 assets) external nonReentrant returns (uint256 shares) {
    // CHECKS
    // TODO: Verify assets > 0
    
    // EFFECTS  
    // TODO: Calculate shares (use _convertToShares)
    // TODO: Verify shares > 0
    // TODO: Update totalShares
    // TODO: Update sharesOf[msg.sender]
    
    // INTERACTIONS
    // TODO: Transfer tokens from user
    // TODO: Emit Deposit event
}
```

**💡 Hint:** Calculate shares BEFORE the transfer (because the formula uses current balance)

---

## ✏️ Exercise 2.3: Withdraw Function

Implement the `withdraw` function:

```solidity
/**
 * @notice Withdraw assets by burning shares
 * @param shares Number of shares to burn
 * @return assets Amount received
 */
function withdraw(uint256 shares) external nonReentrant returns (uint256 assets) {
    // CHECKS
    // TODO: Verify shares > 0
    // TODO: Verify sharesOf[msg.sender] >= shares
    
    // EFFECTS
    // TODO: Calculate assets (use _convertToAssets)
    // TODO: Update sharesOf[msg.sender]
    // TODO: Update totalShares
    
    // INTERACTIONS
    // TODO: Transfer assets to user
    // TODO: Emit Withdraw event
}
```

---

## ✏️ Exercise 2.4: WithdrawAll Function

Add a convenience function to withdraw everything:

```solidity
/**
 * @notice Withdraw all user's assets
 */
function withdrawAll() external returns (uint256 assets) {
    // TODO: Implement (reuse withdraw logic)
}
```

---

## ✅ Validation Criteria

- [ ] CEI pattern followed in all functions
- [ ] `nonReentrant` on deposit and withdraw
- [ ] Events emitted correctly
- [ ] Explicit errors (not just `require(false)`)
- [ ] `forge test` passes

---

➡️ **Next exercise: [03 - Rewards](../03_rewards/)**
