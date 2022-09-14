// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "contracts/Vault.sol";
import "@pwnednomore/contracts/Agent.sol";

contract TestVault is Agent {
    Vault vault;

    address USER = address(0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB);

    function deploy() internal {
        vault = new Vault();
    }

    function deposit(address _address, uint256 _amount) internal {
        hoax(_address, _amount);
        vault.deposit{value: _amount}(_address);
    }
}
