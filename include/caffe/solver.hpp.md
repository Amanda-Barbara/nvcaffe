# solver.hpp代码解析
## 定义函数指针类型ActionCallback
通过`boost::function<return class type(param)>`来定义一个函数指针类型
```c++
typedef boost::function<SolverAction::Enum()> ActionCallback;
```
与下方代码等价
```c++
typedef SolverAction::Enum (*ActionCallback)();
```