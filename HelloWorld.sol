//需求1：SPDX许可证标识符：允许开源
// SPDX-License-Identifier: MIT

//需求2：编译器版本
pragma solidity >=0.8.16<0.9.0;

//需求3：合约名
contract HelloWorld{
    string myName = "Hello World! My name is Wang Zheng";

    //需求4：公开函数
       
    //solidaty支持多返回值，并且函数声明返回值的时候关键字是"returns"
    //返回内存中的string值必须标明memory关键字
    function myFirstHelloWorld() public view returns (string memory){

        return myName;
    }

    //为什么这里的返回值是(string menmory)？为什么读取string类型的状态变量去掉memory会报错，而读取uint类型的不需要memory？
      //

}