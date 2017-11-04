pragma solidity ^0.4.15;

import './TokenInterface.sol';
import '../../core/interfaces/OwnershipInterface.sol';

contract MintableTokenInterface is OwnershipInterface, TokenInterface {
  bool public mintingFinished;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  function mint(address _to, uint256 _amount) senderWithRights canMint public returns (bool);
  function finishMinting() senderWithRights public returns (bool);
  
  event Mint(address indexed to, uint256 amount);
  event MintFinished();
}