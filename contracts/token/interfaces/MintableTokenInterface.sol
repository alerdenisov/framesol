pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './TokenInterface.sol';

contract MintableTokenInterface is TokenInterface, Ownable {
  bool public mintingFinished;

  function mint(address _to, uint256 _amount) onlyOwner public returns (bool);
  function finishMinting() onlyOwner public returns (bool);
  
  event Mint(address indexed to, uint256 amount);
  event MintFinished();
}