# Yield Aggregator Vault

A professional-grade, ERC4626-compatible yield aggregator. This vault allows users to deposit a single asset (e.g., USDC) and automatically allocates it to the highest-yielding protocol available.

## Core Features
* **ERC4626 Standard**: Fully compatible with the Tokenized Vault Standard for easy integration.
* **Dynamic Rebalancing**: Authorized keepers can trigger the `rebalance()` function to shift funds when interest rates change.
* **Share-Based Accounting**: Users receive vault shares representing their claim on the underlying assets plus accumulated interest.
* **Fee Management**: Built-in performance and management fee logic.



## Operational Flow
1. **Deposit**: User deposits $X$ amount of underlying assets.
2. **Mint**: Vault calculates current exchange rate and mints proportional shares.
3. **Invest**: The Vault deposits the underlying assets into a low-risk lending protocol.
4. **Harvest**: Strategies are called to collect rewards and reinvest them, increasing the share price.

## Tech Stack
* Solidity ^0.8.20
* OpenZeppelin ERC4626
