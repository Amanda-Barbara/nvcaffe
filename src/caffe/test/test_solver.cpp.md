# test_solver.cpp代码解析
## 测试参数说明
```c++
TYPED_TEST(SolverTest, TestInitTrainTestNets) {
  const string& proto =
     "test_interval: 10 "
     "test_iter: 10 "
    }
```
* `test_interval`表示训练多少次进行测试，`test_iter`表示的是要对测试的数据集进行多少次迭代， 
```c++
# test_iter specifies how many forward passes the test should carry out.
# In the case of MNIST, we have test batch size 100 and 100 test iterations,
# covering the full 10,000 testing images.
test_iter: 100
# Carry out testing every 500 training iterations.
test_interval: 500
```
