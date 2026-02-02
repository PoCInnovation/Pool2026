# ⛽ Exercise 04: Gas Optimization

## 🎯 Objective

Learn to optimize your contracts to reduce transaction fees for your users.

---

## 📖 Why Gas Matters

In Solidity, every operation costs **gas**. Gas = money for your users. Optimizing gas makes your contracts cheaper to use.

---

## 📋 Optimization Techniques

### 4.1 Custom Errors vs require()

**❌ Bad practice (expensive):**
```solidity
require(msg.sender == owner, "Only owner can call this function");
```
The string is stored on-chain = expensive!

**✅ Good practice (cheap):**
```solidity
error NotOwner();

if (msg.sender != owner) revert NotOwner();
```
Custom errors only store a 4-byte selector = ~50 gas saved per call!

---

### 4.2 Variable Packing

Solidity stores variables in 32-byte slots. Small variables can share a slot!

**❌ Bad order (4 slots = expensive):**
```solidity
uint256 a;    // Slot 0 (32 bytes)
uint8 b;      // Slot 1 (wastes 31 bytes!)
uint256 c;    // Slot 2
uint8 d;      // Slot 3 (wastes 31 bytes!)
```

**✅ Good order (2 slots = cheap):**
```solidity
uint256 a;    // Slot 0
uint256 c;    // Slot 1
uint8 b;      // Slot 2 (shared!)
uint8 d;      // Slot 2 (shared!)
```

**💡 Rule:** Group small types together (uint8, bool, address)

---

### 4.3 View and Pure Functions

`view` and `pure` functions are **FREE** when called off-chain (read-only calls).

```solidity
// Free when called read-only (no transaction sent)
function getLevel(address user) external view returns (uint256) {
    return profiles[user].level;
}

// Pure = no state access at all (just math)
function calculateBonus(uint256 level) external pure returns (uint256) {
    return level * 10;
}
```

---

### 4.4 Short-Circuit Evaluation

Put the **cheapest check first**:

```solidity
// ✅ Good: simple check first (might skip expensive mapping read)
if (amount == 0 || balances[msg.sender] < amount) revert();

// ❌ Bad: mapping read first (always executed)
if (balances[msg.sender] < amount || amount == 0) revert();
```

---

### 4.5 calldata vs memory

For function parameters you don't modify:

```solidity
// ✅ calldata = cheaper (read-only, no copy)
function setName(string calldata _name) external { }

// ❌ memory = more expensive (creates a copy)
function setName(string memory _name) external { }
```

---

## 🎯 Challenge: Optimize your ProfileSystem!

### Gas Targets

| Function        | ❌ Not optimized | ✅ Well optimized |
|-----------------|------------------|-------------------|
| `createProfile` | > 80,000         | < 55,000          |
| `levelUp`       | > 35,000         | < 28,000          |

### Check your gas usage:

```bash
forge test --gas-report
```

---

## 📝 Optimization Checklist

Apply these to your `ProfileSystem.sol`:

1. **Custom Errors** ✓ (already done in exercise 02)
2. **calldata for string params**
   ```solidity
   // Change this:
   function createProfile(string memory _name)
   // To this:
   function createProfile(string calldata _name)
   ```
3. **Variable packing in struct** - reorder fields if possible
4. **Short-circuit checks** - put cheapest conditions first

---

## 💡 Optimization Tips from AI

Use these prompts to get AI help:

**For calldata optimization:**
> "Which `memory` parameters in my Solidity functions can be changed to `calldata`? Code: [paste]"

**For struct packing:**
> "Analyze my Solidity struct and reorganize for optimal storage packing: [paste struct]"

**For general audit:**
> "Find gas optimization opportunities in my Solidity contract: [paste code]"

---

## ✅ Validation

```bash
forge test --gas-report
```

- [ ] `createProfile` < 55,000 gas
- [ ] `levelUp` < 28,000 gas
- [ ] All custom errors used
- [ ] calldata used for string parameters

---

➡️ **Next exercise: [05 - CLI Interaction](../05_cli_interaction/)**
