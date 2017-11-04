pragma solidity ^0.4.15;

import '../token/StandardToken.sol';

contract SampleToken is StandardToken {
  function SampleToken() public {
    sName = "Sample Token";
    sTicker = "EST";
    uDecimals = 18;
    // 1,000,000,000 tokens
    uint256 INITIAL_SUPPLY = 1 * (10 ** 9) * (10 ** decimals());
    require(mint(msg.sender, INITIAL_SUPPLY));
  }
}