### Introduction
move tensorflow lite from tensorflow master(based commit: 2fc6decf7bbedadda0e41aa8f185bd9394a0c311), and it can work on CentOS/Android/macOS, you can find one simple example from tflite_examples/

### Installation
1. clone the code
```
git clone https://github.com/PeterWang1986/sword.git
```

2. build for Linux/macOS
```
mkdir build && cd build && cmake .. && make -j 4
```

3. build for Android
```
source aarch64_api26_stllibcxx_profile.sh && mkdir aarch64 && cd aarch64
cmake -DENABLE_AARCH64_ANDROID_MAKE=ON .. && make -j 4
```
here suppose you have installed toolchain successfully.

### Example
suppose you have build successfully on Linux
```
ln -s ../examples/models models
ln -s ../examples/mobilenet_ssd/testdata testdata
./ssd
```

and you will see
```
load mobile net model successfully.
load interpreter successfully.
using float input.
height: 300, width: 300, channels: 3
finished data feed.
average time: 238.56 ms
idx= 10, score= 0.999854
idx= 13, score= 0.99398
idx= 7, score= 0.991537
idx= 20, score= 0.989233
idx= 5, score= 0.988634
idx= 0, score= 0.888868
idx= 1, score= 0.717236
idx= 3, score= 0.705536
idx= 11, score= 0.509059
```

### Notes
1. the api of BuildFromFile() cannot work on my macOS, but can load the model correctly on CentOS/Android
2. currently NOT support nnapi, so tflite will use CPU version
3. you need to specify the 'blas' library by yourself when build for macOS
4. I also upload two tflite models in examples/models/
