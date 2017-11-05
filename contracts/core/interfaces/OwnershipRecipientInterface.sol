pragma solidity ^0.4.15;

contract OwnershipRecipientInterface {
  function receiveOwnership(address _what, address _from) public returns(bool) {
    ReceiveOwnership(_what, _from);
    return true;
  }
  event ReceiveOwnership(address indexed what, address indexed from);
}