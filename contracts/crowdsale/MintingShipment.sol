pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './interfaces/ShipmentInterface.sol';

contract MintingShipment is Ownable, ShipmentInterface {
  MintableToken public token;

  function MintingShipment(address _tokenAddress) {
    token = MintableToken(_tokenAddress);    
  }

  function ship(address _for, uint _amount) onlyOwner public returns (bool) {
    require(token.mint(_for, _amount));
    return true;
  }

  function canShip(address _for, uint _amount) public constant returns (bool) {
    return token.owner() == address(this) && !token.mintingFinished();
  }
}