package nl.jknaapen.fladder.composables.controls

import androidx.activity.compose.BackHandler
import androidx.activity.compose.LocalActivity
import androidx.annotation.OptIn
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
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
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
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.key
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.AudioSquare
import io.github.rabehx.iconsax.filled.Backward
import io.github.rabehx.iconsax.filled.Check
import io.github.rabehx.iconsax.filled.Flash
import io.github.rabehx.iconsax.filled.Forward
import io.github.rabehx.iconsax.filled.Pause
import io.github.rabehx.iconsax.filled.Play
import io.github.rabehx.iconsax.filled.SliderVertical
import io.github.rabehx.iconsax.filled.Subtitle
import io.github.rabehx.iconsax.outline.CloseSquare
import io.github.rabehx.iconsax.outline.Refresh
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.compose
import nl.jknaapen.fladder.VideoPlayerScreen
import nl.jknaapen.fladder.composables.dialogs.AudioPicker
import nl.jknaapen.fladder.composables.dialogs.ChapterSelectionSheet
import nl.jknaapen.fladder.composables.dialogs.PlaybackSpeedPicker
import nl.jknaapen.fladder.composables.dialogs.SubtitlePicker
import nl.jknaapen.fladder.composables.shared.CurrentTime
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.ImmersiveSystemBars
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.keyEvent
import nl.jknaapen.fladder.utility.leanBackEnabled
import nl.jknaapen.fladder.utility.visible
import kotlin.time.Duration.Companion.milliseconds
import kotlin.time.Duration.Companion.seconds


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
    var showSpeedDialog by remember { mutableStateOf(false) }

    val interactionSource = remember { MutableInteractionSource() }

    val isTVMode by VideoPlayerObject.implementation.isTVMode.collectAsState(false)

    val activity = LocalActivity.current

    val buffering by VideoPlayerObject.buffering.collectAsState(true)
    val playing by VideoPlayerObject.playing.collectAsState(false)
    val controlsPadding = 32.dp

    ImmersiveSystemBars(isImmersive = !showControls)

    val bottomControlFocusRequester = remember { FocusRequester() }

    fun hideControls() {
        showControls = false
        bottomControlFocusRequester.requestFocus()
    }

    BackHandler(
        enabled = true
    ) {
        if (showControls) {
            hideControls()
        } else {
            activity?.finish()
        }
    }

    // Restart the hide timer whenever `lastInteraction` changes.
    LaunchedEffect(lastInteraction.longValue) {
        delay(5.seconds)
        hideControls()
    }

    fun updateLastInteraction() {
        showControls = true
        lastInteraction.longValue = System.currentTimeMillis()
    }

    val forwardSpeed by PlayerSettingsObject.forwardSpeed.collectAsState(30.seconds)
    val backwardSpeed by PlayerSettingsObject.backwardSpeed.collectAsState(15.seconds)

    val position by VideoPlayerObject.position.collectAsState(0L)
    val player = VideoPlayerObject.implementation.player
    val lastSeekInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

    var currentSkipTime by remember { mutableLongStateOf(0L) }

    // Restart the multiplier
    LaunchedEffect(lastSeekInteraction.longValue) {
        delay(1.seconds)
        if (currentSkipTime == 0L) return@LaunchedEffect
        player?.seekTo(position + currentSkipTime)
        currentSkipTime = 0L
    }

    fun updateSeekInteraction() {
        lastSeekInteraction.longValue = System.currentTimeMillis()
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
            .keyEvent { keyEvent: KeyEvent ->
                when (keyEvent.key) {
                    Key.MediaStop, Key.X -> {
                        activity?.finish()
                        return@keyEvent true
                    }

                    Key.MediaPlay -> {
                        player?.play()
                        return@keyEvent true
                    }

                    Key.MediaPlayPause -> {
                        player?.let {
                            if (it.isPlaying) {
                                it.pause()
                                updateLastInteraction()
                            } else {
                                it.play()
                            }
                        }
                        return@keyEvent true

                    }

                    Key.MediaPause, Key.P -> {
                        player?.pause()
                        updateLastInteraction()
                        return@keyEvent true
                    }

                    Key.Back, Key.Escape, Key.ButtonB, Key.Backspace -> {
                        if (showControls) {
                            hideControls()
                            return@keyEvent true
                        } else {
                            activity?.finish()
                            return@keyEvent true
                        }
                    }
                }

                if (!showControls && !isTVMode) {
                    when (keyEvent.key) {
                        Key.DirectionLeft -> {
                            currentSkipTime -= backwardSpeed.inWholeMilliseconds
                            updateSeekInteraction()
                            return@keyEvent true
                        }

                        Key.DirectionRight -> {
                            currentSkipTime += forwardSpeed.inWholeMilliseconds
                            updateSeekInteraction()
                            return@keyEvent true
                        }
                    }
                    bottomControlFocusRequester.requestFocus()
                    updateLastInteraction()
                    return@keyEvent true
                } else {
                    updateLastInteraction()
                    return@keyEvent false
                }
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
                                    Color.Black.copy(alpha = 0.90f),
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
                        modifier = Modifier
                            .padding(controlsPadding)
                            .weight(1f),
                    ) {
                        Row(
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically,
                        ) {
                            val state by VideoPlayerObject.implementation.playbackData.collectAsState(
                                null
                            )
                            state?.let {
                                ItemHeader(
                                    modifier = Modifier
                                        .weight(1f),
                                    it
                                )
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
                                            .size(42.dp)
                                            .focusable(false),
                                        contentDescription = "Close icon",
                                        tint = Color.White,
                                    )
                                }
                            } else {
                                CurrentTime()
                            }
                        }
                    }
                }
                Spacer(modifier = Modifier.weight(1f))
                // Progress Bar
                Column(
                    modifier = Modifier
                        .background(
                            brush = Brush.linearGradient(
                                colors = listOf(
                                    Color.Black.copy(alpha = 0f),
                                    Color.Black.copy(alpha = 0.9f),
                                ),
                                start = Offset(0f, 0f),
                                end = Offset(0f, Float.POSITIVE_INFINITY)
                            ),
                        )
                        .padding(horizontal = controlsPadding)
                        .displayCutoutPadding()
                        .padding(top = 8.dp, bottom = controlsPadding)
                ) {
                    ProgressBar(
                        modifier = Modifier,
                        exoPlayer, bottomControlFocusRequester, ::updateLastInteraction
                    )
                    Row(
                        horizontalArrangement = Arrangement.Center,
                        verticalAlignment = Alignment.CenterVertically,
                        modifier = Modifier
                            .fillMaxWidth()
                    ) {
                        LeftButtons(
                            openChapterSelection = {
                                showChapterDialog = true
                            },
                            openPlaybackSpeedPicker = {
                                showSpeedDialog = true
                            }
                        )
                        PlaybackButtons(exoPlayer, bottomControlFocusRequester) {
                            updateLastInteraction()
                        }
                        RightButtons(showAudioDialog, showSubDialog)
                    }
                }
            }
        }
        SegmentSkipOverlay()
        SeekOverlay(value = currentSkipTime)
        if (buffering && !playing) {
            CircularProgressIndicator(
                modifier = Modifier
                    .align(alignment = Alignment.Center)
                    .size(64.dp),
                strokeCap = StrokeCap.Round,
                strokeWidth = 10.dp
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

    if (showSpeedDialog) {
        PlaybackSpeedPicker(
            player = exoPlayer,
            onDismissRequest = {
                showSpeedDialog = false
            }
        )
    }
}

// Control Buttons
@Composable
fun PlaybackButtons(
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
    onPause: () -> Unit,
) {
    val state by VideoPlayerObject.videoPlayerState.collectAsState(null)

    val forwardSpeed by PlayerSettingsObject.forwardSpeed.collectAsState(30.seconds)
    val backwardSpeed by PlayerSettingsObject.backwardSpeed.collectAsState(15.seconds)

    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState(null)
    val nextVideo = playbackData?.nextVideo
    val previousVideo = playbackData?.previousVideo

    val isPlaying = state?.playing ?: false

    val isTVMode by VideoPlayerObject.implementation.isTVMode.collectAsState(false)

    Row(
        modifier = Modifier
            .padding(horizontal = 4.dp, vertical = 6.dp)
            .wrapContentWidth(),
        horizontalArrangement = Arrangement.spacedBy(
            12.dp,
            alignment = Alignment.CenterHorizontally
        ),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        if (!isTVMode) {
            CustomButton(
                onClick = { VideoPlayerObject.videoPlayerControls?.loadPreviousVideo {} },
                enabled = previousVideo != null,
            ) {
                Icon(
                    Iconsax.Filled.Backward,
                    contentDescription = previousVideo?.title,
                )
            }
            CustomButton(
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
                        modifier = Modifier.size(42.dp),
                        contentDescription = "Backwards",
                    )
                    Text(
                        "-${backwardSpeed.inWholeSeconds}",
                        style = MaterialTheme.typography.bodySmall
                    )
                }
            }
        }
        CustomButton(
            modifier = Modifier
                .focusRequester(bottomControlFocusRequester)
                .defaultSelected(true),
            enableScaledFocus = true,
            onClick = {
                if (player.isPlaying) {
                    player.pause()
                    onPause()
                } else {
                    player.play()
                }
            },
        ) {
            Icon(
                if (isPlaying) Iconsax.Filled.Pause else Iconsax.Filled.Play,
                modifier = Modifier.size(45.dp),
                contentDescription = if (isPlaying) "Pause" else "Play",
            )
        }
        if (!isTVMode) {
            CustomButton(
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
                            .size(42.dp)
                            .scale(scaleX = -1f, scaleY = 1f),
                    )
                    Text(
                        forwardSpeed.inWholeSeconds.toString(),
                        style = MaterialTheme.typography.bodySmall
                    )
                }
            }

            CustomButton(
                onClick = { VideoPlayerObject.videoPlayerControls?.loadNextVideo {} },
                enabled = nextVideo != null,
            ) {
                Icon(
                    Iconsax.Filled.Forward,
                    contentDescription = nextVideo?.title,
                )
            }
        }
    }
}

