pragma solidity ^0.4.15;

import '../core/SafeMath.sol';
import '../core/SingleOwner.sol';
import './interfaces/TokenInterface.sol';
import './interfaces/MintableTokenInterface.sol';
import './interfaces/TokenRecipientInterface.sol';


contract StandardToken is SingleOwner, TokenInterface, MintableTokenInterface {
  using SafeMath for uint;

  function decimals() public constant returns(uint) { return uDecimals; }
  function ticker() public constant returns(string) { return sTicker; }
  function name() public constant returns(string) { return sName; }
  function totalSupply() public constant returns(uint) { return uTotalSupply; }

  uint internal uDecimals;
  string internal sTicker;
  string internal sName;
  uint internal uTotalSupply;

  mapping (address => mapping (address => uint256)) internal mAllowed;
  mapping (address => uint) mBalances;


  function allowance(address _owner, address _spender) public constant returns (uint) { return mAllowed[_owner][_spender]; }

  function transferFrom(address _from, address _to, uint _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= mBalances[_from]);
    require(_value <= mAllowed[_from][msg.sender]);

    mBalances[_from] = mBalances[_from].sub(_value);
    mBalances[_to] = mBalances[_to].add(_value);
    mAllowed[_from][msg.sender] = mAllowed[_from][msg.sender].sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint _value) public returns (bool) {
    mAllowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function approveAndCall(address _spender, uint _value, bytes _data) public returns (bool) {
    TokenRecipientInterface spender = TokenRecipientInterface(_spender);
    if (approve(_spender, _value)) {
      spender.receiveApproval(msg.sender, _value, this, _data);
      return true;
    }
    return false;
  }

  function balanceOf(address _who) public constant returns (uint) { return mBalances[_who]; }

  function transfer(address _to, uint _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= mBalances[msg.sender]);
    mBalances[msg.sender] = mBalances[msg.sender].sub(_value);
    mBalances[_to] = mBalances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  function mint(address _to, uint256 _amount) senderWithRights canMint public returns (bool) {
    uTotalSupply = uTotalSupply.add(_amount);
    mBalances[_to] = mBalances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    return true;
  }

  function finishMinting() senderWithRights public returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }
}
