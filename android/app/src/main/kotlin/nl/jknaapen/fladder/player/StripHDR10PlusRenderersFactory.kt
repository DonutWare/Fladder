package nl.jknaapen.fladder.player

import android.content.Context
import android.os.Handler
import android.util.Log
import androidx.annotation.OptIn
import androidx.media3.common.MimeTypes
import androidx.media3.common.util.UnstableApi
import androidx.media3.decoder.DecoderInputBuffer
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.exoplayer.Renderer
import androidx.media3.exoplayer.mediacodec.MediaCodecAdapter
import androidx.media3.exoplayer.mediacodec.MediaCodecSelector
import androidx.media3.exoplayer.video.MediaCodecVideoRenderer
import androidx.media3.exoplayer.video.VideoRendererEventListener

private const val TAG = "FladderPlayer"

@OptIn(UnstableApi::class)
class StripHDR10PlusRenderersFactory(context: Context) : DefaultRenderersFactory(context) {
    override fun buildVideoRenderers(
        context: Context,
        extensionRendererMode: Int,
        mediaCodecSelector: MediaCodecSelector,
        enableDecoderFallback: Boolean,
        eventHandler: Handler,
        eventListener: VideoRendererEventListener,
        allowedVideoJoiningTimeMs: Long,
        out: ArrayList<Renderer>
    ) {
        super.buildVideoRenderers(
            context,
            extensionRendererMode,
            mediaCodecSelector,
            enableDecoderFallback,
            eventHandler,
            eventListener,
            allowedVideoJoiningTimeMs,
            out
        )

        val rendererIndex = out.indexOfFirst { it is MediaCodecVideoRenderer }
        if (rendererIndex < 0) {
            Log.w(TAG, "HDR10+ stripping backend enabled, but no MediaCodec video renderer was found")
            return
        }

        out[rendererIndex] = StripHDR10PlusVideoRenderer(
            MediaCodecVideoRenderer.Builder(context)
                .setCodecAdapterFactory(codecAdapterFactory)
                .setMediaCodecSelector(mediaCodecSelector)
                .setAllowedJoiningTimeMs(allowedVideoJoiningTimeMs)
                .setEnableDecoderFallback(enableDecoderFallback)
                .setEventHandler(eventHandler)
                .setEventListener(eventListener)
                .setMaxDroppedFramesToNotify(MAX_DROPPED_VIDEO_FRAME_COUNT_TO_NOTIFY)
        )
    }
}

@OptIn(UnstableApi::class)
private class StripHDR10PlusVideoRenderer(builder: MediaCodecVideoRenderer.Builder) : MediaCodecVideoRenderer(builder) {
    private var stripHdr10PlusSei = false
    private var stripDvRpu = false

    override fun onCodecInitialized(
        name: String,
        configuration: MediaCodecAdapter.Configuration,
        initializedTimestampMs: Long,
        initializationDurationMs: Long
    ) {
        super.onCodecInitialized(name, configuration, initializedTimestampMs, initializationDurationMs)

        val codecs = configuration.format.codecs?.lowercase() ?: ""
        val dvHevcFormat = configuration.format.sampleMimeType == MimeTypes.VIDEO_DOLBY_VISION &&
            (codecs.startsWith("dvhe.") || codecs.startsWith("dvh1."))
        val codecMimeType = configuration.codecInfo.codecMimeType
        val newStripHdr10PlusSei = dvHevcFormat && codecMimeType == MimeTypes.VIDEO_DOLBY_VISION
        val newStripDvRpu = dvHevcFormat &&
            codecMimeType == MimeTypes.VIDEO_H265 &&
            isBlCompatibleDvProfile(codecs)

        if (newStripHdr10PlusSei != stripHdr10PlusSei || newStripDvRpu != stripDvRpu) {
            Log.i(
                TAG,
                "DV bitstream sanitizing: stripHdr10PlusSei=$newStripHdr10PlusSei, " +
                    "stripDvRpu=$newStripDvRpu (codec=$name, codecs=${configuration.format.codecs})"
            )
        }

        stripHdr10PlusSei = newStripHdr10PlusSei
        stripDvRpu = newStripDvRpu
    }

    override fun onQueueInputBuffer(buffer: DecoderInputBuffer) {
        if (stripHdr10PlusSei || stripDvRpu) {
            val data = buffer.data
            if (data != null && data.hasRemaining() && !buffer.isEncrypted) {
                StripHDR10PlusBitstreamSanitizer.sanitize(data, stripHdr10PlusSei, stripDvRpu)
            }
        }
        super.onQueueInputBuffer(buffer)
    }

    private fun isBlCompatibleDvProfile(codecs: String): Boolean =
        codecs.startsWith("dvhe.07") ||
            codecs.startsWith("dvh1.07") ||
            codecs.startsWith("dvhe.08") ||
            codecs.startsWith("dvh1.08")
}
