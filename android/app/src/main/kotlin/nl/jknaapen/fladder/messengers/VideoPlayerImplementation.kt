package nl.jknaapen.fladder.messengers

import PlayableData
import VideoPlayerApi
import android.os.Handler
import android.os.Looper
import androidx.core.net.toUri
import androidx.core.os.postDelayed
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import kotlinx.coroutines.flow.MutableStateFlow
import nl.jknaapen.fladder.objects.VideoPlayerObject
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
    var player: ExoPlayer? = null
    val playbackData: MutableStateFlow<PlayableData?> = MutableStateFlow(null)

    override fun sendPlayableModel(playableData: PlayableData): Boolean {
        try {
            println("Send playable data")
            playbackData.value = playableData
            return true
        } catch (e: Exception) {
            println("Error loading data $e")
            return false
        }
    }

    override fun open(url: String, play: Boolean) {
        Handler(Looper.getMainLooper()).postDelayed(delayInMillis = 1.seconds.inWholeMilliseconds) {
            try {
                playbackData.value?.let {
                    VideoPlayerObject.setAudioTrackIndex(it.defaultAudioTrack.toInt(), true)
                    VideoPlayerObject.setSubtitleTrackIndex(it.defaultSubtrack.toInt(), true)
                }

                val subTitles = playbackData.value?.subtitleTracks ?: listOf()
                val mediaItem = MediaItem.Builder()
                    .setUri(url)
                    .setTag(playbackData.value?.currentItem?.title)
                    .setMediaId(playbackData.value?.currentItem?.id ?: "")
                    .setSubtitleConfigurations(
                        subTitles.filter { it.external && !it.url.isNullOrEmpty() }.map { sub ->
                            MediaItem.SubtitleConfiguration.Builder(sub.url!!.toUri())
                                .setMimeType(guessSubtitleMimeType(sub.url))
                                .setLanguage(sub.languageCode)
                                .setLabel(sub.name)
                                .build()
                        }
                    )
                    .build()


                player?.stop()
                player?.clearMediaItems()
                player?.setMediaItem(mediaItem)
                player?.prepare()

                val startPosition = playbackData.value?.startPosition ?: 0L
                if (startPosition > 0) {
                    player?.seekTo(startPosition)

                    player?.playWhenReady = play
                }
            } catch (e: Exception) {
                println("Error playing video $e")
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
        //exoPlayer initializes after the playbackData is set for the first load
        playbackData.value?.let {
            sendPlayableModel(it)
            VideoPlayerObject.setAudioTrackIndex(it.defaultAudioTrack.toInt(), true)
            VideoPlayerObject.setSubtitleTrackIndex(it.defaultSubtrack.toInt(), true)
            open(it.url, true)
        }
    }
}

fun guessSubtitleMimeType(fileName: String): String = when {
    fileName.contains(".srt", ignoreCase = true) -> MimeTypes.APPLICATION_SUBRIP
    fileName.contains(".vtt", ignoreCase = true) -> MimeTypes.TEXT_VTT
    fileName.contains(".ass", ignoreCase = true) -> MimeTypes.TEXT_SSA
    else -> MimeTypes.APPLICATION_SUBRIP
}

fun ExoPlayer.properlySetSubAndAudioTracks(playableData: PlayableData) {
    try {
        val currentSubIndex = playableData.defaultSubtrack
        val indexOfSubtitleTrack =
            playableData.subtitleTracks.indexOfFirst { it.index == currentSubIndex }
        val internalSubTracks = this.getSubtitleTracks()

        val wantedSubIndex = indexOfSubtitleTrack - 1
        if (wantedSubIndex < 0) {
            clearSubtitleTrack()
        } else {
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
        } else {
            clearAudioTrack(false)
            setInternalAudioTrack(internalAudioTracks[wantedAudioIndex])
        }
    } catch (e: Exception) {
        e.printStackTrace()
    }
}
