# solver.hpp代码解析
## 定义函数指针类型ActionCallback
通过`boost::function<return class type(param)>`来定义一个函数指针类型
```c++
typedef boost::function<SolverAction::Enum()> ActionCallback;
```
* `boost::function`可以定义一个指针，指向具有特定签名的函数，上述定义了一个返回值类型为`SolverAction::Enum()`的
  函数指针类型ActionCallback，匹配此签名的函数均可赋值给这个指针。
* `boost::function`是对如下使用`typedef`关键字定义的函数指针类型的封装
```c++
typedef SolverAction::Enum (*ActionCallback)();
```

## 参考链接
* 1 [boost库之函数对象](https://wizardforcel.gitbooks.io/the-boost-cpp-libraries/content/3.html)
