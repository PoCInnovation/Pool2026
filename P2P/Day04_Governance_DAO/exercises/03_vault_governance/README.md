# 🏗️ Exercise 03: Prepare Vault for Governance

## 🎯 Objective

Modify your Day 03 Vault to be controlled by the DAO.

---

## 📋 Instructions

### 3.1 Add Governance Elements to the Vault

Modify your `src/Vault.sol` to add:

```solidity
// ========== GOVERNANCE VARIABLES ==========
// TODO: uint256 public withdrawalFeeBps (in basis points: 100 = 1%)
// TODO: address public governor
// TODO: uint256 public constant MAX_FEE = 1000 (max 10%)

// ========== EVENTS ==========
// TODO: event WithdrawalFeeUpdated(uint256 oldFee, uint256 newFee)
// TODO: event GovernorUpdated(address indexed oldGovernor, address indexed newGovernor)

// ========== ERRORS ==========
// TODO: error OnlyGovernor()
// TODO: error FeeTooHigh()

// ========== MODIFIER ==========
modifier onlyGovernor() {
    // TODO: Check msg.sender == governor
    // TODO: Otherwise revert OnlyGovernor()
    _;
}
```

**💡 Understanding basis points:**
```
100 bps = 1%
250 bps = 2.5%
1000 bps = 10%

Fee calculation:
fee = (amount * feeBps) / 10000
```

---

### 3.2 Governance Functions

Implement these functions:

```solidity
/**
 * @notice Set the Governor address
 * @param newGovernor New Governor address
 * @dev TODO:
 *   - Restrict to onlyOwner
 *   - Save old governor
 *   - Update governor
 *   - Emit GovernorUpdated
 */
function setGovernor(address newGovernor) external {
    // TODO: Implement
}

/**
 * @notice Modify withdrawal fee (called by Governor after vote)
 * @param newFeeBps New fee in basis points (100 = 1%)
 * @dev TODO:
 *   - Restrict to onlyGovernor
 *   - Check newFeeBps <= MAX_FEE, otherwise revert FeeTooHigh
 *   - Save old fee
 *   - Update withdrawalFeeBps
 *   - Emit WithdrawalFeeUpdated
 */
function setWithdrawalFee(uint256 newFeeBps) external {
    // TODO: Implement
}
```

**💡 Hint:** Use the `onlyGovernor` modifier, check the fee is ≤ MAX_FEE, then update state and emit the event.

---

### 3.3 Modify the withdraw Function

Modify `withdraw()` to apply fees:

```solidity
function withdraw(uint256 sharesToBurn) external nonReentrant {
    // ... existing checks ...
    
    uint256 assetsToReturn = _convertToAssets(sharesToBurn);
    
    // TODO: Calculate fee
    // fee = (assetsToReturn * withdrawalFeeBps) / 10000
    
    // TODO: Calculate amount after fee
    // assetsAfterFee = assetsToReturn - fee
    
    // ... Effects ...
    
    // TODO: Transfer assetsAfterFee (not assetsToReturn)
    // Fees stay in the Vault (benefit all remaining stakers!)
}
```

**💡 Hint:** Fee = `(assetsToReturn * withdrawalFeeBps) / 10000`. User receives `assetsToReturn - fee`; the fee stays in the vault.

---

### 3.4 Create Tests

Create `test/VaultGovernance.t.sol` with these tests:

| Test | What to verify |
|------|----------------|
| `testSetWithdrawalFee()` | Governor can set the fee; `withdrawalFeeBps()` returns the new value |
| `testNonGovernorCannotSetFee()` | A non-governor call reverts with `OnlyGovernor`. **Hint:** `vm.expectRevert(Vault.OnlyGovernor.selector)` |
| `testFeeCannotExceedMax()` | Setting fee &gt; MAX_FEE (e.g. 1500 for 15%) reverts with `FeeTooHigh` |
| `testWithdrawalWithFee()` | After setting a fee (e.g. 2.5%), a user who withdraws receives `assets - fee` (e.g. 975 for 1000 assets at 2.5%) |

---

## ✅ Validation

```bash
forge test --match-contract VaultGovernanceTest -vvv
```

- [ ] Governor can modify fees
- [ ] Non-governor cannot modify fees
- [ ] Fee > MAX_FEE rejected
- [ ] Fees correctly applied to withdrawals

---

➡️ **Next exercise: [04 - Proposals & Voting](../04_proposals_voting/)**
