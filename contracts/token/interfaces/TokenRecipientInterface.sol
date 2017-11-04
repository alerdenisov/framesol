pragma solidity ^0.4.16;

contract TokenRecipientInterface { 
  function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; 
}