package nl.jknaapen.fladder.objects

import PlaybackState
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import android.os.Build
import androidx.annotation.RequiresApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import nl.jknaapen.fladder.VideoPlayerActivity
import nl.jknaapen.fladder.messengers.VideoPlayerImplementation
import nl.jknaapen.fladder.utility.InternalTrack
import java.time.ZoneId
import kotlin.time.Clock
import kotlin.time.ExperimentalTime
import kotlin.time.toJavaInstant

object VideoPlayerObject {
    val implementation: VideoPlayerImplementation = VideoPlayerImplementation()
    private var _currentState = MutableStateFlow<PlaybackState?>(null)

    val videoPlayerState = _currentState.map { it }

    val buffering = _currentState.map { it?.buffering ?: true }
    val position = _currentState.map { it?.position ?: 0L }
    val duration = _currentState.map { it?.duration ?: 0L }
    val playing = _currentState.map { it?.playing ?: false }

    val chapters = implementation.playbackData.map { it?.chapters }

    val nextUpVideo = implementation.playbackData.map { it?.nextVideo }

    @RequiresApi(Build.VERSION_CODES.O)
    @OptIn(ExperimentalTime::class)
    val endTime = combine(position, duration) { pos, dur ->
        val now = Clock.System.now().toJavaInstant()
        val zone = ZoneId.systemDefault()
        val remainingMs = (dur - pos).coerceAtLeast(0L)
        val endInstant = now.plusMillis(remainingMs)

        val endZoned = endInstant.atZone(zone)

        endZoned.toOffsetDateTime().toString()
    }

    val currentSubtitleTrackIndex =
        MutableStateFlow((implementation.playbackData.value?.defaultSubtrack ?: -1).toInt())
    val currentAudioTrackIndex =
        MutableStateFlow((implementation.playbackData.value?.defaultAudioTrack ?: -1).toInt())

    val exoAudioTracks = MutableStateFlow<List<InternalTrack>>(emptyList())
    val exoSubTracks = MutableStateFlow<List<InternalTrack>>(emptyList())

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

    val hasSubtracks: Flow<Boolean> =
        combine(subtitleTracks, exoSubTracks.asStateFlow()) { sub, exo ->
            sub.isNotEmpty() && exo.isNotEmpty()
        }

    val hasAudioTracks: Flow<Boolean> =
        combine(audioTracks, exoAudioTracks.asStateFlow()) { audio, exo ->
            audio.isNotEmpty() && exo.isNotEmpty()
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
}