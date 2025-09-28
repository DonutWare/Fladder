package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack

@OptIn(UnstableApi::class)
@Composable
fun SubtitlePicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerObject.currentSubtitleTrackIndex.collectAsState()
    val subTitles by VideoPlayerObject.subtitleTracks.collectAsState(listOf())
    val internalSubTracks by VideoPlayerObject.exoSubTracks

    val listState = rememberLazyListState()

    LaunchedEffect(selectedIndex) {
        listState.scrollToItem(
            subTitles.indexOfFirst { it.index == selectedIndex.toLong() }
        )
    }

    CustomModalBottomSheet(
        onDismissRequest,
        maxWidth = 600.dp,
    ) {
        LazyColumn(
            state = listState,
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 8.dp, vertical = 16.dp),
            verticalArrangement = Arrangement.spacedBy(6.dp)
        ) {
            item {
                TrackButton(
                    modifier = Modifier
                        .fillMaxWidth()
                        .defaultSelected(-1 == selectedIndex),
                    onClick = {
                        VideoPlayerObject.setSubtitleTrackIndex(-1)
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
            }
            internalSubTracks.forEachIndexed { index, subtitle ->
                val serverSub = subTitles.elementAtOrNull(index + 1)
                val selected = serverSub?.index == selectedIndex.toLong()
                item {
                    TrackButton(
                        modifier = Modifier
                            .fillMaxWidth()
                            .defaultSelected(selected),
                        onClick = {
                            serverSub?.index?.let {
                                VideoPlayerObject.setSubtitleTrackIndex(it.toInt())
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
}