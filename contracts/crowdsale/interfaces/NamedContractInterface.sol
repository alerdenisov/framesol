pragma solidity ^0.4.15;

interface NamedContractInterfrace {
  function getContractName() public constant returns(string);
  function getContractDescription() public constant returns(string);
}