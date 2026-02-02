# 📖 Exercise 02: Using the Price Feed

---

## 📐 Decimal Conversion

The oracle returns a price with **8 decimals**, but we often work with **18 decimals** (standard ERC-20).

```solidity
// Oracle: 300000000000 (= $3000 in 8 dec)
// Conversion to 18 dec:
uint256 price18 = uint256(answer) * 10 ** (18 - 8);
// Result: 3000000000000000000000 (= $3000 in 18 dec)
```

---

## ✏️ Exercise 2.1: Swap Structure

Create `src/Swap.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Swap is ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;

    // Immutables
    AggregatorV3Interface public immutable priceFeed;
    IERC20 public immutable token;
    uint8 public immutable feedDecimals;
    uint8 public immutable tokenDecimals;

    // Configuration
    uint256 public staleThreshold;
    uint256 public tokenPriceUSD;

    // Events
    event Swapped(address indexed user, uint256 ethAmount, uint256 tokenAmount, uint256 priceUsed);

    /**
     * @param priceFeedAddress Chainlink price feed address
     * @param tokenAddress ERC-20 token to swap
     * @param tokenDecimals_ Token decimals (usually 18)
     * @param tokenPriceUSD_ Token price in USD (18 decimals)
     * @param staleThreshold_ Max age of price data in seconds
     * @dev TODO: Initialize all variables
     */
    constructor(
        address priceFeedAddress,
        address tokenAddress,
        uint8 tokenDecimals_,
        uint256 tokenPriceUSD_,
        uint256 staleThreshold_
    ) Ownable(msg.sender) {
        // TODO: Initialize
        // priceFeed = AggregatorV3Interface(priceFeedAddress);
        // feedDecimals = priceFeed.decimals();
        // token = IERC20(tokenAddress);
        // tokenDecimals = tokenDecimals_;
        // tokenPriceUSD = tokenPriceUSD_;
        // staleThreshold = staleThreshold_;
    }
}
```

**💡 Understanding staleThreshold:**
```
staleThreshold = 3600 (1 hour)

If price was last updated 30 min ago → Valid
If price was last updated 2 hours ago → Stale (reject!)
```

---

## ✏️ Exercise 2.2: _getPrice() Function

Add this internal function:

```solidity
/**
 * @notice Get ETH price normalized to 18 decimals
 * @return priceUSD ETH price in USD (18 decimals)
 * @return updatedAt Timestamp of last update
 */
function _getPrice() internal view returns (uint256 priceUSD, uint256 updatedAt) {
    (, int256 answer, , uint256 updatedAt_, ) = priceFeed.latestRoundData();
    
    require(answer > 0, "Invalid price");
    
    // TODO: Convert to 18 decimals
    // priceUSD = uint256(answer) * 10 ** (18 - feedDecimals);
    
    return (priceUSD, updatedAt_);
}
```

---

## ✏️ Exercise 2.3: getCurrentPrice() Function

Public function for frontend:

```solidity
/**
 * @notice Get current price status for frontend
 * @return price ETH/USD price (18 decimals)
 * @return isStale True if price is too old
 * @return lastUpdate Timestamp of last update
 */
function getCurrentPrice() external view returns (
    uint256 price,
    bool isStale,
    uint256 lastUpdate
) {
    (uint256 priceUSD, uint256 updatedAt) = _getPrice();
    
    // TODO: Calculate isStale
    // bool stale = (block.timestamp - updatedAt) > staleThreshold;
    
    return (priceUSD, stale, updatedAt);
}
```

---

## ✏️ Exercise 2.4: Create the Mock

For testing, we need a mock price feed.

Create `test/mocks/MockPriceFeed.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockPriceFeed {
    int256 public price;
    uint256 public updatedAt;
    uint8 public constant decimals = 8;
    
    function setPrice(int256 _price) external {
        price = _price;
        updatedAt = block.timestamp;
    }
    
    function setUpdatedAt(uint256 _updatedAt) external {
        updatedAt = _updatedAt;
    }
    
    function latestRoundData() external view returns (
        uint80, int256, uint256, uint256, uint80
    ) {
        return (0, price, 0, updatedAt, 0);
    }
}
```

---

## ✏️ Exercise 2.5: Basic Test

Create `test/Swap.t.sol`:

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

contract SwapTest is Test {
    Swap public swapContract;
    MockPriceFeed public mockFeed;
    MockToken public token;
    
    function setUp() public {
        mockFeed = new MockPriceFeed();
        mockFeed.setPrice(300000000000); // $3000 with 8 decimals
        
        token = new MockToken();
        
        swapContract = new Swap(
            address(mockFeed),
            address(token),
            18,     // tokenDecimals
            1e18,   // tokenPriceUSD = $1
            3600    // staleThreshold = 1 hour
        );
        
        // Add liquidity
        token.transfer(address(swapContract), 100_000 ether);
    }
    
    function testGetCurrentPrice() public view {
        (uint256 price, bool isStale, ) = swapContract.getCurrentPrice();
        assertEq(price, 3000 * 1e18); // $3000 in 18 decimals
        assertFalse(isStale);
    }
}
```

Run: `forge test -vv`

---

## ✅ Checklist

- [ ] Constructor initializes all variables
- [ ] `_getPrice()` converts to 18 decimals
- [ ] `getCurrentPrice()` detects stale prices
- [ ] Tests pass

---

➡️ **Next exercise: [03 - Swap Logic](../03_swap_logic/)**
