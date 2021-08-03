# layer_factory.hpp 代码解析
##  `LayerRegisterer`构造函数的参数`creator`是一个返回值为`shared_ptr<LayerBase>`函数参数为`(const LayerParameter&, Type, Type, size_t)`
的函数指针
```c++
class LayerRegisterer {
 public:
  LayerRegisterer(const string& type,
      shared_ptr<LayerBase> (*creator)(const LayerParameter&, Type, Type, size_t)) {
    LayerRegistry::AddCreator(type, creator);
  }
};
```
