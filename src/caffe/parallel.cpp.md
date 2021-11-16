# parallel.cpp 代码解析

## 构造函数`P2PManager::P2PManager`
* 多卡训练需要`NCCL`，检查数量是否一致。
  `ncclGetUniqueId`函数生成要在`ncclCommInitRank`函数中使用的`nccl_id_`，
  应该调用一次`ncclGetUniqueId`函数。在调用`ncclCommInitRank`函数之前，应将`nccl_id_`分发给通信器中的所有队列。
```c++
#ifndef USE_NCCL
  LOG(FATAL) << "USE_NCCL must be specified for multi-GPU mode";
#else
  LOG_IF(FATAL, CAFFE_NCCL_VER < 20200) << "NCCL 2.2 or higher is required";
  if (global_rank_ == 0) {
    NCCL_CHECK(ncclGetUniqueId(&nccl_id_));
  }
#endif
#ifdef USE_MPI
  MPI_Bcast(&nccl_id_, sizeof(nccl_id_), MPI_BYTE, 0, MPI_COMM_WORLD);
#endif
```

## `void P2PManager::Run(const vector<int>& gpus)`函数
![](../../docs/tutorial/src/caffe/P2PManagerRun.png)
* 读取求解器参数，切换设备`nccl_id_`后用于初始化多个`P2PSync`类对象。
  每个`P2PSync`类对象`syncs_[i]`的`shared_`均指向`P2PManager`创建出的共享内存。
```c++
shared_ptr<SharedScores<float>> shared_
```
```c++
  SolverParameter param = root_solver_->param();
  this->shared_ = make_shared<SharedScores<float>>(nranks_);
  for (int i = 0; i < gpus.size(); ++i) {
    param.set_device_id(gpus[i]);
    const int universal_rank = (int)gpus.size() * P2PManager::global_rank() + i;
    LOG(INFO) << "Starting sync " << i << " (of total " << gpus.size() << "), {"
              << universal_rank << "." << universal_rank_count << "}";
    syncs_[i].reset(new P2PSync(this, root_solver_, universal_rank, universal_rank_count, param));
    syncs_[i]->shared_ = this->shared_;
  }
```
* 每个`P2PSync`类对象`syncs_[i]`启动线程，`StartInternalThread`触发了`P2PSync::InternalThreadEntry`，
并等待线程完成，最后再通过`Solver::perf_report(std::ostream& os, int device, int align)`输出性能报告
```c++
  LOG(INFO) << "Starting Optimization";

  for (int i = 0; i < syncs_.size(); ++i) {
    syncs_[i]->StartInternalThread(true, static_cast<uint64_t>(param.random_seed() +
                                                               P2PManager::global_rank()));
  }
  for (int i = 0; i < syncs_.size(); ++i) {
    syncs_[i]->WaitAll();
  }

```
![](../../docs/tutorial/src/caffe/P2PSync_InternalThreadEntry.png)

## `P2PSync::InternalThreadEntry()`函数
```c++
void P2PSync::InternalThreadEntry() {
  CHECK_EQ(nranks_, Caffe::solver_count());
  CHECK_EQ(target_device_, Caffe::device());
  const bool root = rank_ % (nranks_ / P2PManager::global_count()) == 0;
  if (root) {
    Caffe::set_root_solver(true);
    solver_.swap(root_solver_);
    solver_->root_add_callback(this);
  }
  solve_barrier();
  if (!root) {
    Caffe::set_root_solver(false);
    solver_.reset(caffe::SolverRegistry::CreateSolver(solver_param_, root_solver_.get(), rank_));
  }
  solver_->set_callback(this);
  ...
```
* 如果`root`为0将线程设置为根求解器，否则根据参数创建求解器。
  `SolverRegistry::CreateSolver`借助`Registry`访问已注册的求解器。
  如果是`root`线程则将自身设置为`root_callbacks_`的调用。
  所有线程均将自身设置为`Solver`的`callback_`调用。
  
```c++
  solve_barrier(); //开启线程同步屏障
  NCCL_CHECK(ncclCommInitRank(&nccl_comm_,
                              nranks_,
                              mgr_->nccl_id(),
                              rank_));
  solve_barrier(); 
```
* 当关联的线程都执行到第一个出现的语句`solve_barrier()`时，才会去执行`ncclCommInitRank()`函数
  当关联的线程都执行完函数`ncclCommInitRank()`后，方可各自执行后面的代码
  
## 参考链接
* 1 [`P2PManager`类分析](https://blog.csdn.net/yiran103/article/details/81220278)
* 2 [std::barrier线程同步屏障](https://en.cppreference.com/w/cpp/thread/barrier)
* 3 [std::barrier线程同步屏障](https://zh.cppreference.com/w/cpp/thread/barrier)
* 4 [std::barrier线程同步屏障样例](https://www.modernescpp.com/index.php/barriers-in-c-20)
* 5 [自己总结的std::barrier教程](https://github.com/Amanda-Barbara/CPlusPlus-Tutorial/blob/master/concurrency/Threading_In_CPlusPlus/6.barrier/README.md)

