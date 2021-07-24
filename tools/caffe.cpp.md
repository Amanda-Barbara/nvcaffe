# caffe.cpp源码分析

## 首先从主函数main()开始
1. main()函数
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