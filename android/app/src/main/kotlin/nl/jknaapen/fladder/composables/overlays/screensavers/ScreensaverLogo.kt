package nl.jknaapen.fladder.composables.overlays.screensavers

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import nl.jknaapen.fladder.composables.controls.ItemHeader
import nl.jknaapen.fladder.composables.shared.CurrentTime
import nl.jknaapen.fladder.objects.VideoPlayerObject

@Composable
internal fun ScreensaverLogo() {
    Row(
        modifier = Modifier
            .fillMaxSize()
            .background(color = Color.Black)
            .padding(32.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        val state by VideoPlayerObject.implementation.playbackData.collectAsState(
            null
        )
        state?.let {
            ItemHeader(
                modifier = Modifier
                    .weight(1f),
                it
            )
        }
        CurrentTime()
    }
}