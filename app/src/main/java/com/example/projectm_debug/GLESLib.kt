package com.example.projectm_debug


object GLESLib {
    init {
        System.loadLibrary("projectm_debug")
    }

    external fun init()
    external fun drawFrame()
    external fun surfaceResize(width: Int, height: Int)
}