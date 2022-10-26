// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

  struct Payment {
    uint256 transferAmount;
    address recipient;
  }

  uint256 public totalSupply = 10000;
  
  mapping(address => uint) public balances;
  mapping(address => Payment) public paymentList; // sender -> Payment
  event totalSupplyChanged(uint256 totalSupplyWasChanged);
  event transferOccurred(uint256 amountTransferred, address recipient);

  constructor() {
    balances[msg.sender] = totalSupply;
  }

  function returnTotalSupply() public view returns(uint256){
    return totalSupply;
  }
  
  function changeTotalSupply() public onlyOwner {
    totalSupply += 1000; 
    emit totalSupplyChanged(totalSupply);
  }

  function recordPayment(uint amount, address sender, address recipient) private {
    paymentList[sender] = Payment(amount, recipient);
  }

  function transfer(uint amount, address recipient) public {
    require(msg.sender.balance >= amount);
    balances[msg.sender] -= amount;
    balances[recipient] += amount; 
    recordPayment(amount, msg.sender, recipient);
    emit transferOccurred(amount, recipient);
  }

  function getPayment(address user) public view returns(uint256) {
    return paymentList[user].transferAmount; 
  }
}