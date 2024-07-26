package com.example.projectm_debug

import android.content.Context
import android.opengl.GLSurfaceView
import android.util.AttributeSet
import android.util.Log
import android.view.MotionEvent
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10
import kotlin.math.sqrt


class GLESView(context: Context, attrs: AttributeSet?) : GLSurfaceView(context, attrs) {
    init {
        setEGLContextClientVersion(3)
        val m_Renderer = MyRenderer()
        setRenderer(m_Renderer)
    }

    private class MyRenderer() : Renderer {
        override fun onDrawFrame(gl: GL10) {
            GLESLib.drawFrame()
        }

        override fun onSurfaceChanged(gl: GL10, width: Int, height: Int) {
            GLESLib.surfaceResize(width, height)
        }

        override fun onSurfaceCreated(gl: GL10, config: EGLConfig) {
            GLESLib.init()
        }
    }
}