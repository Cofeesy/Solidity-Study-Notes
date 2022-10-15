// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//枚举的学习笔记
contract Enum{
    //枚举是一种类型，可以让一种变量拥有多种状态

    //声明一个枚举类型
    //这个枚举类型包含6种类型
    //注意：枚举类型 enum 内部就是一个自定义的整型，默认的类型为uint8，当枚举数足够多时，它会自动变成uint16
    enum Status{
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }
    
    //声明一个枚举类型的实例，这个实例包含上面定义的6种状态
    Status public status; 
   
   //定义一个结构体，包含一个枚举类型的属性
    struct Order{
        address buyer;
        //加深：像上面的address一样，枚举是一种类型
        //定义方式：类型大写，属性小写
        Status status;
    }

    Order[] public orders;

    //操作枚举：

    //获取这个status
    //不会返回上面定义的字符串，而是会返回当前所在状态的索引值
    //比如下面这个函数会返回0-->默认是第一个位置
    function get() external view returns(Status){
        return status;
    }

    //设置想要的状态变量的值-->因为枚举中的值是以索引的形式存在的，所以传入参数需要是索引的数值类型
    function set(Status _status) external{
        status = _status;
    }

    //或者指定改变后的状态：
    //改变后读取status的状态，发现索引值改变
    function ship() external{
        status = Status.Shipped;
    }

    //使枚举类型的值恢复到默认值：
    //同样的使用好delete：
    function reset() external{
        delete status;
    }

}