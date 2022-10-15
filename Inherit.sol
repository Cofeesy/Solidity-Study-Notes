// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//继承的学习笔记
contract X{
//不是以.sol文件名为合约名的合约
//这也是基础合约，这是相对于继承的时候，我们称基础合约是没有继承其他合约，而被其他合约所继承的合约    
   
    //virtual关键字：
      //1.用于函数继承时使用，表明该函数被继承合约所重写
      //2.如果该函数被重写，就必须加上virtual关键字 
    function foo() public pure virtual returns(string memory){
        return "X1";
    }
    
    function bar() public pure virtual returns(string memory){
        return "X2";
    }

    function bax() public pure returns(string memory){
        return "bax";
    }
}

//一个.sol文件可以有多个合约文件：
//当然也可以有多个派生合约：

//而派生合约就是继承基础合约的合约，一个基础可以被多个派生合约继承，并且也可以有线性继承
contract Y is X{
    //override关键字：
      //1.表示重写所继承方法
      //2.如果该方法重写了父合约中的方法，就必须加上override关键字
    function foo() public pure virtual override returns (string memory){
        return "Y1";
    }

    function bar() public pure virtual override returns (string memory){
        return "Y2";
    }

    function bay() public pure returns (string memory){
        return "bay";
    }

}


//记住线性关系，多线继承时，继承的合约顺序不能颠倒或者乱序
//X时基础合约必须写在前面
contract Z is X, Y{
    //多线继承时，override写法：需要加上()和所继承的合约
    function foo() public pure virtual override(X,Y) returns (string memory){
        return "Z1";
    }

    //这里override修饰后面加的合约名顺序可以和继承顺序不一致：
    function bar() public pure virtual override(Y,X) returns (string memory){
        return "Z2";
    }

    function baz() public pure returns (string memory){
        return "baz";
    }

}

//加深记忆：
//记住多线继承线性顺序不能错：
//以下继承顺序如改成：X,Z,Y就会报错
contract C is X,Y,Z{

     string public name;

    //父级构造函数
    constructor(string memory _name){
        name = _name;
    }

    function foo() public pure override(X,Y,Z) returns (string memory){
        return "Z1";
    }

    //这里override修饰后面加的合约名顺序可以和继承顺序不一致：
    function bar() public pure override(Y,X,Z) returns (string memory){
        return "Z2";
    }
}

contract D{

    string public text;
    constructor(string memory _text){
        text = _text;
    }  
}

//子合约继承父级合约，父级构造函数中有传入参数的需要子级合约传入参数：
//构造函数运行顺序：按照继承的顺序去初始化

//这里有三种方法：
  //第一种方式：这种方法时已知参数的值，直接传入父级构造函数
  //构造函数运行顺序：C-->D-->E
contract E is C("C"),D("D"){
   
}

  //第二种方式：部署时手动传入
  //构造函数运行顺序：D-->C-->F
contract F is D,C{
    constructor(string memory _name,string memory _text) C(_name) D(_text){

    }
}

  //第三种方式：混合使用：
  //构造函数运行顺序：C-->D-->G
contract G is C("C"),D{
   constructor(string memory _text) D(_text){

   }
}  
