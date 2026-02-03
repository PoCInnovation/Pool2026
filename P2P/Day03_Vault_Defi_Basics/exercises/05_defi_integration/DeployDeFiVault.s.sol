// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/VaultWithHarvest.sol";
import "../src/RewardToken.sol";
import "../src/interfaces/IUniswapV2.sol";

/**
 * @title DeployDeFiVault
 * @notice Script de déploiement complet pour le système Vault + Uniswap
 *
 * @dev Ce script déploie :
 *      1. RewardToken (RWRD)
 *      2. VaultWithHarvest
 *      3. Configure la pool Uniswap (si nécessaire)
 *
 * Usage :
 * ```bash
 * # Configurer les variables d'environnement
 * export PRIVATE_KEY_TEST=0x...
 * export RPC_SEPOLIA=https://sepolia.infura.io/v3/...
 * export POOL_TOKEN_ADDRESS=0x...
 * export UNISWAP_ROUTER=0x...  # Optionnel, utilise défaut Sepolia
 *
 * # Déployer
 * forge script script/DeployDeFiVault.s.sol:DeployDeFiVault \
 *   --rpc-url $RPC_SEPOLIA \
 *   --broadcast \
 *   --verify
 * ```
 */
contract DeployDeFiVault is Script {
    // Adresses Uniswap V2 par réseau
    // Note: Sur Sepolia, vous devrez peut-être déployer votre propre router
    // ou utiliser un fork comme SushiSwap
    address constant UNISWAP_V2_ROUTER_SEPOLIA =
        0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008;

    function run() external {
        // ═══════════════════════════════════════════════════════════════════
        //                         CONFIGURATION
        // ═══════════════════════════════════════════════════════════════════

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address poolTokenAddress = vm.envAddress("POOL_TOKEN_ADDRESS");

        // Router Uniswap (utilise la variable d'env ou le défaut)
        address uniswapRouter;
        try vm.envAddress("UNISWAP_ROUTER") returns (address router) {
            uniswapRouter = router;
        } catch {
            uniswapRouter = UNISWAP_V2_ROUTER_SEPOLIA;
        }
        // Supply initial du RewardToken
        uint256 rewardTokenSupply = 1_000_000 ether;

        vm.startBroadcast(deployerPrivateKey);

        // ═══════════════════════════════════════════════════════════════════
        //                      DEPLOY REWARD TOKEN
        // ═══════════════════════════════════════════════════════════════════

        console.log("Deploying RewardToken...");
        RewardToken rewardToken = new RewardToken(rewardTokenSupply);
        console.log("RewardToken deployed at:", address(rewardToken));
        console.log("  Symbol:", rewardToken.symbol());
        console.log("  Total Supply:", rewardTokenSupply / 1e18, "RWRD");

        // ═══════════════════════════════════════════════════════════════════
        //                         DEPLOY VAULT
        // ═══════════════════════════════════════════════════════════════════

        console.log("\nDeploying VaultWithHarvest...");
        VaultWithHarvest vault = new VaultWithHarvest(
            poolTokenAddress,
            address(rewardToken),
            uniswapRouter
        );
        console.log("VaultWithHarvest deployed at:", address(vault));
        console.log("  Asset (POOL):", poolTokenAddress);
        console.log("  Reward Token (RWRD):", address(rewardToken));
        console.log("  Uniswap Router:", uniswapRouter);

        // ═══════════════════════════════════════════════════════════════════
        //                         SUMMARY
        // ═══════════════════════════════════════════════════════════════════

        console.log("\n========================================");
        console.log("           DEPLOYMENT SUMMARY           ");
        console.log("========================================");
        console.log("RewardToken (RWRD):", address(rewardToken));
        console.log("VaultWithHarvest:  ", address(vault));
        console.log("========================================");
        console.log("\nNEXT STEPS:");
        console.log("1. Create Uniswap pool: POOL/RWRD");
        console.log("2. Add initial liquidity");
        console.log("3. Test deposit/harvest flow");
        console.log("========================================");

        vm.stopBroadcast();
    }
}

