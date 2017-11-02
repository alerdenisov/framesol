pragma solidity ^0.4.15;

interface ShipmentInterface {
  function ship(address _for, uint _amount) public returns(bool);
  function canShip(address _for, uint _amount) public constant returns(bool);
}