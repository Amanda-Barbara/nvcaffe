# ubuntu20.04本地安装教程

## 安装依赖库
```bash
sudo apt update
sudo apt-get install libturbojpeg libturbojpeg0-dev
sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so
sudo apt-get install libboost-all-dev
sudo apt-get install libprotobuf-dev protobuf-compiler
# list(APPEND CMAKE_PREFIX_PATH "/usr/include/google/protobuf")
# list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu")


sudo apt-get install -y libhdf5-dev

# lmdb
git clone https://github.com/LMDB/lmdb.git
cd lmdb/libraries/liblmdb
make -j9 && sudo make install

sudo apt-get install libleveldb-dev
sudo apt-get install -y libsnappy-dev
sudo apt install libopencv-dev
sudo apt install libatlas-base-dev
sudo apt-get install libopenblas-dev
sudo apt install libgoogle-glog-dev
sudo apt-get install libgflags-dev

```
* 如果使用cudnn，则需要继续安装以下依赖包：
```c++
sudo dpkg -i libcudnn8_8.2.1.32-1+cuda11.3_amd64.deb
sudo dpkg -i libcudnn8-dev_8.2.1.32-1+cuda11.3_amd64.deb
```
* if use nccl
```text
cmake -DUSE_NCCL=ON
# download `nccl-local-repo-ubuntu2004-2.8.4-cuda11.1_1.0-1_amd64.deb` package
sudo dpkg -i nccl-local-repo-ubuntu2004-2.8.4-cuda11.1_1.0-1_amd64.deb 
sudo apt-key add /var/nccl-local-repo-ubuntu2004-2.8.4-cuda11.1/7fa2af80.pub 
sudo apt update 
sudo apt install libnccl2 libnccl-dev 
```
## cmake process
```
/home/amanda/software/clion-2021.1.1/bin/cmake/linux/bin/cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeBlocks - Unix Makefiles" /home/amanda/project/tutorial/NVCaffe/nvcaffe
-- The C compiler identification is GNU 9.3.0
-- The CXX compiler identification is GNU 9.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
CMake Warning (dev) at cmake/Misc.cmake:32 (set):
  implicitly converting 'BOOLEAN' to 'STRING' type.
Call Stack (most recent call first):
  CMakeLists.txt:32 (include)
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Found Boost: /usr/local/lib/cmake/Boost-1.76.0/BoostConfig.cmake (found suitable version "1.76.0", minimum required is "1.54") found components: system thread filesystem regex 
-- Found Threads: TRUE  
-- Found GFlags: /usr/include  
-- Found gflags  (include: /usr/include, library: /usr/lib/x86_64-linux-gnu/libgflags.so)
-- Found Glog: /usr/include  
-- Found glog    (include: /usr/include, library: /usr/lib/x86_64-linux-gnu/libglog.so)
-- Found Protobuf: /usr/lib/x86_64-linux-gnu/libprotobuf.so;-lpthread (found version "3.6.1") 
-- Found PROTOBUF Compiler: /usr/bin/protoc
-- Found HDF5: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_cpp.so;/usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so;/usr/lib/x86_64-linux-gnu/libpthread.so;/usr/lib/x86_64-linux-gnu/libsz.so;/usr/lib/x86_64-linux-gnu/libz.so;/usr/lib/x86_64-linux-gnu/libdl.so;/usr/lib/x86_64-linux-gnu/libm.so (found version "1.10.4") found components: HL 
-- Found LMDB: /usr/local/include  
-- Found lmdb    (include: /usr/local/include, library: /usr/local/lib/liblmdb.so)
-- Found LevelDB: /usr/include  
-- Found LevelDB (include: /usr/include, library: /usr/lib/x86_64-linux-gnu/libleveldb.so)
-- Found Snappy: /usr/include  
-- Found Snappy  (include: /usr/include, library: /usr/lib/x86_64-linux-gnu/libsnappy.so)
-- Found JPEGTurbo: /usr/include  
-- Found JPEGTurbo  (include: /usr/include, library: /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0)
-- CUDA detected: 11.3
-- Found CUDNN: /usr/local/cuda/lib64/libcudnn.so (found version "8.2.1") 
-- Added CUDA NVCC flags for: sm_75
-- Found OpenCV: /usr (found version "4.2.0") found components: core imgcodecs highgui imgproc videoio 
-- Found OpenCV 3.x: /usr/lib/x86_64-linux-gnu/cmake/opencv4
-- Found OpenBLAS libraries: /usr/lib/x86_64-linux-gnu/libopenblas.so
-- Found OpenBLAS include: /usr/include/x86_64-linux-gnu
-- Found PythonInterp: /usr/bin/python3 (found suitable version "3.8.10", minimum required is "3") 
-- Found Boost Python Library /usr/lib/x86_64-linux-gnu/libboost_python38.so
-- Found PythonLibs: /usr/lib/x86_64-linux-gnu/libpython3.8.so (found suitable version "3.8.10", minimum required is "3") 
-- Found NumPy: /home/amanda/.local/lib/python3.8/site-packages/numpy/core/include (found suitable version "1.20.2", minimum required is "1.7.1") 
-- NumPy ver. 1.20.2 found (include: /home/amanda/.local/lib/python3.8/site-packages/numpy/core/include)
-- Could NOT find Doxygen (missing: DOXYGEN_EXECUTABLE) 
-- Could NOT find NCCL (missing: NCCL_INCLUDE_DIR NCCL_LIBRARY) 
-- Found NVML: /usr/local/cuda/include  
-- Found NVML (include: /usr/local/cuda/include, library: /usr/lib/x86_64-linux-gnu/libnvidia-ml.so)
-- Found Git: /usr/bin/git (found version "2.25.1") 
-- 
-- ******************* Caffe Configuration Summary *******************
-- General:
--   Version           :   0.17.3
--   Git               :   v0.16.1-762-g5248442b-dirty
--   System            :   Linux
--   C++ compiler      :   /usr/bin/c++
--   Release CXX flags :   -O3 -DNDEBUG -fPIC -Wall -std=c++14 -Wno-sign-compare -Wno-uninitialized
--   Debug CXX flags   :   -g -DDEBUG -fPIC -Wall -std=c++14 -Wno-sign-compare -Wno-uninitialized
--   Build type        :   Debug
-- 
--   BUILD_SHARED_LIBS :   ON
--   BUILD_python      :   ON
--   BUILD_matlab      :   OFF
--   BUILD_docs        :   ON
--   USE_LEVELDB       :   ON
--   USE_LMDB          :   ON
--   TEST_FP16         :   OFF
-- 
-- Dependencies:
--   BLAS              :   Yes (Open)
--   Boost             :   Yes (ver. 1.76)
--   glog              :   Yes
--   gflags            :   Yes
--   protobuf          :   Yes (ver. 3.6.1)
--   lmdb              :   Yes (ver. 0.9.70)
--   LevelDB           :   Yes (ver. 1.22)
--   Snappy            :   Yes (ver. 1.1.8)
--   OpenCV            :   Yes (ver. 4.2.0)
--   JPEGTurbo         :   Yes
--   CUDA              :   Yes (ver. 11.3)
-- 
-- NVIDIA CUDA:
--   Target GPU(s)     :   Auto
--   GPU arch(s)       :   sm_75
--   cuDNN             :   Yes (ver. ???)
--   NCCL              :   Not found (not requested)
--   USE_MPI           :   OFF
--   NVML              :   /usr/lib/x86_64-linux-gnu/libnvidia-ml.so 
-- 
-- Python:
--   Interpreter       :   /usr/bin/python3 (ver. 3.8.10)
--   Libraries         :   /usr/lib/x86_64-linux-gnu/libpython3.8.so (ver 3.8.10)
--   NumPy             :   /home/amanda/.local/lib/python3.8/site-packages/numpy/core/include (ver 1.20.2)
-- 
-- Documentaion:
--   Doxygen           :   No
--   config_file       :   
-- 
-- Install:
--   Install path      :   /home/amanda/project/tutorial/NVCaffe/nvcaffe/cmake-build-debug/install
-- 
-- Configuring done
-- Generating done
-- Build files have been written to: /home/amanda/project/tutorial/NVCaffe/nvcaffe/cmake-build-debug

[Previous CMake output restored: 2021/7/30 上午10:29]

```
