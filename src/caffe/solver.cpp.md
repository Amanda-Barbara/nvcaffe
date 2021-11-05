# solver.cpp 代码解析

## `Solver::GetRequestedAction()`函数
```c++
SolverAction::Enum Solver::GetRequestedAction() {
  if (action_request_function_) {
    // If the external request function has been set, call it.
    return action_request_function_();
  }
  return SolverAction::NONE;
}
```
`action_request_function_`函数指针对象是通过如下代码赋值的
```c++
void Solver::SetActionFunction(ActionCallback func) {
  action_request_function_ = func;
}
```