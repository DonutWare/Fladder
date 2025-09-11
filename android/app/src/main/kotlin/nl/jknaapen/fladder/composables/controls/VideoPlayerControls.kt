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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.collectAsState
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
import io.github.rabehx.iconsax.filled.Pause
import io.github.rabehx.iconsax.filled.Play
import io.github.rabehx.iconsax.outline.ArrowLeft1
import io.github.rabehx.iconsax.outline.ArrowRight4
import io.github.rabehx.iconsax.outline.AudioSquare
import io.github.rabehx.iconsax.outline.Backward
import io.github.rabehx.iconsax.outline.Check
import io.github.rabehx.iconsax.outline.Forward
import io.github.rabehx.iconsax.outline.Subtitle
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.composables.dialogs.AudioPicker
import nl.jknaapen.fladder.composables.dialogs.ChapterSelectionSheet
import nl.jknaapen.fladder.composables.dialogs.SubtitlePicker
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.utility.ImmersiveSystemBars
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.highlightOnFocus
import kotlin.time.Duration.Companion.seconds

object PlaybackState {
    var selectedSubIndex = mutableIntStateOf(0)
    var selectedAudioIndex = mutableIntStateOf(1)
}

@OptIn(UnstableApi::class)
@Composable
fun CustomVideoControls(
    exoPlayer: ExoPlayer,
    trackSelector: DefaultTrackSelector,
) {

    var hideControls by remember { mutableStateOf(false) }
    val lastInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

    val showAudioDialog = remember { mutableStateOf(false) }
    val showSubDialog = remember { mutableStateOf(false) }
    var showChapterDialog by remember { mutableStateOf(false) }

    val interactionSource = remember { MutableInteractionSource() }

    ImmersiveSystemBars(isImmersive = hideControls)

    BackHandler(
        enabled = !hideControls
    ) {
        hideControls = true
    }

    // Restart the hide timer whenever `lastInteraction` changes.
    LaunchedEffect(lastInteraction.longValue) {
        delay(5.seconds)
        hideControls = true
    }

    val bottomControlFocusRequester = remember { FocusRequester() }

    fun updateLastInteraction() {
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
                    LeftButtons(
                        openChapterSelection = {
                            showChapterDialog = true
                        }
                    )
                    PlaybackButtons(exoPlayer, bottomControlFocusRequester)
                    RightButtons(showAudioDialog, showSubDialog)
                }
            }
        }
    }

    if (showAudioDialog.value) {
        AudioPicker(
            player = exoPlayer,
            onDismissRequest = {
                showAudioDialog.value = false
            }
        )
    }

    if (showSubDialog.value) {
        SubtitlePicker(
            player = exoPlayer,
            onDismissRequest = {
                showSubDialog.value = false
            }
        )
    }

    if (showChapterDialog) {
        ChapterSelectionSheet(
            onSelected = {
                exoPlayer.seekTo(it.time)
                showChapterDialog = false
            },
            onDismiss = {
                showChapterDialog = false
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
    val state by VideoPlayerHost.videoPlayerState.collectAsState(null)
    val isPlaying = state?.playing ?: false
    Row(
        modifier = Modifier
            .background(
                color = Color.Black.copy(alpha = 0.1f),
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
            onClick = { VideoPlayerHost.videoPlayerControls?.loadPreviousVideo {} },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.Backward,
                modifier = Modifier.size(32.dp),
                contentDescription = "Previous Video",
                tint = Color.White
            )
        }
        IconButton(
            onClick = { player.seekBack() },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.ArrowLeft1,
                modifier = Modifier.size(32.dp),
                contentDescription = "Back",
                tint = Color.White
            )
        }
        val playButtonShape = RoundedCornerShape(16.dp)
        IconButton(
            modifier = Modifier
                .size(54.dp)
                .focusRequester(bottomControlFocusRequester)
                .highlightOnFocus(
                    width = 4.dp,
                    color = Color.Black.copy(alpha = 0.85f),
                    shape = playButtonShape
                )
                .background(
                    color = Color.White.copy(alpha = 0.8f),
                    shape = playButtonShape,
                )
                .defaultSelected(true),
            onClick = {
                if (player.isPlaying) player.pause() else player.play()
            },
            interactionSource = interactionSource
        ) {
            Icon(
                if (isPlaying) Iconsax.Filled.Pause else Iconsax.Filled.Play,
                modifier = Modifier.size(40.dp),
                contentDescription = if (isPlaying) "Pause" else "Play",
                tint = Color.Black,

                )
        }
        IconButton(
            onClick = { player.seekForward() },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.ArrowRight4,
                contentDescription = "Forward",
                modifier = Modifier.size(32.dp),

                tint = Color.White
            )
        }

        IconButton(
            onClick = { VideoPlayerHost.videoPlayerControls?.loadNextVideo {} },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.Forward,
                modifier = Modifier.size(32.dp),
                contentDescription = "Next video",
                tint = Color.White
            )
        }
    }
}

@Composable
internal fun RowScope.LeftButtons(
    openChapterSelection: () -> Unit,
) {
    Row(
        modifier = Modifier.weight(1f),
        horizontalArrangement = Arrangement.Start
    ) {
        IconButton(
            onClick = openChapterSelection,
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.Check,
                contentDescription = "Show chapters",
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
        IconButton(
            onClick = {
                showAudioDialog.value = true
            },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.AudioSquare,
                contentDescription = "Audio Track",
                tint = Color.White
            )
        }
        IconButton(
            onClick = {
                showSubDialog.value = true
            },
            modifier = Modifier.highlightOnFocus()
        ) {
            Icon(
                Iconsax.Outline.Subtitle,
                contentDescription = "Subtitles",
                tint = Color.White
            )
        }
    }
}
