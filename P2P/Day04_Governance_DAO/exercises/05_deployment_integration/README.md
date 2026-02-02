# 🚀 Exercice 05: Déploiement & Intégration

## 🎯 Objectif

Déployer l'ensemble du système de gouvernance sur Sepolia.

---

## 📋 Instructions

### 5.1 Script de déploiement

Créez `script/DeployGovernance.s.sol` :

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/PoolToken.sol";
import "../src/VaultGovernor.sol";
import "../src/Vault.sol";

contract DeployGovernance is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Paramètres de gouvernance
        uint256 votingDelay = 1;
        uint256 votingPeriod = 50;
        uint256 quorumPercentage = 4;
        uint256 initialSupply = 1_000_000 ether;
        
        vm.startBroadcast(deployerPrivateKey);
        
        // 1. Déployer token
        PoolToken token = new PoolToken(initialSupply);
        
        // 2. Déployer Vault
        Vault vault = new Vault(address(token));
        
        // 3. Déployer Governor
        VaultGovernor governor = new VaultGovernor(
            IVotes(address(token)),
            votingDelay,
            votingPeriod,
            quorumPercentage
        );
        
        // 4. Configurer le Vault
        vault.setGovernor(address(governor));
        
        // 5. Le deployer délègue à lui-même
        token.delegate(msg.sender);
        
        vm.stopBroadcast();
        
        console.log("Token:", address(token));
        console.log("Vault:", address(vault));
        console.log("Governor:", address(governor));
    }
}
```

---

### 5.2 Déployer

```bash
source .env

forge script script/DeployGovernance.s.sol:DeployGovernance \
  --rpc-url $RPC_SEPOLIA \
  --broadcast \
  --verify
```

**Copiez les adresses affichées !**

---

### 5.3 Interaction CLI

**Déléguer votre pouvoir de vote :**
```bash
cast send $TOKEN_ADDRESS "delegate(address)" $YOUR_ADDRESS \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY
```

**Créer une proposition :**
```bash
# Encoder le calldata
CALLDATA=$(cast calldata "setWithdrawalFee(uint256)" 250)

# Créer la proposition
cast send $GOVERNOR_ADDRESS \
  "propose(address[],uint256[],bytes[],string)" \
  "[$VAULT_ADDRESS]" "[0]" "[$CALLDATA]" "Set fee to 2.5%" \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY
```

**Voter sur une proposition :**
```bash
# 0 = Against, 1 = For, 2 = Abstain
cast send $GOVERNOR_ADDRESS "castVote(uint256,uint8)" $PROPOSAL_ID 1 \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY
```

**Exécuter une proposition :**
```bash
DESCRIPTION_HASH=$(cast keccak "Set fee to 2.5%")

cast send $GOVERNOR_ADDRESS \
  "execute(address[],uint256[],bytes[],bytes32)" \
  "[$VAULT_ADDRESS]" "[0]" "[$CALLDATA]" $DESCRIPTION_HASH \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY
```

---

## ✅ Validation

- [ ] Token avec votes déployé
- [ ] Vault déployé et configuré
- [ ] Governor déployé
- [ ] Délégation effectuée via CLI
- [ ] Proposition créée via CLI
- [ ] Vote effectué
- [ ] Proposition exécutée
- [ ] Frais du Vault modifiés par la DAO
