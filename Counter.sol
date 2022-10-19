//开源协议：
// SPDX-License-Identifier: MIT

//智能合约的版本号
pragma solidity ^0.8.15;

//实现一个计数器(包含一些学习笔记)：
contract Counter{
    //solidaty变量分为三种：
    //1.状态变量：该变量将永远保存在区块链上，同时变量更改后也是永久保存的-->即函数调用对状态变量的改变是永久的
    //2.全局变量：不用定义就能够显示内容的变量，记录链上和账户的信息
    //3.局部变量：函数调用的时候才会产生，被加载到栈区域

    //1.这是状态变量,会被加载到内存Menmory区
    //该变量可视范围为公开，合约内外部都可调用
      //被public修饰的变量会自动生成 getter函数，用于查询数值-->所以以remix为例，被public修饰的变量可以被读取而不消耗是通过getter函数的
    uint public count;//默认值是uint256类型的0
   
    int public i;//默认值是int256类型:0
    address public a;//默认值：0x0000000000000000000000000000000000000000-->一共40个0，表示20个16进制的数字
    bytes32 public b32;//默认值：0x0000000000000000000000000000000000000000000000000000000000000000-->一共64个零，表示32个16进制的数字

    //2.这是全局变量，msg.sender:记录的是上一个调用这个合约的账户地址，可能是一个外部账户地址，也可能是上一个调用该合约的合约账户
    //关于msg.sender：
      //msg.sender是动态的，"run"时选择的是哪个account(钱包地址)，msg.sender就是哪个地址
    address myaddress = msg.sender;
    //获取一些全局变量
    function globalVars() external view returns (address,uint,uint) {
    address sender = msg.sender;
    uint timestamp = block.timestamp;//这是时间戳
    uint blockNum = block.number;//这是区块编号
    return (sender, timestamp, blockNum);
  }
      
 
    //对状态变量加一
    //external:外部可视,其他的函数是不可以读取的，只能由外部读取
    function inc() external{
        count +=1;

        //3.这是局部变量  
        uint b = 456;
    }

    //对状态变量减一
    function dec() external{
        //inc();-->会报错
        count -=1;
    }

    //&& 和 ||运算符遵循短路规则，这意味着，假如存在f(x) || g(y)的表达式，如果f(x)是true，g(y)不会被计算，即使它和f(x)的结果是相反的（或者说f(x）&&g(y),如果f(x)是false，g(y)不会被计算）
}