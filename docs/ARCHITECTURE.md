# NVCaffe Project Architecture

NVCaffe (NVIDIA Caffe v0.17) is NVIDIA's fork of the BVLC Caffe deep learning framework, optimized for NVIDIA GPUs with features like FP16/mixed-precision training, cuDNN integration, NCCL multi-GPU support, and optimized GPU memory management.

This document provides a comprehensive overview of the project's design architecture.

---

## Table of Contents

- [High-Level Overview](#high-level-overview)
- [Directory Structure](#directory-structure)
- [Core Architecture](#core-architecture)
  - [Blob -- Data Container](#blob----data-container)
  - [Layer -- Computation Unit](#layer----computation-unit)
  - [Net -- Computation Graph (DAG)](#net----computation-graph-dag)
  - [Solver -- Training Orchestrator](#solver----training-orchestrator)
- [Mixed-Precision Type System](#mixed-precision-type-system)
- [Memory Management](#memory-management)
- [Data Pipeline](#data-pipeline)
- [Multi-GPU / Multi-Node Parallelism](#multi-gpu--multi-node-parallelism)
- [Factory Pattern and Registration](#factory-pattern-and-registration)
- [Protocol Buffer Configuration](#protocol-buffer-configuration)
- [Python Interface](#python-interface)
- [Build System](#build-system)
- [Command-Line Tools](#command-line-tools)
- [Layer Taxonomy](#layer-taxonomy)
- [Solver Taxonomy](#solver-taxonomy)

---

## High-Level Overview

The framework follows a classic four-tier architecture:

```
+----------------------------------------------------------+
|                   Command-Line Tools                     |
|          (train, test, time, device_query ...)           |
+----------------------------------------------------------+
|                        Solver                            |
|   (SGD, Adam, AdaGrad, Nesterov, RMSProp, AdaDelta)     |
+----------------------------------------------------------+
|                          Net                             |
|        (DAG of Layers, Forward/Backward passes)          |
+----------------------------------------------------------+
|                        Layer                             |
|  (Conv, Pool, ReLU, Softmax, Loss, Data, LSTM, ...)     |
+----------------------------------------------------------+
|                         Blob                             |
|        (N-dimensional data + diff tensors)               |
+----------------------------------------------------------+
|              Tensor / SyncedMemory / GPUMemory           |
|      (CPU/GPU memory sync, mixed-precision storage)      |
+----------------------------------------------------------+
```

Data flows **bottom-up** during forward pass (input to loss), and gradients flow **top-down** during backward pass (loss to parameters).

---

## Directory Structure

```
nvcaffe/
|-- include/caffe/          # Public C++ headers
|   |-- blob.hpp            # Blob data container
|   |-- layer.hpp           # LayerBase / Layer<Ftype,Btype> base class
|   |-- net.hpp             # Net (DAG of layers)
|   |-- solver.hpp          # Solver base class
|   |-- common.hpp          # Caffe singleton, CUDA handles, utilities
|   |-- tensor.hpp          # Multi-type tensor with lazy conversion
|   |-- syncedmem.hpp       # CPU/GPU synchronized memory
|   |-- type.hpp            # Type enum helpers (FLOAT, FLOAT16, DOUBLE)
|   |-- layer_factory.hpp   # Layer registry and factory
|   |-- solver_factory.hpp  # Solver registry and factory
|   |-- sgd_solvers.hpp     # SGD-family solver implementations
|   |-- parallel.hpp        # Multi-GPU P2PSync / P2PManager
|   |-- data_reader.hpp     # Parallel data reader with caching
|   |-- data_transformer.hpp# Data augmentation transforms
|   |-- filler.hpp          # Weight initialization strategies
|   |-- layers/             # Individual layer headers
|   |-- util/               # Utility headers (math, I/O, GPU, cuDNN, etc.)
|
|-- src/caffe/              # C++ / CUDA implementation
|   |-- blob.cpp            # Blob implementation
|   |-- net.cpp             # Net implementation
|   |-- solver.cpp          # Solver base implementation
|   |-- layer.cpp           # Layer base implementation
|   |-- common.cpp          # Caffe singleton implementation
|   |-- tensor.cpp          # Tensor implementation
|   |-- syncedmem.cpp       # SyncedMemory implementation
|   |-- parallel.cpp        # Multi-GPU parallelism
|   |-- data_reader.cpp     # Data reader threads
|   |-- data_transformer.cpp/cu # Data transforms (CPU + GPU)
|   |-- layers/             # ~140+ layer implementations (.cpp / .cu)
|   |-- solvers/            # Solver implementations (.cpp / .cu)
|   |-- proto/caffe.proto   # Protocol Buffer schema (2300+ lines)
|   |-- util/               # Utility implementations
|   |-- test/               # Unit tests (Google Test)
|
|-- tools/                  # Command-line executables
|   |-- caffe.cpp           # Main entry (train/test/time/device_query)
|   |-- compute_image_mean.cpp
|   |-- convert_imageset.cpp
|   |-- convert_annoset.cpp
|   |-- ...
|
|-- python/caffe/           # Python bindings (pycaffe)
|   |-- _caffe.cpp          # Boost.Python bindings
|   |-- pycaffe.py          # Python Net/Solver wrappers
|   |-- net_spec.py         # Programmatic net definition
|   |-- classifier.py       # Image classification helper
|   |-- detector.py         # Object detection helper
|
|-- models/                 # Pre-defined model architectures
|   |-- resnet50/           # ResNet-50
|   |-- vgg16/              # VGG-16
|   |-- bvlc_googlenet/     # GoogLeNet
|   |-- ...
|
|-- cmake/                  # CMake build modules
|-- data/                   # Dataset download scripts
|-- examples/               # Usage examples
|-- docker/                 # Docker build files
```

---

## Core Architecture

### Blob -- Data Container

**Files:** [`blob.hpp`](include/caffe/blob.hpp), [`blob.cpp`](src/caffe/blob.cpp)

`Blob` is the fundamental data abstraction in Caffe. It stores both the **data** (forward activations or input) and **diff** (backward gradients) as N-dimensional tensors.

```
Blob
 |-- data_tensor_  (shared_ptr<Tensor>)  -- forward data
 |-- diff_tensor_  (shared_ptr<Tensor>)  -- backward gradients
 |-- shape_        (vector<int>)         -- e.g. [N, C, H, W]
 |-- count_        (int)                 -- total element count
```

**Key design features:**

- **Template-less base class**: The base `Blob` class is not templated; it supports mixed-precision by storing `data_type` and `diff_type` independently (e.g., FP16 data with FP32 gradients).
- **`TBlob<Dtype>`**: A templated subclass providing typed access (`cpu_data()`, `gpu_data()`, `mutable_cpu_data()`, etc.).
- **Lazy memory allocation**: Memory is only allocated upon first access via `Reshape()`.

**Relationship to lower layers:**

```
Blob --> Tensor --> SyncedMemory --> GPUMemory (cub::CachingDeviceAllocator)
```

### Layer -- Computation Unit

**Files:** [`layer.hpp`](include/caffe/layer.hpp), [`layer.cpp`](src/caffe/layer.cpp), [`layer_factory.hpp`](include/caffe/layer_factory.hpp)

Layers are the atomic units of computation. Each layer takes a vector of bottom (input) Blobs, processes them, and produces a vector of top (output) Blobs.

**Class hierarchy:**

```
LayerBase                          # Non-templated base (param storage, SetUp protocol)
  |
  +-- Layer<Ftype, Btype>          # Dual-typed: Ftype for forward, Btype for backward
        |
        +-- ConvolutionLayer<F,B>
        +-- PoolingLayer<F,B>
        +-- ReLULayer<F,B>
        +-- SoftmaxLayer<F,B>
        +-- InnerProductLayer<F,B>
        +-- DataLayer<F,B>
        +-- LossLayer<F,B>
        +-- ...
```

**Dual-template design (NVCaffe-specific):**

Unlike vanilla Caffe's single `<Dtype>` template, NVCaffe uses `Layer<Ftype, Btype>` where:
- `Ftype` -- precision for the **forward** pass (e.g., `float16`)
- `Btype` -- precision for the **backward** pass (e.g., `float`)

This enables per-layer mixed-precision training.

**Layer lifecycle:**

1. **Construction**: `LayerRegistry::CreateLayer(param)` via factory
2. **`SetUp(bottom, top)`**: calls `CheckBlobCounts` -> `LayerSetUp` -> `Reshape` -> `SetLossWeights`
3. **`Forward(bottom, top)`**: compute output from input
4. **`Backward(top, propagate_down, bottom)`**: compute gradients

### Net -- Computation Graph (DAG)

**Files:** [`net.hpp`](include/caffe/net.hpp), [`net.cpp`](src/caffe/net.cpp)

The `Net` class connects layers into a directed acyclic graph (DAG) as defined by a `NetParameter` protobuf.

**Key responsibilities:**

- **Layer instantiation and wiring**: Creates all layers, allocates intermediate Blobs, and connects bottom/top Blobs between layers.
- **Forward pass**: Executes layers in topological order, accumulating loss.
- **Backward pass**: Executes layers in reverse topological order, propagating gradients.
- **Parameter management**: Collects learnable parameters from all layers and exposes them as a flat list for the Solver.
- **Memory optimization**: Shares Blob memory across layers where possible to reduce GPU memory usage.

```
Net::Init(NetParameter)
  |-- FilterNet()           # Apply rules/phases to filter layers
  |-- InsertSplits()        # Insert split layers for shared blobs
  |-- For each layer:
  |     |-- LayerRegistry::CreateLayer()
  |     |-- layer->SetUp(bottom_blobs, top_blobs)
  |-- ShareWeights()        # Share params across weight-sharing layers
  |-- ReduceAndUpdate()     # Set up parallel gradient reduction
```

**Forward/Backward flow:**

```
Input Blobs --> [Layer 0] --> [Layer 1] --> ... --> [Layer N] --> Loss
                   ^                                    |
                   |            Backward                |
                   +------------------------------------+
```

### Solver -- Training Orchestrator

**Files:** [`solver.hpp`](include/caffe/solver.hpp), [`solver.cpp`](src/caffe/solver.cpp), [`sgd_solvers.hpp`](include/caffe/sgd_solvers.hpp)

The `Solver` orchestrates the training loop: forward, backward, parameter updates, learning rate scheduling, snapshotting, and testing.

**Class hierarchy:**

```
Solver (base class)
  |
  +-- SGDSolver<Dtype>           # SGD with momentum
  |     |
  |     +-- NesterovSolver       # Nesterov accelerated gradient
  |     +-- AdaGradSolver        # Adaptive gradient
  |     +-- RMSPropSolver        # RMS propagation
  |     +-- AdaDeltaSolver       # AdaDelta
  |     +-- AdamSolver           # Adaptive moment estimation
  |
  +-- SAGSolver<Dtype>           # Stochastic Average Gradient
```

**Training loop (`Solver::Step`):**

```
for iter in range(max_iter):
    1. net_->ClearParamDiffs()
    2. for i in range(iter_size):      # gradient accumulation
         net_->Forward(&loss)
         net_->Backward()
    3. ApplyUpdate()                   # solver-specific param update
    4. if test_interval:
         TestAll()                     # run test nets
    5. if snapshot_interval:
         Snapshot()                    # save model + solver state
```

**Key NVCaffe features in solvers:**
- **LARC (Layer-wise Adaptive Rate Control)**: Adjusts learning rate per-layer based on weight and gradient norms.
- **Fused CUDA kernels**: Weight update + history update in a single GPU kernel for performance.
- **Adaptive global gradient scaler**: For stable FP16 training.

---

## Mixed-Precision Type System

**Files:** [`type.hpp`](include/caffe/type.hpp), [`float16.hpp`](include/caffe/util/float16.hpp), [`tensor.hpp`](include/caffe/tensor.hpp)

NVCaffe's distinguishing feature is its mixed-precision support:

```
enum Type { DOUBLE=0, FLOAT=1, FLOAT16=2, INT=3, UINT=4, BOOL=5 };
```

**How mixed precision works:**

1. **Per-layer precision**: Each layer's forward and backward types can be set independently in the protobuf config (`forward_type`, `backward_type`).
2. **Net-level default**: `NetParameter` has `default_forward_type` / `default_backward_type`.
3. **Tensor lazy conversion**: The `Tensor` class maintains a map of `SyncedMemory` arrays indexed by `Type`. When a different type is requested, data is converted on-the-fly.
4. **Blob dual types**: Each `Blob` has independent `data_type()` and `diff_type()`, allowing FP16 activations with FP32 gradients.

```
Tensor
  |-- synced_arrays_[Type]   # One SyncedMemory per Type (lazy)
  |-- type_                  # Current active type
  |-- count_                 # Element count
```

---

## Memory Management

**Files:** [`syncedmem.hpp`](include/caffe/syncedmem.hpp), [`gpu_memory.hpp`](include/caffe/util/gpu_memory.hpp)

### SyncedMemory

Manages CPU/GPU memory synchronization with a state machine:

```
States: UNINITIALIZED --> HEAD_AT_CPU <--> SYNCED <--> HEAD_AT_GPU
```

- `cpu_data()` / `gpu_data()`: Read-only access; syncs if needed.
- `mutable_cpu_data()` / `mutable_gpu_data()`: Write access; marks the location as head.

### GPUMemory

A static memory manager wrapping `cub::CachingDeviceAllocator` for efficient GPU memory allocation:

- **Caching allocator**: Reuses freed GPU memory blocks to avoid expensive `cudaMalloc` / `cudaFree` calls.
- **Scoped initialization**: `GPUMemory::Scope` initializes the allocator for a set of GPUs.
- **Workspace abstraction**: `GPUMemory::Workspace` provides RAII-managed temporary GPU buffers for convolution workspaces, etc.

---

## Data Pipeline

**Files:** [`data_reader.hpp`](include/caffe/data_reader.hpp), [`data_transformer.hpp`](include/caffe/data_transformer.hpp), [`layers/data_layer.hpp`](include/caffe/layers/data_layer.hpp)

The data pipeline is designed for high-throughput parallel I/O:

```
DB (LMDB/LevelDB)
     |
     v
DataReader (multiple parser threads)
     |  -- CursorManager per thread
     |  -- DataCache (optional in-memory caching)
     |  -- Round-robin distribution to solvers
     v
BlockingQueue<shared_ptr<Datum>>
     |
     v
DataTransformer (CPU + GPU)
     |  -- Crop, Mirror, Scale, Mean subtraction
     |  -- GPU-accelerated transforms (CUDA kernels)
     v
DataLayer --> Blob (top[0]: data, top[1]: label)
```

**Key components:**

- **`DataReader`**: Extends `InternalThread`; reads data from database backends (LMDB, LevelDB) using multiple threads.
- **`CursorManager`**: Manages database cursor position per parser thread, supporting sharding across solvers for multi-GPU.
- **`DataCache`**: Optional in-memory caching of the entire dataset to avoid repeated disk reads.
- **`DataTransformer`**: Applies augmentations (crop, mirror, scale, mean subtraction) with both CPU and GPU (CUDA) implementations.

---

## Multi-GPU / Multi-Node Parallelism

**Files:** [`parallel.hpp`](include/caffe/parallel.hpp), [`parallel.cpp`](src/caffe/parallel.cpp)

### Multi-GPU (Single Node)

Uses **data parallelism** with NCCL for gradient synchronization:

```
P2PManager
  |-- Creates one P2PSync per GPU
  |-- Each P2PSync runs a Solver on its assigned GPU
  |-- After backward pass: NCCL AllReduce on gradients
  |-- Barriers (solve_bar_, solved_bar_) for synchronization

P2PSync extends InternalThread
  |-- Owns a Solver instance
  |-- Shares parameters with root solver
  |-- Uses NCCL communicators for gradient reduction
```

### Multi-Node (Experimental)

Uses MPI + NCCL 2.2:
- `P2PManager::Init()` initializes MPI
- NCCL unique IDs are broadcast across nodes
- Each node runs a `P2PManager` with local GPUs

---

## Factory Pattern and Registration

### LayerRegistry

**File:** [`layer_factory.hpp`](include/caffe/layer_factory.hpp)

Uses a static registry pattern with macro-based auto-registration:

```cpp
// In layer implementation file:
REGISTER_LAYER_CLASS(Convolution);

// Creates layers at runtime:
LayerRegistry::CreateLayer(layer_param);
```

The factory handles NVCaffe's mixed-precision by instantiating the correct `Layer<Ftype, Btype>` combination (9 possible combinations of float/float16/double for forward/backward).

### SolverRegistry

**File:** [`solver_factory.hpp`](include/caffe/solver_factory.hpp)

Same pattern for solvers:

```cpp
REGISTER_SOLVER_CLASS(SGD);

// Creates solvers at runtime:
SolverRegistry::CreateSolver(solver_param);
```

---

## Protocol Buffer Configuration

**File:** [`caffe.proto`](src/caffe/proto/caffe.proto) (~2300 lines)

All model architecture, training parameters, and data configuration are defined via Protocol Buffers:

```
SolverParameter          # Training config (lr, momentum, solver type, ...)
  |-- NetParameter       # Network definition
        |-- LayerParameter[]    # Per-layer configuration
              |-- type           # Layer type string (e.g., "Convolution")
              |-- bottom[]       # Input blob names
              |-- top[]          # Output blob names
              |-- ConvolutionParameter
              |-- PoolingParameter
              |-- ...            # Type-specific params
              |-- forward_type   # FP precision for forward (NVCaffe)
              |-- backward_type  # FP precision for backward (NVCaffe)
```

Key NVCaffe-specific additions to the proto schema:
- `Type` enum: `DOUBLE`, `FLOAT`, `FLOAT16`
- `Packing` enum: `NCHW`, `NHWC`
- `default_forward_type` / `default_backward_type` in `NetParameter`
- `raw_data` / `raw_diff` in `BlobProto` for efficient FP16 serialization

---

## Python Interface

**Files:** [`python/caffe/_caffe.cpp`](python/caffe/_caffe.cpp), [`python/caffe/pycaffe.py`](python/caffe/pycaffe.py)

Python bindings are provided via Boost.Python:

```python
import caffe

# Set GPU mode
caffe.set_mode_gpu()
caffe.set_device(0)

# Load and use a network
net = caffe.Net('deploy.prototxt', 'model.caffemodel', caffe.TEST)
net.forward()

# Train with a solver
solver = caffe.SGDSolver('solver.prototxt')
solver.solve()

# Programmatic net definition
from caffe import layers as L, params as P
n = caffe.NetSpec()
n.data, n.label = L.Data(batch_size=64, ...)
n.conv1 = L.Convolution(n.data, num_output=96, kernel_size=11)
```

**Modules:**
- `_caffe.cpp`: C++ Boost.Python bindings exposing `Net`, `Solver`, `Blob`, `Layer` to Python
- `pycaffe.py`: Pythonic wrappers adding `Net.forward()`, `Net.backward()`, dict-style blob access
- `net_spec.py`: DSL for building networks programmatically
- `classifier.py` / `detector.py`: High-level inference helpers

---

## Build System

**Files:** [`CMakeLists.txt`](CMakeLists.txt), [`Makefile`](Makefile)

Supports both CMake and Makefile builds:

**CMake options:**
| Option | Default | Description |
|--------|---------|-------------|
| `USE_CUDNN` | ON | cuDNN support |
| `USE_NCCL` | NONE | Multi-GPU NCCL support |
| `USE_TRT` | OFF | TensorRT inference plugin |
| `USE_MPI` | OFF | Multi-node training |
| `BUILD_python` | ON | Python bindings |
| `TEST_FP16` | OFF | FP16 unit tests |
| `USE_LEVELDB` | ON | LevelDB database backend |
| `USE_LMDB` | ON | LMDB database backend |

**Dependencies:** CUDA, cuDNN, NCCL, protobuf, glog, gflags, Boost, OpenCV, BLAS (MKL/OpenBLAS/Atlas), HDF5, LevelDB, LMDB, libturbojpeg

---

## Command-Line Tools

**File:** [`tools/caffe.cpp`](tools/caffe.cpp)

The main `caffe` binary uses a command registry pattern (`RegisterBrewFunction`) to expose sub-commands:

| Command | Description |
|---------|-------------|
| `train` | Train a model from a solver definition |
| `test` | Evaluate a trained model on test data |
| `time` | Benchmark layer-by-layer execution time |
| `device_query` | Print GPU device properties |

**Additional tools:**
- [`compute_image_mean`](tools/compute_image_mean.cpp) -- Compute dataset mean image
- [`convert_imageset`](tools/convert_imageset.cpp) -- Convert images to LMDB/LevelDB
- [`convert_annoset`](tools/convert_annoset.cpp) -- Convert annotated datasets (detection)
- [`extract_features`](tools/extract_features.cpp) -- Extract feature vectors from a network

---

## Layer Taxonomy

NVCaffe includes 100+ layer types organized by function:

### Data Layers
| Layer | Description |
|-------|-------------|
| `Data` | Reads from LMDB/LevelDB |
| `AnnotatedData` | Data with bounding box annotations |
| `ImageData` | Reads from image file list |
| `HDF5Data` | Reads from HDF5 files |
| `MemoryData` | In-memory data |
| `DummyData` | Generated dummy data |
| `VideoData` | Video frame input |
| `WindowData` | Window-based image crops |

### Vision Layers
| Layer | Description |
|-------|-------------|
| `Convolution` / `CuDNNConv` | 2D convolution |
| `Deconvolution` / `CuDNNDeconv` | Transposed convolution |
| `Pooling` / `CuDNNPooling` | Max/Average pooling |
| `LRN` / `CuDNNLRN` | Local Response Normalization |
| `BatchNorm` / `CuDNNBatchNorm` | Batch Normalization |
| `Im2col` | Image to column transform |
| `SPP` | Spatial Pyramid Pooling |
| `Crop` | Spatial cropping |

### Activation Layers (Neuron)
| Layer | Description |
|-------|-------------|
| `ReLU` / `CuDNNReLU` | Rectified Linear Unit |
| `Sigmoid` / `CuDNNSigmoid` | Sigmoid activation |
| `TanH` / `CuDNNTanH` | Hyperbolic tangent |
| `ELU` | Exponential Linear Unit |
| `PReLU` | Parametric ReLU |
| `AbsVal` | Absolute value |
| `Power` | Power transform |
| `Exp` / `Log` | Exponential / Logarithm |
| `BNLL` | Binomial Normal Log Likelihood |
| `Threshold` | Threshold activation |
| `Dropout` / `CuDNNDropout` | Dropout regularization |

### Loss Layers
| Layer | Description |
|-------|-------------|
| `SoftmaxWithLoss` | Cross-entropy classification loss |
| `EuclideanLoss` | L2 regression loss |
| `L1Loss` | L1 regression loss |
| `SmoothL1Loss` | Smooth L1 loss (detection) |
| `HingeLoss` | SVM hinge loss |
| `SigmoidCrossEntropyLoss` | Binary cross-entropy |
| `ContrastiveLoss` | Siamese network loss |
| `InfogainLoss` | Information gain loss |
| `MultinomialLogisticLoss` | Multinomial logistic loss |
| `MultiboxLoss` | SSD detection loss |

### Common Layers
| Layer | Description |
|-------|-------------|
| `InnerProduct` | Fully connected layer |
| `Softmax` | Softmax normalization |
| `Concat` | Concatenate along axis |
| `Split` | Copy blob to multiple outputs |
| `Slice` | Slice blob along axis |
| `Reshape` | Reshape blob dimensions |
| `Flatten` | Flatten to 2D |
| `Tile` | Tile/repeat along axis |
| `Eltwise` | Element-wise operations |
| `Scale` | Scale + bias |
| `Bias` | Additive bias |
| `Embed` | Embedding lookup |
| `Reduction` | Reduce (sum/mean/etc.) |
| `Silence` | Suppress unused blobs |
| `Filter` | Conditional filtering |
| `Permute` | Dimension permutation |
| `Normalize` | L2 normalization |
| `Axpy` | ax + y operation |

### Sequence Layers
| Layer | Description |
|-------|-------------|
| `Recurrent` | Base recurrent layer |
| `LSTM` | Long Short-Term Memory |
| `RNN` | Simple RNN |

### Detection Layers
| Layer | Description |
|-------|-------------|
| `DetectionOutput` | SSD detection output |
| `DetectionEvaluate` | Detection evaluation |
| `PriorBox` | SSD prior box generation |
| `DetectNetTransform` | DetectNet data augmentation |

### Inference Layers
| Layer | Description |
|-------|-------------|
| `TRT` | TensorRT inference plugin (experimental) |

---

## Solver Taxonomy

| Solver | Update Rule | Key Feature |
|--------|-------------|-------------|
| `SGD` | `v = mu*v - lr*grad; w += v` | Momentum-based baseline |
| `Nesterov` | Nesterov accelerated gradient | Look-ahead momentum |
| `AdaGrad` | Per-parameter adaptive learning rate | Sparse gradient friendly |
| `RMSProp` | Moving average of squared gradients | Handles non-stationary |
| `AdaDelta` | No manual learning rate needed | Adapts from gradient history |
| `Adam` | Combines momentum + RMSProp | Often best default choice |
| `SAG` | Stochastic Average Gradient | Variance reduction |

All SGD-family solvers inherit from `SGDSolver` and override `ComputeUpdateValue()`. Each solver has both CPU (.cpp) and GPU (.cu) implementations with **fused CUDA kernels** for maximum throughput.

---

## Summary

NVCaffe extends BVLC Caffe with a focus on GPU performance through:

1. **Mixed-precision architecture**: Dual-type `Layer<Ftype,Btype>`, type-polymorphic `Tensor`, and FP16 support throughout the stack
2. **Optimized GPU memory management**: Caching allocator via `cub::CachingDeviceAllocator`, memory sharing across layers
3. **Parallel data pipeline**: Multi-threaded data reading, GPU-accelerated data augmentation, in-memory caching
4. **Multi-GPU training**: NCCL-based gradient synchronization via `P2PSync` / `P2PManager`
5. **Fused CUDA solvers**: Single-kernel parameter updates for reduced kernel launch overhead
6. **cuDNN integration**: Automatic algorithm selection for convolution and other operations
