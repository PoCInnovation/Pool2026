# 📖 Exercise 04: Security

---

## ⚠️ The Risks

1. **Stale price**: Oracle can fail, price stays stuck
2. **Invalid price**: Negative or zero price = wrong calculations
3. **Emergency need**: Ability to stop the contract if problem

---

## ✏️ Exercise 4.1: Custom Errors

Custom errors are more gas-efficient.

Add at the beginning of the contract:

```solidity
error InvalidPrice(int256 price);
error StalePrice(uint256 updatedAt, uint256 threshold);
error ContractPaused();
```

**💡 Why custom errors?**
```solidity
// Old way (expensive - stores string)
require(price > 0, "Price must be positive");

// New way (cheap - only 4-byte selector)
if (price <= 0) revert InvalidPrice(price);
```

---

## ✏️ Exercise 4.2: Improve _getPrice()

```solidity
function _getPrice() internal view returns (uint256 priceUSD, uint256 updatedAt) {
    (
        uint80 roundId,
        int256 answer,
        ,
        uint256 updatedAt_,
        uint80 answeredInRound
    ) = priceFeed.latestRoundData();
    
    // Check 1: Price must be positive
    if (answer <= 0) {
        revert InvalidPrice(answer);
    }
    
    // Check 2: Price not too old
    if (block.timestamp - updatedAt_ > staleThreshold) {
        revert StalePrice(updatedAt_, staleThreshold);
    }
    
    // Check 3: Round is valid (data was actually updated)
    if (answeredInRound < roundId) {
        revert StalePrice(updatedAt_, staleThreshold);
    }
    
    priceUSD = uint256(answer) * 10 ** (18 - feedDecimals);
    updatedAt = updatedAt_;
}
```

**💡 Understanding round checks:**
```
roundId = Current round
answeredInRound = Round when answer was updated

If answeredInRound < roundId → Data wasn't updated this round (stale)
```

---

## ✏️ Exercise 4.3: Circuit Breaker

Add the pause system:

```solidity
bool public paused;

event Paused(address indexed by);
event Unpaused(address indexed by);

modifier whenNotPaused() {
    if (paused) revert ContractPaused();
    _;
}

function pause() external onlyOwner {
    paused = true;
    emit Paused(msg.sender);
}

function unpause() external onlyOwner {
    paused = false;
    emit Unpaused(msg.sender);
}
```

**Don't forget** to add `whenNotPaused` to the `swap()` function:

```solidity
function swap() external payable nonReentrant whenNotPaused returns (uint256 tokensOut) {
    // ...
}
```

---

## ✏️ Exercise 4.4: Secure Configuration

```solidity
event StaleThresholdUpdated(uint256 oldValue, uint256 newValue);
event TokenPriceUpdated(uint256 oldValue, uint256 newValue);

/**
 * @notice Update stale threshold with bounds
 */
function setStaleThreshold(uint256 newThreshold) external onlyOwner {
    require(newThreshold >= 60, "Minimum 60 seconds");
    require(newThreshold <= 86400, "Maximum 24 hours");
    
    uint256 old = staleThreshold;
    staleThreshold = newThreshold;
    emit StaleThresholdUpdated(old, newThreshold);
}

/**
 * @notice Update token price (for pegged stablecoins)
 */
function setTokenPriceUSD(uint256 newPrice) external onlyOwner {
    require(newPrice > 0, "Price must be positive");
    
    uint256 old = tokenPriceUSD;
    tokenPriceUSD = newPrice;
    emit TokenPriceUpdated(old, newPrice);
}
```

---

## ✏️ Exercise 4.5: Security Tests

Create `test/SwapSecurity.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Swap.sol";
import "./mocks/MockPriceFeed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20 {
    constructor() ERC20("Mock", "MCK") {
        _mint(msg.sender, 1_000_000 ether);
    }
}

contract SwapSecurityTest is Test {
    Swap public swapContract;
    MockPriceFeed public mockFeed;
    MockToken public token;
    
    function setUp() public {
        mockFeed = new MockPriceFeed();
        mockFeed.setPrice(300000000000);
        token = new MockToken();
        swapContract = new Swap(
            address(mockFeed),
            address(token),
            18, 1e18, 3600
        );
        token.transfer(address(swapContract), 100_000 ether);
    }
    
    function testRevertOnStalePrice() public {
        // Set price to 2 hours ago
        mockFeed.setUpdatedAt(block.timestamp - 2 hours);
        
        vm.deal(address(this), 1 ether);
        vm.expectRevert();
        swapContract.swap{ value: 1 ether }();
    }
    
    function testRevertOnZeroPrice() public {
        mockFeed.setPrice(0);
        
        vm.deal(address(this), 1 ether);
        vm.expectRevert();
        swapContract.swap{ value: 1 ether }();
    }
    
    function testRevertOnNegativePrice() public {
        mockFeed.setPrice(-100);
        
        vm.deal(address(this), 1 ether);
        vm.expectRevert();
        swapContract.swap{ value: 1 ether }();
    }
    
    function testPauseBlocksSwap() public {
        swapContract.pause();
        
        vm.deal(address(this), 1 ether);
        vm.expectRevert();
        swapContract.swap{ value: 1 ether }();
    }
    
    function testUnpauseAllowsSwap() public {
        swapContract.pause();
        swapContract.unpause();
        
        vm.deal(address(this), 1 ether);
        uint256 tokens = swapContract.swap{ value: 1 ether }();
        assertTrue(tokens > 0);
    }
    
    function testOnlyOwnerCanPause() public {
        vm.prank(address(0x999));
        vm.expectRevert();
        swapContract.pause();
    }
}
```

---

## ✅ Checklist

- [ ] Custom errors defined
- [ ] `_getPrice()` checks everything
- [ ] Circuit breaker works
- [ ] Config has limits
- [ ] Security tests pass

---

➡️ **Next exercise: [05 - Frontend Integration](../05_front_integration/)**
