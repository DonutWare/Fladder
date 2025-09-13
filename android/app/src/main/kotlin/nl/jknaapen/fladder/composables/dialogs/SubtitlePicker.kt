package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
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
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.core.net.toUri
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.utility.addExternalSubtitle
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.getSubtitleTracks
import nl.jknaapen.fladder.utility.highlightOnFocus
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack

@OptIn(UnstableApi::class)
@Composable
fun SubtitlePicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerHost.defaultSubIndex.collectAsState(1)
    val subTitles by VideoPlayerHost.subtitleTracks.collectAsState(listOf())
    val internalSubTracks = player.getSubtitleTracks()
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
            subTitles.forEachIndexed { index, subtitle ->
                val isSelected = subtitle.index.toInt() == selectedIndex
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
                        player.clearSubtitleTrack()
                        val wantedIndex = index - 1
                        if (wantedIndex < 0) {
                            return@TextButton
                        }
                        if (subtitle.external) {
                            player.addExternalSubtitle(
                                (subtitle.url ?: "").toUri(),
                                language = subtitle.languageCode,
                                label = subtitle.name
                            )
                        } else {
                            player.setInternalSubtitleTrack(internalSubTracks[wantedIndex])
                        }
                    }
                ) {
                    Column(
                        horizontalAlignment = Alignment.Start,
                        verticalArrangement = Arrangement.spacedBy(
                            8.dp,
                            alignment = Alignment.CenterVertically
                        )
                    ) {
                        Text(
                            text = subtitle.name,
                            color = Color.White
                        )
                        Text(
                            text = subtitle.languageCode,
                            color = Color.White
                        )
                    }
                }
            }
        }
    }
}