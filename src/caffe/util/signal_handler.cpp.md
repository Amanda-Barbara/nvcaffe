# signal_handler.cpp 代码解析
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
* 2 []()
* 3
