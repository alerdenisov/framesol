pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract ShipmentInterface is Ownable {
  function ship(address _for, uint _amount) onlyOwner public returns(bool);
  function canShip(address _for, uint _amount) public constant returns(bool);
}