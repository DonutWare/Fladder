package nl.jknaapen.fladder.messengers

import PlayableData
import VideoPlayerApi
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import kotlinx.coroutines.flow.MutableStateFlow
import nl.jknaapen.fladder.utility.clearAudioTrack
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.getAudioTracks
import nl.jknaapen.fladder.utility.getSubtitleTracks
import nl.jknaapen.fladder.utility.setInternalAudioTrack
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack

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
        try {
            player?.clearMediaItems()
            val startPosition = playbackData.value?.startPosition
            println("Loading video in native $url")
            val mediaItem = MediaItem.fromUri(url)
            player?.setMediaItem(mediaItem, startPosition ?: 0L)
            player?.prepare()
            if (play) {
                player?.play()
            }
        } catch (e: Exception) {
            println("Error playing video $e")
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
            open(it.url, true)
        }
    }
}

fun ExoPlayer.properlySetSubAndAudioTracks(playableData: PlayableData) {
    try {
        val currentSubIndex = playableData.defaultSubtrack
        val indexOfSubtitleTrack =
            playableData.subtitleTracks.indexOfFirst { it.index == currentSubIndex }
        val internalSubTracks = this.getSubtitleTracks()

        //Set default subtitle, -1 for "Off" index
        val wantedSubIndex = indexOfSubtitleTrack - 1
        if (wantedSubIndex < 0) {
            clearSubtitleTrack()
        } else {
            clearSubtitleTrack(false)
            setInternalSubtitleTrack(internalSubTracks[wantedSubIndex])
        }

        //Set default audio, -1 for "Off" index
        return

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