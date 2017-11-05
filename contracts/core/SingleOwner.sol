pragma solidity ^0.4.15;

import './interfaces/OwnershipRecipientInterface.sol';
import './interfaces/OwnershipInterface.sol';

contract SingleOwner is OwnershipInterface {
  address public owner;

  function SingleOwner() public {
    owner = msg.sender;
    SetRights(owner, true);
  }

  function hasRights(address _who) public constant returns(bool) {
    return owner == _who;
  }  

  function addRights(address _for) public returns(bool) {
    require(_for != 0x0);

    if(owner != 0x0) {
      SetRights(owner, false);
    }

    owner = _for;
    
    OwnershipRecipientInterface receiver = OwnershipRecipientInterface(_for);
    if (address(receiver) != 0x0) {
      receiver.receiveOwnership(address(this), msg.sender);
    }

    SetRights(owner, true);

    return true;
  }

  function removeRights(address _for) public returns(bool) {
    require(false);
    return false;
  }
}