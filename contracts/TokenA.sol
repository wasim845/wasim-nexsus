// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("Token A", "TKNA") {
        _mint(msg.sender, 1_000_000 * 1e6); // 1M tokens, 6 decimals
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function faucet() public {
        _mint(msg.sender, 1000 * 1e6);
    }
}
