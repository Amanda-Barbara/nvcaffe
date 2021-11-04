# signal_handler.cpp 代码解析

## 信号的基础知识
```shell
./cmake-build-debug/tools/caffe-d train --solver=examples/cifar10/cifar10_quick_solver.prototxt
```
* 使用`ctrl+c`直接终止程序执行
* 使用`ctrl+z`将`caffe-d`进程程序挂起(进程程序暂停执行)，`fg`命令可以将进程`caffe-d`继续在前台执行，
  `bg`命令可以将进程`caffe-d`在后台继续执行，使用`jobs`命令可以查看被挂起的进程，`kill %id`将终止被挂起的进程id
  
## boost::bind使用
```c++
// Return the function that the solver can use to find out if a snapshot or
// early exit is being requested.
ActionCallback SignalHandler::GetActionFunction() const {
return boost::bind(&SignalHandler::CheckForSignals, this);
}
```

## 参考链接
* 1 [boost::bind使用教程](https://www.boost.org/doc/libs/1_66_0/libs/bind/doc/html/bind.html)
* 2 [SignalHandler代码解析](https://alanse7en.github.io/caffedai-ma-jie-xi-4/)
* 3 [信号的概念](https://www.freecplus.net/eec5c39aa63b45ad946f1cc08134d9f9.html)
