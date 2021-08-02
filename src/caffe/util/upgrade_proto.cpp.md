# upgrade_proto.cpp代码解析
## ReadSolverParamsFromTextFileOrDie()函数
* 读取类似于`"examples/cifar10/cifar10_quick_solver.prototxt"`网络训练配置文件
```c++
// Read parameters from a file into a SolverParameter proto message.
SolverParameter ReadSolverParamsFromTextFileOrDie(const string& param_file) {
SolverParameter param;
CHECK(ReadProtoFromTextFile(param_file, &param))
<< "Failed to parse SolverParameter file: " << param_file;
UpgradeSolverAsNeeded(param_file, &param);
return param;
}
```

## 参考链接
* 1