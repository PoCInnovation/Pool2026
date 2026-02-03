// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IUniswapV2Router02
 * @notice Interface simplifiée du Router Uniswap V2
 *
 * @dev Uniswap V2 est plus simple que V3 pour l'apprentissage :
 *      - Pas de gestion de concentrated liquidity
 *      - Pas de position NFT
 *      - Une seule fonction pour swap
 *
 * Documentation officielle :
 * https://docs.uniswap.org/contracts/v2/reference/smart-contracts/router-02
 */
interface IUniswapV2Router02 {
    /**
     * @notice Swap un montant exact de tokens d'entrée contre un minimum de tokens de sortie
     * @param amountIn Montant exact de tokens à envoyer
     * @param amountOutMin Montant minimum de tokens à recevoir (protection slippage)
     * @param path Chemin de swap : [tokenIn, ..., tokenOut]
     * @param to Adresse qui reçoit les tokens de sortie
     * @param deadline Timestamp limite pour exécuter la transaction
     * @return amounts Tableau des montants : [amountIn, ..., amountOut]
     *
     * Exemple de path :
     * - [RWRD, POOL] → swap direct RWRD vers POOL
     * - [RWRD, WETH, POOL] → swap via WETH si pas de pool directe
     *
     * Slippage protection :
     * - amountOutMin empêche les sandwich attacks
     * - Typiquement 0.5% à 1% de tolérance
     */
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    /**
     * @notice Ajoute de la liquidité à une paire
     * @param tokenA Premier token de la paire
     * @param tokenB Deuxième token de la paire
     * @param amountADesired Montant souhaité de tokenA
     * @param amountBDesired Montant souhaité de tokenB
     * @param amountAMin Montant minimum de tokenA (slippage)
     * @param amountBMin Montant minimum de tokenB (slippage)
     * @param to Adresse qui reçoit les LP tokens
     * @param deadline Timestamp limite
     * @return amountA Montant réel de tokenA ajouté
     * @return amountB Montant réel de tokenB ajouté
     * @return liquidity Montant de LP tokens reçus
     */
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    /**
     * @notice Retourne le montant de sortie pour un montant d'entrée donné
     * @param amountIn Montant de tokens d'entrée
     * @param path Chemin de swap
     * @return amounts Tableau des montants à chaque étape
     *
     * Utile pour :
     * - Prévisualiser un swap avant exécution
     * - Calculer le amountOutMin avec slippage
     */
    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    /// @notice Adresse de la factory Uniswap V2
    function factory() external pure returns (address);

    /// @notice Adresse du WETH (Wrapped ETH)
    function WETH() external pure returns (address);
}

/**
 * @title IUniswapV2Factory
 * @notice Interface de la Factory Uniswap V2
 *
 * @dev La factory gère la création et le tracking des paires de liquidité
 */
interface IUniswapV2Factory {
    /**
     * @notice Crée une nouvelle paire de liquidité
     * @param tokenA Premier token
     * @param tokenB Deuxième token
     * @return pair Adresse de la nouvelle paire créée
     *
     * Note : La paire est créée si elle n'existe pas déjà
     */
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    /**
     * @notice Retourne l'adresse d'une paire existante
     * @param tokenA Premier token
     * @param tokenB Deuxième token
     * @return pair Adresse de la paire (ou address(0) si inexistante)
     */
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

/**
 * @title IUniswapV2Pair
 * @notice Interface d'une paire de liquidité Uniswap V2
 */
interface IUniswapV2Pair {
    /// @notice Retourne les réserves de la paire
    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    /// @notice Premier token de la paire
    function token0() external view returns (address);

    /// @notice Deuxième token de la paire
    function token1() external view returns (address);
}
