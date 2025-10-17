package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.clearAudioTrack
import nl.jknaapen.fladder.utility.setInternalAudioTrack

@OptIn(UnstableApi::class)
@Composable
fun AudioPicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerObject.currentAudioTrackIndex.collectAsState()
    val audioTracks by VideoPlayerObject.audioTracks.collectAsState(emptyList())
    val internalAudioTracks by VideoPlayerObject.exoAudioTracks.collectAsState(emptyList())

    if (internalAudioTracks.isEmpty()) return

    val focusOffTrack = remember { FocusRequester() }
    val focusRequesters = remember(internalAudioTracks) {
        internalAudioTracks.associateWith { FocusRequester() }
    }

    val listState = rememberLazyListState()

    LaunchedEffect(selectedIndex, audioTracks, internalAudioTracks) {
        if (selectedIndex == -1) {
            focusOffTrack.requestFocus()
            return@LaunchedEffect
        }

        val serverTrackIndex = audioTracks.indexOfFirst { it.index == selectedIndex.toLong() }

        if (serverTrackIndex <= 0) {
            focusOffTrack.requestFocus()
            return@LaunchedEffect
        }

        val internalIndex = serverTrackIndex - 1
        val lazyColumnIndex = internalIndex + 1

        listState.scrollToItem(lazyColumnIndex)
        focusRequesters[internalAudioTracks[internalIndex]]?.requestFocus()
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
        ) {
            item {
                val selectedOff = selectedIndex == -1
                TrackButton(
                    modifier = Modifier
                        .fillMaxWidth()
                        .focusRequester(focusOffTrack),
                    onClick = {
                        VideoPlayerObject.setAudioTrackIndex(-1)
                        player.clearAudioTrack()
                    },
                    selected = selectedOff
                ) {
                    Translate(Localized::off) {
                        Text(it)
                    }
                }
            }

            internalAudioTracks.forEachIndexed { index, track ->
                val serverTrack = audioTracks.elementAtOrNull(index + 1)
                val selected = serverTrack?.index?.toInt() == selectedIndex

                item {
                    TrackButton(
                        modifier = Modifier
                            .fillMaxWidth()
                            .focusRequester(focusRequesters[track]!!),
                        onClick = {
                            serverTrack?.index?.let { VideoPlayerObject.setAudioTrackIndex(it.toInt()) }
                            player.setInternalAudioTrack(track)
                        },
                        selected = selected
                    ) {
                        Text(serverTrack?.name ?: "")
                    }
                }
            }
        }
    }
}
