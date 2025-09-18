package nl.jknaapen.fladder.objects

import PlaybackState
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.RequiresApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.map
import nl.jknaapen.fladder.VideoPlayerActivity
import nl.jknaapen.fladder.messengers.VideoPlayerImplementation
import kotlin.time.DurationUnit
import kotlin.time.toDuration

object VideoPlayerObject {
    val implementation: VideoPlayerImplementation = VideoPlayerImplementation()
    private var _currentState = MutableStateFlow<PlaybackState?>(null)

    val videoPlayerState = _currentState.map { it }

    val buffering = _currentState.map { it?.buffering ?: true }
    val position = _currentState.map { it?.position ?: 0L }
    val duration = _currentState.map { it?.duration ?: 0L }
    val playing = _currentState.map { it?.playing ?: 0L }

    val currentSubtitleTrackIndex =
        MutableStateFlow((implementation.playbackData.value?.defaultSubtrack ?: -1).toInt())
    val currentAudioTrackIndex =
        MutableStateFlow((implementation.playbackData.value?.defaultAudioTrack ?: -1).toInt())

    fun setSubtitleTrackIndex(value: Int, init: Boolean = false) {
        currentSubtitleTrackIndex.value = value
        if (!init) {
            videoPlayerControls?.swapSubtitleTrack(value.toLong(), callback = {})
        }
    }

    fun setAudioTrackIndex(value: Int, init: Boolean = false) {
        currentAudioTrackIndex.value = value
        if (!init) {
            videoPlayerControls?.swapAudioTrack(value.toLong(), callback = {})
        }
    }

    val subtitleTracks = implementation.playbackData.map { it?.subtitleTracks ?: listOf() }
    val audioTracks = implementation.playbackData.map { it?.audioTracks ?: listOf() }

    val forwardSpeed =
        implementation.playbackData.map {
            (it?.skipForward ?: 1L).toDuration(DurationUnit.MILLISECONDS)
        }
    val backwardSpeed = implementation.playbackData.map {
        (it?.skipBackward ?: 1L).toDuration(
            DurationUnit.MILLISECONDS
        )
    }

    fun setPlaybackState(state: PlaybackState) {
        _currentState.value = state
        videoPlayerListener?.onPlaybackStateChanged(
            state, callback = {}
        )
    }

    var videoPlayerListener: VideoPlayerListenerCallback? = null
    var videoPlayerControls: VideoPlayerControlsCallback? = null
    var currentActivity: VideoPlayerActivity? = null

    @RequiresApi(Build.VERSION_CODES.O)
    fun isAndroidTV(context: Context): Boolean {
        val pm = context.packageManager
        val leanBackEnabled = pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK)
        val leanBackOnly = pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK_ONLY)
        return leanBackEnabled || leanBackOnly
    }
}