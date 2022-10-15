// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//Solidity 语言有两类和状态读写有关的函数类型
  //一类是 view 函数（也称为视图函数）
  //另一类是 pure 函数（也称为纯函数）
  //两类区别：
    //view函数不修改状态
    //pure函数既不修改状态也不读取状态


// 下面的语句被认为是在修改状态：

// 修改状态变量；
// 触发事件；
// 创建其他合约；
// 使用 selfdestruct；
// 通过调用发送以太币；
// 调用任何未标记 view 或 pure 的函数；
// 使用低级调用；
// 使用包含某些操作码的内联汇编。


contract ViewAndPureFunctions{
    //1.定义一个状态变量
      //当合约中成员变量的访问为 public 则合约自动为该变量生成获得该变量的方法
    uint public num1 = 111;

    uint private num2;

    //2.定义一个view类型函数，该函数读取状态变量，但不做修改
    function viewFunc() external view returns(uint){
        //num+=1; -->这行代码修改一个状态变量，去掉注释会报错
        return num1;
    }

    //3.定义一个pure类型的函数，该函数既不能读取状态变量，也不能修改状态变量
    function pureFunc() external pure returns(uint){
        //uint a = num1;-->这行代码读取一个状态变量，去掉注释会报错
        return 1;    
    }

    //4.这个函数应该用view来修饰,读取了状态变量，但保证不修改状态
    function addToNum1(uint x) external view returns (uint){
        return num1 + x;
    }

    //5.这个函数应该用pure来修饰,既没有修改状态也没有读取状态
    function addToNum2(uint x,uint y) external pure returns (uint){
        return x + y;
    }

    //public

}