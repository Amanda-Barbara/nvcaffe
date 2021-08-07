# macros.hpp代码解析
## 类模板实例化
* C++中模板的实例化指函数模板（类模板）生成模板函数（模板类）的过程。
  对于函数模板而言，模板实例化之后，会生成一个真正的函数。而类模板经过实例化之后，完成了类的定义，变成了模板类  
* 类模板的重点是模板。表示的是一个模板，专门用于产生类的模子
* 模板类的重点是一个具体的类，是由类模板而具体定义的类

## 禁止调用类的拷贝、赋值、移动运算符
```c++
#define DISABLE_COPY_MOVE_AND_ASSIGN(classname) \
  classname(const classname&) = delete;\
  classname(classname&&) = delete;\
  classname& operator=(const classname&) = delete; \
  classname& operator=(classname&&) = delete
```
