pragma solidity ^0.4.15;

contract PricingInterface {
  function change(address _for, uint _changeAmount) public constant returns (uint);
  function canChange(address _who, uint _changeAmount) public constant returns (bool);
}