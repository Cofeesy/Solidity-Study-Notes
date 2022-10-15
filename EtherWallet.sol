// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//以太坊钱包练习：
  //实现功能；
    //1.我们可以存入一些以太坊主币
    //2.然后我们可以取出一些主币

contract EtherWallet{
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    //只需要接收主币，而不需要消息调用，所以
    receive() external payable{}

    //取款-->合约的调用者才能调用此合约
    function withdraw(uint _amount) external{
        //需要调用者为合约的拥有者
        require(msg.sender == owner,"caller is not owner");
        //msg.sender是没有payable属性的
        payable(msg.sender).transfer(_amount);
    } 

    //获取余额
    function getBalance() external view returns(uint amount){
        //address(this)代表当前调用者
        return address(this).balance;
    } 
}