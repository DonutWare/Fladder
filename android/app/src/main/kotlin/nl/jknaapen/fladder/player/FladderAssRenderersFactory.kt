package nl.jknaapen.fladder.player

import android.os.Handler
import androidx.media3.exoplayer.NoSampleRenderer
import androidx.media3.exoplayer.Renderer
import androidx.media3.exoplayer.RenderersFactory
import androidx.media3.exoplayer.audio.AudioRendererEventListener
import androidx.media3.exoplayer.metadata.MetadataOutput
import androidx.media3.exoplayer.text.TextOutput
import androidx.media3.exoplayer.video.VideoRendererEventListener
import io.github.peerless2012.ass.media.AssHandler

class FladderAssRenderersFactory(
    private val assHandler: AssHandler,
    private val renderersFactory: RenderersFactory,
) : RenderersFactory {
    override fun createRenderers(
        eventHandler: Handler,
        videoRendererEventListener: VideoRendererEventListener,
        audioRendererEventListener: AudioRendererEventListener,
        textRendererOutput: TextOutput,
        metadataRendererOutput: MetadataOutput,
    ): Array<Renderer> =
        renderersFactory.createRenderers(
            eventHandler,
            videoRendererEventListener,
            audioRendererEventListener,
            textRendererOutput,
            metadataRendererOutput,
        ) + FladderAssTimeRenderer(assHandler)

    override fun createSecondaryRenderer(
        renderer: Renderer,
        eventHandler: Handler,
        videoRendererEventListener: VideoRendererEventListener,
        audioRendererEventListener: AudioRendererEventListener,
        textRendererOutput: TextOutput,
        metadataRendererOutput: MetadataOutput,
    ): Renderer? =
        renderersFactory.createSecondaryRenderer(
            renderer,
            eventHandler,
            videoRendererEventListener,
            audioRendererEventListener,
            textRendererOutput,
            metadataRendererOutput,
        )
}

private class FladderAssTimeRenderer(
    private val assHandler: AssHandler,
) : NoSampleRenderer() {
    override fun getName(): String = "FladderAssTimeRenderer"

    override fun render(positionUs: Long, elapsedRealtimeUs: Long) {
        val safePositionUs = when {
            positionUs >= SUBTITLE_TIME_OFFSET_US -> positionUs - SUBTITLE_TIME_OFFSET_US
            else -> positionUs
        }.coerceAtLeast(0L)
        assHandler.videoTime = safePositionUs
    }

    private companion object {
        const val SUBTITLE_TIME_OFFSET_US = 1_000_000_000_000L
    }
}
