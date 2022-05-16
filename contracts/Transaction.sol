//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Transaction {

    address payable public user;

    constructor() {
        user = payable(msg.sender);
    }

    function payEther() public payable {
       require(msg.value == 1 ether);
    }
    function getBalance() public view returns(uint) {
      return address(this).balance;
      }

    function Transfer(address to) public payable {
        payable(to).transfer(getBalance());
    }


}
