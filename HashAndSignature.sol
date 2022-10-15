// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//介绍solidaty中的常用hash函数和一些编码函数

//数据打包：
  //介绍两种方式以及不同之处
contract Encode{
    //abi.encodePacked():紧凑编码给定数据。
    //abi.encodePacked(...) returns (bytes memory)
            //原理：将传入参数先转为16进制，然后进行拼接
            //注意：紧凑编码解码时可能会有歧义！(多个动态数据类型传给abi.encodePacked时，可能会发生哈希冲突)
    function encodepacked01() external pure returns(bytes memory){
        return abi.encodePacked("aa","bb");
    }

    function encodepacked02() external pure returns(bytes memory){
        return abi.encodePacked("aab","b");
    }
     
    //出现歧义!：上面两者函数传入参数不同，但返回参数都是0x61616262
      //这个时候就必须使用到abi.encode()函数
      //或者隔开：
       function encodepacked03() external pure returns(bytes memory){
        //使用uint类型的数据隔开：
          //注意格式，传入的是uint(222)而不是数据222
        return abi.encodePacked("aab",uint(222),"b");
    }

    //abi.encode():编码给定参数
    //abi.encode(...) returns (bytes memory)
      //与abi.encodePacked()不同,abi.encode()需要先进行补零 ，再进行转码拼接,所以结果会和encodePacked
    function encode() external pure returns(bytes memory){
        return abi.encodePacked("aab","b");
    }
}

//hash数据：
//因为hash函数的特性(输入相同，输出肯定相同)，所以我们可以在链外计算一些hash值然后拿到链上进行验证
contract Hash{

    function hash(string memory text,uint num,address addr) external pure returns(bytes32){
        //keccak256(bytes) returns (bytes32)
            
        //通常使用abi.encodePacked打包所有数据，然后再进行keccak256哈希
          //打包：打包输出的结果就是将一堆传入的数据打包成bytes(字节数组)    
        return keccak256(abi.encodePacked(text,num,addr));
    }
}

//智能合约签名及验证有以下四个步骤(原理：数字签名与验证)
  //0.message to sign --> 对消息进行签名
  //1.hash(message) --> 对消息进行hash运算
  //2.sign(hash(message) ,private key) | offchain --> 再把消息和私钥进行签名，这一步在链下进行
  //3.ecrecover(hash(message),signature) == signer -->恢复签名，这里使用内置函数ecrecover()函数，对想要验证的签名人进行验证就就行

contract Verifysig{

  function verify(address _signer ,string memory _message,bytes memory _sig) external pure returns(bool){
    
    //1.得到消息摘要--Hash
    bytes32 messageHash = getMessageHash(_message);
    
    //2.对摘要值用私钥进行签名
    bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
    
    //3.验证
    return recover(ethSignedMessageHash,_sig) == _signer;

  }
  
  //1.hash(message)
  function getMessageHash(string memory _message) public pure returns(bytes32){
    return keccak256(abi.encodePacked(_message));
  }
  
  //2.对摘要值用私钥进行签名
    //需要
  function getEthSignedMessageHash(bytes32 _messageHash) public pure returns(bytes32){
    return keccak256(abi.encodePacked(
      "\x19Ethereum Signed Message:\n32",
      _messageHash
      ));
  }
  
  //3.验证
  function recover(bytes32 _ethSignedMessaggeHash,bytes memory _sig) public pure returns(address) {
    //RSA
    (bytes32 r, bytes32 s,uint8 v) = _split(_sig);
    
    //固定算法ecrecover，返回地址
    return ecrecover(_ethSignedMessaggeHash,v,r,s);  
  }

  function _split(bytes memory _sig) internal pure returns(bytes32 r,bytes32 s,uint8 v){

    //
    require(_sig.length == 65,"invalidd signature length");
   
    //使用内联汇编进行分割
    assembly{
      r:=mload(add(_sig,32))
      s:=mload(add(_sig,64))
      v:=byte(0,mload(add(_sig,96)))
    }
    return (r,s,v);
  }
}
    