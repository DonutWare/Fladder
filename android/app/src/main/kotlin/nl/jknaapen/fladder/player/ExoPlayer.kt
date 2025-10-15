package nl.jknaapen.fladder.player

import PlaybackState
import android.app.ActivityManager
import android.view.ViewGroup
import androidx.annotation.OptIn
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.content.getSystemService
import androidx.media3.common.AudioAttributes
import androidx.media3.common.C
import androidx.media3.common.Player
import androidx.media3.common.TrackSelectionParameters
import androidx.media3.common.Tracks
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import androidx.media3.extractor.DefaultExtractorsFactory
import androidx.media3.extractor.ts.TsExtractor
import androidx.media3.ui.CaptionStyleCompat
import androidx.media3.ui.PlayerView
import io.github.peerless2012.ass.media.kt.buildWithAssSupport
import io.github.peerless2012.ass.media.type.AssRenderType
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.composables.overlays.NextUpOverlay
import nl.jknaapen.fladder.messengers.properlySetSubAndAudioTracks
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.getAudioTracks
import nl.jknaapen.fladder.utility.getSubtitleTracks
import kotlin.time.Duration.Companion.seconds

val LocalPlayer = compositionLocalOf<ExoPlayer?> { null }

@OptIn(UnstableApi::class)
@Composable
internal fun ExoPlayer(
    controls: @Composable (
        player: ExoPlayer,
    ) -> Unit,
) {
    val videoHost = VideoPlayerObject
    val context = LocalContext.current

    var initialized = false

    val extractorsFactory = DefaultExtractorsFactory().apply {
        val isLowRamDevice = context.getSystemService<ActivityManager>()?.isLowRamDevice == true
        setTsExtractorTimestampSearchBytes(
            when (isLowRamDevice) {
                true -> TsExtractor.TS_PACKET_SIZE * 1800
                false -> TsExtractor.DEFAULT_TIMESTAMP_SEARCH_BYTES
            }
        )
        setConstantBitrateSeekingEnabled(true)
        setConstantBitrateSeekingAlwaysEnabled(true)
    }

    val dataSourceFactory = remember {
        DefaultDataSource.Factory(context, DefaultHttpDataSource.Factory())
    }

    val audioAttributes = AudioAttributes.Builder()
        .setUsage(C.USAGE_MEDIA)
        .setContentType(C.AUDIO_CONTENT_TYPE_MOVIE)
        .build()

    val renderersFactory = DefaultRenderersFactory(context)
        .setExtensionRendererMode(DefaultRenderersFactory.EXTENSION_RENDERER_MODE_ON)
        .setEnableDecoderFallback(true)

    val trackSelector = DefaultTrackSelector(context).apply {
        setParameters(buildUponParameters().apply {
            setAudioOffloadPreferences(
                TrackSelectionParameters.AudioOffloadPreferences.DEFAULT.buildUpon().apply {
                    setAudioOffloadMode(TrackSelectionParameters.AudioOffloadPreferences.AUDIO_OFFLOAD_MODE_ENABLED)
                }.build()
            )
            setTunnelingEnabled(PlayerSettingsObject.settings.value?.enableTunneling ?: false)
            setAllowInvalidateSelectionsOnRendererCapabilitiesChange(true)
        })
    }

    val exoPlayer = remember {
        ExoPlayer.Builder(context, renderersFactory)
            .setTrackSelector(trackSelector)
            .setMediaSourceFactory(DefaultMediaSourceFactory(dataSourceFactory, extractorsFactory))
            .setAudioAttributes(audioAttributes, true)
            .setHandleAudioBecomingNoisy(true)
            .setPauseAtEndOfMediaItems(true)
            .setVideoScalingMode(C.VIDEO_SCALING_MODE_SCALE_TO_FIT)
            .buildWithAssSupport(
                context,
                renderersFactory = renderersFactory,
                extractorsFactory = extractorsFactory,
                renderType = AssRenderType.LEGACY
            )
    }

    fun updatePlaybackState() {
        videoHost.setPlaybackState(
            PlaybackState(
                position = exoPlayer.currentPosition,
                buffered = exoPlayer.bufferedPosition,
                duration = exoPlayer.duration,
                playing = exoPlayer.isPlaying,
                buffering = exoPlayer.playbackState == Player.STATE_BUFFERING,
                completed = exoPlayer.playbackState == Player.STATE_ENDED,
                failed = exoPlayer.playbackState == Player.STATE_IDLE
            )
        )
    }

    LaunchedEffect(exoPlayer) {
        while (true) {
            updatePlaybackState()
            delay(1.seconds)
        }
    }

    DisposableEffect(exoPlayer) {
        val listener = object : Player.Listener {
            override fun onPlaybackStateChanged(playbackState: Int) {
                videoHost.setPlaybackState(
                    PlaybackState(
                        position = exoPlayer.currentPosition,
                        buffered = exoPlayer.bufferedPosition,
                        duration = exoPlayer.duration,
                        playing = exoPlayer.isPlaying,
                        buffering = playbackState == Player.STATE_BUFFERING,
                        completed = playbackState == Player.STATE_ENDED,
                        failed = playbackState == Player.STATE_IDLE
                    )
                )
            }

            override fun onEvents(player: Player, events: Player.Events) {
                super.onEvents(player, events)
                updatePlaybackState()
            }

            override fun onTracksChanged(tracks: Tracks) {
                super.onTracksChanged(tracks)
                if (!initialized) {
                    initialized = true
                    VideoPlayerObject.implementation.playbackData.value?.let {
                        exoPlayer.properlySetSubAndAudioTracks(it)
                    }
                    VideoPlayerObject.exoSubTracks.value = exoPlayer.getSubtitleTracks()
                    VideoPlayerObject.exoAudioTracks.value = exoPlayer.getAudioTracks()
                }
            }
        }
        exoPlayer.addListener(listener)
        onDispose {
            exoPlayer.removeListener(listener)
        }
    }

    DisposableEffect(Unit) {
        VideoPlayerObject.implementation.init(exoPlayer)
        onDispose {
            videoHost.videoPlayerControls?.onStop(callback = {})
            VideoPlayerObject.implementation.init(null)
            exoPlayer.release()
        }
    }


    NextUpOverlay(
        modifier = Modifier
            .fillMaxSize()
    ) { showControls ->
        AndroidView(
            modifier = Modifier
                .fillMaxSize(),
            factory = {
                PlayerView(it).apply {
                    player = exoPlayer
                    useController = false
                    layoutParams = ViewGroup.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT,
                    )
                    subtitleView?.apply {
                        setStyle(
                            CaptionStyleCompat(
                                android.graphics.Color.WHITE,
                                android.graphics.Color.TRANSPARENT,
                                android.graphics.Color.TRANSPARENT,
                                CaptionStyleCompat.EDGE_TYPE_OUTLINE,
                                android.graphics.Color.BLACK,
                                null
                            )
                        )
                    }
                }
            },
        )
        if (showControls)
            CompositionLocalProvider(LocalPlayer provides exoPlayer) {
                controls(exoPlayer)
            }
    }
}
