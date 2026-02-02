# 📚 Exercise 01: Solidity Basics

## 🎯 Objective

Create your first smart contract in Solidity by learning the fundamental concepts.

---

## 📖 Introduction

Solidity is a language for writing smart contracts on the Ethereum blockchain. A smart contract is a program stored and executed on the blockchain.

---

## 📋 Instructions

### Step 0.01 - Basic Structure

Create `src/SmartContract.sol` with the basic structure:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SmartContract {
    // Your code here
}
```

**Key concepts:**
- `// SPDX-License-Identifier: MIT` : Specifies the contract license (required to avoid compiler warnings)
- `pragma solidity ^0.8.20;` : Declares the minimum Solidity version required (^0.8.20 means >= 0.8.20 and < 0.9.0)
- `contract SmartContract` : Declares a new Solidity contract

**✓ Expected result:** A file with the basic structure of a Solidity contract.

---

### Step 0.02 & 0.03 - Variables and Visibility

Add variables with different visibility levels:

**💡 Hint - Visibility types:**
| Visibility | Accessible from | Use case |
|------------|-----------------|----------|
| `public` | Everywhere | Data you want to expose |
| `internal` | Contract + children | Shared between inherited contracts |
| `private` | This contract only | Sensitive internal data |

**📝 Example:**
```solidity
// Public - auto-generates a getter function
uint256 public myNumber = 42;

// Internal - convention uses _ prefix
bool internal _isActive = true;

// Private - convention uses _ prefix
address private _secretAddress;
```

**Your task - Add these variables:**

