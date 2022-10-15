// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//工厂模式
//场景：如果要创建同一个合约的多个实例，并且寻找一种跟踪它们并简化管理的方法，那么可以使用到工厂合约的设计模式
  //工厂合约使用new关键字来部署子合约

//工厂合约测试子合约
contract Factory{

    //合约为数组类型，这是一个合约类型的数组，存放该合约的多个实例
    Child[] public children;
    uint disableCount;

    event ChildCreated(address childAddress,uint data);

    //创建
    function createChild(uint _data) external{
        //重点：使用new关键字创建子合约的实例-->这类似java创建类的对象，然后使用该对象访问类的元素
        Child child = new Child(_data,children.length);
        //
        children.push(child);
        emit ChildCreated(address(child),_data);
    }

    function getChildren() external view returns(Child[] memory _children){
       //方法体内定长数组的创建方法02：
        _children = new Child[](children.length-disableCount);
        uint count; //默认值为0
        for(uint i=0;i<children.length;i++){
            if(children[i].isEnable()){
                _children[count] = children[i];
                count++;
            }
        }
    }

    function disable(Child child) external{
        children[child.index()].disable();
        disableCount++;
    }
}


//待测试的子合约(可以理解为核心智能合约)：
//使用工厂模式后，这个函数不用部署也能够调用逻辑了
  //但是工厂合约和工厂合约创建的对象的合约两者需要在同一个文件中，否则需要import引入合约文件
contract Child{
    uint data;
    bool public isEnable;
    uint public index;

    //被工厂合约创建的合约只需要暴露这个构造方法
    constructor (uint _data,uint _index){ 
        data = _data;
        index = _index;
        isEnable = true;    
    }

    function disable() external{
        isEnable = false;
    }
}

//库合约-->节约代码量的做法
//关键字：library

library Math{
    //如果库合约内的函数定义为外部可视将毫无意义-->库函数主要是给内部合约使用
    function max(uint x,uint y) internal pure returns (uint){
       return x >= y ? x : y;
    }
} 

library ArrayLib{
    function find(uint[] storage arr,uint x) internal view returns (uint){
        for (uint i = 0;i<arr.length;i++){
            if (arr[i] == x){
                return i;
            } 
        }
        revert("not found");
    }
}

contract testLibrary{
    //using关键字：将库函数作为类型的功能
    //这表示uint[]都将拥有库函数ArrayLib的功能
    using ArrayLib for uint[];


    uint[] public arr = [3,2,1];
    
    function testMax(uint x,uint y) external pure returns(uint){
        //简单的被定义的Math库的用法：
        return Math.max(x,y);
    }

    function testFind() external view returns(uint _i){
        return ArrayLib.find(arr,2);
    }
   
    //相当于是数组的一个方法了：
      //这样使用比上面的函数调用更加简洁
    uint public i = arr.find(1);

}