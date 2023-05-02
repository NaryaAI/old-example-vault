// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vault} from "contracts/Vault.sol";
import {PTest} from "@narya-ai/contracts/PTest.sol";

// A test contract, needs to extends `PTest`
// Contract name could be anything
contract FundLossTest is PTest {
  Vault vault;

  address user = makeAddr("user");
  address agent;

  function setUp() external {
    // Step 1: Deploy target contract
    vault = new Vault();

    // Step 2: Grant user account 1 eth, and deposit it into the vault
    hoax(user, 1 ether); // Next call will be sent from `user` account
    vault.deposit{value: 1 ether}();

    // Step 3: Grant agent account 1 eth, and deposit it into the vault
    agent = getAgent(); // Initialize the field
    hoax(agent, 1 ether); // Next call will be sent from `agent` account
    vault.deposit{value: 1 ether}();
  }

  // Invariant assertion function.
  // Function name needs to be started with `invariant`.
  // Prefer to have no side effect (view function), but this is not required.
  function invariantFundLoss() public view {
    // Invariant: Contract balance should always be >= 1 ether,
    // since the user takes no action after setUp() is called.
    assert(address(vault).balance >= 1 ether);
  }
}
