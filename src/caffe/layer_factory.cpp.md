# layer_factory.cpp代码解析
## REGISTER_LAYER_CREATOR宏定义
* 宏定义`REGISTER_LAYER_CREATOR`定义了`LayerRegisterer`类型的对象`g_creator_##type`，
由于`g_creator_##type`是一个全局变量，因此在
```c++
#define REGISTER_LAYER_CREATOR(type, creator)                                  \
  static LayerRegisterer g_creator_##type(#type, creator);
```
```c++
REGISTER_LAYER_CREATOR(Convolution, GetConvolutionLayer);
```