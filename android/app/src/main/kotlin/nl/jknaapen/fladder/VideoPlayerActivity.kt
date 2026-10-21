package nl.jknaapen.fladder

import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.annotation.OptIn
import androidx.annotation.RequiresApi
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.lifecycleScope
import androidx.media3.common.util.UnstableApi
import kotlinx.coroutines.launch
import nl.jknaapen.fladder.composables.controls.CustomVideoControls
import nl.jknaapen.fladder.composables.overlays.screensavers.ScreenSaver
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.player.ExoPlayer
import nl.jknaapen.fladder.utility.ScaledContent
import nl.jknaapen.fladder.utility.applyRefreshRate
import nl.jknaapen.fladder.utility.leanBackEnabled
import nl.jknaapen.fladder.utility.resetRefreshRate
import nl.jknaapen.fladder.utility.resetRefreshRateAndWait

class VideoPlayerActivity : ComponentActivity() {
    // Display mode active before refresh rate matching switched it; restored on exit.
    private var originalModeId: Int? = null
    private var finishingWithModeReset = false

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        VideoPlayerObject.currentActivity = this

        window.setFlags(
            WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED,
            WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED
        )

        window.setFormat(PixelFormat.TRANSLUCENT)

        setContent {
            VideoPlayerTheme {
                VideoPlayerScreen()
            }
        }
    }

    suspend fun applyVideoRefreshRate(videoWidth: Int, videoHeight: Int, frameRate: Float) {
        val displayManager = getSystemService(DISPLAY_SERVICE) as DisplayManager
        val previousModeId = applyRefreshRate(window, displayManager, videoWidth, videoHeight, frameRate)
        // Keep the first captured mode across episode transitions so we restore the true original.
        if (previousModeId != null && originalModeId == null) {
            originalModeId = previousModeId
        }
    }

    override fun finish() {
        // Restore the original display mode and let the HDMI handshake settle while the window
        // and video surface are still alive. Switching during teardown can leave pass-through
        // soundbars/AVRs with a black screen that needs a power cycle.
        val modeId = originalModeId
        if (modeId == null || finishingWithModeReset) {
            super.finish()
            return
        }
        finishingWithModeReset = true
        // Player may already be released when finishing via disposeActivity().
        runCatching { VideoPlayerObject.implementation.player?.playWhenReady = false }
        val displayManager = getSystemService(DISPLAY_SERVICE) as DisplayManager
        lifecycleScope.launch {
            resetRefreshRateAndWait(window, displayManager, modeId)
            originalModeId = null
            super.finish()
        }
    }

    override fun onPause() {
        super.onPause()
        VideoPlayerObject.implementation.pause()
    }

    override fun onDestroy() {
        super.onDestroy()
        // Fallback for destruction without finish(); normally the mode is already restored.
        if (originalModeId != null) {
            resetRefreshRate(window)
        }
        VideoPlayerObject.currentActivity = null
    }
}

@OptIn(UnstableApi::class)
@Composable
fun VideoPlayerScreen(
) {
    val leanBackEnabled = leanBackEnabled(LocalContext.current)
    ScreenSaver {
        ExoPlayer { player ->
            ScaledContent(
                scale = if (leanBackEnabled) 0.75f else 1f,
                fontScale = if (leanBackEnabled) 1.2f else 1f,
            ) {
                CustomVideoControls(player)
            }
        }
    }
}
