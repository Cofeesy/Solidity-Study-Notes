// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//学习发送主币的方法的学习笔记
contract sendEther{
    
    constructor() payable{}

    
    //在合约中有三种内置方法(函数)发送以太坊主币：

      //1.transfer
        //使用transfer发送主币只会带有2300个gas，如果gas消耗完毕(或者接收方拒收或者触发其他逻辑)会执行reverts(回退)中断合约的进行
        //使用transfer方法向_to地址发送主币
        function sendViaTransfer(address payable _to) external payable {
             //这样就可以向目标地址--_to地址发送主币了
             _to.transfer(123);//-->代表123wei被发送到_to地址
        }
      //2.send
        //使用send发送主币也会带有2300个gas，但是遇到gas耗尽或者其他逻辑异常不会像t'ran函数会返回一个bool值来表明发送是否成功
        //使用send方法向_to地址发送主币       
        function sendViaSend(address payable _to) external payable{
            //同样向目标地址--_to地址发送124wei
            //使用局部变量接收
            bool sent = _to.send(124);

            //一般搭配使用错误处理进行操作：
            require(sent,"sent failed");
        }

      //3.call
        //使用call方法发送主币会发送所有的gas，然后会返回一个bool值和data数据
        //使用call方法向_to地址发送主币
        //调用call方法的地址是可以不需要payable关键字修饰的
        function sendViaCall(address _to) external payable{
            //注意call方法使用格式：{}里面是类似对象的value值，()里面对应的是发送的数据
            //注意接收格式：这里的接收()是不可没有的，并且可以省略data数据，然后留下一个","号表示不接收data数据：即solidity使用解构式赋值的规则，即支持读取函数的全部或部分返回值，也就是说，用逗号隔开按顺序排列的返回值中可以有空值（但是","不能少）
            //(bool success,bytes memory data) =  _to.call{value:125}(" ");-->这里注意发送数据("")和(" ")的区别：前者表示数据才为空，后者数据不为空
            (bool success, ) =  _to.call{value:125}("");
            

            
            //一般搭配错误处理进行操作：
            require(success,"call failed");        

        } 

}


//接收主币的合约
contract EthReceiver{

    event Log(uint amount,uint gasleft);
   
    //使用receive函数接收主币
      //gasleft()函数：显示剩余gas的数量
    receive() external payable{
        emit Log(msg.value,gasleft());
    }

}