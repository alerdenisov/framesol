pragma solidity ^0.4.15;

import './interfaces/OwnershipRecipientInterface.sol';
import './interfaces/OwnershipInterface.sol';

contract Multionwer is OwnershipInterface {
  mapping (address => bool) public owners;

  function SingleOwner() public {
    owners[msg.sender];
  }

  function hasRights(address _who) public constant returns(bool) {
    return owners[_who];
  }  

  function addRights(address _for) public returns(bool) {
    require(_for != 0x0);
    owners[_for] = true;

    OwnershipRecipientInterface receiver = OwnershipRecipientInterface(_for);
    if (address(receiver) != 0x0) {
      receiver.receiveOwnership(address(this), msg.sender);
    }

    SetRights(_for, true);

    return true;
  }

  function removeRights(address _for) public returns(bool) {
    require(_for != msg.sender);
    owners[_for] = false;

    SetRights(_for, false);
    return true;
  }
}