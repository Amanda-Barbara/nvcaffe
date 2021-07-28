# caffe.cpp源码分析

## 首先从主函数main()开始
1. main()函数
参考3,4
```c++
FLAGS_alsologtostderr = 1;
```
调用了`DECLARE_bool(alsologtostderr);`定义了一个flB命名空间下的bool变量FLAGS_alsologtostderr,并对其赋值为true
意思是:
```c++
FLAGS_alsologtostderr = 1;  //设置日志消息除了日志文件之外是否去标准输出
```

```c++
int main(int argc, char** argv) {
  // Run tool or show usage.
  caffe::GlobalInit(&argc, &argv);
  // 设置设备
  vector<int> gpus;
  get_gpus(&gpus);
#ifndef CPU_ONLY
  if (gpus.size() > 0) {
    Caffe::SetDevice(gpus[0]);
  }
#endif
  if (argc == 2) {
      // 若训练 caffe 的命令行为 ./build/tools/caffe train
      // 则这里 g_brew_map 的 key 值为 argv[1]，也即是 'train'，则实际调用了 train()
      return GetBrewFunction(caffe::string(argv[1]))();  // ------->
  } else {
    gflags::ShowUsageWithFlagsRestrict(argv[0], "tools/caffe");
  }
}
```
2. RegisterBrewFunction 宏定义
参考1，2
```c++
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
3. GetBrewFunction() 函数  
* GetBrewFunction() 函数返回 g_brew_map[name], 即返回需要实现功能的函数
```c++
static BrewFunction GetBrewFunction(const caffe::string& name) {
  if (g_brew_map.count(name)) {
    return g_brew_map[name];
  }
}  
```



## 参考链接
* 1 https://blog.csdn.net/s_sunnyy/category_6381314.html
* 2 https://blog.csdn.net/s_sunnyy/article/details/78247827
* 3 [用于控制链接库总函数对外是否可见](https://blog.csdn.net/mutourenzhang/article/details/47803803)
* 4 [glog日志输出](https://www.cnblogs.com/hiloves/p/6009707.html)
* 