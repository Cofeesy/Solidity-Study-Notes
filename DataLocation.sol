// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//数据存储的学习笔记
contract DataLocation{
    //三种存储方式：storage，memory，calldata

    //以例子来看：

    //定义一个结构体
    struct MyStruct{
        uint foo;
        string text;
    }

    //定义一个mapping,地址指向结构体，相当于一个人绑定身份信息，地址代表一个人，身份信息用结构体替代(身份信息有很多属性)
    mapping(address => MyStruct) public myStructs;

    //加深记忆01：数组、结构体、字符串(字符串也是数组，是bytes类型的数组)在作为输入输出参数时，都必须加上memory关键字
    function examples(uint[] calldata t,string memory s) external returns(uint[] memory){
        //使用mapping，将调用本合约的地址赋予一个匿名MyStruct结构体对象
        myStructs[msg.sender] = MyStruct({foo:123, text:"bar"});
        
        //重要记录存储
        MyStruct storage myStruct = myStructs[msg.sender];
        //被修改且被记录
        myStruct.text = "foo";

        //运行后就消失
        MyStruct memory readonly = myStructs[msg.sender];
        readonly.foo = 456;

       //加深记忆02：方法中声明的数组需要加上memory关键字并且只能是定长数组 
       uint[] memory memArr = new uint[](3);

       //calldata(调用数据)用法：
         //和memory存储相似，用来修饰输入参数
         //优点：这样内部函数可以遍历 calldata 的数组，而不用再复制到内存了。
         //但是请注意传过来的calldate修饰的类型是只读的(数据不可修改的)，也就是无法在 calldata 变量中创建新值或将某些内容复制到 calldata变量 
        _internal(t);
        return memArr;
    }


    //uint[] calldata arr01;//使用calldata修饰状态变量报错，说明calldata只是用来修饰传入参数的，并且应用场景就是保证!状态!(这里的状态是storage中的状态，而非内存或栈中的变量之类的信息)不会被随意改变
    
    //
    function _internal(uint[] calldata y) private{
      //下面这段代码去掉注释就会报错
      //y[0]=1;
      uint x = y[0];
    }

   // 数据位置和赋值规则：不同的存储类型相互赋值的时候，有时候会产生独立的副本（修改新变量的时候不会改变原变量），有时会产生引用（修改新变量会影响原变量），遵循以下规则：

     //  1.storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量

     //  2.storage赋值给memory，会创建独立的副本，修改其中一个不会影响另一个；反之亦然

     //  3.memory赋值给memory，会创建引用，改变新变量会影响原变量

     //  4.其他情况，变量赋值给storage，会创建独立的副本，修改其中一个不会影响另一个

}