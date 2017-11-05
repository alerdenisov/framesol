pragma solidity ^0.4.15;

import './PricingInterface.sol';
import './ShipmentInterface.sol';

contract SaleInterface {
  PricingInterface public pricing;
  ShipmentInterface public shipment;

  function buyTokens(address _investor, uint _value) internal returns (bool) {
    require(canBuy(_investor, _value));
    return shipment.ship(_investor, pricing.change(_investor, _value));
  }
  
  function canBuy(address _investor, uint _value) public constant returns (bool);
}