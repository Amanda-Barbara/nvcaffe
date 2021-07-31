# cmake build 
```c++
====================[ Build | caffe.bin | Debug ]===============================
/snap/clion/162/bin/cmake/linux/bin/cmake --build /home/devy/tmp/nvcaffe/cmake-build-debug --target caffe.bin -j 13
[  0%] Running C++/Python protocol buffer compiler on /home/devy/tmp/nvcaffe/src/caffe/proto/caffe.proto
Scanning dependencies of target proto
[  0%] Building CXX object src/caffe/CMakeFiles/proto.dir/__/__/include/caffe/proto/caffe.pb.cc.o
[  1%] Linking CXX static library ../../lib/libproto-d.a
[  1%] Built target proto
[  3%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_axpy_layer.cu.o
[  3%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/cuda_compile_1_generated_data_transformer.cu.o
[  3%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_math_functions2.cu.o
[  3%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_accuracy_layer.cu.o
[  3%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_absval_layer.cu.o
[  4%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_batch_reindex_layer.cu.o
[  4%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_base_data_layer.cu.o
[  4%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_batch_norm_layer.cu.o
[  4%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_bias_layer.cu.o
[  4%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_bnll_layer.cu.o
[  6%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_concat_layer.cu.o
[  6%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_contrastive_loss_layer.cu.o
[  6%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_conv_layer.cu.o
[  7%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_crop_layer.cu.o
[  7%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_batch_norm_layer.cu.o
[  7%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_conv_layer.cu.o
[  7%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_deconv_layer.cu.o
[  9%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_dropout_layer.cu.o
[  9%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_lcn_layer.cu.o
[  9%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_lrn_layer.cu.o
[ 10%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_pooling_layer.cu.o
[ 10%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_relu_layer.cu.o
[ 10%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_sigmoid_layer.cu.o
[ 12%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_softmax_layer.cu.o
[ 12%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_cudnn_tanh_layer.cu.o
[ 12%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_deconv_layer.cu.o
[ 14%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_detection_output_layer.cu.o
[ 14%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_detectnet_transform_layer.cu.o
[ 14%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_dropout_layer.cu.o
[ 14%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_eltwise_layer.cu.o
[ 15%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_elu_layer.cu.o
[ 15%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_embed_layer.cu.o
[ 15%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_euclidean_loss_layer.cu.o
[ 17%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_exp_layer.cu.o
[ 17%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_filter_layer.cu.o
[ 17%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_hdf5_data_layer.cu.o
[ 18%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_hdf5_output_layer.cu.o
/usr/include/opencv4/opencv2/stitching/detail/warpers.hpp(213): warning: overloaded virtual function "cv::detail::PlaneWarper::buildMaps" is only partially overridden in class "cv::detail::AffineWarper"

/usr/include/opencv4/opencv2/stitching/detail/warpers.hpp(213): warning: overloaded virtual function "cv::detail::PlaneWarper::warp" is only partially overridden in class "cv::detail::AffineWarper"

/usr/include/opencv4/opencv2/stitching/detail/blenders.hpp(100): warning: overloaded virtual function "cv::detail::Blender::prepare" is only partially overridden in class "cv::detail::FeatherBlender"

/usr/include/opencv4/opencv2/stitching/detail/blenders.hpp(127): warning: overloaded virtual function "cv::detail::Blender::prepare" is only partially overridden in class "cv::detail::MultiBandBlender"

/usr/include/opencv4/opencv2/videostab/motion_stabilizing.hpp(106): warning: function "cv::videostab::IMotionStabilizer::stabilize(int, const std::vector<cv::Mat, std::allocator<cv::Mat>> &, std::pair<int, int>, cv::Mat *)" is hidden by "cv::videostab::GaussianMotionFilter::stabilize" -- virtual function override intended?

[ 18%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_im2col_layer.cu.o
/usr/include/opencv4/opencv2/stitching/detail/warpers.hpp(213): warning: overloaded virtual function "cv::detail::PlaneWarper::buildMaps" is only partially overridden in class "cv::detail::AffineWarper"

/usr/include/opencv4/opencv2/stitching/detail/warpers.hpp(213): warning: overloaded virtual function "cv::detail::PlaneWarper::warp" is only partially overridden in class "cv::detail::AffineWarper"

/usr/include/opencv4/opencv2/stitching/detail/blenders.hpp(100): warning: overloaded virtual function "cv::detail::Blender::prepare" is only partially overridden in class "cv::detail::FeatherBlender"

/usr/include/opencv4/opencv2/stitching/detail/blenders.hpp(127): warning: overloaded virtual function "cv::detail::Blender::prepare" is only partially overridden in class "cv::detail::MultiBandBlender"

/usr/include/opencv4/opencv2/videostab/motion_stabilizing.hpp(106): warning: function "cv::videostab::IMotionStabilizer::stabilize(int, const std::vector<cv::Mat, std::allocator<cv::Mat>> &, std::pair<int, int>, cv::Mat *)" is hidden by "cv::videostab::GaussianMotionFilter::stabilize" -- virtual function override intended?

[ 18%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_inner_product_layer.cu.o
[ 20%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_l1_loss_layer.cu.o
[ 20%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_log_layer.cu.o
[ 20%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_lrn_layer.cu.o
[ 20%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_lstm_unit_layer.cu.o
[ 21%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_mvn_layer.cu.o
[ 21%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_normalize_layer.cu.o
[ 21%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_permute_layer.cu.o
[ 23%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_pooling_layer.cu.o
[ 23%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_power_layer.cu.o
[ 23%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_prelu_layer.cu.o
[ 25%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_recurrent_layer.cu.o
[ 25%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_reduction_layer.cu.o
[ 25%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_relu_layer.cu.o
[ 26%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_scale_layer.cu.o
[ 26%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_sigmoid_cross_entropy_loss_layer.cu.o
[ 26%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_sigmoid_layer.cu.o
[ 26%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_silence_layer.cu.o
[ 28%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_slice_layer.cu.o
[ 28%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_smooth_L1_loss_layer.cu.o
[ 28%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_softmax_layer.cu.o
[ 29%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_softmax_loss_layer.cu.o
[ 29%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_split_layer.cu.o
[ 29%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_tanh_layer.cu.o
[ 31%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_threshold_layer.cu.o
[ 31%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/layers/cuda_compile_1_generated_tile_layer.cu.o
[ 31%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_adadelta_solver.cu.o
[ 32%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_adagrad_solver.cu.o
[ 32%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_adam_solver.cu.o
[ 32%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_nesterov_solver.cu.o
[ 32%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_rmsprop_solver.cu.o
[ 34%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_sag_solver.cu.o
[ 34%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/solvers/cuda_compile_1_generated_sgd_solver.cu.o
[ 34%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_bbox_util.cu.o
[ 35%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_gpu_amax.cu.o
[ 35%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_gpu_asum.cu.o
[ 35%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_gpu_sumsq.cu.o
[ 37%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_im2col.cu.o
[ 37%] Building NVCC (Device) object src/caffe/CMakeFiles/cuda_compile_1.dir/util/cuda_compile_1_generated_math_functions.cu.o
Scanning dependencies of target caffe
[ 37%] Building CXX object src/caffe/CMakeFiles/caffe.dir/blob.cpp.o
[ 39%] Building CXX object src/caffe/CMakeFiles/caffe.dir/data_reader.cpp.o
[ 39%] Building CXX object src/caffe/CMakeFiles/caffe.dir/data_transformer.cpp.o
[ 39%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layer.cpp.o
[ 40%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layer_factory.cpp.o
[ 40%] Building CXX object src/caffe/CMakeFiles/caffe.dir/common.cpp.o
[ 42%] Building CXX object src/caffe/CMakeFiles/caffe.dir/internal_thread.cpp.o
[ 42%] Building CXX object src/caffe/CMakeFiles/caffe.dir/batch_transformer.cpp.o
[ 42%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/accuracy_layer.cpp.o
[ 42%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/absval_layer.cpp.o
[ 43%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/annotated_data_layer.cpp.o
[ 43%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/argmax_layer.cpp.o
[ 43%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/axpy_layer.cpp.o
[ 45%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/base_conv_layer.cpp.o
[ 45%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/base_data_layer.cpp.o
[ 45%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/batch_norm_layer.cpp.o
[ 46%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/batch_reindex_layer.cpp.o
[ 46%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/bias_layer.cpp.o
[ 46%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/bnll_layer.cpp.o
[ 46%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/concat_layer.cpp.o
[ 48%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/contrastive_loss_layer.cpp.o
[ 48%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/conv_layer.cpp.o
[ 48%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/crop_layer.cpp.o
[ 50%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_batch_norm_layer.cpp.o
[ 50%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_conv_layer.cpp.o
[ 50%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_deconv_layer.cpp.o
[ 51%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_dropout_layer.cpp.o
[ 51%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_lrn_layer.cpp.o
[ 51%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_lcn_layer.cpp.o
[ 53%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_pooling_layer.cpp.o
[ 53%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_relu_layer.cpp.o
[ 53%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_sigmoid_layer.cpp.o
[ 53%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_softmax_layer.cpp.o
[ 53%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/data_layer.cpp.o
[ 54%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/cudnn_tanh_layer.cpp.o
[ 54%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/deconv_layer.cpp.o
[ 56%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/detection_evaluate_layer.cpp.o
[ 56%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/detection_output_layer.cpp.o
[ 56%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/detectnet_transform_layer.cpp.o
[ 57%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/dropout_layer.cpp.o
[ 57%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/dummy_data_layer.cpp.o
[ 57%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/eltwise_layer.cpp.o
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp: In instantiation of ‘bool caffe::DataLayer<Ftype, Btype>::load_batch(caffe::Batch*, int, size_t) [with Ftype = float; Btype = half_float::half; size_t = long unsigned int]’:
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:354:1:   required from here
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:327:15: warning: ‘void* memcpy(void*, const void*, size_t)’ writing to an object of type ‘class half_float::half’ with no trivial copy-assignment; use copy-assignment or copy-initialization instead [-Wclass-memaccess]
  327 |         memcpy(dst_cptr + offset, tmp.data(), buf_len * sizeof(Btype));
      |         ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/devy/tmp/nvcaffe/include/caffe/util/float16.hpp:12,
                 from /home/devy/tmp/nvcaffe/include/caffe/common.hpp:32,
                 from /home/devy/tmp/nvcaffe/include/caffe/blob.hpp:11,
                 from /home/devy/tmp/nvcaffe/include/caffe/data_transformer.hpp:8,
                 from /home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:1:
/home/devy/tmp/nvcaffe/3rdparty/half_float/half.hpp:957:8: note: ‘class half_float::half’ declared here
  957 |  class half
      |        ^~~~
[ 59%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/elu_layer.cpp.o
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp: In instantiation of ‘bool caffe::DataLayer<Ftype, Btype>::load_batch(caffe::Batch*, int, size_t) [with Ftype = double; Btype = half_float::half; size_t = long unsigned int]’:
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:354:1:   required from here
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:327:15: warning: ‘void* memcpy(void*, const void*, size_t)’ writing to an object of type ‘class half_float::half’ with no trivial copy-assignment; use copy-assignment or copy-initialization instead [-Wclass-memaccess]
  327 |         memcpy(dst_cptr + offset, tmp.data(), buf_len * sizeof(Btype));
      |         ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/devy/tmp/nvcaffe/include/caffe/util/float16.hpp:12,
                 from /home/devy/tmp/nvcaffe/include/caffe/common.hpp:32,
                 from /home/devy/tmp/nvcaffe/include/caffe/blob.hpp:11,
                 from /home/devy/tmp/nvcaffe/include/caffe/data_transformer.hpp:8,
                 from /home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:1:
/home/devy/tmp/nvcaffe/3rdparty/half_float/half.hpp:957:8: note: ‘class half_float::half’ declared here
  957 |  class half
      |        ^~~~
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp: In instantiation of ‘bool caffe::DataLayer<Ftype, Btype>::load_batch(caffe::Batch*, int, size_t) [with Ftype = half_float::half; Btype = half_float::half; size_t = long unsigned int]’:
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:354:1:   required from here
/home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:327:15: warning: ‘void* memcpy(void*, const void*, size_t)’ writing to an object of type ‘class half_float::half’ with no trivial copy-assignment; use copy-assignment or copy-initialization instead [-Wclass-memaccess]
  327 |         memcpy(dst_cptr + offset, tmp.data(), buf_len * sizeof(Btype));
      |         ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/devy/tmp/nvcaffe/include/caffe/util/float16.hpp:12,
                 from /home/devy/tmp/nvcaffe/include/caffe/common.hpp:32,
                 from /home/devy/tmp/nvcaffe/include/caffe/blob.hpp:11,
                 from /home/devy/tmp/nvcaffe/include/caffe/data_transformer.hpp:8,
                 from /home/devy/tmp/nvcaffe/src/caffe/layers/data_layer.cpp:1:
/home/devy/tmp/nvcaffe/3rdparty/half_float/half.hpp:957:8: note: ‘class half_float::half’ declared here
  957 |  class half
      |        ^~~~
[ 59%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/embed_layer.cpp.o
[ 59%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/euclidean_loss_layer.cpp.o
[ 59%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/exp_layer.cpp.o
[ 60%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/filter_layer.cpp.o
[ 60%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/flatten_layer.cpp.o
[ 60%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/hdf5_data_layer.cpp.o
[ 62%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/hdf5_output_layer.cpp.o
[ 62%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/hinge_loss_layer.cpp.o
[ 62%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/im2col_layer.cpp.o
[ 64%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/image_data_layer.cpp.o
[ 64%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/infogain_loss_layer.cpp.o
[ 64%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/inner_product_layer.cpp.o
[ 65%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/input_layer.cpp.o
[ 65%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/l1_loss_layer.cpp.o
[ 65%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/log_layer.cpp.o
[ 65%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/loss_layer.cpp.o
[ 67%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/lrn_layer.cpp.o
[ 67%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/lstm_layer.cpp.o
[ 67%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/lstm_unit_layer.cpp.o
[ 68%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/memory_data_layer.cpp.o
[ 68%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/multibox_loss_layer.cpp.o
[ 68%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/multinomial_logistic_loss_layer.cpp.o
[ 70%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/mvn_layer.cpp.o
[ 70%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/neuron_layer.cpp.o
[ 70%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/normalize_layer.cpp.o
[ 71%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/permute_layer.cpp.o
[ 71%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/pooling_layer.cpp.o
[ 71%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/power_layer.cpp.o
[ 71%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/prelu_layer.cpp.o
[ 73%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/prior_box_layer.cpp.o
[ 73%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/python_layer.cpp.o
[ 73%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/recurrent_layer.cpp.o
[ 75%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/reduction_layer.cpp.o
[ 75%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/relu_layer.cpp.o
[ 75%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/reshape_layer.cpp.o
[ 76%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/rnn_layer.cpp.o
[ 76%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/scale_layer.cpp.o
[ 76%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/sigmoid_cross_entropy_loss_layer.cpp.o
[ 78%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/sigmoid_layer.cpp.o
[ 78%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/silence_layer.cpp.o
[ 78%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/slice_layer.cpp.o
[ 79%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/smooth_L1_loss_layer.cpp.o
[ 79%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/softmax_layer.cpp.o
[ 79%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/softmax_loss_layer.cpp.o
[ 79%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/split_layer.cpp.o
[ 81%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/spp_layer.cpp.o
[ 81%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/tanh_layer.cpp.o
[ 81%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/threshold_layer.cpp.o
[ 82%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/tile_layer.cpp.o
[ 82%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/trt_layer.cpp.o
[ 82%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/video_data_layer.cpp.o
[ 84%] Building CXX object src/caffe/CMakeFiles/caffe.dir/layers/window_data_layer.cpp.o
[ 84%] Building CXX object src/caffe/CMakeFiles/caffe.dir/net.cpp.o
[ 84%] Building CXX object src/caffe/CMakeFiles/caffe.dir/parallel.cpp.o
[ 85%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solver.cpp.o
[ 85%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/adadelta_solver.cpp.o
[ 85%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/adagrad_solver.cpp.o
[ 85%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/adam_solver.cpp.o
[ 87%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/nesterov_solver.cpp.o
[ 87%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/rmsprop_solver.cpp.o
[ 87%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/sag_solver.cpp.o
[ 89%] Building CXX object src/caffe/CMakeFiles/caffe.dir/solvers/sgd_solver.cpp.o
[ 89%] Building CXX object src/caffe/CMakeFiles/caffe.dir/syncedmem.cpp.o
[ 89%] Building CXX object src/caffe/CMakeFiles/caffe.dir/tensor.cpp.o
[ 90%] Building CXX object src/caffe/CMakeFiles/caffe.dir/type.cpp.o
[ 90%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/bbox_util.cpp.o
[ 90%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/benchmark.cpp.o
[ 92%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/blocking_queue.cpp.o
[ 92%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/cudnn.cpp.o
[ 92%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/db.cpp.o
[ 92%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/db_leveldb.cpp.o
[ 93%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/db_lmdb.cpp.o
[ 93%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/detectnet_coverage_rectangular.cpp.o
[ 93%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/gpu_memory.cpp.o
[ 95%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/hdf5.cpp.o
[ 95%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/im2col.cpp.o
[ 95%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/im_transforms.cpp.o
[ 96%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/insert_splits.cpp.o
[ 96%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/io.cpp.o
[ 98%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/math_functions.cpp.o
[ 98%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/sampler.cpp.o
[ 98%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/signal_handler.cpp.o
[ 98%] Building CXX object src/caffe/CMakeFiles/caffe.dir/util/upgrade_proto.cpp.o
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp: In instantiation of ‘void caffe::caffe_set(int, Dtype, Dtype*) [with Dtype = half_float::half]’:
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:114:78:   required from here
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:103:11: warning: ‘void* memset(void*, int, size_t)’ clearing an object of type ‘class half_float::half’ with no trivial copy-assignment; use assignment or value-initialization instead [-Wclass-memaccess]
  103 |     memset(Y, 0, sizeof(Dtype) * N);  // NOLINT(caffe/alt_fn)
      |     ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/devy/tmp/nvcaffe/include/caffe/util/float16.hpp:12,
                 from /home/devy/tmp/nvcaffe/include/caffe/common.hpp:32,
                 from /home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:4:
/home/devy/tmp/nvcaffe/3rdparty/half_float/half.hpp:957:8: note: ‘class half_float::half’ declared here
  957 |  class half
      |        ^~~~
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp: In instantiation of ‘void caffe::caffe_copy(int, const Dtype*, Dtype*) [with Dtype = half_float::half]’:
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:152:76:   required from here
/home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:143:13: warning: ‘void* memcpy(void*, const void*, size_t)’ writing to an object of type ‘class half_float::half’ with no trivial copy-assignment; use copy-assignment or copy-initialization instead [-Wclass-memaccess]
  143 |       memcpy(Y, X, sizeof(Dtype) * N);  // NOLINT(caffe/alt_fn)
      |       ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/devy/tmp/nvcaffe/include/caffe/util/float16.hpp:12,
                 from /home/devy/tmp/nvcaffe/include/caffe/common.hpp:32,
                 from /home/devy/tmp/nvcaffe/src/caffe/util/math_functions.cpp:4:
/home/devy/tmp/nvcaffe/3rdparty/half_float/half.hpp:957:8: note: ‘class half_float::half’ declared here
  957 |  class half
      |        ^~~~
[ 98%] Linking CXX shared library ../../lib/libcaffe-nv-d.so
[ 98%] Built target caffe
Scanning dependencies of target caffe.bin
[100%] Building CXX object tools/CMakeFiles/caffe.bin.dir/caffe.cpp.o
[100%] Linking CXX executable caffe-d
[100%] Built target caffe.bin

Build finished

```