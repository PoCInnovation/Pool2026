# 🔎 Exercise 05: Advanced CLI Interaction

## 🎯 Objective

Interact with your deployed contracts directly from the terminal like a real blockchain hacker!

---

## 📖 Why CLI?

Etherscan is great for beginners, but real developers use the terminal:
- Faster workflow
- Scriptable/automatable
- Works in CI/CD pipelines
- Makes you look cool 😎

---

## 📋 Prerequisites

1. Both `SmartContract` and `ProfileSystem` deployed on Sepolia
2. Contracts verified on Etherscan
3. Environment loaded: `source .env`

---

## 📋 Instructions

### 5.1 Deploy ProfileSystem

```bash
forge create src/ProfileSystem.sol:ProfileSystem \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```

**Copy the contract address!**

### 5.2 Verify on Etherscan

```bash
forge flatten src/ProfileSystem.sol > ProfileSystem.flat.sol
```

Then verify on Etherscan (same settings as SmartContract).

---

## 📚 Cast Commands Reference

**💡 `cast` is Foundry's CLI tool for blockchain interaction**

### Reading Data (Free - No Gas)

| Command | Usage |
|---------|-------|
| `cast call` | Call view/pure functions |
| `cast storage` | Read raw storage slots |
| `cast balance` | Check ETH balance |

### Writing Data (Costs Gas)

| Command | Usage |
|---------|-------|
| `cast send` | Send transactions |

---

### 5.3 Create a Profile

**💡 Hint:** Use `cast send` for state-changing functions

```bash
cast send <PROFILE_SYSTEM_ADDRESS> "createProfile(string)" "MyHackerName" \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY
```

---

### 5.4 Read Data

**Read a public variable:**
```bash
cast call <CONTRACT_ADDRESS> "halfAnswerOfLife()" --rpc-url $RPC_URL
```

**Read from a mapping:**
```bash
# For ProfileSystem's profiles mapping
cast call <PROFILE_SYSTEM_ADDRESS> "profiles(address)" <YOUR_ADDRESS> \
  --rpc-url $RPC_URL
```

**💡 Hint:** The result is ABI-encoded. You'll see hex data representing the struct fields.

---

### 5.5 Call Functions

**Function without parameters:**
```bash
cast send <PROFILE_SYSTEM_ADDRESS> "levelUp()" \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY
```

**Function with parameters:**
```bash
cast send <CONTRACT_ADDRESS> "editMyCity(string)" "New York" \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY
```

---

### 5.6 Send ETH

**Payable function:**
```bash
cast send <CONTRACT_ADDRESS> "addToBalance()" \
  --value 0.01ether \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY
```

**Check balance after:**
```bash
cast call <CONTRACT_ADDRESS> "getMyBalance()" --rpc-url $RPC_URL
```

---

### 5.7 Explore Storage

**Read specific storage slot:**
```bash
cast storage <CONTRACT_ADDRESS> 0 --rpc-url $RPC_URL
cast storage <CONTRACT_ADDRESS> 1 --rpc-url $RPC_URL
```

**Convert hex to decimal:**
```bash
cast --to-dec 0x15  # Returns: 21
```

**Convert decimal to hex:**
```bash
cast --to-hex 42  # Returns: 0x2a
```

---

## 📝 Useful Cast Commands

| Command | Description |
|---------|-------------|
| `cast call` | Read data (free) |
| `cast send` | Write data (costs gas) |
| `cast storage` | Read raw storage |
| `cast balance <addr>` | Get ETH balance |
| `cast tx <hash>` | Get transaction details |
| `cast receipt <hash>` | Get transaction receipt |
| `cast --to-dec <hex>` | Convert hex → decimal |
| `cast --to-hex <dec>` | Convert decimal → hex |
| `cast keccak <text>` | Compute keccak256 hash |
| `cast abi-encode` | Encode function data |
| `cast abi-decode` | Decode function data |

---

## 🎯 Challenge Tasks

Try these on your own:

1. **Level up 3 times** using `cast send`
2. **Read your profile** and decode the level
3. **Add 0.05 ETH** to your SmartContract balance
4. **Withdraw 0.02 ETH** from your balance
5. **Find the hash** of "Hello World" using `cast keccak`

---

## ✅ Validation

- [ ] ProfileSystem deployed and verified
- [ ] Profile created via `cast send`
- [ ] Data read via `cast call`
- [ ] Storage explored via `cast storage`
- [ ] Payable function tested with ETH
- [ ] Level up function called successfully

---

## 🏁 Day 01 Complete!

**Congratulations!** You have:
1. ✅ Learned Solidity fundamentals
2. ✅ Built a complete data system
3. ✅ Written unit tests
4. ✅ Deployed to a real blockchain
5. ✅ Discovered blockchain transparency
6. ✅ Optimized for gas
7. ✅ Mastered CLI interaction

**Tomorrow:** We transform data into **NFTs** and **Tokens**! 🚀
