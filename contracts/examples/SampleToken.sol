pragma solidity ^0.4.15;

import '../token/interfaces/MintableTokenInterface.sol';
import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract SampleToken is MintableTokenInterface, MintableToken {
  string public constant name = "SimpleToken";
  string public constant symbol = "SIM";
  uint8 public constant decimals = 18;

  // 1,000,000,000 tokens
  uint256 public constant INITIAL_SUPPLY = 1 * (10 ** 9) * (10 ** uint256(decimals));

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  function SimpleToken() {
    mint(msg.sender, INITIAL_SUPPLY);
  }
}