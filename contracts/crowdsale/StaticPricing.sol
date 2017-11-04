pragma solidity ^0.4.15;

import '../core/SafeMath.sol';
import './interfaces/PricingInterface.sol';

contract StaticPricing is PricingInterface {
  using SafeMath for uint;

  uint public weiPrice;
  uint public multiplier;

  function StaticPricing(uint _weiPrice, uint _decimals) public {
    require(_weiPrice > 0);
    weiPrice = _weiPrice;
    multiplier = _decimals;
  }

  function change(address _for, uint _changeAmount) public constant returns (uint) {
    require(canChange(_for, _changeAmount));
    return _changeAmount.mul(10 ** multiplier).div(weiPrice);
  }

  function canChange(address _who, uint _changeAmount) public constant returns (bool) {
    return _who != 0x0 && _changeAmount > 0;
  }
}