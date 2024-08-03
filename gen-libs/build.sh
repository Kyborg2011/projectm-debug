#!/bin/bash

if [ -z "$ANDROID_SDK" ]; then
    export ANDROID_SDK="/Users/aroslavivanov/Library/Android/sdk"
fi
if [ -z "$ANDROID_NDK" ]; then
    export ANDROID_NDK="/Users/aroslavivanov/Library/Android/sdk/ndk/26.1.10909125"
fi

CMAKE_MAKE_PROGRAM="${ANDROID_SDK}/cmake/3.22.1/bin/ninja"
BUILD_OUTPUT_PATH="../../../distribution"
MIN_SDK_VERSION=24

mkdir -p projectm/build
cd projectm/build

function build_projectm {
    ABI=$1
    mkdir -p ${ABI}

    cmake -S .. -B${ABI} \
        -G "Ninja" \
        -DCMAKE_SYSTEM_NAME=Android \
        -DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM} \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=${ABI} \
        -DANDROID_PLATFORM=android-${MIN_SDK_VERSION} \
        -DANDROID_TOOLCHAIN=clang \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTING=NO \
        -DENABLE_SDL_UI=OFF \
        -DENABLE_PLAYLIST=OFF \
        -DENABLE_SYSTEM_PROJECTM_EVAL=OFF \
        -DENABLE_GLES=ON

    cmake --build ${ABI} --config "Release" --parallel

    mkdir -p ${BUILD_OUTPUT_PATH}/libprojectM/lib/${ABI}
    cp ${ABI}/src/libprojectM/libprojectM-4.so ${BUILD_OUTPUT_PATH}/libprojectM/lib/${ABI}/
}

build_projectm arm64-v8a
build_projectm armeabi-v7a
build_projectm x86
build_projectm x86_64

mkdir -p ${BUILD_OUTPUT_PATH}/libprojectM/include/
cp -r ../src/api/include/projectM-4 ${BUILD_OUTPUT_PATH}/libprojectM/include/
cp arm64-v8a/src/api/include/projectM-4/version.h ${BUILD_OUTPUT_PATH}/libprojectM/include/projectM-4/
cp arm64-v8a/src/api/include/projectM-4/projectM_export.h ${BUILD_OUTPUT_PATH}/libprojectM/include/projectM-4/
cp arm64-v8a/include/config.h ${BUILD_OUTPUT_PATH}/libprojectM/include/