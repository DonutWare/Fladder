package nl.jknaapen.fladder.messengers

import PlayableData
import SubtitleSettings
import TVGuideModel
import VideoPlayerApi
import android.os.Handler
import android.os.Looper
import androidx.core.net.toUri
import androidx.core.os.postDelayed
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.map
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.player.FladderAssSidecarController
import nl.jknaapen.fladder.player.isAssSubtitleTrack
import nl.jknaapen.fladder.player.isAssSubtitleUrl
import nl.jknaapen.fladder.utility.clearAudioTrack
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.enableSubtitles
import nl.jknaapen.fladder.utility.getAudioTracks
import nl.jknaapen.fladder.utility.getSubtitleTracks
import nl.jknaapen.fladder.utility.setInternalAudioTrack
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack
import kotlin.time.Duration.Companion.seconds

class VideoPlayerImplementation(
) : VideoPlayerApi {
    private companion object {
        const val MAX_PRELOADED_SIDECAR_SUBTITLES = 25
    }

    var player: ExoPlayer? = null
    private var assSidecarController: FladderAssSidecarController? = null
    val playbackData: MutableStateFlow<PlayableData?> = MutableStateFlow(null)

    var subsInitialized = false

    val isTVMode: Flow<Boolean> = playbackData.asStateFlow().map {
        it?.mediaInfo?.playbackType == PlaybackType.TV
    }

    override fun sendPlayableModel(
        playableData: PlayableData,
        callback: (Result<Boolean>) -> Unit
    ) {
        try {
            println("Send playable data")
            playbackData.value = playableData
            callback(Result.success(true))
            return
        } catch (e: Exception) {
            println("Error loading data $e")
            callback(Result.success(false))
            return
        }
    }

    override fun sendTVGuideModel(guide: TVGuideModel, callback: (Result<Boolean>) -> Unit) {
        try {
            VideoPlayerObject.tvGuide.value = guide
            callback(Result.success(true))
        } catch (e: Exception) {
            println("Error sending TV guide model: $e")
            callback(Result.success(false))
        }
    }

    override fun setSubtitleSettings(settings: SubtitleSettings) {
        try {
            PlayerSettingsObject.subtitleSettings.value = settings
        } catch (e: Exception) {
            println("Error setting subtitle settings: $e")
        }
    }

    override fun open(url: String, play: Boolean, callback: (Result<Boolean>) -> Unit) {
        Handler(Looper.getMainLooper()).postDelayed(delayInMillis = 1.seconds.inWholeMilliseconds) {
            try {
                playbackData.value?.let {
                    VideoPlayerObject.setAudioTrackIndex(it.defaultAudioTrack.toInt(), true)
                    VideoPlayerObject.setSubtitleTrackIndex(it.defaultSubtrack.toInt(), true)
                }

                val isHls = url.contains("streamMode=hls", ignoreCase = true) || url.endsWith(
                    ".m3u8",
                    ignoreCase = true
                )
                val subTitles = playbackData.value?.subtitleTracks ?: listOf()
                val playableData = playbackData.value
                val useManualAssSidecars = playableData.usesManualAssSidecarPlayback()
                val subtitleConfigurations = subTitles
                    .filter { !it.url.isNullOrEmpty() }
                    .let { subtitlesWithUrl ->
                        if (useManualAssSidecars) {
                            return@let subtitlesWithUrl.filterNot { it.isAssSubtitleTrack() }
                        }
                        val assTrackCount = subtitlesWithUrl.count { it.isAssSubtitleTrack() }
                        if (
                            sidecarSubtitlesCanPreload(
                                subtitlesWithUrl.size,
                                assTrackCount,
                                MAX_PRELOADED_SIDECAR_SUBTITLES
                            )
                        ) {
                            subtitlesWithUrl
                        } else {
                            val selectedSubtitleIndex = playbackData.value?.defaultSubtrack ?: -1
                            subtitlesWithUrl.filter { it.index == selectedSubtitleIndex }
                        }
                    }
                assSidecarController?.configure(
                    subTitles,
                    useManualAssSidecars,
                    playableData?.defaultSubtrack ?: -1,
                )
                val mediaItemBuilder = MediaItem.Builder()
                    .setUri(url)
                    .setTag(playbackData.value?.currentItem?.title)
                    .setMediaId(playbackData.value?.currentItem?.id ?: "")
                    .setSubtitleConfigurations(
                        subtitleConfigurations.map { sub ->
                            MediaItem.SubtitleConfiguration.Builder(sub.url!!.toUri())
                                .setId("fladder-sub-${sub.index}")
                                .setMimeType(guessSubtitleMimeType(sub.url))
                                .setLanguage(sub.languageCode)
                                .setLabel(sub.name)
                                .build()
                        }
                    )

                if (isHls) {
                    mediaItemBuilder.setMimeType(MimeTypes.APPLICATION_M3U8)
                }

                val mediaItem = mediaItemBuilder.build()

                player?.stop()
                player?.clearMediaItems()
                player?.setMediaItem(mediaItem)
                player?.prepare()

                val startPosition = playbackData.value?.startPosition ?: 0L
                if (startPosition > 0L) {
                    player?.seekTo(startPosition)
                }
                player?.playWhenReady = play
                callback(Result.success(true))
                subsInitialized = false
                return@postDelayed
            } catch (e: Exception) {
                println("Error playing video $e")
                callback(Result.success(false))
                return@postDelayed
            }
        }
    }


    override fun setLooping(looping: Boolean) {
        player?.repeatMode = if (looping) Player.REPEAT_MODE_ONE else Player.REPEAT_MODE_OFF
    }

    override fun setVolume(volume: Double) {
        player?.volume = volume.toFloat()
    }

    override fun setPlaybackSpeed(speed: Double) {
        player?.setPlaybackSpeed(speed.toFloat())
    }

    override fun play() {
        player?.play()
    }

    override fun pause() {
        player?.pause()
    }

    override fun seekTo(position: Long) {
        player?.seekTo(position)
    }

    override fun stop() {
        player?.stop()
    }

    fun init(exoPlayer: ExoPlayer?) {
        player = exoPlayer
        subsInitialized = false
        //exoPlayer initializes after the playbackData is set for the first load
        playbackData.value?.let { playData ->
            VideoPlayerObject.setAudioTrackIndex(playData.defaultAudioTrack.toInt(), true)
            VideoPlayerObject.setSubtitleTrackIndex(playData.defaultSubtrack.toInt(), true)
            open(playData.url, true, callback = {})
        }
    }

    fun initAssSidecarController(controller: FladderAssSidecarController?) {
        assSidecarController = controller
    }

    fun applySubtitleTrack(trackIndex: Int) {
        val playableData = playbackData.value
        if (playableData.usesManualAssSidecarPlayback()) {
            val selectedSubtitle = playableData?.subtitleTracks
                ?.firstOrNull { it.index.toInt() == trackIndex }
            if (trackIndex < 0 || selectedSubtitle?.isAssSubtitleTrack() == true) {
                assSidecarController?.select(trackIndex.toLong())
                player?.clearSubtitleTrack()
                return
            }
            assSidecarController?.select(-1)
        }
        player?.selectSubtitleTrack(playbackData.value, trackIndex)
    }

    fun applyAudioTrack(trackIndex: Int) {
        player?.selectAudioTrack(playbackData.value, trackIndex)
    }

}

