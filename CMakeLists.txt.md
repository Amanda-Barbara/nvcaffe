# CMakeList.txt代码使用说明文档

## Caffe version
1. 设置caffe版本  
   在CMakeLists.txt 中，使用add_definitions()函数完成类似于代码中宏定义的功能
```c++
set(CAFFE_TARGET_VERSION "0.17.3")
set(CAFFE_TARGET_SOVERSION "0.17")
add_definitions(-DCAFFE_VERSION=${CAFFE_TARGET_VERSION})
```
这样caffe.cpp中能够识别`CAFFE_VERSION`的宏定义
```c++
gflags::SetVersionString(AS_STRING(CAFFE_VERSION));
```



## 参考链接
* 1 [add_definitions()宏定义](https://blog.csdn.net/qq_42189368/article/details/109522528) 
* 2


