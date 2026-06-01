package nl.jknaapen.fladder.player

import android.util.Log
import io.github.peerless2012.ass.AssRender

object AssFontConfigurator {
    private const val TAG = "AssFontConfigurator"

    private val nativeRenderField by lazy {
        AssRender::class.java.getDeclaredField("nativeRender").apply {
            isAccessible = true
        }
    }

    init {
        runCatching { System.loadLibrary("fladder_ass") }
            .onFailure { error ->
                Log.w(TAG, "Unable to load ASS font native helper", error)
            }
    }

    fun setFonts(
        render: AssRender,
        defaultFontPath: String? = "/system/fonts/NotoSansCJK-Regular.ttc",
        defaultFamily: String = "Noto Sans CJK JP",
    ): Boolean {
        val nativeRender = runCatching { nativeRenderField.getLong(render) }
            .onFailure { error ->
                Log.w(TAG, "Unable to access native ASS renderer", error)
            }
            .getOrDefault(0L)
        if (nativeRender == 0L) return false

        return runCatching { nativeSetFonts(nativeRender, defaultFontPath, defaultFamily) }
            .onFailure { error ->
                Log.w(TAG, "Unable to configure ASS fonts", error)
            }
            .getOrDefault(false)
    }

    private external fun nativeSetFonts(
        nativeRender: Long,
        defaultFontPath: String?,
        defaultFamily: String,
    ): Boolean
}
