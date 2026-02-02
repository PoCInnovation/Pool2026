# 🪙 Exercise 02: ERC-20 with Permit (EIP-2612)

## 🎯 Objective

Create an ERC-20 token with the Permit feature for gasless approvals.

---

## 📖 Understanding ERC-20

### What is ERC-20?

- A standard for **fungible tokens** (interchangeable)
- Every token is identical to another
- Used for: cryptocurrencies, stablecoins, governance tokens, etc.

**💡 Example:** 1 USDC = 1 USDC (always), unlike NFTs where each is unique.

---

## 📖 Understanding Permit (EIP-2612)

### The Problem

Normally, to let a contract spend your tokens:
1. Call `approve()` → **pay gas**
2. Contract calls `transferFrom()` → **pay gas**

**Two transactions = expensive and bad UX!**

### The Solution: Permit

1. Sign a message off-chain → **FREE** (no gas)
2. Contract calls `permit()` + `transferFrom()` → **one transaction**

**One transaction = cheaper and better UX!**

---

## 📋 Instructions

### 2.1 Create the ERC-20 Contract

Create `src/PoolToken.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PoolToken is ERC20Permit, Ownable {
    
    // ========== EVENTS ==========
    // TODO: Declare event TokensMinted(address indexed to, uint256 amount)

    /**
     * @notice Constructor
     * @param initialSupply Initial supply to mint to deployer
     * @dev TODO:
     *   1. Call ERC20("PoolToken", "POOL")
     *   2. Call ERC20Permit("PoolToken") - NAME MUST MATCH!
     *   3. Call Ownable(msg.sender)
     *   4. Mint initialSupply to msg.sender using _mint()
     */
    constructor(uint256 initialSupply) {
        // TODO: Implement
    }

    /**
     * @notice Mint new tokens
     * @param to Recipient address
     * @param amount Amount to mint
     * @dev TODO:
     *   - Add onlyOwner modifier
     *   - Call _mint(to, amount)
     *   - Emit TokensMinted event
     */
    function mint(address to, uint256 amount) external {
        // TODO: Implement
    }

    /**
     * @notice Burn your own tokens
     * @param amount Amount to burn
     * @dev TODO: Call _burn(msg.sender, amount)
     */
    function burn(uint256 amount) external {
        // TODO: Implement
    }
}
```

---

### 2.2 Key Concepts

**💡 Important: Name consistency**
```solidity
// The name in ERC20Permit MUST match ERC20!
ERC20("PoolToken", "POOL")      // Token name
ERC20Permit("PoolToken")         // SAME name for signatures to work!
```

**💡 Using _mint and _burn:**
```solidity
// Internal functions provided by ERC20
_mint(recipient, amount);  // Create new tokens
_burn(holder, amount);     // Destroy tokens
```

**💡 Inherited functions (from ERC20):**
- `name()` - Returns token name
- `symbol()` - Returns token symbol
- `decimals()` - Returns 18 (default)
- `totalSupply()` - Total tokens in existence
- `balanceOf(address)` - Balance of an address
- `transfer(to, amount)` - Send tokens
- `approve(spender, amount)` - Allow spending
- `transferFrom(from, to, amount)` - Spend allowed tokens

---

### 2.3 Write Tests

Create `test/PoolToken.t.sol`:

**Test cases to implement:**

| Test | What to verify |
|------|----------------|
| `testInitialSupply()` | `totalSupply()` and `balanceOf(owner)` equal initialSupply |
| `testTokenMetadata()` | name = "PoolToken", symbol = "POOL", decimals = 18 |
| `testMint()` | Owner can mint, balances update correctly |
| `testOnlyOwnerCanMint()` | Non-owner gets reverted |
| `testBurn()` | User can burn their tokens, supply decreases |
| `testPermit()` | `DOMAIN_SEPARATOR()` is not zero (proves Permit works) |

**💡 Test hint:**
```solidity
function testOnlyOwnerCanMint() public {
    vm.startPrank(nonOwner);
    vm.expectRevert();  // Expects the next call to revert
    token.mint(nonOwner, 1000);
    vm.stopPrank();
}
```

---

## ✅ Validation

```bash
forge test --match-contract PoolTokenTest -vvvv
```

- [ ] Contract compiles
- [ ] Initial supply minted correctly
- [ ] Only owner can mint
- [ ] Anyone can burn their own tokens
- [ ] DOMAIN_SEPARATOR exists (Permit enabled)

---

➡️ **Next exercise: [03 - ERC-721 NFT](../03_erc721_nft/)**
