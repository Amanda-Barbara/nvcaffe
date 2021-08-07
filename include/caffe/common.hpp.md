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
## mutable可变关键字
```c++
mutable std::mutex m_; //参考5
mutable std::condition_variable cv_;//参考4
```
* `mutable`可变关键字可修改被`const`修饰符修饰的变量
* `mutex`互斥量保证同一时间只能有一个线程可以对共享数据进行访问
## 参考链接
* 1 [lock_guard()类模板在作用域内自动加锁解锁](https://study.163.com/course/courseLearn.htm?courseId=1006067356#/learn/video?lessonId=1053471354&courseId=1006067356)
* 2 [友元类](https://blog.csdn.net/m0_46657980/article/details/109385050)
* 3 [mutable可变关键字](https://www.geeksforgeeks.org/c-mutable-keyword/)
* 4 [condition_variable](https://study.163.com/course/courseLearn.htm?courseId=1006067356#/learn/video?lessonId=1053540121&courseId=1006067356)
* 5 [mutex互斥量保证同一时间只能有一个线程可以对共享数据进行访问](https://study.163.com/course/courseLearn.htm?courseId=1006067356#/learn/video?lessonId=1053471354&courseId=1006067356)