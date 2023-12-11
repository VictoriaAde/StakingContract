# Staking Contract

## Overview

This smart contract facilitates staking of ERC-20 tokens within a specified time window. Users can stake tokens during the staking period and subsequently withdraw their staked amount after the staking duration has elapsed.

## Contract Details

- **Compiler Version:** Solidity ^0.8.20
- **License:** MIT

## Functionality

### `constructor`

The contract constructor initializes key parameters:

- `stakingToken`: The ERC-20 token used for staking.
- `stakingStartTime`: The timestamp when staking becomes active.
- `stakingDuration`: The duration of the staking period.

### `stake(uint256 amount) external`

Allows users to stake a specified amount of the staking token. The function checks if staking has started and if the amount to be staked is greater than zero. Staked balances are recorded, and the `Staked` event is emitted.

### `withdraw() external`

Allows users to withdraw their staked amount after the staking duration has ended. It checks whether the staking duration is over, if the user has staked tokens, and transfers the staked amount back to the user. The `Withdrawn` event is emitted.

### `getStakedBalance(address user) external view returns (uint256)`

Enables users to query their staked balance by providing their address. Returns the staked balance of the specified user.

### `getContractBalance() external view returns (uint256)`

Returns the total balance of the staking token held by the contract.

## Usage

1. **Stake Tokens:**
   - Call the `stake` function, providing the desired amount of tokens to stake.
   - Ensure staking has started (`block.timestamp >= stakingStartTime`).
   - Verify the staked amount is greater than zero.

2. **Withdraw Staked Tokens:**
   - Call the `withdraw` function after the staking duration has ended (`block.timestamp >= stakingStartTime + stakingDuration`).
   - Verify that tokens have been staked (`amount > 0`).

3. **Check Staked Balance:**
   - Use the `getStakedBalance` function to check the staked balance for a specific user.

4. **Check Contract Balance:**
   - Use the `getContractBalance` function to check the total balance of the staking token held by the contract.

## Notes

- Ensure you interact with the contract using a wallet that supports ERC-20 token transactions.
- The contract assumes the staking token implements the ERC-20 standard.

**Important:** Review the contract source code and understand the implications of staking and withdrawing before interacting with the contract on the blockchain.
