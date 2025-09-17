package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.getSubtitleTracks
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack

@OptIn(UnstableApi::class)
@Composable
fun SubtitlePicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerHost.currentSubtitleTrackIndex.collectAsState()
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
            verticalArrangement = Arrangement.spacedBy(6.dp)
        ) {
            TrackButton(
                modifier = Modifier
                    .fillMaxWidth()
                    .defaultSelected(-1 == selectedIndex),
                onClick = {
                    VideoPlayerHost.setSubtitleTrackIndex(-1)
                    player.clearSubtitleTrack()
                },
                selected = -1 == selectedIndex
            ) {
                Column(
                    horizontalAlignment = Alignment.Start,
                    verticalArrangement = Arrangement.spacedBy(
                        8.dp,
                        alignment = Alignment.CenterVertically
                    )
                ) {
                    Text(
                        text = "Off",
                    )
                }
            }
            internalSubTracks.forEachIndexed { index, subtitle ->
                val serverSub = subTitles.elementAtOrNull(index + 1)
                val selected = serverSub?.index == selectedIndex.toLong()
                TrackButton(
                    modifier = Modifier
                        .fillMaxWidth()
                        .defaultSelected(selected),
                    onClick = {
                        serverSub?.index?.let {
                            VideoPlayerHost.setSubtitleTrackIndex(it.toInt())
                        }
                        player.setInternalSubtitleTrack(subtitle)
                    },
                    selected = selected,
                ) {
                    Column(
                        horizontalAlignment = Alignment.Start,
                        verticalArrangement = Arrangement.spacedBy(
                            8.dp,
                            alignment = Alignment.CenterVertically
                        )
                    ) {
                        Text(
                            text = serverSub?.name ?: "",
                        )
                    }
                }
            }
        }
    }
}