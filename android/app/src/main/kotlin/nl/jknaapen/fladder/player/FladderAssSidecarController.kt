package nl.jknaapen.fladder.player

import SubtitleTrack
import android.os.Handler
import android.os.Looper
import io.github.peerless2012.ass.AssFrame
import io.github.peerless2012.ass.AssRender
import io.github.peerless2012.ass.AssTrack
import io.github.peerless2012.ass.media.AssHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import java.net.URL

class FladderAssSidecarController(
    private val assHandler: AssHandler,
) {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val mainHandler = Handler(Looper.getMainLooper())
    private val lock = Any()
    private val subtitles = mutableMapOf<Long, SubtitleTrack>()
    private val subtitleBytes = mutableMapOf<Long, ByteArray>()
    private val loading = mutableSetOf<Long>()

    private var manualMode = false
    private var generation = 0L
    private var wantedIndex: Long? = null
    private var activeTrack: AssTrack? = null
    private var manualRender: AssRender? = null
    private var onActiveTrackChanged: (() -> Unit)? = null

    fun setOnActiveTrackChanged(callback: (() -> Unit)?) {
        synchronized(lock) {
            onActiveTrackChanged = callback
        }
    }

    fun configure(tracks: List<SubtitleTrack>, enabled: Boolean, selectedIndex: Long) {
        val assTracks = tracks.filter { it.isAssSubtitleTrack() }
        val currentGeneration = synchronized(lock) {
            generation += 1
            generation
        }
        synchronized(lock) {
            manualMode = enabled
            subtitles.clear()
            subtitleBytes.clear()
            loading.clear()
            activeTrack = null
            manualRender = null
            wantedIndex = selectedIndex.takeIf { enabled && it >= 0 }
            assTracks.forEach { subtitles[it.index] = it }
        }

        if (!enabled) {
            notifyActiveTrackChanged()
            return
        }

        assTracks.forEach { preload(it.index, currentGeneration) }
        select(selectedIndex)
    }

    fun select(index: Long): Boolean {
        val track = synchronized(lock) {
            if (!manualMode) return false
            wantedIndex = index.takeIf { it >= 0 }
            activeTrack = null
            subtitles[index]
        }

        if (index < 0) {
            notifyActiveTrackChanged()
            return true
        }

        if (track == null) {
            notifyActiveTrackChanged()
            return false
        }

        val cachedBytes = synchronized(lock) { subtitleBytes[index] }
        if (cachedBytes != null) {
            activate(index, cachedBytes)
        } else {
            preload(index, synchronized(lock) { generation })
            notifyActiveTrackChanged()
        }
        return true
    }

    fun renderFrame(render: AssRender, fallbackTrack: AssTrack?, videoTimeUs: Long): AssFrame? {
        synchronized(lock) {
            val track = if (manualMode) activeTrack else fallbackTrack
            if (track == null) return null
            render.setTrack(track)
            return render.renderFrame(videoTimeUs / 1000L, true)
        }
    }

    fun renderForManualMode(): AssRender? {
        synchronized(lock) {
            if (!manualMode) return null
            if (manualRender == null) {
                manualRender = assHandler.ass.createRender()
            }
            return manualRender
        }
    }

    private fun preload(index: Long, trackGeneration: Long) {
        val track = synchronized(lock) {
            if (
                trackGeneration != generation ||
                !manualMode ||
                subtitleBytes.containsKey(index) ||
                !loading.add(index)
            ) {
                return
            }
            subtitles[index]
        } ?: return

        scope.launch {
            val bytes = runCatching { download(track.url!!) }
                .getOrNull()
            if (bytes == null) {
                synchronized(lock) { loading.remove(index) }
                return@launch
            }

            val shouldActivate = synchronized(lock) {
                loading.remove(index)
                if (trackGeneration != generation) {
                    return@synchronized false
                }
                subtitleBytes[index] = bytes
                wantedIndex == index
            }

            if (shouldActivate) {
                activate(index, bytes)
            }
        }
    }

    private fun activate(index: Long, bytes: ByteArray) {
        val changed = synchronized(lock) {
            if (!manualMode || wantedIndex != index) return
            activeTrack = assHandler.ass.createTrack().apply {
                readBuffer(bytes, 0, bytes.size)
            }
            true
        }

        if (changed) {
            notifyActiveTrackChanged()
        }
    }

    private fun notifyActiveTrackChanged() {
        val callback = synchronized(lock) { onActiveTrackChanged }
        mainHandler.post { callback?.invoke() }
    }

    private fun download(url: String): ByteArray {
        val connection = URL(url).openConnection()
        connection.connectTimeout = 10_000
        connection.readTimeout = 20_000
        return connection.getInputStream().use { it.readBytes() }
    }
}

fun String?.isAssSubtitleUrl(): Boolean =
    this?.contains(".ass", ignoreCase = true) == true ||
        this?.contains(".ssa", ignoreCase = true) == true

fun SubtitleTrack.isAssSubtitleTrack(): Boolean =
    url.isAssSubtitleUrl() ||
        codec.equals("ass", ignoreCase = true) ||
        codec.equals("ssa", ignoreCase = true)
