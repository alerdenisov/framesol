pragma solidity ^0.4.15;

interface PricingInterface {
  function changeRate(address _for, uint _changeAmount) public constant returns (uint);
  function canChange(address _who, uint _changeAmount) public constant returns (bool);
}