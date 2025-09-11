package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.utility.clearAudioTrack
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.getAudioTracks
import nl.jknaapen.fladder.utility.highlightOnFocus
import nl.jknaapen.fladder.utility.setInternalAudioTrack

@OptIn(UnstableApi::class)
@Composable
fun AudioPicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerHost.defaultAudioIndex.collectAsState(1)
    val audioTracks by VideoPlayerHost.audioTracks.collectAsState(listOf())
    val internalAudioTracks = player.getAudioTracks()

    CustomModalBottomSheet(
        onDismissRequest,
        maxWidth = 600.dp,
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 8.dp, vertical = 16.dp)
                .verticalScroll(rememberScrollState()),
        ) {
            audioTracks.forEachIndexed { index, audioTrack ->
                val isSelected = audioTrack.index.toInt() == selectedIndex
                TextButton(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(
                            color = Color.Black.copy(alpha = 0.65f),
                            shape = RoundedCornerShape(12.dp),
                        )
                        .defaultSelected(isSelected)
                        .highlightOnFocus()
                        .padding(12.dp),
                    onClick = {
                        val wantedIndex = index - 1
                        if (wantedIndex < 0) {
                            player.clearAudioTrack()
                            return@TextButton
                        }
                        player.clearAudioTrack(false)
                        player.setInternalAudioTrack(internalAudioTracks[wantedIndex])
                    }
                ) {
                    Text(
                        text = audioTrack.name,
                        color = Color.White
                    )
                }
            }
        }
    }
}