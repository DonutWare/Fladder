package nl.jknaapen.fladder.composables.controls

import android.os.Build
import androidx.activity.compose.BackHandler
import androidx.activity.compose.LocalActivity
import androidx.annotation.OptIn
import androidx.annotation.RequiresApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.focusable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.displayCutoutPadding
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeContentPadding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.AudioSquare
import io.github.rabehx.iconsax.filled.Backward
import io.github.rabehx.iconsax.filled.Check
import io.github.rabehx.iconsax.filled.Forward
import io.github.rabehx.iconsax.filled.Pause
import io.github.rabehx.iconsax.filled.Play
import io.github.rabehx.iconsax.filled.Subtitle
import io.github.rabehx.iconsax.outline.CloseSquare
import io.github.rabehx.iconsax.outline.Refresh
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.composables.dialogs.AudioPicker
import nl.jknaapen.fladder.composables.dialogs.ChapterSelectionSheet
import nl.jknaapen.fladder.composables.dialogs.SubtitlePicker
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.ImmersiveSystemBars
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.leanBackEnabled
import nl.jknaapen.fladder.utility.visible
import kotlin.time.Duration.Companion.seconds


@RequiresApi(Build.VERSION_CODES.O)
@OptIn(UnstableApi::class)
@Composable
fun CustomVideoControls(
    exoPlayer: ExoPlayer,
) {
    var showControls by remember { mutableStateOf(false) }
    val lastInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

    val showAudioDialog = remember { mutableStateOf(false) }
    val showSubDialog = remember { mutableStateOf(false) }
    var showChapterDialog by remember { mutableStateOf(false) }

    val interactionSource = remember { MutableInteractionSource() }

    val activity = LocalActivity.current

    val buffering by VideoPlayerObject.buffering.collectAsState(true)
    val playing by VideoPlayerObject.playing.collectAsState(false)

    ImmersiveSystemBars(isImmersive = !showControls)

    BackHandler(
        enabled = showControls
    ) {
        showControls = false
    }

    // Restart the hide timer whenever `lastInteraction` changes.
    LaunchedEffect(lastInteraction.longValue) {
        delay(5.seconds)
        showControls = false
    }

    val bottomControlFocusRequester = remember { FocusRequester() }

    fun updateLastInteraction() {
        showControls = true
        lastInteraction.longValue = System.currentTimeMillis()
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .focusable(enabled = false)
            .onFocusChanged { focusState ->
                if (focusState.hasFocus) {
                    bottomControlFocusRequester.requestFocus()
                }
            }
            .onKeyEvent { keyEvent: KeyEvent ->
                if (keyEvent.type != KeyEventType.KeyDown) return@onKeyEvent false
                if (!showControls) {
                    bottomControlFocusRequester.requestFocus()
                }
                updateLastInteraction()
                return@onKeyEvent false
            }
            .clickable(
                indication = null,
                interactionSource = interactionSource,
            ) {
                showControls = !showControls
                if (showControls) lastInteraction.longValue = System.currentTimeMillis()
            },
        contentAlignment = Alignment.BottomCenter
    ) {
        Box(
            modifier = Modifier.visible(
                visible = showControls,
            )
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.SpaceBetween,
                modifier = Modifier
                    .fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .wrapContentHeight()
                        .background(
                            brush = Brush.linearGradient(
                                colors = listOf(
                                    Color.Black.copy(alpha = 0.85f),
                                    Color.Black.copy(alpha = 0f),
                                ),
                                start = Offset(0f, 0f),
                                end = Offset(0f, Float.POSITIVE_INFINITY)
                            ),
                        )
                        .safeContentPadding(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp, alignment = Alignment.Start)
                ) {
                    Column(
                        modifier = Modifier.weight(1f),
                    ) {
                        val state by VideoPlayerObject.implementation.playbackData.collectAsState(
                            null
                        )
                        state?.let {
                            ItemHeader(it)
                        }
                    }
                    if (!leanBackEnabled(LocalContext.current)) {
                        IconButton(
                            {
                                activity?.finish()
                            }
                        ) {
                            Icon(
                                Iconsax.Outline.CloseSquare,
                                modifier = Modifier
                                    .size(48.dp)
                                    .focusable(false),
                                contentDescription = "Close icon",
                                tint = Color.White,
                            )
                        }
                    }
                }
                Spacer(modifier = Modifier.weight(1f))
                // Progress Bar
                Column(
                    modifier = Modifier
                        .padding(horizontal = 16.dp)
                        .displayCutoutPadding(),
                ) {
                    ProgressBar(
                        modifier = Modifier,
                        exoPlayer, bottomControlFocusRequester, ::updateLastInteraction
                    )
                }
                Row(
                    horizontalArrangement = Arrangement.Center,
                    verticalAlignment = Alignment.CenterVertically,
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(
                            brush = Brush.linearGradient(
                                colors = listOf(
                                    Color.Black.copy(alpha = 0f),
                                    Color.Black.copy(alpha = 0.85f),
                                ),
                                start = Offset(0f, 0f),
                                end = Offset(0f, Float.POSITIVE_INFINITY)
                            ),
                        )
                        .displayCutoutPadding()
                        .padding(horizontal = 16.dp)
                        .padding(top = 8.dp, bottom = 16.dp)
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
        SegmentSkipOverlay()
        if (buffering && !playing) {
            CircularProgressIndicator(
                modifier = Modifier
                    .align(alignment = Alignment.Center)
            )
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
    val state by VideoPlayerObject.videoPlayerState.collectAsState(null)

    val forwardSpeed by PlayerSettingsObject.forwardSpeed.collectAsState(30.seconds)
    val backwardSpeed by PlayerSettingsObject.backwardSpeed.collectAsState(15.seconds)

    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState(null)
    val nextVideo = playbackData?.nextVideo
    val previousVideo = playbackData?.previousVideo

    val isPlaying = state?.playing ?: false

    Row(
        modifier = Modifier
            .padding(horizontal = 4.dp, vertical = 6.dp)
            .wrapContentWidth(),
        horizontalArrangement = Arrangement.spacedBy(
            8.dp,
            alignment = Alignment.CenterHorizontally
        ),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        CustomIconButton(
            onClick = { VideoPlayerObject.videoPlayerControls?.loadPreviousVideo {} },
            enabled = previousVideo != null,
        ) {
            Icon(
                Iconsax.Filled.Backward,
                modifier = Modifier.size(32.dp),
                contentDescription = previousVideo,
                tint = Color.White
            )
        }
        CustomIconButton(
            onClick = {
                player.seekTo(
                    player.currentPosition - backwardSpeed.inWholeMilliseconds
                )
            },
        ) {
            Box(
                modifier = Modifier
                    .wrapContentSize(),
                contentAlignment = Alignment.Center,
            ) {
                Icon(
                    Iconsax.Outline.Refresh,
                    contentDescription = "Forward",
                    modifier = Modifier
                        .size(48.dp),
                )
                Text("-${backwardSpeed.inWholeSeconds}")
            }
        }
        CustomIconButton(
            modifier = Modifier
                .focusRequester(bottomControlFocusRequester)
                .defaultSelected(true),
            enableScaledFocus = true,
            onClick = {
                if (player.isPlaying) player.pause() else player.play()
            },
        ) {
            Icon(
                if (isPlaying) Iconsax.Filled.Pause else Iconsax.Filled.Play,
                modifier = Modifier.size(55.dp),
                contentDescription = if (isPlaying) "Pause" else "Play",
            )
        }
        CustomIconButton(
            onClick = {
                player.seekTo(
                    player.currentPosition + forwardSpeed.inWholeMilliseconds
                )
            },
        ) {
            Box(
                modifier = Modifier
                    .wrapContentSize(),
                contentAlignment = Alignment.Center,
            ) {
                Icon(
                    Iconsax.Outline.Refresh,
                    contentDescription = "Forward",
                    modifier = Modifier
                        .size(48.dp)
                        .scale(scaleX = -1f, scaleY = 1f),
                )
                Text(forwardSpeed.inWholeSeconds.toString())
            }
        }

        CustomIconButton(
            onClick = { VideoPlayerObject.videoPlayerControls?.loadNextVideo {} },
            enabled = nextVideo != null,
        ) {
            Icon(
                Iconsax.Filled.Forward,
                modifier = Modifier.size(32.dp),
                contentDescription = nextVideo,
            )
        }
    }
}

@Composable
internal fun RowScope.LeftButtons(
    openChapterSelection: () -> Unit,
) {
    val chapters by VideoPlayerObject.chapters.collectAsState(emptyList())

    Row(
        modifier = Modifier.weight(1f),
        horizontalArrangement = Arrangement.Start
    ) {
        CustomIconButton(
            onClick = openChapterSelection,
            enabled = chapters?.isNotEmpty() == true
        ) {
            Icon(
                Iconsax.Filled.Check,
                modifier = Modifier.size(32.dp),
                contentDescription = "Show chapters",
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
        CustomIconButton(
            onClick = {
                showAudioDialog.value = true
            },
        ) {
            Icon(
                Iconsax.Filled.AudioSquare,
                modifier = Modifier.size(32.dp),
                contentDescription = "Audio Track",
            )
        }
        CustomIconButton(
            onClick = {
                showSubDialog.value = true
            },
        ) {
            Icon(
                Iconsax.Filled.Subtitle,
                modifier = Modifier.size(32.dp),
                contentDescription = "Subtitles",
            )
        }
    }
}
