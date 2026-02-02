# 📖 Exercise 04: Security - Reentrancy Attack

---

## 🎓 Lesson: The Reentrancy Attack

This is the most famous attack in DeFi. It cost **$60 million** to The DAO in 2016.

### How It Works

```
1. Attacker calls withdraw(100)
2. Vault calculates: "OK, I owe 100 tokens"
3. Vault sends 100 tokens to attacker
4. ⚠️ Attacker's contract has receive() that calls withdraw(100) again
5. Vault calculates: "OK, I owe 100 tokens" (balance not yet updated!)
6. Vault sends another 100 tokens
7. ... and so on until the vault is drained
```

### The Protections

**1. CEI Pattern (Checks-Effects-Interactions)**
```solidity
function withdraw(uint256 amount) external {
    require(balance[msg.sender] >= amount);  // Check
    balance[msg.sender] -= amount;            // Effect BEFORE
    token.transfer(msg.sender, amount);       // Interaction AFTER
}
```

**2. OpenZeppelin's ReentrancyGuard**
```solidity
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vault is ReentrancyGuard {
    function withdraw(uint256 amount) external nonReentrant {
        // ...
    }
}
```

The `nonReentrant` modifier prevents calling the function twice in the same transaction.

---

## ⚔️ Attack Scenario

```
┌─────────────────┐          ┌─────────────────┐
│    Attacker     │          │      Vault      │
└────────┬────────┘          └────────┬────────┘
         │                            │
         │ 1. deposit(100)            │
         │ ──────────────────────────▶│
         │                            │
         │ 2. withdraw(100)           │
         │ ──────────────────────────▶│
         │                            │
         │    3. transfer() triggers  │
         │◀─────────receive()──────── │
         │                            │
         │ 4. withdraw(100) AGAIN     │
         │ ──────────────────────────▶│
         │                            │
         │    5. transfer()           │
         │◀──────────────────────────│
         │                            │
         │ ... until vault is empty   │
```

---

## ✏️ Exercise 4.1: Create a Malicious Token

To test your vault's security, create a malicious token:

File: `test/mocks/MaliciousToken.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MaliciousToken
 * @notice Token that attempts a reentrancy attack during transfer
 */
contract MaliciousToken is ERC20 {
    address public vault;
    bool public attacking;
    uint256 public attackCount;

    constructor() ERC20("Malicious", "MAL") {
        _mint(msg.sender, 1_000_000 ether);
    }

    function setVault(address vault_) external {
        vault = vault_;
    }

    function setAttacking(bool attacking_) external {
        attacking = attacking_;
    }

    /**
     * @dev Override transfer to trigger the attack
     * @dev TODO: If attacking == true and msg.sender == vault
     *      Try to call vault.withdraw(amount) again
     *      Increment attackCount
     */
    function transfer(address to, uint256 amount) public override returns (bool) {
        // TODO: Implement attack logic
        
        return super.transfer(to, amount);
    }
}
```

---

## ✏️ Exercise 4.2: Reentrancy Test

File: `test/VaultReentrancy.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vault.sol";
import "./mocks/MaliciousToken.sol";

contract VaultReentrancyTest is Test {
    Vault public vault;
    MaliciousToken public maliciousToken;
    address public attacker = address(0x666);

    function setUp() public {
        // TODO: Deploy malicious token
        // TODO: Deploy vault with this token
        // TODO: Configure token to target vault
        // TODO: Give tokens to attacker
    }

    function testReentrancyProtection() public {
        // TODO: Attacker deposits tokens
        // TODO: Enable attack mode
        // TODO: Attacker calls withdraw
        // TODO: Verify attack failed (funds are protected)
    }
}
```

---

## ✅ Validation Criteria

- [ ] Malicious token implemented
- [ ] Reentrancy test written
- [ ] Vault resists the attack
- [ ] `nonReentrant` present on all risky functions

---

## 🔐 Final Security Checklist

Verify your vault has:

- [ ] `nonReentrant` on `deposit`
- [ ] `nonReentrant` on `withdraw`
- [ ] `nonReentrant` on `withdrawAll`
- [ ] `nonReentrant` on `addReward`
- [ ] CEI pattern respected everywhere
- [ ] `SafeERC20` used for transfers

---

➡️ **Next exercise: [05 - DeFi Integration](../05_defi_integration/)**
