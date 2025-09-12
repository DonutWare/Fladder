package nl.jknaapen.fladder.player

import PlaybackState
import android.content.Context
import android.view.ViewGroup
import androidx.annotation.OptIn
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.viewinterop.AndroidView
import androidx.media3.common.AudioAttributes
import androidx.media3.common.C
import androidx.media3.common.C.VIDEO_SCALING_MODE_SCALE_TO_FIT
import androidx.media3.common.Player
import androidx.media3.common.Tracks
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.LeastRecentlyUsedCacheEvictor
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import androidx.media3.ui.CaptionStyleCompat
import androidx.media3.ui.PlayerView
import io.github.peerless2012.ass.media.kt.buildWithAssSupport
import io.github.peerless2012.ass.media.type.AssRenderType
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.messengers.properlySetSubAndAudioTracks
import nl.jknaapen.fladder.objects.VideoPlayerHost
import java.io.File
import kotlin.time.Duration.Companion.seconds

val LocalPlayer = compositionLocalOf<ExoPlayer?> { null }

@OptIn(UnstableApi::class)
@Composable
internal fun ExoPlayer(
    controls: @Composable (
        player: ExoPlayer,
        trackSelector: DefaultTrackSelector,
    ) -> Unit,
) {
    val videoHost = VideoPlayerHost
    val context = LocalContext.current

    var initialized = false


    val trackSelector = DefaultTrackSelector(context).apply {
        setParameters(
            buildUponParameters()
                .setAllowVideoMixedMimeTypeAdaptiveness(true)
                .setAllowVideoNonSeamlessAdaptiveness(true)
                .setTunnelingEnabled(true)
        )
    }
    val cacheDataSourceFactory = remember { VideoCache.buildCacheDataSourceFactory(context) }

    val audioAttributes = AudioAttributes.Builder()
        .setUsage(C.USAGE_MEDIA)
        .setContentType(C.AUDIO_CONTENT_TYPE_MOVIE)
        .build()

    val renderersFactory = DefaultRenderersFactory(context)
        .setExtensionRendererMode(DefaultRenderersFactory.EXTENSION_RENDERER_MODE_PREFER) // ensure ffmpeg is picked first
        .setEnableDecoderFallback(true)

    val exoPlayer = ExoPlayer.Builder(context, renderersFactory)
        .setTrackSelector(trackSelector)
        .setMediaSourceFactory(DefaultMediaSourceFactory(cacheDataSourceFactory))
        .setAudioAttributes(audioAttributes, true)
        .setVideoScalingMode(VIDEO_SCALING_MODE_SCALE_TO_FIT)
        .buildWithAssSupport(context, AssRenderType.OVERLAY)

    LaunchedEffect(exoPlayer) {
        while (true) {
            if (exoPlayer.isPlaying) {
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
            delay(1.seconds)
        }
    }

    DisposableEffect(exoPlayer) {
        val listener = object : Player.Listener {
            override fun onEvents(player: Player, events: Player.Events) {
                super.onEvents(player, events)
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

            override fun onTracksChanged(tracks: Tracks) {
                super.onTracksChanged(tracks)
                if (!initialized) {
                    initialized = true
                    VideoPlayerHost.implementation.playbackData.value?.let {
                        exoPlayer.properlySetSubAndAudioTracks(it)
                    }
                }

            }
        }
        exoPlayer.addListener(listener)
        onDispose {
            exoPlayer.removeListener(listener)
        }
    }

    DisposableEffect(Unit) {
        VideoPlayerHost.implementation.init(exoPlayer)
        //Testing purposes
//        VideoPlayerHost.implementation.sendPlayableModel(testPlaybackData)
        onDispose {
            videoHost.videoPlayerControls?.onStop(callback = {})
            VideoPlayerHost.implementation.init(null)
            exoPlayer.release()
        }
    }


    Box(
        modifier = Modifier
            .background(Color.Black)
            .fillMaxSize()
    ) {
        AndroidView(
            modifier = Modifier.fillMaxSize(),
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
            }
        )
        CompositionLocalProvider(LocalPlayer provides exoPlayer) {
            controls(exoPlayer, trackSelector)
        }
    }
}

@UnstableApi
object VideoCache {
    private const val CACHE_SIZE: Long = 150L * 1024L * 1024L // 150 MB

    @Volatile
    private var cache: SimpleCache? = null

    fun getCache(context: Context): SimpleCache {
        return cache ?: synchronized(this) {
            cache ?: SimpleCache(
                File(context.cacheDir, "video_cache"),
                LeastRecentlyUsedCacheEvictor(CACHE_SIZE)
            ).also { cache = it }
        }
    }

    fun buildCacheDataSourceFactory(context: Context): DataSource.Factory {
        val httpDataSourceFactory = DefaultHttpDataSource.Factory()
        val upstreamFactory = DefaultDataSource.Factory(context, httpDataSourceFactory)

        return CacheDataSource.Factory()
            .setCache(getCache(context))
            .setUpstreamDataSourceFactory(upstreamFactory)
            .setFlags(CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR)
    }
}