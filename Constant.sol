// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//常量的一些学习笔记
contract Constant{
    //常量：固定值，在被定义后不能被修改，使用关键词constant修饰的状态变量
    //比如管理员的地址，可以定义为常量
    //使用常量的规范：
      //字母需要大写:

    //为什么要定义常量？-->一些经常使用的状态变量定义为常量后可以节省Gas  
      //常量消耗Gas:21442
      address public constant MY_ADDRESS01 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;//20个字节
      //非常量消耗Gas:21464
      address public constant MY_ADDRESS02 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

      uint public constant MY_UINT = 123;

      string constant b = "yyy";
      //Only constants of value type and byte array type are implemented.
      //仅实现常量值类型和字节数组类型
      //uint[] public constant a = [1,2,3];-->报错

    //关键字：immutable
    //被immutable修饰的变量为不可变量-->在定义后既变为常量
    //immutable和constant区别：
      //1.被immutable修饰的变量在部署的时候就知道值了，并且部署后不允许修改；
        //而被constant修饰的值，在部署的时候是不知道的

      //2.只有数值变量可以声明 constant 和 immutable；String 和 bytes 可以声明为 constant，但不能为 immutable  
      //3.被constant修饰的变量必须在声明时即初始化，而被immutable修饰的变量可以在声明时或构造函数中初始化，因此更加灵活

      uint public immutable o;
      constructor (uint _text){
          o = _text;
      }
    
      
    //程序控制语句--if/else 
    function ifelse(uint x) external pure returns (uint){
        if (x>2){
            return 1;
        }else if (x<4){
        return 2;
        }else{
            return 3;
        }    
    }

    //程序控制语句--循环
    function loop01() external pure{
        for(uint i = 0;i<10;i++){
            if (i == 5){
                continue;
            }

            if (i==8){
                break;
            }
        }

    }

    function loop02(uint x) external pure returns(uint){
        uint s;
        
    } 

    //bytes32字节数组和address进行相互转换
      //两种思路
        //1.长度转换(这样会丢失)
        //


    //1.
    function test(bytes32 _input) external pure returns(address){
        return address(uint160(uint256(_input)));
    }

}