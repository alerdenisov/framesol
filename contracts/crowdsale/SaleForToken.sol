pragma solidity ^0.4.15;

import '../core/SingleOwner.sol';
import './interfaces/SaleInterface.sol';
import '../token/interfaces/TokenRecipientInterface.sol';
import '../token/interfaces/TokenInterface.sol';

contract SaleForToken is SingleOwner, SaleInterface {
  TokenInterface public token;

  function SaleForToken(address _tokenAddress, address _pricingAddress, address _shipmentAddress) public {
    require(_tokenAddress != 0x0);
    require(_pricingAddress != 0x0);
    require(_shipmentAddress != 0x0);

    token = TokenInterface(_tokenAddress);
    pricing = PricingInterface(_pricingAddress);
    shipment = ShipmentInterface(_shipmentAddress);
  }

  function consumeTokens(address _from, uint _value) internal {
    require(token.allowance(_from, address(this)) >= _value);
    token.transferFrom(_from, owner, _value);
    buyTokens(_from, _value);
  }

  function receiveApproval(address _from, uint _value, address _token, bytes _extraData) public {
    require(_token == address(token));
    require(_value > 0);

    token.transferFrom(_from, owner, _value);
    buyTokens(_from, _value);
  }

  function canBuy(address _investor, uint _value) public constant returns (bool) {
    return true;
  }
}