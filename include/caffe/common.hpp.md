# common.hpp代码解析
## set_gpus()
```c++
static void set_gpus(const std::vector<int>& gpus) {
    std::lock_guard<std::mutex> lock(caffe_mutex_); //参考1
    gpus_ = gpus;
    if (gpus_.empty()) {
      gpus_.push_back(root_device_);
    }
  }
```
## Properties()
```c++
// Caffe Properties singleton
  class Properties {
    friend class Caffe;//参考2，Caffe作为Properties的友元类，可以访问Properties的成员
    // Properties作为Caffe的内部类，可以访问caffe的成员，上述语句表明两个类可以相互访问
    Properties();
```
## 参考链接
* 1 [lock_guard()类模板在作用域内自动加锁解锁](https://study.163.com/course/courseLearn.htm?courseId=1006067356#/learn/video?lessonId=1053471354&courseId=1006067356)
* 2 [友元类](https://blog.csdn.net/m0_46657980/article/details/109385050)
* 3 