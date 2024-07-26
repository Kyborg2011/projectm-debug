# projectm-debug:

## How to build:
```bash
git submodule update --init --recursive
export ANDROID_SDK="/home/user/Android/Sdk"
export ANDROID_NDK="/home/user/Android/Sdk/ndk"
cd gen-libs
./build.sh
./gradlew assembleDebug
```