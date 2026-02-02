# 📚 Exercise 02: User Profile System

## 🎯 Objective

Consolidate your knowledge by creating a complete user profile system using all the concepts learned (structs, mappings, enums, modifiers, custom errors, events).

---

## 📖 Context

In blockchain, once deployed, you can't fix a bug. **Testing is a religion.** This exercise will help you practice combining multiple Solidity concepts into a real-world use case.

---

## 📋 Instructions

### 2.1 Data Structures

Create `src/ProfileSystem.sol` with the following elements:

**💡 Hint - Combining concepts:**
```solidity
// Enum for finite states
enum Status { Pending, Active, Banned }

// Struct to group related data
struct User {
    string name;
    Status status;
    uint256 createdAt;
}

// Mapping to store per-address data
mapping(address => User) public users;
```

**Your task:**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProfileSystem {
    // ========== ENUMS ==========
    // TODO: Create enum Role { GUEST, USER, ADMIN }
    
    // ========== STRUCTS ==========
    // TODO: Create struct UserProfile with:
    //   - string username
    //   - uint256 level
    //   - Role role
    //   - uint256 lastUpdated
    
    // ========== MAPPINGS ==========
    // TODO: mapping(address => UserProfile) public profiles
    
    // ========== CUSTOM ERRORS ==========
    // TODO: error UserAlreadyExists()
    // TODO: error EmptyUsername()
    // TODO: error UserNotRegistered()
}
```

---

### 2.2 Modifier: onlyRegistered

**💡 Hint - Checking if user exists:**
```solidity
// A user exists if their level > 0 (default is 0)
modifier onlyRegistered() {
    if (profiles[msg.sender].level == 0) {
        revert UserNotRegistered();
    }
    _;
}
```

**Your task:**
```solidity
/**
 * @notice Modifier that checks if user has a profile
 * @dev Revert with UserNotRegistered if profiles[msg.sender].level == 0
 */
modifier onlyRegistered() {
    // TODO: Implement
    _;
}
```

---

### 2.3 Function: createProfile

**💡 Hint - Checking for empty string:**
```solidity
// bytes() converts string to bytes array
// Empty string has length 0
if (bytes(name).length == 0) {
    revert EmptyUsername();
}
```

**💡 Hint - block.timestamp:**
```solidity
// block.timestamp gives current block time in seconds (Unix timestamp)
uint256 currentTime = block.timestamp;
```

**Your task:**
```solidity
/**
 * @notice Create a new user profile
 * @param _name The username (cannot be empty)
 * @dev TODO:
 *   1. Check bytes(_name).length > 0, else revert EmptyUsername
 *   2. Check profiles[msg.sender].level == 0, else revert UserAlreadyExists
 *   3. Create profile with:
 *      - username: _name
 *      - level: 1
 *      - role: Role.USER
 *      - lastUpdated: block.timestamp
 */
function createProfile(string calldata _name) external {
    // TODO: Implement
}
```

---

### 2.4 Function: levelUp

**Your task:**
```solidity
/**
 * @notice Increase user level by 1
 * @dev Must use onlyRegistered modifier
 *   1. Increment profiles[msg.sender].level
 *   2. Update lastUpdated to block.timestamp
 */
function levelUp() external onlyRegistered {
    // TODO: Implement
}
```

---

### 2.5 Bonus: Events

**💡 Hint:** Add events to track important actions:

```solidity
event ProfileCreated(address indexed user, string username);
event LevelUp(address indexed user, uint256 newLevel);
```

---

## 📝 Tests

Create `test/ProfileSystem.t.sol` with these test cases:

**💡 Hint - Test structure:**
```solidity
contract ProfileTest is Test {
    ProfileSystem public system;
    address user1 = address(0x1);
    
    function setUp() public {
        system = new ProfileSystem();
    }
    
    function testCreateProfile() public {
        vm.startPrank(user1);  // Simulate user1 calling
        system.createProfile("Alice");
        
        // Read from public mapping
        (string memory name, uint256 level, , ) = system.profiles(user1);
        
        assertEq(name, "Alice");
        assertEq(level, 1);
        vm.stopPrank();
    }
}
```

**Test cases to implement:**
- `testCreateProfile()` - Verify name and level = 1
- `testCannotCreateEmptyProfile()` - Expect revert EmptyUsername
- `testCannotCreateDuplicateProfile()` - Expect revert UserAlreadyExists
- `testLevelUp()` - Verify level increments
- `testCannotLevelUpIfNotRegistered()` - Expect revert UserNotRegistered

---

## 💡 Key Concepts

| Concept | Usage in this exercise |
|---------|------------------------|
| `enum` | Define finite set of roles |
| `struct` | Group user profile data |
| `mapping` | Store profiles by address |
| `modifier` | Protect functions |
| `custom error` | Gas-efficient error handling |
| `block.timestamp` | Record action time |

---

## ✅ Validation

```bash
forge test --match-contract ProfileTest -vvvv
```

All tests must pass! ✅

---

➡️ **Next exercise: [03 - Deployment](../03_deployment/)**
