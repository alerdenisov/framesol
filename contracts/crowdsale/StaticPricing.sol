pragma solidity ^0.4.15;

import './interfaces/NamedContractInterface.sol';
import './interfaces/PricingInterface.sol';

contract StaticPricing is PricingInterface, NamedContractInterface {
  uint public changeRate;

  function StaticPricing(uint _changeRate) public {
    changeRate = _changeRate;
  }

  function changeRate(address _for, uint _changeAmount) public constant returns (uint) {
    require(canChange(_for, _changeAmount));
    return changeRate;
  }

  function canChange(address _who, uint _changeAmount) public constant returns (bool) {
    return _who != 0x0 && _changeAmount > 0;
  }

  function getContractName() public constant returns(string) {
    return "Static Price";
  }
  
  function getContractDescription() public constant returns(string) {

  }
}