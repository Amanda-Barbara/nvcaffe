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


## 参考链接
* 1 [google的gflags解析命令行参数](https://blog.csdn.net/zhouyusong_bupt/article/details/51576612)
* 2 [glog简单入门](https://www.cnblogs.com/foreveryl/archive/2011/10/14/2212265.html)
* 3 [追溯因信号异常导致的程序崩溃](http://www.yeolar.com/note/2014/12/20/glog/)