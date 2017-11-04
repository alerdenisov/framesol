pragma solidity ^0.4.15;

import '../core/SafeMath.sol';
import './interfaces/PricingInterface.sol';

contract AmountDependentPricing is PricingInterface {
  using SafeMath for uint;

  mapping (uint => uint) amountPrices;
  uint[] public amountSlices;
  
  uint public multiplier;

  function AmountDependentPricing(uint[] _amountSlices, uint[] _prices, uint _decimals) public {
    require(_amountSlices.length > 1);
    require(_prices.length == _amountSlices.length);

    uint lastSlice = 0;

    for (uint index = 0; index < _amountSlices.length; index++) {
      require(_amountSlices[index] >= lastSlice);
      lastSlice = _amountSlices[index];
      amountSlices.push(lastSlice);
      amountPrices[lastSlice] = _prices[index];
    }

    multiplier = 10 ** _decimals;
  }

  function change(address _for, uint _changeAmount) public constant returns (uint) {
    require(canChange(_for, _changeAmount));

    uint price = 0;
    for (uint index = 0; index < amountSlices.length; index++) {
      if(amountSlices[index] > _changeAmount) {
        break;
      }

      price = amountPrices[amountSlices[index]];
    }

    require(price > 0);

    return _changeAmount.mul(multiplier).div(price);
  }

  function canChange(address _who, uint _changeAmount) public constant returns (bool) {
    return _who != 0x0 && _changeAmount > 0;
  }
}