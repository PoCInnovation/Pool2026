# 🏛️ Exercise 02: Create the Governor

## 🎯 Objective

Create the heart of your DAO: the Governor that manages proposals, votes, and executions.

---

## 📚 Understanding the Governor

The Governor is the central contract that:
1. Receives proposals
2. Manages the voting period
3. Counts votes
4. Executes approved decisions

---

## 📋 Instructions

### 2.1 Create the Governor Contract

Create `src/VaultGovernor.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";

contract VaultGovernor is
    Governor,
    GovernorCountingSimple,
    GovernorVotes,
    GovernorVotesQuorumFraction
{
    uint256 private immutable _votingDelay;
    uint256 private immutable _votingPeriod;

    /**
     * @notice Constructor
     * @param token_ Voting token (must implement IVotes)
     * @param votingDelay_ Delay before voting starts (in blocks)
     * @param votingPeriod_ Duration of voting (in blocks)
     * @param quorumPercentage_ Percentage of supply required for quorum
     * @dev TODO:
     *   - Call Governor("VaultGovernor")
     *   - Call GovernorVotes(token_)
     *   - Call GovernorVotesQuorumFraction(quorumPercentage_)
     *   - Store _votingDelay and _votingPeriod
     */
    constructor(
        IVotes token_,
        uint256 votingDelay_,
        uint256 votingPeriod_,
        uint256 quorumPercentage_
    ) {
        // TODO: Implement
    }

    /**
     * @notice Returns delay before voting
     * @dev TODO: Return _votingDelay
     */
    function votingDelay() public view override returns (uint256) {
        // TODO: Implement
    }

    /**
     * @notice Returns voting duration
     * @dev TODO: Return _votingPeriod
     */
    function votingPeriod() public view override returns (uint256) {
        // TODO: Implement
    }

    /**
     * @notice Returns required quorum
     * @dev Override to resolve inheritance conflict
     */
    function quorum(uint256 blockNumber)
        public
        view
        override(Governor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        // TODO: Call super.quorum()
    }
}
```

---

### 2.2 Key Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `votingDelay` | Delay before voting starts (in blocks) | 1 block |
| `votingPeriod` | Duration of voting (in blocks) | 50 blocks (~10 min) |
| `quorumPercentage` | Minimum participation % | 4% |

**💡 Understanding blocks vs time:**
- Ethereum: ~12 seconds per block
- 50 blocks ≈ 10 minutes
- 7200 blocks ≈ 1 day

**💡 Understanding quorum:**
```
If total supply = 1,000,000 tokens
And quorum = 4%
Then 40,000 votes needed for proposal to pass
```

---

### 2.3 OpenZeppelin Extensions Explained

| Extension | Purpose |
|-----------|---------|
| `Governor` | Base contract with core functionality |
| `GovernorCountingSimple` | Simple For/Against/Abstain voting |
| `GovernorVotes` | Uses ERC20Votes for voting power |
| `GovernorVotesQuorumFraction` | Quorum as % of supply |

---

### 2.4 Create Tests

Create `test/VaultGovernor.t.sol` with these tests:

| Test | What to verify |
|------|----------------|
| `testGovernorParameters()` | `votingDelay()`, `votingPeriod()`, `name()` match the values passed to the constructor |
| `testQuorumCalculation()` | With 1M token supply and 4% quorum, `quorum(blockNumber)` returns 40,000 tokens (in wei). **Hint:** `quorum()` takes a block number as argument |
| `testCreateProposal()` | A proposal can be created and returns a non-zero ID. **Hints:** (1) Delegate tokens to the proposer first and `vm.roll(block.number + 1)`. (2) Build `targets`, `values`, `calldatas` arrays (length 1). (3) Call `governor.propose(targets, values, calldatas, description)`. |

---

## ✅ Validation

```bash
forge test --match-contract VaultGovernorTest -vvv
```

- [ ] Governor compiles without errors
- [ ] Parameters correctly configured
- [ ] Quorum calculated correctly
- [ ] Proposal creation works

---

➡️ **Next exercise: [03 - Vault Governance](../03_vault_governance/)**
