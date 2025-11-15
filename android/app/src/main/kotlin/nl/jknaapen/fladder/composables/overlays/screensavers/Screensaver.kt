package nl.jknaapen.fladder.composables.overlays.screensavers

import Screensaver
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.platform.LocalContext
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.leanBackEnabled
import kotlin.time.Duration.Companion.minutes

@RequiresApi(Build.VERSION_CODES.O)
@Composable
internal fun ScreenSaver(
    content: @Composable () -> Unit,
) {
    if (!leanBackEnabled(LocalContext.current)) return

    val selectedType by PlayerSettingsObject.screenSaver.collectAsState(Screensaver.LOGO)
    val isPlaying by VideoPlayerObject.playing.collectAsState(false)
    val isBuffering by VideoPlayerObject.buffering.collectAsState(true)

    val lastInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

    val playerInactive by remember(isPlaying, isBuffering) {
        derivedStateOf {
            !isPlaying && !isBuffering
        }
    }

    var screenSaverActive by remember { mutableStateOf(false) }

    fun updateLastInteraction() {
        screenSaverActive = false
        lastInteraction.longValue = System.currentTimeMillis()
    }

    LaunchedEffect(playerInactive, selectedType, lastInteraction.longValue) {
        if (selectedType == Screensaver.DISABLED) {
            screenSaverActive = false
            return@LaunchedEffect
        }

        if (playerInactive) {
            delay(5.minutes)
            screenSaverActive = true
        } else {
            screenSaverActive = false
        }
    }

    Box(
        modifier = Modifier.onKeyEvent { _ ->
            updateLastInteraction()
            if (screenSaverActive) {
                return@onKeyEvent true
            }
            return@onKeyEvent false
        }
    ) {
        content()
        AnimatedVisibility(
            visible = screenSaverActive,
            enter = fadeIn(),
            exit = fadeOut(),
        ) {
            when (selectedType) {
                Screensaver.DVD -> ScreensaverDvd()
                Screensaver.LOGO -> ScreensaverLogo()
                Screensaver.TIME -> ScreensaverTime()
                Screensaver.BLACK -> BlackScreensaver()
                Screensaver.DISABLED -> {}
            }
        }
    }
}

@Composable
private fun BlackScreensaver() {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(color = Color.Black)
    )
}