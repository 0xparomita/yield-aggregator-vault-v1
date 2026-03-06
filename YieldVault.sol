// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title YieldVault
 * @dev An ERC4626 vault that aggregates yield from external providers.
 */
contract YieldVault is ERC4626, Ownable {
    
    address public currentStrategy;
    uint256 public performanceFee = 500; // 5% (basis points)
    uint256 public constant MAX_FEE = 1000; // 10%

    event StrategyUpdated(address indexed newStrategy);
    event FeesHarvested(uint256 amount);

    constructor(
        IERC20 _asset,
        string memory _name,
        string memory _symbol
    ) ERC4626(_asset) ERC20(_name, _symbol) Ownable(msg.sender) {}

    /**
     * @dev Deposits the underlying assets into the active strategy.
     */
    function _afterDeposit(uint256 assets, uint256 /*shares*/) internal override {
        if (currentStrategy != address(0)) {
            SafeERC20.safeApprove(IERC20(asset()), currentStrategy, assets);
            // logic to deposit into strategy (e.g., Aave)
        }
    }

    /**
     * @dev Withdraws assets from the strategy before burning shares.
     */
    function _beforeWithdraw(uint256 assets, uint256 /*shares*/) internal override {
        if (currentStrategy != address(0)) {
            // logic to withdraw from strategy
        }
    }

    /**
     * @dev Updates the active yield-generating strategy.
     */
    function setStrategy(address _strategy) external onlyOwner {
        require(_strategy != address(0), "Invalid strategy");
        currentStrategy = _strategy;
        emit StrategyUpdated(_strategy);
    }

    /**
     * @dev Adjusts performance fee.
     */
    function setPerformanceFee(uint256 _fee) external onlyOwner {
        require(_fee <= MAX_FEE, "Fee too high");
        performanceFee = _fee;
    }

    /**
     * @dev Returns total assets managed by the vault (idle + invested).
     */
    function totalAssets() public view override returns (uint256) {
        // In a real implementation, this would query the strategy for balance
        return super.totalAssets();
    }
}
