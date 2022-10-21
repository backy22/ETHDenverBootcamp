// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin{

  uint256 public totalSupply = 10000;
  address public owner;

  mapping(address => uint256) private balances;
  event totalSupplyChanged(uint256 totalSupplyWasChanged);

    constructor() {
      owner = msg.sender;
      balances[owner] = totalSupply;
    }

    modifier isOwner{
      require(msg.sender == owner);
      _;
    }

    function returnTotalSupply() public view returns(uint256) {
      return totalSupply;
    }

    function changeTotalSupply() public isOwner {
      totalSupply += 1000;
      emit totalSupplyChanged(totalSupply);
    }
    
    function balanceOf(address account) public view returns(uint256) {
      return balances[account];
    }

    function transfer (uint256 amount, address recipient) public returns(uint256) {
      balances[msg.sender] = balances[msg.sender] - amount;
      balances[recipient] = balances[recipient] + amount;
      return balances[recipient];
    }

}