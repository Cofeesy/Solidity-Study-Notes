// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//支付函数和回退函数的学习笔记
contract PayableAndFallback{
    //payable关键字：
      //1.使用payable修饰函数：表示该函数可以接收以太坊主币的传入,也就是可以给合约地址发送主币，发送后可以通过调用看到该地址上的主币余额
      //2.使用payable修饰地址：表示该地址可以接收以太坊主币
        //如果该地址有构造器函数传入，构造器内的变量也需要payable修饰

    //1.可以支付主币的函数：
    function deposit() external payable{}

    //2.记住payable修饰地址的顺序：在可视化修饰的前面
    //代表该地址可以接收主币：
    address payable public owner;

    //2.构造函数(payable修饰构造器代表部署的时候既可以同时给该合约传入主币)：
    constructor() payable{
        owner = payable(msg.sender);
    }

    //查看地址的余额
    function getBalance() external view returns(uint){
        //address代表当前的地址
        return address(this).balance;
    }
    //回调函数的作用：接收ETH和处理合约中不存在的函数调用 

    //回调函数有以下特点(回退函数都是外部不可见的)：
      //1.当合约中不存在的函数被调用的时候，将调用fallback函数或者receive函数
      //2.被标记为外部函数
      //3.没有名字
      //4.没有参数
      //5.不能返回任何东西
      //6.每个合约定义一个回退函数
      //7.如果没有被标记为payable，则当合约收到无数据的纯以太币转账时，将抛出异常

     event Log(string fun,address sender,uint value,bytes data);
        
      //在0.8版本中有两种写法：
        //一是fallback关键字开头
        fallback() external payable{
          //msg.value：调用合约时发送的以太坊主币数量
          //msg.data:调用合约时发送的数据
          emit Log("fallback",msg.sender,msg.value,msg.data);
        }

        //二是以receive关键字开头，必须有external关键字和payable关键字
        receive() external payable{
          //receive不接受数据，所以不需要msg.data
          emit Log("receive",msg.sender,msg.value," ");
        }

        //是调用fallback函数还是receive函数?(两种判断)：

//           Ether is sent to contract(当以太坊主币发送到合约的时候)
//                      |
//               is msg.data empty?
//                    /   \ 
//                  yes   no
//                  /       \
//      receive() exists?   fallback()
//              /   \
//             yes  no 
//            /       \
//        receive()  fallback()  
//

       //还有一种情况:当合约中只有fallback函数而没有receive函数的时候,就都会调用fallback函数 




} 