# 📖 Exercise 01: Understanding Oracles

---

## 🤔 What is an Oracle?

An **oracle** is a bridge between the blockchain and the outside world.

**The problem:** A smart contract cannot access the Internet. It cannot call an API to get the ETH price.

**The solution:** An oracle (like Chainlink) retrieves real-world data and puts it on the blockchain.

```
    REAL WORLD                      BLOCKCHAIN
    
 ┌─────────────┐               ┌─────────────┐
 │  Binance    │               │             │
 │  Coinbase   │──► CHAINLINK ─┼──► Contract │
 │  Kraken     │    (oracle)   │             │
 └─────────────┘               └─────────────┘
```

**Chainlink** aggregates prices from multiple sources to prevent manipulation.

---

## 📐 Decimals

In Solidity, there are no floating-point numbers. We use **implicit decimals**.

```
Chainlink ETH/USD oracle uses 8 decimals.

Real price: $3,000.12
Oracle:     300012000000

To convert: 300012000000 ÷ 10^8 = 3000.12
```

**💡 Common decimal standards:**
| Type | Decimals |
|------|----------|
| Chainlink price feeds | 8 |
| ETH | 18 |
| Most ERC-20 tokens | 18 |
| USDC/USDT | 6 |

---

## ✏️ Exercise 1.1: Find the Feed Address

Each oracle has an address on the blockchain.

1. Go to: https://docs.chain.link/data-feeds/price-feeds/addresses
2. Select **Sepolia** (testnet)
3. Find **ETH / USD**
4. Note the address: `0x694AA1769357215DE4FAC081bf1f309aDC325306`

---

## ✏️ Exercise 1.2: Create PriceReader.sol

Create `src/PriceReader.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title PriceReader
 * @notice Reads ETH/USD price from Chainlink
 */
contract PriceReader {
    
    AggregatorV3Interface public immutable priceFeed;

    constructor(address priceFeedAddress) {
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    /**
     * @notice Returns ETH/USD price
     * @return price The price with 8 decimals
     * @dev TODO: 
     *   - Call latestRoundData()
     *   - Extract the "answer" (2nd return value)
     *   - Return it as int256
     */
    function getLatestPrice() public view returns (int256 price) {
        // TODO: Implement
        // Hint: latestRoundData() returns 5 values
        // Use (, int256 answer, , , ) to ignore the others
    }

    /**
     * @notice Returns the number of decimals
     * @dev TODO: Call decimals() on priceFeed
     */
    function getDecimals() public view returns (uint8) {
        // TODO: Implement
    }

    /**
     * @notice Returns price normalized to 18 decimals
     * @dev TODO:
     *   - Get price and decimals
     *   - Convert: price * 10^(18 - decimals)
     */
    function getPriceIn18Decimals() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        uint8 decimals = priceFeed.decimals();
        
        // TODO: Convert to 18 decimals
        // Formula: price * 10^(18 - decimals)
    }
}
```

---

## 💡 Key Concepts

### Ignoring return values

```solidity
// latestRoundData returns: (roundId, answer, startedAt, updatedAt, answeredInRound)
// We only want "answer":

(, int256 answer, , , ) = priceFeed.latestRoundData();
```

### Decimal conversion

```solidity
// From 8 decimals to 18 decimals:
uint256 price18 = uint256(answer) * 10 ** (18 - 8);
// = answer * 10^10
```

---

## ✏️ Exercise 1.3: Compile

Verify your code compiles:

```bash
forge build
```

---

## ✅ Checklist

- [ ] `getLatestPrice()` returns the price
- [ ] `getDecimals()` returns 8
- [ ] `getPriceIn18Decimals()` converts correctly
- [ ] `forge build` passes without error

---

➡️ **Next exercise: [02 - Price Feed Integration](../02_price_feed/)**
