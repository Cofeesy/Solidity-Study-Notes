// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//事件和触发器的学习笔记
contract EventAndEmit{
    //Solidity中的事件（event）是EVM上日志的抽象，有以下两个特点：
      //响应：应用程序（ether.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
      //经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas
    
    event Log(string message,uint val);

    //以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分
    

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

    //数据Date
      //事件中不带 indexed的参数会被存储在 data 部分中，可以理解为事件的“值”。
      //data 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 data 部分可以用来存储复杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特，即使存储在事件的 topic 部分中，也是以哈希的方式存储。
      //另外，data 部分的变量在存储上消耗的gas相比于 topic 更少。

}