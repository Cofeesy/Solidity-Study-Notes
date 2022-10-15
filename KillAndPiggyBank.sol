// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

// selfdestruct--两个功能
  //1.delete :删除合约，即将合约地址变为0
  //2.force send:强制向合约发送主币(一般来说合约需要回退函数才能够接收主币，否则会报错，但是这个函数可以使合约不需要回退函数)
contract Kill{
    constructor ()payable{}
    
    function kill() external {
        //selfdestruct(address payable recipient)
        //强制性行为的发送主币
        //需要传入能够接收主币的地址
        selfdestruct(payable(msg.sender));
    }

    //如果没有返回值则自毁测试成功：
    function testCall() external pure returns (uint){
            return 123;
        }
}

//kill练习：
//小猪存钱罐
  //实现逻辑：
    //1.任何人的地址都可以向存钱罐发送主币
    //2.存钱罐的拥有者才可以取出存钱罐中的主币，取出后存钱罐就自毁掉，无法再次存储

contract PiggyBank{
    //存款事件：
    event Deposit(uint amount);
    //取款事件
    event Withdraw(uint amount);
    
    //相当于构造器函数传入地址
    address public owner = msg.sender;

    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() external{
        require(owner == msg.sender,"not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}