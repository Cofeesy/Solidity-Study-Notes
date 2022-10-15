// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//一个合约调用另一个合约的一些操作方法-->这是和已部署的智能合约进行交互(区别于工厂模式使用new关键字来部署子合约-->即需要的使用的合约)

//调用TestContract
contract CallTestContract{
    //调用另一个合约就是像创建调用合约的对象，然后通过此合约对象访问，只是，可以用类型(合约地址)来比喻这个对象
    //实质就是使用另一个合约的地址调用合约的函数 
    
    //1.传入地址，然后将地址变量传入合约类型中调用
    function setX(address payable _test,uint _x) external{
        TestContract(_test).setX(_x);
    }

    //2.直接传入另一个合约的类型，使用另一个合约的类型来调用
    function getX(TestContract _test) external view returns(uint x){
        //第一种返回方式(使用return关键字返回)：
        //return _test.getX();-->这种返回方式returns后面只需要返回值类型即可，不需要具体返回值
        //第二种返回方式(不使用return关键字返回)-->这种返回方式需要返回值类型和具体的返回值
        x = _test.getX();
    }

    //含有能够接收主币的函数调用-->即合约之间传递价值
    function setXandReceiveEther(address _test,uint _x) external payable{
        //注意传入格式：函数接上{}
        //下面传入意义是将调用此函数附带的所有主币传递给下一个合约
        TestContract(_test).setXandReceiveEther{value:msg.value}(_x);
    }

    function getXandValue(TestContract _test) external view returns(uint,uint){
        (uint x,uint value) = _test.getXandValue();
        return (x,value);
    }

}

//被调用合约Testcontract，有四个方法
contract TestContract{
    uint public x;
    uint public value;
   

    //改变这个合约中状态变量的x值
    function setX(uint _x) external{
        x = _x;
    }

    //读取x的值
    function getX() external view returns (uint){
        return x;
    }

    //改变这个合约中状态变量x和value的值
    //函数的意思：设置一个变量x的时候同时传入主币
    function setXandReceiveEther(uint _x) external payable{
        x = _x;
        value = msg.value;
    }

    //读取x和value的值
    function getXandValue() external view returns(uint,uint){
        return (x,value);
    }

}