# layer.cpp代码解析

## 派生类调用基类的构造函数对成员数据进行初始化
* 必须在派生类的初始化列表中调用基类的构造函数
```c++
template<typename Ftype, typename Btype>
Layer<Ftype, Btype>::Layer(const LayerParameter& param) : LayerBase(param) {
// Set phase and copy blobs (if there are any).
phase_ = layer_param_.phase();
debug_ = layer_param_.debug();
...
}
```
## 参考链接
* 1 [派生类调用基类的构造函数对成员数据进行初始化](https://github.com/Amanda-Barbara/CPlusPlus-Tutorial/blob/master/basic_content/%E6%B4%BE%E7%94%9F%E7%B1%BB/%E6%9E%84%E9%80%A0%E5%87%BD%E6%95%B0%E7%9A%84%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F/README.md)
* 2 