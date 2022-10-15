// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//删除数组元素的一些方法的学习笔记
contract deleteArr{
    //delete元素删除后，删除元素的位置变为数组的默认值，而pop元素是弹出数组中最后一个元素，然后数组长度减一；
    //如果我们需要删除中间的元素，然后使数组长度减一，我们有两种方式：
      //1.通过移动元素位置
      //2.通过替换

      //场景：现在有一个数组：
      uint[] public arr01 = [0,1,2,3,4];
      //现在我们需要删掉中间的某个数字

      //第一种移动方式：
      //例如：我们要删除数字2这个元素
        //我们可以将该索引之后的元素向该索引对应元素移动，然后使用pop方法使数组长度减一
      function movetoDelete(uint _index) public{
        //首先判断索引长度是否合法
        require(_index < arr01.length,"index out of bound");

        for (uint i = _index;i < arr01.length-1;i++){
          arr01[i] = arr01[i+1];
        }
        arr01.pop();
      }

    //第二种替换方式：
    //同样删除索引为2的元素，通过将该索引对应元素和数组最后一个元素进行替换，然后执行pop方法将其删掉
      //缺点：这样会破坏数组顺序
      //优点：这样可以节省gas费-->省去了循环结构
    function insteadDelete(uint _index) public{
      require(_index<arr01.length,"index out of bound");
      arr01[_index]=arr01[arr01.length-1];
      arr01.pop();
    }
        
}