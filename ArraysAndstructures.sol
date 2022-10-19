// SPDX-License-Identifier: MIT

//"^"符号表示版本大于等于后面的版本--0.8.15,但是小于一个大的版本0.9.0
pragma solidity ^0.8.15;

//数组和结构体的一些学习笔记
contract ArraysAndstructures{
 
    //静态数组(定长数组)
    uint[3] arr01;//只能装上三个uint类型的元素
    uint[2] public arr02= [1,2];//声明即赋值，也可以使用数组的push方法来装入数据
    //uint a[3]=[1,2,3]-->错误声明数组方式,注意格式

    //动态数组(变长数组)
    string[] public arr03;
    uint[] public arr04 = [1,2,3];
    uint[]  _arr04;

    //uint [] _arr05 = new uint[](7);
 
    //在内存中创建定长数组(两种方式)：
    function creatmemArr(uint[] calldata t) external returns(uint[] memory){
      //uint[9] memory public arr05;//在内存中创建一个被public修饰的变量是不行的
      //第一种：
      //正确方法以及格式：
      //注意两点：
        //1.内存中可以创建动态数组(编译不会报错，但是还是遵循在内存中只能创建内存数组)
        //2.在内存中如果使用new关键字创建，必须声明长度，并且声明长度后就不能改变长度
      uint [] memory arr05 = new uint[](5);
      //针对注意1：不应该创建此内存数组
      uint [] memory arr09;
      arr09[0] = 9;

      //或者创建非内存数组
      uint[] storage arr10;
      
      //针对注意第2点和第3点可以知道：
        //pop方法和push方法无法对内存数组使用，因为pop和push都会改变数组的长度

      //只能够通过索引操作内存数组：
        arr05[0] = 1;
        arr05[1] = 2;
      //注意两点：
        //1.和string一样，如果需要返回所有数组所有信息必须在返回值类型后加上memory关键字 
        return arr05;
        //2.而返回uint类型的内存变量不需要
        //return arr05[0];
      //第二种：函数外部声明不初始化然后在函数内部进行变量赋值   
        _arr04 = new uint[](7);
        arr03 = new string[](3);
      
      //数组切片：
        //截至目前，数组切片仅用于调用数据数组,即被calldata修饰的数组;目前没有以go语言中切片的类似用法
        t[0:1];
        //arr01[0:1];

    }
    
    //数组的方法
      //length方法：
      //获取数组的长度
    uint public a = arr01.length;

      //push方法:
      //向变长数组中添加元素
      //arr04.push(5);//报错-->为什么
        //数组的push方法需要放在方法体内   
    function pushIn() public{
      //arr01.push(6);-->定长数组不能调用push方法向里面添加存储元素
       arr03.push("rr");
       arr04.push(4);
    }

      //delete方法：删除数组元素
      //删除不会改变数组的长度，而是将该索引位置变为默认值
      //delete arr02[0];
      function deleteArr() public{
        delete arr02[0];
      } 

      //pop方法
      //同样的，是对变长数组的长度-1
      //弹出元素，弹出后数组长度减1
      function popArr() external returns(uint){
        arr04.pop();
        uint length = arr04.length;
        return length;        
      }

    
    //结构体
    struct Person{
        string name;
        uint age;
      //name:string-->错误声明方式，注意格式
    }
    
    //结构体与数组
    Person[] public person;//存放结构体的数组--状态变量
    Person public steve = Person("Steve Jobs",56); // 
    function pushPeople() external{
      //memory关键字不可或缺-->Data location must be "storage", "memory" or "calldata"
       Person memory wanger = Person({name:"wanger",age:20});
        person.push(steve);
        person.push(wanger);
    }
    
}