@Composable
internal fun RowScope.LeftButtons(
    openChapterSelection: () -> Unit,
    openPlaybackSpeedPicker: () -> Unit,
) {
    val chapters by VideoPlayerObject.chapters.collectAsState(emptyList())
    val isTVMode by VideoPlayerObject.implementation.isTVMode.collectAsState(false)


    Row(
        modifier = Modifier.weight(1f),
        horizontalArrangement = Arrangement.spacedBy(12.dp, alignment = Alignment.Start)
    ) {
        if (!isTVMode) {
            CustomButton(
                onClick = openChapterSelection,
                enabled = chapters?.isNotEmpty() == true
            ) {
                Icon(
                    Iconsax.Filled.Check,
                    contentDescription = "Show chapters",
                )
            }

            CustomButton(
                onClick = openPlaybackSpeedPicker,
                enabled = true
            ) {
                Icon(
                    Iconsax.Filled.Flash,
                    contentDescription = "Playback Speed",
                )
            }
        }
    }
}

@Composable
internal fun RowScope.RightButtons(
    showAudioDialog: MutableState<Boolean>,
    showSubDialog: MutableState<Boolean>
) {
    val hasSubtitles by VideoPlayerObject.hasSubtracks.collectAsState(false)
    val hasAudioTracks by VideoPlayerObject.hasAudioTracks.collectAsState(false)

    val isTVMode by VideoPlayerObject.implementation.isTVMode.collectAsState(false)

    Row(
        modifier = Modifier.weight(1f),
        horizontalArrangement = Arrangement.spacedBy(12.dp, alignment = Alignment.End)
    ) {
        if (isTVMode) {
            CustomButton(
                onClick = {
                    VideoPlayerObject.toggleGuideVisibility()
                },
            ) {
                Icon(
                    Iconsax.Filled.SliderVertical,
                    contentDescription = "TV Guide",
                )
            }
        } else {
            CustomButton(
                enabled = hasAudioTracks,
                onClick = {
                    showAudioDialog.value = true
                },
            ) {
                Icon(
                    Iconsax.Filled.AudioSquare,
                    contentDescription = "Audio Track",
                )
            }
            CustomButton(
                enabled = hasSubtitles,
                onClick = {
                    showSubDialog.value = true
                },
            ) {
                Icon(
                    Iconsax.Filled.Subtitle,
                    contentDescription = "Subtitles",
                )
            }
        }
    }
}
