// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TokenB.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    TokenB public tokenB;
    IERC20 public tokenA;

    uint256 private constant DECIMAL_MULTIPLIER = 10**12; // Convert from 6 to 18 decimals

    constructor(address _tokenB, address _tokenA) {
        tokenB = TokenB(_tokenB);
        tokenA = IERC20(_tokenA);
    }

    function swapToTokenB(uint256 amount) public {
        require(amount > 0, "Amount must be > 0");
        require(tokenA.transferFrom(msg.sender, address(this), amount), "TokenA transfer failed");

        uint256 tokenBAmount = amount * DECIMAL_MULTIPLIER;
        tokenB.mint(msg.sender, tokenBAmount);
    }

    function swapToTokenA(uint256 tokenBAmount) public {
        require(tokenBAmount > 0, "Amount must be > 0");
        require(tokenB.transferFrom(msg.sender, address(this), tokenBAmount), "TokenB transfer failed");

        uint256 tokenAAmount = tokenBAmount / DECIMAL_MULTIPLIER;
        require(tokenA.transfer(msg.sender, tokenAAmount), "TokenA transfer failed");

        tokenB.burn(address(this), tokenBAmount); // optional cleanup
    }
}
