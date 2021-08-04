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
## `REGISTER_LAYER_CLASS(type)`宏定义
```c++
#define REGISTER_LAYER_CLASS(type)                                             \
  shared_ptr<LayerBase> Creator_##type##Layer(const LayerParameter& param,     \
      Type ftype, Type btype, size_t)                                          \
  {                                                                            \
    return CreateLayerBase<type##Layer>(param, ftype, btype);                  \
  }                                                                            \
  REGISTER_LAYER_CREATOR(type, Creator_##type##Layer)
```
* `REGISTER_LAYER_CLASS(type)`宏定义中定义了一个名为`Creator_##type##Layer`函数，函数体是执行
  `CreateLayerBase<type##Layer>(param, ftype, btype);`并返回其执行结果，
  
## 函数模板`CreateLayerBase()`
```c++
template<template <typename Ftype, typename Btype> class LType>
inline shared_ptr<LayerBase> CreateLayerBase(const LayerParameter& param,
    Type ftype, Type btype) {
  bool failed = false;
  shared_ptr<LayerBase> ptr;
  if (ftype == FLOAT) {
    if (btype == FLOAT) {
      ptr.reset(new LType<float, float>(param, solver_rank));
    } else if (btype == FLOAT16) {
      ptr.reset(new LType<float, float16>(param, solver_rank));
    } else if (btype == DOUBLE) {
      ptr.reset(new LType<float, double>(param, solver_rank));
    } else {
      failed = true;
    }
  }
  ...
  }
```
* `template <typename Ftype, typename Btype> class LType`作为模板的模板参数`LType`，
  通过向模板函数`CreateLayerBase()`传递`LType`类型的模板参数，`CreateLayerBase()`的调用语句如下：
![](docs/CreateLayerBase.png)
```c++
template <typename Ftype, typename Btype>
class ConvolutionLayer : public BaseConvolutionLayer<Ftype, Btype> {
public:
```
* `CreateLayerBase<ConvolutionLayer>(param, ftype, btype)`接受的类模板参数是LType类型，
```c++
template <typename Ftype, typename Btype>
class BaseConvolutionLayer : public Layer<Ftype, Btype> {
 public:
```
* `BaseConvolutionLayer`类模板继承类模板`Layer<Ftype, Btype>`，
```c++
template<typename Ftype, typename Btype>
class Layer : public LayerBase {
 public:
```
* 类模板`Layer<Ftype, Btype>`则继承`LayerBase`类，
```c++
class LayerBase {
 public:
```
* 进一步解释了为什么在函数模板`CreateLayerBase()`中可以使用`ptr.reset(new LType<float, float>(param, solver_rank));`
这样的语句进行执行，虽然`LayerBase`不是模板类，但继承`LayerBase`的类都是接收`Layer<Ftype, Btype>`模板参数的类模板
  
## 参考链接
* 1 [模板的模板参数](https://www.jianshu.com/p/c94184e295d7)
* 2 []()