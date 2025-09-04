package nl.jknaapen.fladder

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.annotation.OptIn
import androidx.compose.runtime.Composable
import androidx.media3.common.util.UnstableApi
import nl.jknaapen.fladder.composables.controls.CustomVideoControls
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.player.ExoPlayer

class VideoPlayerActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        VideoPlayerHost.currentActivity = this
        setContent {
            VideoPlayerTheme {
                VideoPlayerScreen()
            }
        }
    }
}

@OptIn(UnstableApi::class)
@Composable
fun VideoPlayerScreen(
) {
    ExoPlayer { player, trackSelector ->
        CustomVideoControls(player, trackSelector)
    }
}