// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    mapping(address => uint256) public balances;

    // Allows users to put some tokens on contract address
    function deposit() public payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    // Allows users to get tokens out
    function withdraw() public {
        if (balances[msg.sender] > 0) {
            uint256 balance = balances[msg.sender];
            (bool result, ) = msg.sender.call{value: balance}("");
            require(result, "Failed to withdraw");
            balances[msg.sender] = 0;
        }
    }
}
