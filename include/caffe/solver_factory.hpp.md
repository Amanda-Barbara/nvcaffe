# solver_factory.hpp 代码解析
## 使用`typedef`定义返回值为`Solver*`，参数为`(const SolverParameter&, size_t, Solver*)`的函数指针类型Creator
```c++
typedef Solver* (*Creator)(const SolverParameter&, size_t, Solver*);
```
## 使用`typedef`定义`map`数据结构类型`CreatorRegistry`
```c++
typedef std::map<string, Creator> CreatorRegistry;
```

