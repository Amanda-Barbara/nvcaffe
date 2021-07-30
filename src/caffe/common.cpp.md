# common.cpp代码解析
## 作用域解析运算符::
```c++
// Google flags.
  ::gflags::ParseCommandLineFlags(pargc, pargv, true);
  // Google logging.
  ::google::InitGoogleLogging(*(pargv)[0]);
```
前置了作用域解析运算符::，意思是告诉编译器在全局命名空间中查找该类型，避免调用本文件重名的类

