package nl.jknaapen.fladder.messengers

import PlayableData
import VideoPlayerApi
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import kotlinx.coroutines.flow.MutableStateFlow

class VideoPlayerImplementation(
) : VideoPlayerApi {
    var player: ExoPlayer? = null
    val playbackData: MutableStateFlow<PlayableData?> = MutableStateFlow(null)

    override fun sendPlayableModel(playableData: PlayableData): Boolean {
        try {
            playbackData.value = playableData
            println("Loading video in native ${playableData.url}")
            val mediaItem = MediaItem.fromUri(playableData.url)
            player?.setMediaItem(mediaItem)
            player?.prepare()
            player?.play()
            return true
        } catch (e: Exception) {
            println("Error playing video $e")
            return false
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
        playbackData.value?.let {
            sendPlayableModel(it)
        }
    }
}