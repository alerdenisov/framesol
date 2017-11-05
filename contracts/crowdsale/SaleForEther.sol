pragma solidity ^0.4.15;

import '../token/interfaces/MintableTokenInterface.sol';

import './interfaces/SaleInterface.sol';
import './StaticPricing.sol';
import './MintingShipment.sol';

contract SaleForEther is SaleInterface {
  function () public payable {
    require(msg.value > 0);
    buyTokens(msg.sender, msg.value);
  }

  function buy(address _investor) public payable returns (bool) {
    require(msg.value > 0);
    buyTokens(_investor, msg.value);
    
    return true;
  }

  function canBuy(address _investor, uint _value) public constant returns (bool) {
    return true;
  }
}