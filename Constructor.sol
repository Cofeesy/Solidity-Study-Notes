// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//构造器的一些学习笔记
contract Constructor{
    //构造器关键词:constructor
    //作用:一般用来初始化一些变量的值
    //局限性:仅在合约部署的时候被调用一次,之后再也不能被调用了

    address public owner;
    uint public x;
    uint public y;

    //传入string参数出现报错？
    constructor (uint _x,uint _y){
        owner = msg.sender;
        x = _x;
        y = _y;
    }
}