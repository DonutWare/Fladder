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
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.viewinterop.AndroidView
import androidx.media3.common.C.VIDEO_SCALING_MODE_SCALE_TO_FIT
import androidx.media3.common.Player
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.LeastRecentlyUsedCacheEvictor
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import androidx.media3.ui.PlayerView
import nl.jknaapen.fladder.objects.VideoPlayerHost
import java.io.File

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
    val trackSelector = DefaultTrackSelector(context)
    val cacheDataSourceFactory = remember { VideoCache.buildCacheDataSourceFactory(context) }

    val exoPlayer = remember {
        ExoPlayer.Builder(context).apply {
            setTrackSelector(trackSelector)
            setMediaSourceFactory(
                DefaultMediaSourceFactory(cacheDataSourceFactory)
            )
            setVideoScalingMode(VIDEO_SCALING_MODE_SCALE_TO_FIT)
        }.build()
    }

    DisposableEffect(exoPlayer) {
        val listener = object : Player.Listener {
            override fun onEvents(player: Player, events: Player.Events) {
                super.onEvents(player, events)

                videoHost.callBack?.onPlaybackStateChanged(
                    PlaybackState(
                        position = exoPlayer.currentPosition,
                        buffered = exoPlayer.bufferedPosition,
                        playing = exoPlayer.isPlaying,
                        completed = exoPlayer.playbackState == Player.STATE_ENDED,
                        failed = exoPlayer.playbackState == Player.STATE_IDLE
                    ),
                    callback = {

                    }
                )
            }
        }
        exoPlayer.addListener(listener)
        onDispose {
            exoPlayer.removeListener(listener)
        }
    }

    DisposableEffect(Unit) {
        VideoPlayerHost.implementation.init(exoPlayer)
        onDispose {
            videoHost.callBack?.onStop(callback = {})
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
                        ViewGroup.LayoutParams.MATCH_PARENT
                    )
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