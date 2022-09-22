// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Vault.t.sol";

// Test whether the vault's fund can be stolen or not
contract BalanceTest is VaultTest {
    function setUp() external {
        // Step 1. Deploy the smart contracts
        deploy();

        // Step 2. User owned 1 ether in the vault
        deposit(USER, 1 ether);

        // Step 3. Attacker owned 100000 wei in the vault
        deposit(address(this), 100000 wei);
    }

    function invariantBalanceLowerLimit() external view {
        require(address(vault).balance >= 1 ether, "User fund loss");
    }
}
