// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin {

  struct Payment {
    uint256 transferAmount;
    address recipient;
  }

  uint256 public totalSupply = 10000;
  address payable public owner;
  
  mapping(address => uint) public balances;
  mapping(address => Payment) public paymentList;
  event totalSupplyChanged(uint256 totalSupplyWasChanged);
  event transferOccurred(uint256 amountTransferred, address recipient);

  constructor() {
    owner = payable(msg.sender);
    balances[owner] = totalSupply;
  }

  modifier isOwner {
    require(msg.sender == owner);
    _;
  }

  function returnTotalSupply() public view returns(uint256){
    return totalSupply;
  }
  
  function changeTotalSupply() public isOwner {
    totalSupply += 1000; 
    emit totalSupplyChanged(totalSupply);
  }

  function transfer(uint amount, address recipient) public {
    require(msg.sender.balance >= amount);
    balances[msg.sender] -= amount;
    balances[recipient] += amount; 
    paymentList[msg.sender] = Payment(amount, recipient);
    emit transferOccurred(amount, recipient);
  }
}