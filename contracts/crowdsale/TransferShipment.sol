pragma solidity ^0.4.15;

import '../token/interfaces/TokenInterface.sol';
import './interfaces/ShipmentInterface.sol';

contract TransferShipment is ShipmentInterface {
  TokenInterface public token;
  address public supplyAddress;

  function TransferShipment(address _supplyAddress, address _tokenAddress) {
    assert(_supplyAddress != 0x0);
    assert(_tokenAddress != 0x0);

    token = TokenInterface(_tokenAddress);
    supplyAddress = _supplyAddress; 
  }

  function ship(address _for, uint _amount) onlyOwner public returns (bool) {
    require(canShip(_for, _amount));
    
    token.transferFrom(supplyAddress, _for, _amount);
    return true;
  }

  function canShip(address _for, uint _amount) public constant returns (bool) {
    return _for != 0x0 && token.allowance(supplyAddress, address(this)) >= _amount;
  }  
}