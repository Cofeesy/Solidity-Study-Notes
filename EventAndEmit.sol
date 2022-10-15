// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//事件和触发器的学习笔记
contract EventAndEmit{
    //事件可以被前端知道，如js中异步操作一章的订阅事件操作，在此事件响应后，js执行相关异步操作
    event Log(string message,uint val);

    //indexed关键字：
    //用于修饰事件里的变量；
    //被修饰的变量可以被链外作为索引：
    
    //这个事件中，将地址作为链外索引，uint类型的值代表余额
    event IndexdLog(address indexed sender,uint val);

    //但是，一个事件中被indexed修饰的变量不能超过三个，超出会报错


    //有事件通知的函数(emit)，那么这个方法就是写入方法，不能被view或pure修饰（确实改变了链上的状态-->链上会记录此信息）
    function example() external{
        //事件触发器，当这个函数被调用的时候，这个事件就被触发
        //事件触发后会体现在区块链浏览器上
        emit Log("foo",222);

        //indexed事件触发器:当前调用合约的地址
        emit IndexdLog(msg.sender,777);

        //code
    }
}