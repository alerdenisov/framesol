pragma solidity ^0.4.15;

import '../..//core/SingleOwner.sol';

contract ShipmentInterface is SingleOwner {
  function ship(address _for, uint _amount) senderWithRights public returns(bool);
  function canShip(address _for, uint _amount) public constant returns(bool);
}