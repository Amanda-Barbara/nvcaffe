# signal_handler.h 代码解析
* 在命名空间`caffe`下定义了`SignalHandler`信号处理类，`GetActionFunction()`成员函数的返回值是
一个函数指针类型的对象`ActionCallback`，私有成员函数`CheckForSignals()`的返回值类型是`SolverAction::Enum`
```c++
class SignalHandler {
public:
// Contructor. Specify what action to take when a signal is received.
SignalHandler(SolverAction::Enum SIGINT_action,
    SolverAction::Enum SIGHUP_action);
    ~SignalHandler();
    ActionCallback GetActionFunction() const;
    private:
    SolverAction::Enum CheckForSignals() const;
    SolverAction::Enum SIGINT_action_;
    SolverAction::Enum SIGHUP_action_;
};
```
