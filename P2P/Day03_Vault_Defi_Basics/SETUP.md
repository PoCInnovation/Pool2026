# Day 03 – Setup

## 🎯 Objectif

Préparer l'environnement pour coder, tester et déployer le **Vault de staking ERC-20** avec système de shares/assets, rewards et protection anti-réentrance.

---

## ✅ Prérequis

### Du Day 02
- [ ] Projet Foundry initialisé et fonctionnel
- [ ] OpenZeppelin installé (`forge install OpenZeppelin/openzeppelin-contracts`)
- [ ] Adresse de votre PoolToken (ERC-20) déployé sur Sepolia
- [ ] ETH Sepolia suffisant pour les transactions

### Wallet & Tokens
- [ ] Des PoolTokens dans votre wallet testnet (pour staker)
- [ ] ETH Sepolia pour le gas (approve + deposit + withdraw)

### Outils
- [ ] Foundry à jour (`foundryup`)
- [ ] `.env` configuré avec RPC_SEPOLIA, PRIVATE_KEY_TEST, ETHERSCAN_API_KEY

---

## 🛠️ Étapes de Configuration

### 1. Vérifier les Dépendances

```bash
# Vérifier Foundry
forge --version

# Vérifier que le projet compile
forge build
```

Si des erreurs de remapping OpenZeppelin apparaissent, vérifiez votre `foundry.toml` :

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200

remappings = ["@openzeppelin/=lib/openzeppelin-contracts/"]
```

### 2. Configuration Environnement

Créez ou éditez votre `.env` :

```bash
# Clé privée de test (NE JAMAIS UTILISER EN PRODUCTION)
PRIVATE_KEY_TEST=0xvotre_cle_privee

# RPC Sepolia (Alchemy, Infura, ou autre)
RPC_SEPOLIA=https://sepolia.infura.io/v3/YOUR_KEY

# Etherscan API pour la vérification
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_KEY

# Adresse du token ERC-20 du Day02
TOKEN_ADDRESS=0xYourPoolTokenAddress
```

Chargez les variables :

```bash
source .env
```

### 3. Vérifier le Token ERC-20

Avant de créer le Vault, assurez-vous que votre token du Day02 fonctionne :

```bash
# Vérifier le nom du token
cast call $TOKEN_ADDRESS "name()" --rpc-url $RPC_SEPOLIA

# Vérifier votre balance
cast call $TOKEN_ADDRESS "balanceOf(address)" $YOUR_WALLET --rpc-url $RPC_SEPOLIA

# Si besoin, mint des tokens (si vous êtes owner)
cast send $TOKEN_ADDRESS "mint(address,uint256)" $YOUR_WALLET 10000000000000000000000 \
  --rpc-url $RPC_SEPOLIA \
  --private-key $PRIVATE_KEY_TEST
```

### 4. Test Local avec Anvil (Optionnel mais recommandé)

Anvil permet de tester rapidement sans attendre les confirmations sur Sepolia.

```bash
# Terminal 1 : Lancer Anvil
anvil

# Terminal 2 : Déployer un mock token et le vault
forge script script/DeployVault.s.sol:DeployVault --rpc-url http://localhost:8545 --broadcast
```

### 5. Lancer les Tests

```bash
# Tous les tests
forge test

# Tests avec verbosité (voir les logs)
forge test -vvv

# Tests avec coverage
forge coverage

# Un test spécifique
forge test --match-test testDepositFirst -vvvv
```

---

## 📁 Structure des Fichiers

```
Day03_Vault_Defi_Basics/
├── README.md              # Instructions et exercices
├── SETUP.md               # Ce fichier
```

---

## 🔧 Commandes Utiles

### Compilation
```bash
forge build
```

### Tests
```bash
forge test                    # Tous les tests
forge test -vvvv              # Avec détails
forge test --match-test testDeposit  # Tests matching "testDeposit"
forge coverage                # Coverage report
```

### Déploiement
```bash
# Sepolia
forge script script/DeployVault.s.sol:DeployVault \
  --rpc-url $RPC_SEPOLIA \
  --broadcast \
  --verify

# Local (Anvil)
forge script script/DeployVault.s.sol:DeployVault \
  --rpc-url http://localhost:8545 \
  --broadcast
```

### Interaction avec Cast
```bash
# Lire le total assets
cast call $VAULT_ADDRESS "totalAssets()" --rpc-url $RPC_SEPOLIA

# Lire les shares d'un utilisateur
cast call $VAULT_ADDRESS "sharesOf(address)" $YOUR_WALLET --rpc-url $RPC_SEPOLIA

# Approve le vault
cast send $TOKEN_ADDRESS "approve(address,uint256)" $VAULT_ADDRESS 1000000000000000000000 \
  --rpc-url $RPC_SEPOLIA --private-key $PRIVATE_KEY_TEST

# Déposer 100 tokens
cast send $VAULT_ADDRESS "deposit(uint256)" 100000000000000000000 \
  --rpc-url $RPC_SEPOLIA --private-key $PRIVATE_KEY_TEST

# Retirer 50 shares
cast send $VAULT_ADDRESS "withdraw(uint256)" 50000000000000000000 \
  --rpc-url $RPC_SEPOLIA --private-key $PRIVATE_KEY_TEST
```

---

## 🌐 Intégration Frontend

Après déploiement, configurez le frontend :

```javascript
// config.js ou .env du frontend
VAULT_ADDRESS=0xYourVaultAddress
TOKEN_ADDRESS=0xYourPoolTokenAddress
SHOW_VAULT=true
```

Fonctionnalités à vérifier :
- [ ] Affichage du solde de shares
- [ ] Preview du dépôt (combien de shares)
- [ ] Bouton Approve puis Deposit
- [ ] Preview du retrait (combien d'assets)
- [ ] Bouton Withdraw
- [ ] Affichage du ratio actuel

---

## 🆘 Troubleshooting

### "Compiler run failed"
```bash
# Réinstaller OpenZeppelin
forge install OpenZeppelin/openzeppelin-contracts --no-commit

# Vérifier les remappings
cat foundry.toml
```

### "Insufficient funds"
```bash
# Obtenir du Sepolia ETH sur un faucet
# https://sepoliafaucet.com/
# https://www.alchemy.com/faucets/ethereum-sepolia
```

### "ERC20: insufficient allowance"
```bash
# Vous devez approve avant de déposer
cast send $TOKEN_ADDRESS "approve(address,uint256)" $VAULT_ADDRESS 1000000000000000000000 \
  --rpc-url $RPC_SEPOLIA --private-key $PRIVATE_KEY_TEST
```

---

## ✅ Prêt ?

Passez au [README.md](./README.md) pour implémenter le Vault avec :
- Système deposit/withdraw avec shares
- Pattern CEI anti-réentrance
- Système de rewards
- Tests de sécurité
