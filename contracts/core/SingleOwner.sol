pragma solidity ^0.4.15;

import './interfaces/OwnershipInterface.sol';

contract SingleOwner is OwnershipInterface {
  address public owner;

  function SingleOwner() public {
    owner = msg.sender;
  }

  function hasRights(address _who) public constant returns(bool) {
    return owner == _who;
  }  

  function addRights(address _for) public returns(bool) {
    require(_for != 0x0);
    owner = _for;

    return true;
  }
}