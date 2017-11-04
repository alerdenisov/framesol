pragma solidity ^0.4.15;

import '../../core/interfaces/OwnershipInterface.sol';

contract ShipmentInterface is OwnershipInterface {
  function ship(address _for, uint _amount) senderWithRights public returns(bool);
  function canShip(address _for, uint _amount) public constant returns(bool);
}