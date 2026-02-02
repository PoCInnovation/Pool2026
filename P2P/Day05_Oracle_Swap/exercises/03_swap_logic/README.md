# 📖 Exercise 03: Swap Logic

---

## 📐 The Swap Formula

User sends ETH, receives tokens.

```
tokensOut = (ETH_sent × ETH_price) ÷ token_price

Example: 1 ETH × $3000 ÷ $1 = 3000 tokens
```

In Solidity with decimals:

```solidity
tokensOut = (msg.value * priceETH * 10**tokenDecimals) / (1e18 * tokenPriceUSD);
```

**💡 Formula breakdown:**
```
msg.value        = ETH amount (18 decimals - wei)
priceETH         = ETH/USD price (18 decimals after conversion)
tokenDecimals    = Output token decimals (usually 18)
1e18             = To cancel msg.value decimals
tokenPriceUSD    = Token price in USD (18 decimals)
```

---

## ✏️ Exercise 3.1: swap() Function

Add the main swap function:

```solidity
/**
 * @notice Swap ETH for tokens
 * @return tokensOut Amount of tokens received
 * @dev CEI pattern: Checks, Effects, Interactions
 */
function swap() external payable nonReentrant returns (uint256 tokensOut) {
    // CHECKS
    require(msg.value > 0, "Send ETH");
    
    (uint256 priceETH, uint256 updatedAt) = _getPrice();
    require(block.timestamp - updatedAt <= staleThreshold, "Price too old");
    
    // EFFECTS
    // TODO: Calculate tokensOut
    // tokensOut = (msg.value * priceETH * 10**tokenDecimals) / (1e18 * tokenPriceUSD);
    
    require(token.balanceOf(address(this)) >= tokensOut, "Not enough liquidity");
    
    // INTERACTIONS
    token.safeTransfer(msg.sender, tokensOut);
    emit Swapped(msg.sender, msg.value, tokensOut, priceETH);
}
```

---

## ✏️ Exercise 3.2: previewSwap() Function

For frontend to show estimate before swap:

```solidity
/**
 * @notice Preview how many tokens you'll receive
 * @param ethAmount Amount of ETH to swap
 * @return tokensOut Estimated tokens
 * @return priceUsed ETH price used
 */
function previewSwap(uint256 ethAmount) external view returns (
    uint256 tokensOut,
    uint256 priceUsed
) {
    (uint256 priceETH, ) = _getPrice();
    
    // TODO: Same calculation as swap()
    // tokensOut = (ethAmount * priceETH * 10**tokenDecimals) / (1e18 * tokenPriceUSD);
    
    return (tokensOut, priceETH);
}
```

---

## ✏️ Exercise 3.3: Liquidity Management

```solidity
/**
 * @notice Get available token liquidity
 */
function getTokenLiquidity() public view returns (uint256) {
    return token.balanceOf(address(this));
}

/**
 * @notice Get max ETH that can be swapped
 * @dev Inverse of the swap formula
 */
function getMaxSwappableETH() external view returns (uint256 maxEth) {
    uint256 tokenBalance = getTokenLiquidity();
    (uint256 priceETH, ) = _getPrice();
    
    if (priceETH == 0 || tokenBalance == 0) return 0;
    
    // TODO: Inverse formula
    // maxEth = (tokenBalance * 1e18 * tokenPriceUSD) / (priceETH * 10**tokenDecimals);
}

/**
 * @notice Add tokens to the swap pool
 */
function addLiquidity(uint256 amount) external onlyOwner {
    token.safeTransferFrom(msg.sender, address(this), amount);
}

/**
 * @notice Remove tokens from the pool
 */
function removeLiquidity(uint256 amount) external onlyOwner {
    token.safeTransfer(msg.sender, amount);
}

/**
 * @notice Withdraw collected ETH
 */
function withdrawETH() external onlyOwner {
    uint256 balance = address(this).balance;
    require(balance > 0, "No ETH");
    (bool success, ) = payable(owner()).call{ value: balance }("");
    require(success, "Transfer failed");
}
```

---

## ✏️ Exercise 3.4: Tests

Add these tests:

```solidity
function testSwapSuccess() public {
    address user = address(0x123);
    vm.deal(user, 10 ether);  // Give user 10 ETH
    
    vm.prank(user);
    uint256 tokens = swapContract.swap{ value: 1 ether }();
    
    // 1 ETH × $3000 / $1 = 3000 tokens
    assertEq(tokens, 3000 ether);
    assertEq(token.balanceOf(user), 3000 ether);
}

function testSwapZeroValue() public {
    vm.expectRevert("Send ETH");
    swapContract.swap{ value: 0 }();
}

function testPreviewSwap() public view {
    (uint256 tokensOut, ) = swapContract.previewSwap(1 ether);
    assertEq(tokensOut, 3000 ether);
}

function testGetMaxSwappableETH() public view {
    // Pool has 100,000 tokens
    // 100,000 tokens / 3000 = 33.33 ETH max
    uint256 maxEth = swapContract.getMaxSwappableETH();
    assertApproxEqAbs(maxEth, 33.33 ether, 0.01 ether);
}
```

Run: `forge test -vv`

---

## ✅ Checklist

- [ ] `swap()` calculates correctly
- [ ] `previewSwap()` returns correct estimate
- [ ] Liquidity management works
- [ ] Tests pass

---

➡️ **Next exercise: [04 - Security](../04_security/)**