1. **Public variables:**
   - `uint256 public halfAnswerOfLife` = 21
   - `address public myEthereumContractAddress` = `address(this)` (the contract's own address)
   - `address public myEthereumAddress` = `msg.sender` (deployer's address)
   - `string public PoCIsWhat` = "PoC is good, PoC is life."

2. **Internal variable:**
   - `bool internal _areYouABadPerson` = false

3. **Private variable:**
   - `int256 private _youAreACheater` = -42 (note: `int256` can be negative!)

---

### Step 0.04 - Advanced Types

Add complex data structures:

**💡 Hint - Type explanations:**

| Type | Description | Example |
|------|-------------|---------|
| `bytes32` | Fixed 32-byte data | Hashes, IDs |
| `mapping` | Key-value store | `mapping(address => uint)` |
| `array` | Fixed or dynamic list | `string[5]`, `uint[]` |
| `enum` | Named constants | `enum Status { Active, Inactive }` |
| `struct` | Custom data type | Group multiple fields |

**📝 Example - How to create a struct:**
```solidity
// Define the struct
struct Person {
    string name;
    uint8 age;
}

// Create an instance
Person public alice = Person({
    name: "Alice",
    age: 25
});
```

**Your task:**

1. Add a `bytes32` variable named `whoIsTheBest`
2. Add a `mapping(string => uint256) public myGrades`
3. Add a fixed array `string[5] public myPhoneNumber`
4. Create an `enum roleEnum { STUDENT, TEACHER }`
5. Create a `struct informations` with: firstName, lastName, age (uint8), city, role
6. Create an instance `informations public myInformations`

---

### Step 0.05 - Functions

Add functions with different visibility:

**💡 Hint - Function modifiers:**
| Modifier | Meaning |
|----------|---------|
| `view` | Reads state, doesn't modify |
| `pure` | No state access at all |
| `payable` | Can receive ETH |
| (none) | Can modify state |

**📝 Example:**
```solidity
// View function - reads but doesn't write
function getNumber() public view returns (uint256) {
    return myNumber;
}

// Pure function - just calculates
function add(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
```

**Your task - Implement these functions:**

```solidity
/**
 * @notice Returns halfAnswerOfLife
 * @dev TODO: Return the value of halfAnswerOfLife
 */
function getHalfAnswerOfLife() public view returns (uint256) {
    // TODO: Implement
}

/**
 * @notice Returns the contract address (internal)
 * @dev TODO: Return myEthereumContractAddress
 */
function _getMyEthereumContractAddress() internal view returns (address) {
    // TODO: Implement
}

/**
 * @notice Returns PoCIsWhat (external only)
 * @dev TODO: Return PoCIsWhat with memory keyword for string
 */
function getPoCIsWhat() external view returns (string memory) {
    // TODO: Implement
}

/**
 * @notice Sets _areYouABadPerson (internal)
 * @dev TODO: Update the internal variable
 */
function _setAreYouABadPerson(bool _value) internal {
    // TODO: Implement
}
```

---

### Step 0.06 - Foundry Tests

Create `test/SmartContract.t.sol`:

**💡 Hint - Testing internal functions:**
To test `internal` functions, create a helper contract that inherits from your contract:

```solidity
contract SmartContractHelper is SmartContract {
    // Expose internal functions as public
    function getAreYouABadPerson() public view returns (bool) {
        return _areYouABadPerson;  // Access internal variable
    }
}
```

**💡 Hint - Foundry test structure:**
```solidity
import "forge-std/Test.sol";

contract MyTest is Test {
    function setUp() public {
        // Runs before each test
    }
    
    function testSomething() public {
        assertEq(actual, expected);  // Check equality
    }
}
```

**Your task:**
- Create tests for `getHalfAnswerOfLife()` 
- Create tests for internal variable access via helper
- Create tests for struct data

**Command:** `forge test -vvvv`

---

### Step 0.07 - Data Location

**💡 Hint - memory vs calldata:**
| Location | Usage | Can modify? | Gas cost |
|----------|-------|-------------|----------|
| `calldata` | Function params | No | Lower |
| `memory` | Temp variables | Yes | Higher |
| `storage` | State variables | Yes | Highest |

**📝 Example:**
```solidity
// calldata for input (read-only, cheaper)
function setName(string calldata _name) public { }

// memory for return (can be constructed)
function getName() public view returns (string memory) { }
```

**Your task - Implement:**
```solidity
function editMyCity(string calldata _newCity) public {
    // TODO: Update myInformations.city
}

function getMyFullName() public view returns (string memory) {
    // TODO: Concatenate firstName + " " + lastName
    // Hint: Use abi.encodePacked() to concatenate strings
    // return string(abi.encodePacked(str1, " ", str2));
}
```

---

### Step 0.08 - Modifiers

**💡 Hint - Modifier pattern:**
```solidity
address private owner;

constructor() {
    owner = msg.sender;  // Set deployer as owner
}

modifier onlyOwner() {
    require(msg.sender == owner, "Not the owner");
    _;  // This is where the function code runs
}

function sensitiveAction() public onlyOwner {
    // Only owner can call this
}
```

**Your task:**
1. Add `address private owner` variable
2. Create constructor that sets `owner = msg.sender`
3. Create `onlyOwner` modifier
4. Create `completeHalfAnswerOfLife()` function that adds 21 to halfAnswerOfLife (protected by onlyOwner)

---

### Step 0.09 - Hashing

**💡 Hint:** `keccak256` is Ethereum's hash function.

```solidity
function hashMyMessage(string calldata _message) public pure returns (bytes32) {
    // TODO: return the message hashed with keccak256
}
```

---

### Step 0.10 - ETH Management

**💡 Hint - Payable functions:**
```solidity
// payable allows receiving ETH
function deposit() public payable {
    // msg.value contains the ETH amount sent
}

// Sending ETH (safe pattern)
(bool success, ) = recipient.call{value: amount}("");
require(success, "Transfer failed");
```

**Your task:**
```solidity
mapping(address => uint256) public balances;

function getMyBalance() public view returns (uint256) {
    // TODO: Return balances[msg.sender]
}

function addToBalance() public payable {
    // TODO: Add msg.value to balances[msg.sender]
}

function withdrawFromBalance(uint256 _amount) public {
    // TODO: 
    // 1. Check balance >= amount
    // 2. Subtract from balance FIRST (before transfer!)
    // 3. Transfer using call{value}
    // 4. Check success
}
```

---

### Step 0.11 - Events

**💡 Hint:** Events log data on the blockchain that indexers and tools can read.

```solidity
event BalanceUpdated(address indexed user, uint256 newBalance);

// In your functions:
emit BalanceUpdated(msg.sender, balances[msg.sender]);
```

**Your task:** Add the event and emit it in `addToBalance()` and `withdrawFromBalance()`

---

### Step 0.12 - Custom Errors

**💡 Hint:** Custom errors save gas compared to strings in require().

```solidity
// Declaration
error InsufficientBalance(uint256 available, uint256 requested);

// Usage
if (balances[msg.sender] < _amount) {
    revert InsufficientBalance(balances[msg.sender], _amount);
}
```

**Your task:** Replace the require in `withdrawFromBalance()` with a custom error.

---

### Step 0.13 - Interface

**💡 Hint:** Interfaces define the contract's public API.

Create `src/interfaces/ISmartContract.sol`:
```solidity
interface ISmartContract {
    // Declare types, events, errors, and function signatures
    // (no implementation!)
}
```

Then make your contract inherit: `contract SmartContract is ISmartContract { }`

---

## ✅ Validation

```bash
forge build
forge test -vvvv
```

All tests must pass! ✅
