package nl.jknaapen.fladder.composables.overlays.screensavers

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import nl.jknaapen.fladder.composables.shared.CurrentTime

@Composable
internal fun ScreensaverTime() {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(color = Color.Black),
        contentAlignment = Alignment.Center,
    ) {
        CurrentTime()
    }
}