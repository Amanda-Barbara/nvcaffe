# layer_factory.hpp 代码解析
##  LayerRegisterer
* `LayerRegisterer`构造函数的参数`creator`是一个返回值为`shared_ptr<LayerBase>`函数参数为`(const LayerParameter&, Type, Type, size_t)`
的函数指针，`LayerRegisterer`调用了`LayerRegistry`类型的静态成员函数`AddCreator`，在同一个代码文件中，
类的非静态成员函数可以访问其他类的静态成员函数，静态成员函数只能访问静态成员变量。
```c++
class LayerRegisterer {
 public:
  LayerRegisterer(const string& type,
      shared_ptr<LayerBase> (*creator)(const LayerParameter&, Type, Type, size_t)) {
    LayerRegistry::AddCreator(type, creator);
  }
};
```
