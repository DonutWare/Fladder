package nl.jknaapen.fladder.player

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.PorterDuff
import android.graphics.PorterDuffXfermode
import android.view.View
import io.github.peerless2012.ass.AssFrame
import io.github.peerless2012.ass.AssRender
import io.github.peerless2012.ass.media.AssHandler

class FladderAssSubtitleView(
    context: Context,
    private val assHandler: AssHandler,
    private val assFontConfig: AssFontConfig,
    private val assSidecarController: FladderAssSidecarController,
) : View(context) {
    private val paint = Paint().apply {
        xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_OVER)
    }
    private var assFrame: AssFrame? = null
    private var configuredRender: AssRender? = null

    init {
        setWillNotDraw(false)
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        assHandler.renderCallback = { render: AssRender? ->
            render?.let(::configureRender)
        }

        assHandler.videoTimeCallback = { videoTimeUs ->
            val frame = renderFrameDirect(videoTimeUs)
            assFrame = when {
                frame?.images?.isNotEmpty() == true -> frame
                frame?.changed == 0 -> assFrame
                else -> frame
            }
            postInvalidateOnAnimation()
        }
        assSidecarController.setOnActiveTrackChanged {
            assFrame = null
            postInvalidateOnAnimation()
        }
    }

    override fun onDetachedFromWindow() {
        assHandler.renderCallback = null
        assHandler.videoTimeCallback = null
        assSidecarController.setOnActiveTrackChanged(null)
        super.onDetachedFromWindow()
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        canvas.drawColor(0, PorterDuff.Mode.CLEAR)
        val frame = assFrame
        val images = frame?.images
        if (images.isNullOrEmpty()) {
            return
        }

        images.forEach { tex ->
            val bitmap = tex.bitmap ?: return@forEach
            paint.color = toAndroidColor(tex.color)
            canvas.drawBitmap(bitmap, tex.x.toFloat(), tex.y.toFloat(), paint)
        }
    }

    private fun renderFrameDirect(videoTimeUs: Long): AssFrame? {
        val render = assSidecarController.renderForManualMode() ?: assHandler.render
        val track = assHandler.track
        if (render == null) return null

        return try {
            configureRender(render)
            if (width > 0 && height > 0) {
                render.setFrameSize(width, height)
                render.setStorageSize(width, height)
            }
            assSidecarController.renderFrame(render, track, videoTimeUs)
        } catch (error: Throwable) {
            null
        }
    }

    private fun configureRender(render: AssRender) {
        if (configuredRender === render) return
        configuredRender = render
        val configured = AssFontConfigurator.setFonts(
            render,
            assFontConfig.defaultFontPath,
            assFontConfig.defaultFamily,
        )
    }

    private fun toAndroidColor(assColor: Int): Int {
        val red = assColor shr 24 and 0xff
        val green = assColor shr 16 and 0xff
        val blue = assColor shr 8 and 0xff
        val alpha = 255 - (assColor and 0xff)
        return alpha shl 24 or (red shl 16) or (green shl 8) or blue
    }
}
