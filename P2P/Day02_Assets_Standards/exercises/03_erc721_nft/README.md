# 🖼️ Exercise 03: ERC-721 + IPFS (NFTs)

## 🎯 Objective

Deploy an NFT collection with metadata stored on IPFS.

---

## 📖 Understanding ERC-721

### What is ERC-721?

- A standard for **non-fungible tokens** (unique)
- Each token has a unique ID
- Used for: digital art, collectibles, game items, identities, etc.

**💡 Example:** CryptoPunk #1234 is different from CryptoPunk #5678

---

## 📖 Understanding IPFS

### What is IPFS?

- **InterPlanetary File System** - decentralized file storage
- Files are identified by their **CID** (Content Identifier)
- Immutable: same content = same CID always

### Why IPFS for NFTs?

- NFT metadata (name, description, image) is too large for on-chain storage
- Store metadata on IPFS, only store the URI on-chain
- Contract stores `baseURI` that points to IPFS folder

**💡 How tokenURI works:**
```
baseURI = "ipfs://QmAbc123/"
tokenId = 1

tokenURI(1) = "ipfs://QmAbc123/1"
→ Points to metadata file: 1.json
```

---

## 📋 Instructions

### 3.1 Prepare IPFS Metadata with Pinata

**Option 1: Use a placeholder (quick start)**
```bash
BASE_URI="ipfs://QmPlaceholder123/"
```

**Option 2: Upload to IPFS (recommended)**

1. Create account on [Pinata.cloud](https://www.pinata.cloud/)
2. Create metadata files:

**metadata/1.json:**
```json
{
  "name": "Pool NFT #1",
  "description": "My first NFT from the Blockchain Discovery Pool",
  "image": "ipfs://QmYourImageCID/image1.png"
}
```

3. Upload folder to Pinata
4. Copy the folder CID
5. Your baseURI: `ipfs://YOUR_CID/`

---

### 3.2 Create the ERC-721 Contract

Create `src/PoolNFT.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PoolNFT is ERC721, Ownable, ReentrancyGuard {
    
    // ========== STATE VARIABLES ==========
    // TODO: string private _baseTokenURI
    // TODO: uint256 private _tokenIdCounter (starts at 0, first mint = 1)

    // ========== EVENTS ==========
    // TODO: event NFTMinted(address indexed to, uint256 indexed tokenId)

    /**
     * @notice Constructor
     * @param baseURI_ Base URI for IPFS metadata
     * @dev TODO:
     *   1. Call ERC721("PoolNFT", "PNFT")
     *   2. Call Ownable(msg.sender)
     *   3. Set _baseTokenURI = baseURI_
     *   4. Set _tokenIdCounter = 0
     */
    constructor(string memory baseURI_) {
        // TODO: Implement
    }

    /**
     * @notice Returns base URI for metadata
     * @dev Override ERC721's _baseURI()
     */
    function _baseURI() internal view override returns (string memory) {
        // TODO: Return _baseTokenURI
    }

    /**
     * @notice Public getter for baseURI
     */
    function baseURI() external view returns (string memory) {
        // TODO: Return _baseTokenURI
    }

    /**
     * @notice Mint a single NFT
     * @param to Recipient address
     * @dev TODO:
     *   - Add onlyOwner nonReentrant modifiers
     *   - Increment _tokenIdCounter
     *   - Call _safeMint(to, tokenId)
     *   - Emit NFTMinted event
     */
    function mint(address to) external {
        // TODO: Implement
    }

    /**
     * @notice Mint multiple NFTs in one transaction
     * @param to Recipient address
     * @param quantity Number of NFTs to mint
     * @dev TODO: Loop and mint each NFT
     */
    function mintBatch(address to, uint256 quantity) external {
        // TODO: Implement
    }

    /**
     * @notice Update base URI
     * @param newBaseURI New base URI
     * @dev TODO: Only owner can call
     */
    function setBaseURI(string memory newBaseURI) external {
        // TODO: Implement
    }

    /**
     * @notice Returns total number of NFTs minted
     */
    function totalSupply() external view returns (uint256) {
        // TODO: Return _tokenIdCounter
    }
}
```

---

### 3.3 Key Concepts

**💡 _mint vs _safeMint:**
```solidity
// _mint - basic, doesn't check recipient
_mint(to, tokenId);

// _safeMint - checks if recipient can receive NFTs
// (important for contracts that might not support NFTs)
_safeMint(to, tokenId);
```

**💡 Token IDs start at 1:**
```solidity
// Better UX: tokens are #1, #2, #3... not #0, #1, #2
_tokenIdCounter++;  // Increment FIRST
uint256 tokenId = _tokenIdCounter;  // Then use
```

**💡 ReentrancyGuard:**
```solidity
// Prevents reentrancy attacks
function mint(address to) external nonReentrant {
    // Safe from callback attacks
}
```

---

### 3.4 Write Tests

Create `test/PoolNFT.t.sol`:

| Test | What to verify |
|------|----------------|
| `testMetadata()` | name, symbol, baseURI |
| `testMint()` | ownerOf, balanceOf, totalSupply |
| `testTokenIdStartsAtOne()` | First token is ID 1, not 0 |
| `testOnlyOwnerCanMint()` | Non-owner reverts |
| `testMintBatch()` | All 5 tokens minted with correct IDs |
| `testSetBaseURI()` | Owner can update URI |

---

## ✅ Validation

```bash
forge test --match-contract PoolNFTTest -vvvv
```

- [ ] Contract compiles
- [ ] Token IDs start at 1
- [ ] Batch mint works
- [ ] Only owner can mint
- [ ] baseURI configured correctly

---

➡️ **Next exercise: [04 - Advanced Standards](../04_advanced_standards/)**
