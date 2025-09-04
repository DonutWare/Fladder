package nl.jknaapen.fladder.composables.controls

import androidx.activity.compose.BackHandler
import androidx.annotation.OptIn
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.focusable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.ArrowLeft
import io.github.rabehx.iconsax.filled.ArrowRight1
import io.github.rabehx.iconsax.filled.AudioSquare
import io.github.rabehx.iconsax.filled.Pause
import io.github.rabehx.iconsax.filled.Play
import io.github.rabehx.iconsax.filled.Subtitle
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.highlightOnFocus
import kotlin.time.Duration.Companion.seconds

object PlaybackState {
    var selectedSubIndex = mutableIntStateOf(0)
    var selectedAudioIndex = mutableIntStateOf(1)

    var isPlaying = mutableStateOf(false)
    var position = mutableLongStateOf(0)
    var duration = mutableLongStateOf(0)
}

@OptIn(UnstableApi::class)
@Composable
fun CustomVideoControls(
    exoPlayer: ExoPlayer,
    trackSelector: DefaultTrackSelector,
) {
    var selectedAudioIndex by PlaybackState.selectedAudioIndex
    var selectedSubIndex by PlaybackState.selectedSubIndex

    var hideControls by remember { mutableStateOf(false) }
    // Track the last user interaction so the hide-timer can be reset even
    // when `hideControls` stays the same (e.g. repeated key presses while
    // controls are already visible).
    val lastInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

    val showAudioDialog = remember { mutableStateOf(false) }
    val showSubDialog = remember { mutableStateOf(false) }

    val interactionSource = remember { MutableInteractionSource() }

    BackHandler(
        enabled = !hideControls
    ) {
        hideControls = true
    }

    // Update position every 500ms
    LaunchedEffect(exoPlayer) {
        while (true) {
            PlaybackState.position.longValue = exoPlayer.currentPosition
            PlaybackState.duration.longValue = exoPlayer.duration.takeIf { it > 0 } ?: 1L
            PlaybackState.isPlaying.value = exoPlayer.isPlaying
            delay(500)
        }
    }

    // Restart the hide timer whenever `lastInteraction` changes.
    LaunchedEffect(lastInteraction.longValue) {
        delay(5.seconds)
        hideControls = true
    }

    val bottomControlFocusRequester = remember { FocusRequester() }

    fun updateLastInteraction() {
//        println("Key event")
        hideControls = false
        lastInteraction.longValue = System.currentTimeMillis()
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .focusable(enabled = false)
            .onFocusChanged { focusState ->
                if (focusState.hasFocus) {
                    bottomControlFocusRequester.requestFocus()
                }
            }
            .onKeyEvent { keyEvent: KeyEvent ->
                if (keyEvent.type != KeyEventType.KeyDown) return@onKeyEvent false
                // Show controls and reset the hide timer on any key press
                updateLastInteraction()
                return@onKeyEvent false
            }
            .clickable(
                indication = null,
                interactionSource = interactionSource,
            ) {
                hideControls = !hideControls
                if (!hideControls) lastInteraction.longValue = System.currentTimeMillis()
            },
        contentAlignment = Alignment.BottomCenter
    ) {
        AnimatedVisibility(
            visible = !hideControls,
            enter = fadeIn(),
            exit = fadeOut(),
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxWidth()
            ) {
                // Progress Bar
                ProgressBar(exoPlayer, bottomControlFocusRequester, ::updateLastInteraction)
                Row(
                    horizontalArrangement = Arrangement.Center,
                    verticalAlignment = Alignment.CenterVertically,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                ) {
                    Row(
                        modifier = Modifier.weight(1f),
                        horizontalArrangement = Arrangement.Start,
                    ) {

                    }
                    PlaybackButtons(exoPlayer, bottomControlFocusRequester)
                    RightButtons(showAudioDialog, showSubDialog)
                }
            }
        }
    }

    val audioTracks = listOf(
        AudioEntry(
            displayName = "English",
            language = "en"
        ),
        AudioEntry(
            displayName = "Commentary",
            language = "en"
        ),
    )

    if (showAudioDialog.value) {
        AudioPicker(
            audioTracks = audioTracks,
            current = audioTracks[selectedAudioIndex],
            player = exoPlayer,
            trackSelector = trackSelector,
            onSelected = {
                selectedAudioIndex = audioTracks.indexOf(it)
            },
            onDismissRequest = {
                showAudioDialog.value = false
            }
        )
    }

    val subTracks = listOf(
        SubtitleTrack(
            displayName = "English",
            language = "en",
            isExternal = false
        ),
        SubtitleTrack(
            displayName = "Dutch",
            language = "nl",
            isExternal = true,
            url = "https:sdlfksjdfkl"
        ),
    )

    if (showSubDialog.value) {
        SubtitlePicker(
            subtitles = subTracks,
            current = subTracks[selectedSubIndex],
            player = exoPlayer,
            trackSelector = trackSelector,
            onSelected = { track ->
                selectedSubIndex = subTracks.indexOf(track)
            },
            onDismissRequest = {
                showSubDialog.value = false
            }
        )
    }
}

// Control Buttons
@Composable
fun PlaybackButtons(
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
) {

    val interactionSource by remember { mutableStateOf(MutableInteractionSource()) }
    val isPlaying by PlaybackState.isPlaying
    Row(
        modifier = Modifier
            .background(
                color = Color.Black.copy(alpha = 0.5f),
                shape = RoundedCornerShape(
                    corner = CornerSize(32.dp)
                )
            )
            .padding(horizontal = 4.dp, vertical = 6.dp)
            .wrapContentWidth(),
        horizontalArrangement = Arrangement.spacedBy(
            8.dp,
            alignment = Alignment.CenterHorizontally
        ),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        IconButton(
            onClick = { player.seekBack() },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Filled.ArrowLeft,
                contentDescription = "Back",
                tint = Color.White
            )
        }
        IconButton(
            modifier = Modifier
                .focusRequester(bottomControlFocusRequester)
                .highlightOnFocus(
                    color = Color.Black.copy(alpha = 0.85f)
                )
                .background(
                    color = Color.White.copy(alpha = 0.8f),
                    shape = CircleShape,
                )
                .defaultSelected(true),
            onClick = {
                if (player.isPlaying) player.pause() else player.play()
                PlaybackState.isPlaying.value = player.isPlaying
            },
            interactionSource = interactionSource
        ) {
            Icon(
                if (isPlaying) Iconsax.Filled.Pause else Iconsax.Filled.Play,
                contentDescription = if (isPlaying) "Pause" else "Play",
                tint = Color.Black,
            )
        }
        IconButton(onClick = { player.seekForward() }) {
            Icon(
                Iconsax.Filled.ArrowRight1,
                contentDescription = "Forward",
                tint = Color.White
            )
        }
    }
}

@Composable
internal fun RowScope.RightButtons(
    showAudioDialog: MutableState<Boolean>,
    showSubDialog: MutableState<Boolean>
) {
    Row(
        modifier = Modifier.weight(1f),
        horizontalArrangement = Arrangement.End
    ) {
        IconButton(onClick = {
            showAudioDialog.value = true
        }) {
            Icon(
                Iconsax.Filled.AudioSquare,
                contentDescription = "Audio Track",
                tint = Color.White
            )
        }
        IconButton(onClick = {
            showSubDialog.value = true
        }) {
            Icon(
                Iconsax.Filled.Subtitle,
                contentDescription = "Subtitles",
                tint = Color.White
            )
        }
    }
}
