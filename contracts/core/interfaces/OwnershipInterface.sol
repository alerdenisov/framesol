pragma solidity ^0.4.15;

contract OwnershipInterface {
  modifier withRights(address _who) {
    require(hasRights(_who));
    _;
  }

  modifier senderWithRights() {
    require(hasRights(msg.sender));
    _;
  }

  function hasRights(address _who) public constant returns(bool);
  function addRights(address _for) senderWithRights public returns(bool);

  event SetRights(address indexed who);
}