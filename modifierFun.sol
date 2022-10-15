// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//修饰器modifier 可以轻松改变函数的行为
//比如用于在函数执行前检查某种前置条件
//作用:当函数有重复代码的时候可以用函数修改器将相同代码提取到修改器当中，然后用modifier修饰函数


//具体用法：
contract modifierFun{
    //1.先定义一个状态变量
    uint public a;
   
    //2.然后我们定义一个修饰器，修饰器可以接收变量
      //格式：modifier 修饰器名字(接收变量类型 接收变量,接收变量类型 接收变量...){修饰器逻辑; _;}
    modifier modifierfun(uint value){
        require(value >= 10);//require函数
        _;//修饰器当中的"_"符号代表所修饰函数中的代码。
        a+=1;//上面"_"代表的函数代码执行完后会返回来执行完modifier当中的剩余代码
    }

    //3.定义一个被modifier修饰的函数
      //如果执行这个函数，需要先执行修饰器当中的代码，然后再执行函数中的代码
    function setValue(uint num) external modifierfun(num){
        a = num;
    }
    
    //4.定义一个函数，返回设置的状态变量
    function getValue() external view returns (uint){
        return a;
    }

    //5.多重modifier:

    uint public b = 0;
   
    modifier mod{
        b = 1;
        _;
        b = 5;
    }
   
     modifier mod1{
        b = 3;
        _;
        b = 4;
     }
   
    //格式:再修饰符的位置添上n个modifier嵌套
    function test() public mod mod1{
        b = 100;
    }
    //上面是两个modifier修饰的函数,执行顺序为b=1 ---> b=3 ----> b=100 ----> b=4 ----> b=5
      //分析:首先执行mod中的"b = 1"的代码,因为这是modifier多重嵌套,下一行的"_"执行的是下一层也就是例子当中mod1中的代码,
      //而执行到mod1中"_"的时候,这个时候已经没有下一层的嵌套了,于是执行函数体中的代码,函数体中的代码执行完后,便像压栈似的返回执行剩余未执行的代码
      
      //理解:执行过程类似压栈,而modifier修饰器相当于一个特殊的函数

    //6.总结：修饰器其实类似于一个过滤器(通常也也是过滤器的作用，比如限制只有某些地址的账户才能调用该函数-->通常与require函数搭配)

}