fun guessSubtitleMimeType(fileName: String): String = when {
    fileName.contains(".srt", ignoreCase = true) -> MimeTypes.APPLICATION_SUBRIP
    fileName.contains(".vtt", ignoreCase = true) -> MimeTypes.TEXT_VTT
    fileName.contains(".ass", ignoreCase = true) -> MimeTypes.TEXT_SSA
    fileName.contains(".ssa", ignoreCase = true) -> MimeTypes.TEXT_SSA
    else -> MimeTypes.APPLICATION_SUBRIP
}

private fun sidecarSubtitlesCanPreload(total: Int, assTrackCount: Int, maxPreloaded: Int = 25): Boolean =
    total <= maxPreloaded && assTrackCount <= 1

private fun PlayableData?.usesManualAssSidecarPlayback(maxPreloaded: Int = 25): Boolean {
    if (this?.mediaInfo?.playbackType != PlaybackType.TRANSCODED) return false
    val subtitlesWithUrl = subtitleTracks.filter { !it.url.isNullOrEmpty() }
    return subtitlesWithUrl.size <= maxPreloaded && subtitlesWithUrl.any {
        it.isAssSubtitleTrack()
    }
}

fun ExoPlayer.properlySetSubAndAudioTracks(playableData: PlayableData) {
    if (playableData.mediaInfo.playbackType == PlaybackType.TV) {
        // In TV mode, do not set tracks here as they are handled differently
        return
    }
    try {
        if (playableData.mediaInfo.playbackType == PlaybackType.TRANSCODED) {
            selectSubtitleTrack(playableData, playableData.defaultSubtrack.toInt())
            clearAudioTrack(false)
            return
        }

        val currentSubIndex = playableData.defaultSubtrack
        val indexOfSubtitleTrack =
            playableData.subtitleTracks.indexOfFirst { it.index == currentSubIndex }
        val internalSubTracks = this.getSubtitleTracks()

        val wantedSubIndex = indexOfSubtitleTrack - 1
        if (wantedSubIndex < 0) {
            clearSubtitleTrack()
        } else if (wantedSubIndex < internalSubTracks.size) {
            enableSubtitles()
            setInternalSubtitleTrack(internalSubTracks[wantedSubIndex])
        }

        val currentAudioIndex = playableData.defaultAudioTrack
        val indexOfAudioTrack =
            playableData.audioTracks.indexOfFirst { it.index == currentAudioIndex }
        val internalAudioTracks = this.getAudioTracks()

        val wantedAudioIndex = indexOfAudioTrack - 1
        if (wantedAudioIndex < 0) {
            clearAudioTrack()
        } else if (wantedAudioIndex < internalAudioTracks.size) {
            clearAudioTrack(false)
            setInternalAudioTrack(internalAudioTracks[wantedAudioIndex])
        }
    } catch (e: Exception) {
        e.printStackTrace()
    }
}

