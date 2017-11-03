pragma solidity ^0.4.15;

contract TokenInterface {
  // uint256 public decimals;
  // string public ticker;
  // string public name;
  
  // uint256 public totalSupply;
  function allowance(address owner, address spender) public constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  // function approve(address spender, uint256 value) public returns (bool);
  function balanceOf(address who) public constant returns (uint256);
  // function transfer(address to, uint256 value) public returns (bool);

  // event Approval(address indexed owner, address indexed spender, uint256 value);
  // event Transfer(address indexed from, address indexed to, uint256 value); 
}