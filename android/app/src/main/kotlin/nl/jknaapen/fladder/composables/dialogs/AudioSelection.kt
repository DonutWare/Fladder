package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.clearAudioTrack
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.setInternalAudioTrack

@OptIn(UnstableApi::class)
@Composable
fun AudioPicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerObject.currentAudioTrackIndex.collectAsState()
    val audioTracks by VideoPlayerObject.audioTracks.collectAsState(listOf())
    val internalAudioTracks by VideoPlayerObject.exoAudioTracks

    val listState = rememberLazyListState()

    LaunchedEffect(selectedIndex) {
        listState.scrollToItem(
            audioTracks.indexOfFirst { it.index == selectedIndex.toLong() }
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
                        VideoPlayerObject.setAudioTrackIndex(-1)
                        player.clearAudioTrack()
                    },
                    selected = -1 == selectedIndex
                ) {
                    Text(
                        text = "Off",
                    )
                }
            }
            internalAudioTracks.forEachIndexed { index, track ->
                val serverTrack = audioTracks.elementAtOrNull(index + 1)
                val selected = serverTrack?.index == selectedIndex.toLong()
                item {
                    TrackButton(
                        modifier = Modifier
                            .fillMaxWidth()
                            .defaultSelected(selected),
                        onClick = {
                            serverTrack?.index?.let {
                                VideoPlayerObject.setAudioTrackIndex(it.toInt())
                            }
                            player.setInternalAudioTrack(track)
                        },
                        selected = selected
                    ) {
                        Text(
                            text = serverTrack?.name ?: "",
                        )
                    }
                }
            }
        }
    }
}