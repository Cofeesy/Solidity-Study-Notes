// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//错误处理的学习笔记
contract myError{
   //三种常用报错控制方法：require ,revert,assert和自定义错误
   //三种报错都具有gas费退还以及状态变量回滚的特性
   //
   //require
   function testRequire(uint _i) public pure{
       //require相比于assert为“普通检查“
       //格式：
       //有两个参数，第一个为判断语句必须有;第二个为判断语句为假后报错的字符串，可选
       //第二个可选参数不可带有中文字符串
       require(_i <= 10, "require");
       //code
   }

   //revert
   //revert不能包含表达式，也就是只有报错返回的信息
   function testRevert(uint _i) public pure{
       //可以写一个循环结构
       if(_i > 1){
           //code
            if(_i>2){     
                 if(_i > 10){
                   //同样不可带有中文字符串  
                   revert("revert");
               }
               //more code
           }
       }
   }

   //assert
   uint public a = 10;
   function tsetAssert() public view{
       //功能和require一样
       //不同：
         //1.参数只有第一个必须有的判断逻辑，而没有可选的报错字符串
         //2.如果错误会扣除所有的gas费 
       assert(a == 11);
   }
   //执行该操作可能会使assert报错
   function addAssert() public{
       a++;
   }

   //自定义错误-->节约gas费的小方法
   error MyError(); 
}