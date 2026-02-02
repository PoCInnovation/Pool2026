# 🎫 Exercise 01: Token with Voting Power (ERC20Votes)

## 🎯 Objective

Add voting capabilities to your token. The foundation of any DAO: **1 Token = 1 Vote**.

---

## 📚 The "Flash Loan Voting" Problem

### Attack Scenario

1. Alice wants to pass a malicious proposal
2. She borrows 1 million tokens via a flash loan
3. She votes with 1 million votes
4. She repays the flash loan in the same transaction
5. → Result: She influenced the vote without owning any tokens!

### Solution: Checkpoints (Snapshots)

Instead of reading the current balance, we read the balance **at the block when the proposal was created**. Since the flash loan happens in a single block, the historical balance remains 0.

```
Block 100: Proposal created (snapshot taken)
Block 101: Alice borrows 1M tokens via flash loan
Block 101: Alice tries to vote → getPastVotes(alice, block 100) = 0 ❌
Block 101: Alice repays flash loan
```

**ERC20Votes** stores balance history using checkpoints, making this attack impossible.

---

## 📋 Instructions

### 1.1 Prerequisites

You need:
- Your `PoolToken.sol` from Day 02 (or create a basic ERC-20 if you skipped Day 02)
- Understanding of Solidity inheritance

---

### 1.2 Modify Your Token

**If you did Day 02:** Modify your existing `src/PoolToken.sol`.

**If you didn't do Day 02:** Create a basic ERC-20 first:

<details>
<summary>📦 Click here for base token (if you skipped Day 02)</summary>

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PoolToken is ERC20, Ownable {
    constructor(uint256 initialSupply)
        ERC20("PoolToken", "POOL")
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

</details>

---

### 1.3 Add ERC20Votes

Modify your `src/PoolToken.sol` to add voting capabilities:

**💡 Required imports:**
```solidity
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
```

**💡 Contract inheritance:**
```solidity
contract PoolToken is ERC20Permit, ERC20Votes, Ownable {
    // ...
}
```

**💡 Constructor must call parent constructors:**
- `ERC20("PoolToken", "POOL")`
- `ERC20Permit("PoolToken")` — name must match!
- `Ownable(msg.sender)`

---

### 1.4 Resolve Diamond Inheritance

ERC20Permit and ERC20Votes both inherit from ERC20. You must override conflicting functions.

**Required overrides:**

```solidity
/**
 * @dev Override _update to resolve inheritance conflict
 * @dev TODO: Call super._update(from, to, value)
 */
function _update(address from, address to, uint256 value)
    internal
    override(ERC20, ERC20Votes)
{
    // TODO: Implement
}

/**
 * @dev Override nonces to resolve inheritance conflict
 * @dev TODO: Return super.nonces(owner)
 */
function nonces(address owner)
    public
    view
    override(ERC20Permit, Nonces)
    returns (uint256)
{
    // TODO: Implement
}
```

---

### 1.5 Understanding Delegation

**Critical concept:** Tokens don't vote automatically! Users must **delegate** their voting power.

| Action | Effect |
|--------|--------|
| `token.delegate(msg.sender)` | Activate your own voting power |
| `token.delegate(alice)` | Give your votes to Alice |
| No delegation | Voting power = 0 (even with tokens!) |

**💡 Why delegation?**
- Creates a checkpoint (prevents flash loan attacks)
- Allows liquid democracy (delegate to experts)
- Explicit opt-in to governance

---

### 1.6 Key Functions from ERC20Votes

| Function | Purpose |
|----------|---------|
| `delegate(address)` | Delegate voting power to an address |
| `getVotes(address)` | Get current voting power |
| `getPastVotes(address, blockNumber)` | Get historical voting power (for proposals) |
| `delegates(address)` | See who someone delegated to |

---

## 📝 Tests to Implement

Create `test/PoolToken.t.sol` with these test cases:

| Test | What to verify |
|------|----------------|
| `testInitialVotingPowerIsZero()` | User owns tokens but hasn't delegated → `getVotes()` returns 0 |
| `testDelegateToSelf()` | After `delegate(self)`, `getVotes()` equals token balance |
| `testDelegateToOther()` | Alice delegates to Bob → Bob's voting power increases, Alice's stays 0 |
| `testGetPastVotes()` | After delegation and `vm.roll()`, `getPastVotes(user, pastBlock)` returns historical balance |

**💡 Testing hints:**
- Use `vm.prank(user)` to simulate calls from different addresses
- Use `vm.roll(block.number + 1)` to advance blocks (needed for checkpoints)
- Distribute tokens in `setUp()` using `token.transfer()`

---

## ✅ Validation

```bash
forge test --match-contract PoolTokenVotesTest -vvv
```

- [ ] Token compiles with ERC20Votes
- [ ] `_update()` override resolves inheritance
- [ ] `nonces()` override resolves inheritance
- [ ] Initial voting power = 0 without delegation
- [ ] Self-delegation activates voting power
- [ ] Delegation to another transfers voting power
- [ ] `getPastVotes()` returns historical balance

---

## 💡 Common Mistakes

| Mistake | Fix |
|---------|-----|
| Voting power is always 0 | Did you call `delegate()`? |
| "Diamond inheritance" error | Add both overrides with correct `override(...)` |
| ERC20Permit name mismatch | Name in `ERC20Permit("...")` must match `ERC20("...", ...)` |
| Tests fail on `getPastVotes` | Use `vm.roll()` to advance at least 1 block after delegation |

---

➡️ **Next exercise: [02 - Governor](../02_governor/)**
