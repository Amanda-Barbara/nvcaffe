# parallel.hpp 代码解析

## `P2PManager`类
* `P2PSync`类使用了前向声明，`P2PManager`类声明了保护成员`vector<unique_ptr<P2PSync>> syncs_;`
![](../../docs/tutorial/include/caffe/P2PManager架构.png)
## `P2PSync`类
```c++
class P2PSync : public Solver::Callback, public InternalThread
```
* `P2PSync`类继承了`Solver::Callback`类以及`InternalThread`类，需要对`InternalThread`类的虚函数`InternalThreadEntry()`
  进行重写`void P2PSync::InternalThreadEntry()`，调用流程如下：
```c++
  for (int i = 0; i < syncs_.size(); ++i) {
    syncs_[i]->StartInternalThread(true, static_cast<uint64_t>(param.random_seed() +
                                                               P2PManager::global_rank()));
  }
  for (int i = 0; i < syncs_.size(); ++i) {
    syncs_[i]->WaitAll();
  }
```
`StartInternalThread`是`InternalThread`类的内部函数，内部实现了通过开启`boost::thread`线程
来执行`InternalThread`类的`entry`函数，`entry`函数调用了子类实现的`InternalThreadEntry()`函数


## 参考链接
* 1 [`P2PManager`类分析](https://blog.csdn.net/yiran103/article/details/81220278)
* 2 [`C++`前向声明](https://www.cnblogs.com/wkfvawl/p/10801725.html)
* 3 [`static constexp`使用](https://blog.csdn.net/mxyhktk/article/details/112016564)
