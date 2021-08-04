# layer_factory.cpp代码解析
## REGISTER_LAYER_CREATOR宏定义
* 宏定义`REGISTER_LAYER_CREATOR`声明了`LayerRegisterer`类型的对象`g_creator_##type`，
由于`g_creator_##type`是一个全局变量，因此程序执行在进入`main`函数之前会被定义
```c++
#define REGISTER_LAYER_CREATOR(type, creator)                                  \
  static LayerRegisterer g_creator_##type(#type, creator);
```
```c++
REGISTER_LAYER_CREATOR(Convolution, GetConvolutionLayer);
```
## 执行REGISTER_LAYER_CREATOR宏定义代码
```c++
REGISTER_LAYER_CREATOR(Convolution, GetConvolutionLayer);
```
* 调用了`LayerRegisterer`构造函数，定义了`LayerRegisterer`类型的静态全局变量`g_creator_Convolution`，
`LayerRegisterer`构造函数调用了`LayerRegistry`类型的静态成员函数`AddCreator()`，`AddCreator()`静态成员函数调用了
`LayerRegistry`类型的静态成员函数`Registry()`，`Registry()`静态成员函数定义了一个`CreatorRegistry`类型的静态局部变量
`g_registry_`并返回赋值给静态成员函数`AddCreator()`中定义的`CreatorRegistry&`类型的`registry`变量，
`CreatorRegistry`类型是使用`typedef`关键字定义的`std::map<string, Creator>`数据结构类型，程序执行到静态变量的定义时只初始化一次，
  
```c++
LayerRegistry::AddCreator(type, creator);
```
