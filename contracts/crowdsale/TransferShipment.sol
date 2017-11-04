pragma solidity ^0.4.15;

import '../core/SingleOwner.sol';
import '../token/interfaces/TokenInterface.sol';
import './interfaces/ShipmentInterface.sol';

contract TransferShipment is ShipmentInterface, SingleOwner {
  TokenInterface internal token;
  address public tokenAddress;
  address public supplyAddress;

  function TransferShipment(address _supplyAddress, address _tokenAddress) public {
    assert(_supplyAddress != 0x0);
    assert(_tokenAddress != 0x0);

    tokenAddress = _tokenAddress;
    token = TokenInterface(_tokenAddress);
    supplyAddress = _supplyAddress; 
  }

  function ship(address _for, uint _amount) senderWithRights public returns (bool) {
    require(canShip(_for, _amount));
    token.transferFrom(supplyAddress, _for, _amount);
    return true;
  }

  function canShip(address _for, uint _amount) public constant returns (bool) {
    return _for != 0x0 && token.allowance(supplyAddress, address(this)) >= _amount;
  }
}