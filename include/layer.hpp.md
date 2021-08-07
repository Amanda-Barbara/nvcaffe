# layer.hpp.md 代码解析

## virtual 关键字之纯虚函数
```c++
virtual void Reshape(const vector<Blob*>& bottom, const vector<Blob*>& top) = 0;
```
* `LayerBase`声明了一个纯虚函数`Reshape`，即该纯虚函数`Reshape`只能被`LayerBase`的派生类继承实现，而在基类`LayerBase`
中不能实例化
* 纯虚函数一般多用于接口的封装，继承`LayerBase`基类的派生类来负责具体实现纯虚函数
## 参考链接
* 1 [virtual关键字运行时多态](https://www.geeksforgeeks.org/virtual-function-cpp/)
* 2 [virtual关键字之纯虚函数](https://www.tutorialspoint.com/pure-virtual-functions-and-abstract-classes-in-cplusplus)
