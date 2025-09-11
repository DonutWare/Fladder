package nl.jknaapen.fladder.objects

import PlaybackState
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.map
import nl.jknaapen.fladder.VideoPlayerActivity
import nl.jknaapen.fladder.messengers.VideoPlayerImplementation

object VideoPlayerHost {
    val implementation: VideoPlayerImplementation = VideoPlayerImplementation()
    private var _currentState = MutableStateFlow<PlaybackState?>(null)

    val videoPlayerState = _currentState.map { it }

    val position = _currentState.map { it?.position ?: 0L }
    val duration = _currentState.map { it?.duration ?: 0L }
    val playing = _currentState.map { it?.playing ?: 0L }

    val defaultSubIndex = implementation.playbackData.map { it?.defaultSubtrack?.toInt() ?: 1 }
    val defaultAudioIndex = implementation.playbackData.map { it?.defaultAudioTrack?.toInt() ?: 1 }

    val subtitleTracks = implementation.playbackData.map { it?.subtitleTracks ?: listOf() }
    val audioTracks = implementation.playbackData.map { it?.audioTracks ?: listOf() }

    fun setPlaybackState(state: PlaybackState) {
        _currentState.value = state
        videoPlayerListener?.onPlaybackStateChanged(
            state, callback = {}
        )
    }

    var videoPlayerListener: VideoPlayerListenerCallback? = null
    var videoPlayerControls: VideoPlayerControlsCallback? = null
    var currentActivity: VideoPlayerActivity? = null
}