/**
 * @title CreateUniswapPool
 * @notice Script pour créer et initialiser la pool Uniswap POOL/RWRD
 *
 * Usage :
 * ```bash
 * export POOL_TOKEN_ADDRESS=0x...
 * export REWARD_TOKEN_ADDRESS=0x...
 * export UNISWAP_ROUTER=0x...
 *
 * forge script script/DeployDeFiVault.s.sol:CreateUniswapPool \
 *   --rpc-url $RPC_SEPOLIA \
 *   --broadcast
 * ```
 */
contract CreateUniswapPool is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address poolToken = vm.envAddress("POOL_TOKEN_ADDRESS");
        address rewardToken = vm.envAddress("REWARD_TOKEN_ADDRESS");
        address routerAddress = vm.envAddress("UNISWAP_ROUTER");

        // Montants de liquidité initiale
        uint256 poolAmount = 10_000 ether; // 10,000 POOL
        uint256 rewardAmount = 10_000 ether; // 10,000 RWRD

        IUniswapV2Router02 router = IUniswapV2Router02(routerAddress);

        vm.startBroadcast(deployerPrivateKey);

        // Approve le router
        IERC20(poolToken).approve(routerAddress, poolAmount);
        IERC20(rewardToken).approve(routerAddress, rewardAmount);

        console.log("Adding liquidity to Uniswap...");
        console.log("  POOL amount:", poolAmount / 1e18);
        console.log("  RWRD amount:", rewardAmount / 1e18);

        // Ajouter la liquidité (crée la paire si elle n'existe pas)
        (uint amountA, uint amountB, uint liquidity) = router.addLiquidity(
            poolToken,
            rewardToken,
            poolAmount,
            rewardAmount,
            (poolAmount * 95) / 100, // 5% slippage
            (rewardAmount * 95) / 100,
            msg.sender,
            block.timestamp + 300
        );

        console.log("\nLiquidity added successfully!");
        console.log("  POOL deposited:", amountA / 1e18);
        console.log("  RWRD deposited:", amountB / 1e18);
        console.log("  LP tokens received:", liquidity / 1e18);

        // Récupérer l'adresse de la paire
        IUniswapV2Factory factory = IUniswapV2Factory(router.factory());
        address pair = factory.getPair(poolToken, rewardToken);
        console.log("\nPair address:", pair);

        vm.stopBroadcast();
    }
}

/**
 * @title TestHarvestFlow
 * @notice Script pour tester le flow complet deposit → reward → harvest
 */
contract TestHarvestFlow is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_TEST");
        address vaultAddress = vm.envAddress("VAULT_ADDRESS");
        address poolToken = vm.envAddress("POOL_TOKEN_ADDRESS");
        address rewardToken = vm.envAddress("REWARD_TOKEN_ADDRESS");

        // Calculate the actual deployer address from private key
        address deployer = vm.addr(deployerPrivateKey);

        VaultWithHarvest vault = VaultWithHarvest(vaultAddress);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deposit
        console.log("1. Depositing 100 POOL...");
        console.log("   Deployer address:", deployer);
        IERC20(poolToken).approve(vaultAddress, 100 ether);
        uint256 shares = vault.deposit(100 ether);
        console.log("   Shares received:", shares / 1e18);

        // 2. Simuler l'envoi de rewards
        console.log("\n2. Sending 10 RWRD as rewards...");
        IERC20(rewardToken).transfer(vaultAddress, 10 ether);
        console.log(
            "   Pending harvest:",
            vault.pendingHarvest() / 1e18,
            "RWRD"
        );
        console.log(
            "   Preview harvest:",
            vault.previewHarvest() / 1e18,
            "POOL"
        );

        // 3. Harvest
        console.log("\n3. Harvesting...");
        uint256 harvested = vault.harvest();
        console.log("   POOL received:", harvested / 1e18);
        console.log(
            "   New ratio:",
            vault.currentRatio() / 1e16,
            "% of initial"
        );

        // 4. Check value - Use deployer address instead of msg.sender!
        uint256 userAssets = vault.assetsOf(deployer);
        console.log("\n4. Final state:");
        console.log("   Total assets:", vault.totalAssets() / 1e18, "POOL");
        console.log("   Your assets:", userAssets / 1e18, "POOL");
        
        // Safe subtraction to avoid underflow
        if (userAssets > 100 ether) {
            console.log("   Profit:", (userAssets - 100 ether) / 1e18, "POOL");
        } else {
            console.log("   Profit: 0 POOL (or loss)");
        }

        vm.stopBroadcast();
    }
}
