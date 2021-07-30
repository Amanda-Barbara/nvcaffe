# common.cpp代码解析
## 作用域解析运算符::
参考1
```c++
// Google flags.
  ::gflags::ParseCommandLineFlags(pargc, pargv, true); //解析命令行参数
  // Google logging.
  ::google::InitGoogleLogging(*(pargv)[0]);
```
前置了作用域解析运算符::，意思是告诉编译器在全局命名空间中查找该类型，避免调用本文件重名的类


## 参考链接
* 1 [google的gflags解析命令行参数](https://blog.csdn.net/zhouyusong_bupt/article/details/51576612)