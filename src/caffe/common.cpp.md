# common.cpp代码解析
## 作用域解析运算符::
```c++
// 参考1
// Google flags.
// 解析命令行参数，把caffe.cpp中通过DEFINE_*定义的变量都转换成以FLAGS_为前缀的命令行参数
  ::gflags::ParseCommandLineFlags(pargc, pargv, true);
  // Google logging.
  // 参考2
  ::google::InitGoogleLogging(*(pargv)[0]);
  // Provide a backtrace on segfault.
  // 参考3
  ::google::InstallFailureSignalHandler();
```
前置了作用域解析运算符::，意思是告诉编译器在全局命名空间中查找该类型，避免调用本文件重名的类

## cudaDeviceProp数据结构
```c++
cudaDeviceProp device_prop;
  for (int gpu = 0; gpu < compute_capabilities_.size(); ++gpu) {
    CUDA_CHECK(cudaGetDeviceProperties(&device_prop, gpus[gpu]));
    compute_capabilities_[gpu] = device_prop.major * 100 + device_prop.minor;
    LOG(INFO) << "GPU " << gpus[gpu] << " '" << device_prop.name
               << "' has compute capability " << device_prop.major << "." << device_prop.minor;
  }
```
## thread_local
```c++
static thread_local Caffe caffe;
```
* 使用thread_local标识符修饰的变量caffe使得每个线程拥有其自身的对象实例，进而达到线程安全

## 参考链接
* 1 [google的gflags解析命令行参数](https://blog.csdn.net/zhouyusong_bupt/article/details/51576612)
* 2 [glog简单入门](https://www.cnblogs.com/foreveryl/archive/2011/10/14/2212265.html)
* 3 [追溯因信号异常导致的程序崩溃](http://www.yeolar.com/note/2014/12/20/glog/)
* 4 [cudaDeviceProp数据结构](https://blog.csdn.net/curtern/article/details/85267242)