fun ExoPlayer.selectSubtitleTrack(playableData: PlayableData?, selectedSubIndex: Int) {
    if (playableData == null) return
    if (selectedSubIndex < 0) {
        clearSubtitleTrack()
        return
    }

    val internalSubTracks = getSubtitleTracks()
    val wantedSubIndex = when (playableData.mediaInfo.playbackType) {
        PlaybackType.TRANSCODED -> {
            val subtitlesWithUrl = playableData.subtitleTracks.filter { !it.url.isNullOrEmpty() }
            val selectableSubtitles = if (playableData.usesManualAssSidecarPlayback()) {
                subtitlesWithUrl.filterNot { it.isAssSubtitleTrack() }
            } else {
                subtitlesWithUrl
            }
            val assTrackCount = subtitlesWithUrl.count { it.isAssSubtitleTrack() }
            if (sidecarSubtitlesCanPreload(subtitlesWithUrl.size, assTrackCount)) {
                selectableSubtitles.indexOfFirst { it.index.toInt() == selectedSubIndex }
            } else {
                0
            }
        }

        else -> playableData.subtitleTracks.indexOfFirst { it.index.toInt() == selectedSubIndex } - 1
    }

    internalSubTracks.elementAtOrNull(wantedSubIndex)?.let { setInternalSubtitleTrack(it) }
}

fun ExoPlayer.selectAudioTrack(playableData: PlayableData?, selectedAudioIndex: Int) {
    if (playableData == null || playableData.mediaInfo.playbackType == PlaybackType.TRANSCODED) return
    val internalAudioTracks = getAudioTracks()
    val wantedAudioIndex = playableData.audioTracks.indexOfFirst { it.index.toInt() == selectedAudioIndex } - 1
    if (wantedAudioIndex < 0) {
        clearAudioTrack()
    } else {
        internalAudioTracks.elementAtOrNull(wantedAudioIndex)?.let {
            clearAudioTrack(false)
            setInternalAudioTrack(it)
        }
    }
}
