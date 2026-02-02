# 📖 Exercise 03: Reward System

---

## 🎓 Lesson: How Do Rewards Work?

In a vault, rewards can arrive in several ways:
- The owner sends tokens manually
- An external protocol distributes interest
- Fees are collected and redistributed

### The Mechanism

When tokens are added to the vault without creating new shares, the **ratio increases**:

```
BEFORE reward:
├── Total Assets: 1000 tokens
├── Total Shares: 1000
└── Ratio: 1.0

+ 100 tokens reward

AFTER reward:
├── Total Assets: 1100 tokens
├── Total Shares: 1000 (unchanged!)
└── Ratio: 1.1
```

**Each share is now worth 10% more!**

---

## 🔑 View Functions

Users need to see their situation:

| Function | Purpose |
|----------|---------|
| `totalAssets()` | How many tokens in the vault |
| `currentRatio()` | Current ratio (for display) |
| `assetsOf(user)` | Value of a user's shares |
| `previewDeposit(assets)` | How many shares for X assets? |
| `previewWithdraw(shares)` | How many assets for X shares? |

---

## ✏️ Exercise 3.1: addReward Function

Add a function for the owner to distribute rewards:

```solidity
/**
 * @notice Add rewards to the vault (owner only)
 * @param amount Amount of tokens to add
 * @dev Requirements:
 *   - Caller must be owner
 *   - amount > 0
 *   - There must be stakers (otherwise rewards would be lost)
 */
function addReward(uint256 amount) external onlyOwner nonReentrant {
    // TODO: Verify amount > 0
    // TODO: Verify totalShares > 0
    // TODO: Transfer tokens from owner
    // TODO: Emit RewardAdded(amount) event
}
```

---

## ✏️ Exercise 3.2: View Functions

Implement these functions for the frontend:

```solidity
/**
 * @notice Total assets in the vault
 */
function totalAssets() public view returns (uint256) {
    // TODO: Return asset.balanceOf(address(this))
}

/**
 * @notice Current ratio (multiplied by 1e18 for precision)
 * @return ratio Ex: 1.5e18 means 1 share = 1.5 assets
 */
function currentRatio() external view returns (uint256) {
    // TODO: Handle case totalShares == 0 (return 1e18)
    // TODO: Return (totalAssets * 1e18) / totalShares
}

/**
 * @notice Value of a user's shares
 */
function assetsOf(address user) external view returns (uint256) {
    // TODO: Return _convertToAssets(sharesOf[user])
}

/**
 * @notice Preview deposit
 */
function previewDeposit(uint256 assets) external view returns (uint256) {
    // TODO: Return _convertToShares(assets)
}

/**
 * @notice Preview withdraw
 */
function previewWithdraw(uint256 shares) external view returns (uint256) {
    // TODO: Return _convertToAssets(shares)
}
```

---

## ✏️ Exercise 3.3: Reward Test

Create `test/VaultRewards.t.sol` and write a test that:

1. Alice deposits 1000 tokens
2. Owner adds 100 tokens as reward
3. Verify ratio is now 1.1
4. Alice withdraws everything and receives 1100 tokens

```solidity
function testRewardIncreasesValue() public {
    // TODO: Implement the test
}
```

---

## ✅ Validation Criteria

- [ ] `addReward` only works for owner
- [ ] Cannot add rewards without stakers
- [ ] `currentRatio` returns correct value
- [ ] Reward test passes

---

➡️ **Next exercise: [04 - Security](../04_security/)**
