package nl.jknaapen.fladder.composables.dialogs

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.unit.dp
import androidx.media3.exoplayer.ExoPlayer

private val playbackSpeeds = listOf(0.25f, 0.5f, 0.75f, 1.0f, 1.25f, 1.5f, 1.75f, 2.0f)

@Composable
fun PlaybackSpeedPicker(
    player: ExoPlayer,
    onDismissRequest: () -> Unit
) {
    var currentSpeed = player.playbackParameters.speed
    val selectedIndex = playbackSpeeds.indexOf(currentSpeed).coerceAtLeast(0)

    val listState = rememberLazyListState()
    val focusRequesters = remember {
        playbackSpeeds.map { FocusRequester() }
    }

    LaunchedEffect(Unit) {
        if (selectedIndex in focusRequesters.indices) {
            listState.scrollToItem(selectedIndex)
            focusRequesters[selectedIndex].requestFocus()
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
            itemsIndexed(playbackSpeeds) { index, speed ->
                val selected = speed == currentSpeed
                TrackButton(
                    modifier = Modifier
                        .fillMaxWidth()
                        .focusRequester(focusRequesters[index]),
                    onClick = {
                        player.setPlaybackSpeed(speed)
                        onDismissRequest()
                    },
                    selected = selected,
                ) {
                    Text(text = "x$speed")
                }
            }
        }
    }
}