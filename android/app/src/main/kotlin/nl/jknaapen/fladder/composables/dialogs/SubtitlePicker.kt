package nl.jknaapen.fladder.composables.dialogs

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentWidth
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
import nl.jknaapen.fladder.utility.clearSubtitleTrack
import nl.jknaapen.fladder.utility.setInternalSubtitleTrack

@OptIn(UnstableApi::class)
@Composable
fun SubtitlePicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit,
) {
    val selectedIndex by VideoPlayerObject.currentSubtitleTrackIndex.collectAsState()
    val subTitles by VideoPlayerObject.subtitleTracks.collectAsState(emptyList())
    val internalSubTracks by VideoPlayerObject.exoSubTracks.collectAsState(emptyList())

    if (subTitles.isEmpty()) return

    val focusRequesters = remember(subTitles) {
        subTitles.associateWith { FocusRequester() }
    }

    val listState = rememberLazyListState()

    LaunchedEffect(selectedIndex, subTitles) {
        val selectedSubIndex = subTitles.indexOfFirst { it.index == selectedIndex.toLong() }

        if (selectedSubIndex in subTitles.indices) {
            listState.scrollToItem(selectedSubIndex)
            focusRequesters[subTitles[selectedSubIndex]]?.requestFocus()
        }
    }

    CustomModalBottomSheet(
        onDismissRequest,
        maxWidth = 600.dp,
    ) {
        LazyColumn(
            state = listState,
            modifier = Modifier
                .wrapContentWidth()
                .padding(horizontal = 8.dp, vertical = 16.dp),
        ) {
            subTitles.forEachIndexed { index, serverSub ->
                val isOffTrack = index == 0
                val selected = serverSub.index == selectedIndex.toLong()

                item {
                    TrackButton(
                        modifier = Modifier
                            .fillMaxWidth()
                            .focusRequester(focusRequesters[serverSub]!!),
                        onClick = {
                            if (isOffTrack) {
                                VideoPlayerObject.setSubtitleTrackIndex(-1)
                                player.clearSubtitleTrack()
                            } else {
                                val internalTrackIndex = index - 1

                                val internalSubTrack =
                                    internalSubTracks.elementAtOrNull(internalTrackIndex)

                                if (internalSubTrack != null) {
                                    VideoPlayerObject.setSubtitleTrackIndex(serverSub.index.toInt())
                                    player.setInternalSubtitleTrack(internalSubTrack)
                                }
                            }
                        },
                        selected = selected,
                    ) {
                        if (isOffTrack) {
                            Translate(Localized::off) {
                                Text(it)
                            }
                        } else {
                            Text(
                                text = serverSub.name,
                            )
                        }
                    }
                }
            }
        }
    }
}