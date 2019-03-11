cmake_minimum_required(VERSION 2.8.5)

# this CMakeLists.txt only for tf lite
project(tflite)

option(ENABLE_AARCH64_ANDROID_MAKE "build for android" OFF)

# for cross compile on android
if(${ENABLE_AARCH64_ANDROID_MAKE})
  include("aarch64-android.toolchain.cmake")
endif()

include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/eigen)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/absl)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/gemmlowp)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/neon_2_sse)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/farmhash/src)
include_directories(${PROJECT_SOURCE_DIR}/tensorflow/lite/tools/make/downloads/flatbuffers/include)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIE -fPIC")
if(CMAKE_SYSTEM_PROCESSOR STREQUAL aarch64)
  message(STATUS "cross compile for android.")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG -fPIE -fPIC -std=c++11 -DGEMMLOWP_ALLOW_SLOW_SCALAR_FALLBACK")
  set(LIBS
    stdc++
    m
    z
    dl
    log 
  )
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG -fPIE -fPIC -std=c++11 -DGEMMLOWP_ALLOW_SLOW_SCALAR_FALLBACK -pthread")
  set(LIBS
    stdc++
    pthread
    m
    z
    dl
  )
endif()


set(TF_LITE_DIR ${PROJECT_SOURCE_DIR}/tensorflow/lite)
set(CORE_CC_LTTE_SRCS
  ${TF_LITE_DIR}/allocation.cc
  ${TF_LITE_DIR}/arena_planner.cc
  ${TF_LITE_DIR}/graph_info.cc
  ${TF_LITE_DIR}/interpreter.cc
  ${TF_LITE_DIR}/mmap_allocation.cc
  ${TF_LITE_DIR}/model.cc
  ${TF_LITE_DIR}/mutable_op_resolver.cc
  ${TF_LITE_DIR}/nnapi_delegate.cc
  ${TF_LITE_DIR}/optional_debug_tools.cc
  ${TF_LITE_DIR}/simple_memory_arena.cc
  ${TF_LITE_DIR}/stderr_reporter.cc
  ${TF_LITE_DIR}/string_util.cc
  ${TF_LITE_DIR}/util.cc
  ${TF_LITE_DIR}/c/c_api_internal.c
  ${TF_LITE_DIR}/core/subgraph.cc
  ${TF_LITE_DIR}/core/api/error_reporter.cc
  ${TF_LITE_DIR}/core/api/flatbuffer_conversions.cc
  ${TF_LITE_DIR}/core/api/op_resolver.cc
)

