pragma solidity ^0.4.15;

import '../token/interfaces/MintableTokenInterface.sol';

import './interfaces/SaleInterface.sol';
import './StaticPricing.sol';
import './MintingShipment.sol';

contract StaticEtherSale is SaleInterface {
  MintableTokenInterface token; 

  function StaticEtherSale(uint _weiPrice, address _tokenAddress) public {
    token = MintableTokenInterface(_tokenAddress);
    require(token.hasRights(address(this)));

    pricing = new StaticPricing(_weiPrice, token.decimals());
    shipment = new MintingShipment(_tokenAddress);

    token.addRights(address(shipment));
  }

  function canBuy(address _investor, uint _value) public constant returns (bool) {
    return true;
  }
}