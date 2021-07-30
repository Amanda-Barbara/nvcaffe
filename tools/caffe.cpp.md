# caffe.cpp源码分析

## 首先从主函数main()开始
1. main()函数
```c++
FLAGS_alsologtostderr = 1; //参考3,4
```
调用了`DECLARE_bool(alsologtostderr);`定义了一个flB命名空间下的bool变量FLAGS_alsologtostderr,并对其赋值为true
意思是:
```c++
FLAGS_alsologtostderr = 1;  //设置日志消息除了日志文件之外是否去标准输出
```
## Properties类
* 通过Properties获取caffe、cudnn、cublas、cuda软件版本以及nvidia-gpu设备信息
```c++
Caffe::Properties& props = Caffe::props();
```
## Py_InitializeEx
* 这段代码没看懂，需要跟进
```c++
#ifdef WITH_PYTHON_LAYER
    try {
      Py_InitializeEx(0);
      if (!PyEval_ThreadsInitialized()) {
        PyEval_InitThreads();
        static PyThreadState* mainPyThread = PyEval_SaveThread();
        (void)mainPyThread;
      }
#endif
```
## GetBrewFunction() 函数
* GetBrewFunction() 函数返回 g_brew_map[name], 即返回需要实现功能的函数
```c++
static BrewFunction GetBrewFunction(const string& name) {
  if (g_brew_map.count(name)) {
    return g_brew_map[name];
  } else {
    LOG(ERROR) << "Available caffe actions:";
    for (BrewMap::iterator it = g_brew_map.begin();
         it != g_brew_map.end(); ++it) {
      LOG(ERROR) << "\t" << it->first;
    }
    LOG(FATAL) << "Unknown action: " << name;
    return NULL;  // not reachable, just to suppress old compiler warnings.
  }
}
```
## RegisterBrewFunction 宏定义
```c++
// 参考1，2
#define RegisterBrewFunction(func) \
namespace { \
class __Registerer_##func { \
 public: /* NOLINT */ \
  __Registerer_##func() { \
    g_brew_map[#func] = &func; \
  } \
}; \
__Registerer_##func g_registerer_##func; \
}
```
## BrewFunction函数指针
* 使用`typedef`定义一个名为BrewFunction函数指针类型，返回一个指向int类型的指针
```c++
typedef int (*BrewFunction)();
```
## BrewMap
* 使用`typedef`定义一个map类型的数据结构`BrewMap`
```c++
typedef std::map<std::string, BrewFunction> BrewMap;
```

## 参考链接
* 1 https://blog.csdn.net/s_sunnyy/category_6381314.html
* 2 https://blog.csdn.net/s_sunnyy/article/details/78247827
* 3 [用于控制链接库总函数对外是否可见](https://blog.csdn.net/mutourenzhang/article/details/47803803)
* 4 [glog日志输出](https://www.cnblogs.com/hiloves/p/6009707.html)
* 