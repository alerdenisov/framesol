pragma solidity ^0.4.15;

import '../token/interfaces/MintableTokenInterface.sol';

import './interfaces/SaleInterface.sol';
import './StaticPricing.sol';
import './MintingShipment.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract StaticEtherSale is SaleInterface, Ownable, Pausable {
  MintableTokenInterface token;

  function StaticEtherSale(uint _weiPrice, address _tokenAddress) public {
    token = MintableTokenInterface(_tokenAddress);
    require(token.owner() == address(this));

    pricing = new StaticPricing(_weiPrice, token.decimals());
    shipment = new MintingShipment(_tokenAddress);

    token.transferOwnership(address(shipment));
  }

  function canBuy(address _investor, uint _value) public constant returns (bool) {
    return true;
  }
}