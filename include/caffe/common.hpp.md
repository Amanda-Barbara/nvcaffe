# common.hpp代码解析
## 
```c++
static void set_gpus(const std::vector<int>& gpus) {
    std::lock_guard<std::mutex> lock(caffe_mutex_);
    gpus_ = gpus;
    if (gpus_.empty()) {
      gpus_.push_back(root_device_);
    }
  }
```

## 参考链接
* 1 [lock_guard()模板函数在作用域内自动加锁解锁](https://study.163.com/course/courseLearn.htm?courseId=1006067356#/learn/video?lessonId=1053471354&courseId=1006067356)