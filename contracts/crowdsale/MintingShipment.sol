pragma solidity ^0.4.15;

import '../core/SingleOwner.sol';
import '../token/interfaces/MintableTokenInterface.sol';
import './interfaces/ShipmentInterface.sol';

contract MintingShipment is ShipmentInterface, SingleOwner {
  MintableTokenInterface public token;

  function MintingShipment(address _tokenAddress) public {
    token = MintableTokenInterface(_tokenAddress);    
  }

  function ship(address _for, uint _amount) senderWithRights public returns (bool) {
    require(token.mint(_for, _amount));
    return true;
  }

  function canShip(address _for, uint _amount) public constant returns (bool) {
    return token.hasRights(address(this)) && !token.mintingFinished();
  }

  function returnOwnership() senderWithRights public returns (bool) {
    token.addRights(owner);
    return true;
  }
}