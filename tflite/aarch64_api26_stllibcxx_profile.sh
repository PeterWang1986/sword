# Add the standalone toolchain to the search path
export PATH=$PATH:/data/build/standalone/arm64_api26_stllibcxx/bin

# Tell configure what tools to use
export target_host=aarch64-linux-android
export AR=$target_host-ar
export AS=$target_host-as
export CC=$target_host-clang
export CXX=$target_host-clang++
export LD=$target_host-ld
export STRIP=$target_host-strip

export CFLAGS="-fPIC -fPIE"
export CXXFLAGS="-fPIC -fPIE -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0"
export LDFLAGS="-pie -fPIE -static-libstdc++"
