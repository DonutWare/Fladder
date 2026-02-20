package nl.jknaapen.fladder.objects

import PlaybackState
import TVGuideModel
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map
import nl.jknaapen.fladder.VideoPlayerActivity
import nl.jknaapen.fladder.fake.FakeHelperObjects
import nl.jknaapen.fladder.messengers.VideoPlayerImplementation
import nl.jknaapen.fladder.utility.InternalTrack

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

    val endTime = combine(position, duration) { pos, dur ->
        val nowMs = System.currentTimeMillis()
        val remainingMs = (dur - pos).coerceAtLeast(0L)
        val endMs = nowMs + remainingMs
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val instant = java.time.Instant.ofEpochMilli(endMs)
            val zoneId = java.time.ZoneId.systemDefault()
            java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME
                .withZone(zoneId)
                .format(instant)
        } else {
            val calendar = java.util.Calendar.getInstance()
            calendar.timeInMillis = endMs
            val tz = calendar.timeZone
            val sdf = java.text.SimpleDateFormat(
                "yyyy-MM-dd'T'HH:mm:ssXXX",
                java.util.Locale.getDefault()
            )
            sdf.timeZone = tz
            sdf.format(calendar.time)
        }
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

    var tvGuide = MutableStateFlow<TVGuideModel?>(null)
    val guideVisible = MutableStateFlow(false)

    fun toggleGuideVisibility() {
        guideVisible.value = !guideVisible.value
    }

    var currentActivity: VideoPlayerActivity? = null
}