set(CORE_CC_LITE_KERNEL_SRCS
  ${TF_LITE_DIR}/kernels/activations.cc
  ${TF_LITE_DIR}/kernels/add.cc
  ${TF_LITE_DIR}/kernels/arg_min_max.cc
  ${TF_LITE_DIR}/kernels/audio_spectrogram.cc
  ${TF_LITE_DIR}/kernels/basic_rnn.cc
  ${TF_LITE_DIR}/kernels/batch_to_space_nd.cc
  ${TF_LITE_DIR}/kernels/bidirectional_sequence_lstm.cc
  ${TF_LITE_DIR}/kernels/bidirectional_sequence_rnn.cc
  ${TF_LITE_DIR}/kernels/cast.cc
  ${TF_LITE_DIR}/kernels/comparisons.cc
  ${TF_LITE_DIR}/kernels/concatenation.cc
  ${TF_LITE_DIR}/kernels/conv.cc
  ${TF_LITE_DIR}/kernels/depthwise_conv.cc
  ${TF_LITE_DIR}/kernels/dequantize.cc
  ${TF_LITE_DIR}/kernels/detection_postprocess.cc
  ${TF_LITE_DIR}/kernels/div.cc
  ${TF_LITE_DIR}/kernels/eigen_support.cc
  ${TF_LITE_DIR}/kernels/elementwise.cc
  ${TF_LITE_DIR}/kernels/embedding_lookup.cc
  ${TF_LITE_DIR}/kernels/embedding_lookup_sparse.cc
  ${TF_LITE_DIR}/kernels/exp.cc
  ${TF_LITE_DIR}/kernels/expand_dims.cc
  ${TF_LITE_DIR}/kernels/fake_quant.cc
  ${TF_LITE_DIR}/kernels/fill.cc
  ${TF_LITE_DIR}/kernels/floor.cc
  ${TF_LITE_DIR}/kernels/floor_div.cc
  ${TF_LITE_DIR}/kernels/floor_mod.cc
  ${TF_LITE_DIR}/kernels/fully_connected.cc
  ${TF_LITE_DIR}/kernels/gather.cc
  ${TF_LITE_DIR}/kernels/gemm_support.cc
  ${TF_LITE_DIR}/kernels/hashtable_lookup.cc
  ${TF_LITE_DIR}/kernels/kernel_util.cc
  ${TF_LITE_DIR}/kernels/l2norm.cc
  ${TF_LITE_DIR}/kernels/layer_norm_lstm.cc
  ${TF_LITE_DIR}/kernels/local_response_norm.cc
  ${TF_LITE_DIR}/kernels/logical.cc
  ${TF_LITE_DIR}/kernels/lsh_projection.cc
  ${TF_LITE_DIR}/kernels/lstm.cc
  ${TF_LITE_DIR}/kernels/lstm_eval.cc
  ${TF_LITE_DIR}/kernels/maximum_minimum.cc
  ${TF_LITE_DIR}/kernels/mfcc.cc
  ${TF_LITE_DIR}/kernels/mirror_pad.cc
  ${TF_LITE_DIR}/kernels/mul.cc
  ${TF_LITE_DIR}/kernels/neg.cc
  ${TF_LITE_DIR}/kernels/one_hot.cc
  ${TF_LITE_DIR}/kernels/pack.cc
  ${TF_LITE_DIR}/kernels/pad.cc
  ${TF_LITE_DIR}/kernels/pooling.cc
  ${TF_LITE_DIR}/kernels/pow.cc
  ${TF_LITE_DIR}/kernels/range.cc
  ${TF_LITE_DIR}/kernels/reduce.cc
  ${TF_LITE_DIR}/kernels/register.cc
  ${TF_LITE_DIR}/kernels/register_ref.cc
  ${TF_LITE_DIR}/kernels/relu1.cc
  ${TF_LITE_DIR}/kernels/reshape.cc
  ${TF_LITE_DIR}/kernels/resize_bilinear.cc
  ${TF_LITE_DIR}/kernels/resize_nearest_neighbor.cc
  ${TF_LITE_DIR}/kernels/select.cc
  ${TF_LITE_DIR}/kernels/shape.cc
  ${TF_LITE_DIR}/kernels/skip_gram.cc
  ${TF_LITE_DIR}/kernels/slice.cc
  ${TF_LITE_DIR}/kernels/space_to_batch_nd.cc
  ${TF_LITE_DIR}/kernels/space_to_depth.cc
  ${TF_LITE_DIR}/kernels/sparse_output_fully_connected.cc
  ${TF_LITE_DIR}/kernels/sparse_to_dense.cc
  ${TF_LITE_DIR}/kernels/split.cc
  ${TF_LITE_DIR}/kernels/split_v.cc
  ${TF_LITE_DIR}/kernels/squared_difference.cc
  ${TF_LITE_DIR}/kernels/squeeze.cc
  ${TF_LITE_DIR}/kernels/strided_slice.cc
  ${TF_LITE_DIR}/kernels/sub.cc
  ${TF_LITE_DIR}/kernels/svdf.cc
  ${TF_LITE_DIR}/kernels/tile.cc
  ${TF_LITE_DIR}/kernels/topk_v2.cc
  ${TF_LITE_DIR}/kernels/transpose.cc
  ${TF_LITE_DIR}/kernels/transpose_conv.cc
  ${TF_LITE_DIR}/kernels/unidirectional_sequence_lstm.cc
  ${TF_LITE_DIR}/kernels/unidirectional_sequence_rnn.cc
  ${TF_LITE_DIR}/kernels/unpack.cc
  ${TF_LITE_DIR}/kernels/zeros_like.cc
  ${TF_LITE_DIR}/kernels/internal/kernel_utils.cc
  ${TF_LITE_DIR}/kernels/internal/mfcc.cc
  ${TF_LITE_DIR}/kernels/internal/mfcc_dct.cc
  ${TF_LITE_DIR}/kernels/internal/mfcc_mel_filterbank.cc
  ${TF_LITE_DIR}/kernels/internal/quantization_util.cc
  ${TF_LITE_DIR}/kernels/internal/spectrogram.cc
  ${TF_LITE_DIR}/kernels/internal/tensor_utils.cc
  ${TF_LITE_DIR}/kernels/internal/optimized/neon_tensor_utils.cc
  ${TF_LITE_DIR}/kernels/internal/reference/portable_tensor_utils.cc
)

set(PROFILER_SRCS ${TF_LITE_DIR}/profiling/time.cc)
set(CC_FARMHASH_SRCS ${TF_LITE_DIR}/tools/make/downloads/farmhash/src/farmhash.cc)
set(CC_FFT2D_SRCS ${TF_LITE_DIR}/tools/make/downloads/fft2d/fftsg.c)

set(TF_LITE_CC_SRCS
  ${CORE_CC_LTTE_SRCS}
  ${CORE_CC_LITE_KERNEL_SRCS}
  ${PROFILER_SRCS}
  ${CC_FARMHASH_SRCS}
  ${CC_FFT2D_SRCS}
)

add_library(tensorflow-lite STATIC ${TF_LITE_CC_SRCS})
target_link_libraries(tensorflow-lite
  ${LIBS}
)



