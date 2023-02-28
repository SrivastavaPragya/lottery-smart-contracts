// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;// data type which  stores the address of the manager
    address payable [] public participants; //array is used because there are more than one participants

constructor()
{
    manager =msg.sender; // global variable
}

//payable function for transfering some amount of ether
// for this we use receive function .... which can be used only one time in the contract
// always use with external keyword and always payble and no arguments pass here
receive() external payable// participants tranfer the ether ,this function gets called
{
   require(msg.value==1 ether);//used as if else statement.
    participants.push(payable(msg.sender));// payable ether is tranfered to msg.sender that is manager
}
function getBalance() public view returns(uint)//to check the balance received
{
    require(msg.sender==manager);
return address (this).balance;// fetching the balance from the address of this particular contracr
}

function random() public view returns(uint)//used for the selection of participants on random basis
{
return uint (keccak256 (abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
//hashing algo for creation of random function.... take input bytes and output of hash 32 bytes
}
function selectWinner () public 
{
require(msg.sender==manager);
require(participants.length>=3);
uint r=random();//variable.. stores return value of random function
uint index=r%participants.length;// returns index
address payable winner;
winner=participants[index];// stores index value of the winner
winner.transfer(getBalance());// transfering the balance to the winner
participants =new address payable[](0);// resetting function
}
}