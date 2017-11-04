pragma solidity ^0.4.15;

import '../token/interfaces/MintableTokenInterface.sol';
import './interfaces/ShipmentInterface.sol';

contract MintingShipment is ShipmentInterface {
  MintableTokenInterface public token;

  function MintingShipment(address _tokenAddress) {
    token = MintableTokenInterface(_tokenAddress);    
  }

  function ship(address _for, uint _amount) public returns (bool) {
    require(token.mint(_for, _amount));
    return true;
  }

  function canShip(address _for, uint _amount) public constant returns (bool) {
    return token.hasRights(address(this)) && !token.mintingFinished();
  }
}