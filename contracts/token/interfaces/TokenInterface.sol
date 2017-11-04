pragma solidity ^0.4.15;

contract TokenInterface {
  function decimals() public constant returns(uint);
  function ticker() public constant returns(string);
  function name() public constant returns(string);
  function totalSupply() public constant returns(uint);
  function allowance(address _owner, address _spender) public constant returns (uint);
  function transferFrom(address _from, address _to, uint _value) public returns (bool);
  function approve(address _spender, uint _value) public returns (bool);
  function approveAndCall(address _spender, uint _value, bytes _data) public returns (bool);
  function balanceOf(address _who) public constant returns (uint);
  function transfer(address _to, uint _value) public returns (bool);

  event Approval(address indexed owner, address indexed spender, uint value);
  event Transfer(address indexed from, address indexed to, uint value); 
}