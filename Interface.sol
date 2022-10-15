// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//抽象合约：缺少实现的合约-->通常作为父函数用来被继承
  

//情景：当一个合约中代码和函数太多且冗余或者我们不知道另一个合约的源代码，那我们调用那个合约就变得困难
  //所以我们可以通过接口来调用

//interface关键字：
//接口合约：
interface IConter{
    //接口合约中函数的定义：和其他语言类似，不需要实现其具体逻辑

    //不需要实现其逻辑，即省去{}，并且定义完一个函数需要在后面加上";"
    function inc() external;   
    //相比于抽象合约，接口还是还有其他限制：

    //不能继承其它合约，或接口。
    //不能定义构造器
    //不能定义变量
    //不能定义结构体
    //不能定义枚举类

    //接口中函数不一定是某个合约中的全部函数，可能是多个合约中共有的函数
}

contract CallConter{
    uint public count=1;

    function examples(address _counter) external{
        //通过地址构造合约变量：
        //这是匿名合约变量
        IConter(_counter).inc();

        //或者这样构造一个合约变量：
        //IC为构造的合约变量
        IConter IC = IConter(_counter);

        IC.inc();
        
    }
}

//
contract Conter{
    uint public Count;

    function inc() external{
        Count+=1;         
}     

    function count() external view returns (uint){
        return Count;
    }
}