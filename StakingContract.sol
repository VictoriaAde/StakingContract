// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC20.sol";

contract StakingContract {
    IERC20 public stakingToken;
    uint256 public stakingStartTime;
    uint256 public stakingDuration;

    //mapping to track staked balances for each user.
    mapping(address => uint256) public stakedBalances;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    constructor(
        address _stakingToken,
        uint256 _stakingStartTime,
        uint256 _stakingDuration
    ) {
        stakingToken = IERC20(_stakingToken);
        stakingStartTime = _stakingStartTime;
        stakingDuration = _stakingDuration;    
    }

    function stake(uint256 amount) external {
        require(block.timestamp >= stakingStartTime, "Staking not yet started");
        require(amount > 0, "Amount must be greater than 0");

        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakedBalances[msg.sender] += amount;

        emit Staked(msg.sender, amount);
    }

    function withdraw() external {
        require(block.timestamp >= stakingStartTime + stakingDuration, "Staking duration not over");

        uint256 amount = stakedBalances[msg.sender];
        require(amount > 0, "No tokens staked");

        stakedBalances[msg.sender] = 0;
        stakingToken.transfer(msg.sender, amount);

        emit Withdrawn(msg.sender, amount);
    }

    function getStakedBalance(address user) external view returns (uint256) {
        return stakedBalances[user];
    }
    
    function getContractBalance() external view returns (uint256) {
    return stakingToken.balanceOf(address(this));
    }
}
