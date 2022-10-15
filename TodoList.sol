// SPDX-License-Identifier: MIT

pragma solidity >=0.8.16<0.9.0;

//待办事项列表练习：
contract TodoList{
    //
    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public todos;

    function creat(string calldata _text) external{
        //推入匿名对象
        todos.push(Todo({
            text:_text,
            completed:false
        }));
    }

    //根据索引更新列表text
    function updateText(uint _index,string calldata _text) external{
        //一个值更新选择此方式更节省gas
        todos[_index].text = _text;
  
        //多个值更新选择此方式更节省gas
        //Todo storage todo = todos[_index];
        //todo.text = _text;
    }

    //根据索引获取数组元素-->但是数组自带查找方法 
    function get(uint _index) external view returns(string memory,bool){
        
        //以下两种方式读取消耗的gas不一样：

        //1.使用memory:这种方式是将状态变量拷贝到内存，然后返回值string需要拷贝一份到内存中进行返回
          //Todo memory todo = todos[_index];
        //2.使用storage:这种方式是直接状态变量的信息，然后返回值也是一样是需要拷贝一份信息到内存中然后进行返回
          Todo storage todo = todos[_index];
        //很明显storage方式步骤更少，所以消耗的gas费也更少
        
        return (todo.text,todo.completed);
    }

    //根据索引改变completed值
    function toggleCompleted(uint _index) external{
        
        //bool值反转状态:
        todos[_index].completed = !todos[_index].completed;
    }

}