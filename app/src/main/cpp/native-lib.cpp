#include <jni.h>
#include <android/log.h>
#include <string>
#include "config.h"
#include "projectM-4/projectM.h"

#define LOG_TAG "projectm_debug"
#define LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)

static projectm *projectm_handle_ = nullptr;

extern "C" JNIEXPORT void JNICALL
Java_com_example_projectm_1debug_GLESLib_init(JNIEnv* env, jobject/* this */) {
    projectm_handle_ = projectm_create();
    if (projectm_handle_ == nullptr) {
        LOGD("projectM init failed!");
    } else {
        LOGD("projectM init success!");
    }
}

extern "C" JNIEXPORT void JNICALL
Java_com_example_projectm_1debug_GLESLib_surfaceResize(JNIEnv* env, jobject/* this */, jint width, jint height) {
    if (projectm_handle_ != nullptr) {
        projectm_set_window_size(projectm_handle_, (size_t) width, (size_t) height);
        LOGD("projectm window size setted: %d-%d", width, height);
    }
}

extern "C" JNIEXPORT void JNICALL
Java_com_example_projectm_1debug_GLESLib_drawFrame(JNIEnv* env, jobject/* this */) {
    if (projectm_handle_ != nullptr) {
        projectm_opengl_render_frame(projectm_handle_);
    }
}