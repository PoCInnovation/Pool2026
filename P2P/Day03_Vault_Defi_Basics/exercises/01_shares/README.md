# 📖 Exercise 01: Shares (Ownership Stakes)

---

## 🎓 Lesson: What is a Share?

In a DeFi vault, users don't keep their tokens directly. They receive **shares** in exchange.

### Why Use Shares?

Imagine a vault where Alice and Bob each deposit 100 tokens:

```
BEFORE rewards:
├── Vault: 200 tokens
├── Alice: 100 shares (50%)
└── Bob:   100 shares (50%)

The vault receives 50 tokens as rewards...

AFTER rewards:
├── Vault: 250 tokens
├── Alice: 100 shares = 125 tokens
└── Bob:   100 shares = 125 tokens
```

**Shares automatically distribute gains!**

---

## 🔑 Vocabulary

| Term | Definition |
|------|------------|
| **Asset** | The token being deposited (USDC, ETH, etc.) |
| **Share** | The stake received in exchange |
| **Ratio** | How many assets 1 share is worth |

---

## 📐 The Formulas

### Deposit: Assets → Shares

```
shares = (assets × totalShares) / totalAssets
```

### Withdraw: Shares → Assets

```
assets = (shares × totalAssets) / totalShares
```

### Special Case: First Deposit

When `totalShares == 0`, use a 1:1 ratio:
```
shares = assets
```

### ⚠️ Watch the Order of Operations!

```solidity
// ❌ BAD - precision loss
shares = assets / totalAssets * totalShares;

// ✅ GOOD - multiplication before division
shares = (assets * totalShares) / totalAssets;
```

---

## ✏️ Exercise 1.1: Theoretical Questions

Create the file `exercises/01_shares/answers.md` and answer:

**Question 1:** A vault contains 1000 tokens and has issued 500 shares. What is the ratio?

**Question 2:** With this ratio, if I deposit 200 tokens, how many shares will I receive?

**Question 3:** The vault receives 100 tokens as rewards. What is the new ratio?

**Question 4:** If I withdraw my shares from Q2, how many tokens will I get back?

---

## ✏️ Exercise 1.2: Implementing the Formulas

In `src/Vault.sol`, implement these two functions:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault {
    IERC20 public immutable asset;
    uint256 public totalShares;
    
    constructor(address asset_) {
        asset = IERC20(asset_);
    }
    
    /**
     * @notice Converts assets to shares
     * @dev TODO:
     *   - Handle the case totalShares == 0
     *   - Use asset.balanceOf(address(this)) for totalAssets
     */
    function _convertToShares(uint256 assets) internal view returns (uint256) {
        // TODO: Implement
    }
    
    /**
     * @notice Converts shares to assets
     * @dev TODO:
     *   - Handle the case totalShares == 0
     *   - Use the formula: shares * totalAssets / totalShares
     */
    function _convertToAssets(uint256 shares) internal view returns (uint256) {
        // TODO: Implement
    }
}
```

---

## ✅ Validation Criteria

- [ ] Formulas are correct
- [ ] Case `totalShares == 0` is handled
- [ ] Multiplication BEFORE division
- [ ] Functions are `internal view`

---

➡️ **Next exercise: [02 - Deposit & Withdraw](../02_deposit_withdraw/)**
