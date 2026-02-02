# 🗳️ Exercise 04: Create and Vote on Proposals

## 🎯 Objective

Test the complete workflow: create a proposal, vote, and execute!

---

## 📚 Proposal Lifecycle

```
Pending → Active → Succeeded/Defeated → Executed/Expired
```

1. **Pending**: Proposal created, waiting for voting delay
2. **Active**: Voting period in progress
3. **Succeeded**: Quorum reached + FOR majority
4. **Defeated**: Quorum not reached or AGAINST majority
5. **Executed**: Actions executed

---

## 📋 Instructions

### 4.1 Proposal Structure

To create a proposal, you need these elements:

| Element | Type | Description |
|---------|------|-------------|
| `targets` | `address[]` | Contract addresses to call |
| `values` | `uint256[]` | ETH to send (usually 0) |
| `calldatas` | `bytes[]` | Encoded function calls |
| `description` | `string` | Text description |

**💡 Encoding calldata:** Use `abi.encodeWithSignature("functionName(type)", arg)` or `abi.encodeWithSelector(Contract.functionName.selector, arg)`.

---

### 4.2 Create a Proposal

**What to do:** Build `targets`, `values`, `calldatas` (e.g. one action: call `vault.setWithdrawalFee(250)`), then call `governor.propose(targets, values, calldatas, description)`. The function returns the `proposalId`.

---

### 4.3 Vote on a Proposal

**Vote support values:** `0` = Against, `1` = For, `2` = Abstain. Call `governor.castVote(proposalId, support)`. You can only vote when the proposal is **Active** (after voting delay).

---

### 4.4 Execute a Proposal

**What to do:** After the vote ends and the proposal **Succeeded**, call `governor.execute(targets, values, calldatas, descriptionHash)`. The `descriptionHash` must be `keccak256(bytes(description))` — same string as when creating the proposal.

---

### 4.5 Integration Test

Create `test/GovernanceIntegration.t.sol` and implement:

**`testFullGovernanceWorkflow()`** — full cycle in one test:

1. **Setup:** Give a proposer enough tokens, have them delegate to themselves, then `vm.roll(block.number + 1)` so delegation is effective.
2. **Create proposal:** Same `targets`, `values`, `calldatas`, `description` as above; call `propose(...)` and store `proposalId`.
3. **Wait for voting:** `vm.roll(block.number + governor.votingDelay() + 1)` so the proposal becomes Active.
4. **Vote:** e.g. `castVote(proposalId, 1)` for For.
5. **Wait for end:** `vm.roll(block.number + governor.votingPeriod() + 1)`.
6. **Execute:** `governor.execute(targets, values, calldatas, keccak256(bytes(description)))`.
7. **Verify:** e.g. `vault.withdrawalFeeBps()` has the new value.

**`testCannotVoteTwice()`** — same user voting twice on the same proposal should revert.

**`testProposalFailsWithoutQuorum()`** — a proposal that does not reach quorum should end in Defeated (check `governor.state(proposalId)`).

---

## 💡 Key Points

- Use `vm.roll()` to advance time (blocks)
- Quorum is calculated on total supply
- Each address can only vote once per proposal
- Don't forget to delegate before creating/voting!

**💡 Debugging:** `governor.state(proposalId)` returns the status (0 Pending, 1 Active, 3 Defeated, 4 Succeeded, 7 Executed, etc.). `governor.quorum(blockNumber)` gives the required votes for quorum.

---

## ✅ Validation

```bash
forge test --match-contract GovernanceIntegrationTest -vvvv
```

- [ ] Proposal creation works
- [ ] FOR/AGAINST/ABSTAIN voting works
- [ ] Double vote rejected
- [ ] Execution succeeds after approval
- [ ] Vault fees modified via vote

---

➡️ **Next exercise: [05 - Deployment](../05_deployment_integration/)**

---

## 🏆 Congratulations!

You have built a complete **DAO governance system** with:
- ✅ Voting token with checkpoints
- ✅ Governor contract
- ✅ Governable vault
- ✅ Full proposal lifecycle

This is the foundation of protocols like **Compound**, **Uniswap**, and **Aave**! 🎉
