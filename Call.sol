// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//测试合约
contract Call{
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable{
        emit Log("fallback was called");
    }

    receive() external payable{
        emit Log("receive was called"); 
    }

    function foo(string memory _message,uint _x) external payable returns(bool,uint){
        message = _message;
        x=_x;
        return(true,880);
    }
}


//低级调用另一个合约的方法
contract CallTest{
    bytes public data;

    constructor() payable{
    }

    function callFoo(address _test) external payable {
        //call调用带有消息数据data的例子：
        //调用时消息数据data需要使用abi.encodeWithSignature()方法对消息数据进行编码签名-->注意格式：
        //注意
          //1.调用的函数需要以字符串的形式
          //2.然后以字符串形式的函数内的只需要传入的类型(名称和数据存储类型都不需要)
          //3.注意如果传入的是uint类型，那么需要是uint256
          //4.后面加","传入具体消息数据data
        (bool _success,bytes memory _data) = _test.call{value:111}(abi.encodeWithSignature("foo(string,uint256)","call foo",123
        ));

        require(_success,"call failed");
    
    //保存
    data = _data;
    }


    function callDoesNotExit(address _test) external{

        (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExist()"));
        require(success,"call failed");
    }
}



//委托调用：一种特殊的调用方法
  //理解两种场景的不同(执行者--msg.sender和执行环境的不同)
   
   //传统场景调用：
    //A calls B,发送了100 wei主币；然后B calls C, 发送了50wei主币
    //这个过程中，注意两点：
      //1.A发送给B的100wei主币全部保存在B合约中，B发送的50合约全部保存在C合约中，剩余50wei自己保存
      //2.B调用C合约，关注点都需要在B和C这两个主体上，也就是说C看到的调用发起者是B而不会是A，并且B发送的消息中如果有改变状态变量的逻辑也会相应的改变C中的状态变量(即这个过程执行的环境是c)
   
   //委托调用的场景
    //A calls B,发送了100wei主币;然后B delegatecall C,发送100wei主币-->也就是A委托B调用C合约
    //这个过程注意：
      //1.这个过程C的看到的调用者和B一样,都为A合约 
      //2.委托调用合约和被委托调用的合约的状态变量都需要一致(否则内存变量不一致会出现意料之外的错误)
      //3.委托调用并不会改变C中的状态变量,相应的因为两个合约的内存变量相同,消息中如果有改变状态变量的逻辑会改变B合约(即这个过程执行环境是B--委托调用的调用合约)

//两种场景都是A发送主币和消息调用B,所以不累赘A合约的场景,逻辑处理主要分别在B和C合约对象:

//C合约
contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable{
        num = _num;
        sender = msg.sender;
        value =  msg.value; //A发送过来的主币
    }
}

//B合约
contract DelegateCall{
    //这三个值有必要定义吗?-->答案是肯定有必要的-->为什么呢?-->如果委托合约与被调用合约中的变量布局不同会引起不可预测的异常
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test,uint _num) external payable{
        //delegatecall()即为委托调用关键
          //逻辑和call()方法一样
        //_test.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num));

        //注意abi.encodeWithSelector()方法格式:
          //合约名.方法名.selector 后面紧跟传入的参数
        //这种select方法相比于signatur签名方法好处:改进了因代码书写问题报错的问题  
        (bool success,bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector,_num));

        require(success,"delegateCall failed");
    }
}


