package nl.jknaapen.fladder.composables.controls

import MediaSegment
import MediaSegmentType
import androidx.compose.foundation.background
import androidx.compose.foundation.focusable
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.FocusState
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.Key.Companion.DirectionLeft
import androidx.compose.ui.input.key.Key.Companion.DirectionRight
import androidx.compose.ui.input.key.Key.Companion.Enter
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerHost
import nl.jknaapen.fladder.utility.formatTime
import kotlin.math.max
import kotlin.math.min
import kotlin.time.Duration
import kotlin.time.Duration.Companion.milliseconds
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@Composable
internal fun ProgressBar(
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit = {}
) {
    val position by VideoPlayerHost.position.collectAsState(0L)
    val duration by VideoPlayerHost.duration.collectAsState(0L)
    Row(
        horizontalArrangement = Arrangement.spacedBy(
            8.dp,
            alignment = Alignment.CenterHorizontally
        ),
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(
            formatTime(position),
            color = Color.White,
            style = MaterialTheme.typography.labelMedium
        )
        SimpleProgressBar(player, bottomControlFocusRequester, onUserInteraction)
        Text(
            "-" + formatTime(duration - position),
            color = Color.White,
            style = MaterialTheme.typography.labelMedium
        )
    }
}

@Composable
internal fun RowScope.SimpleProgressBar(
    player: ExoPlayer,
    playFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit,
) {
    val playbackData by VideoPlayerHost.implementation.playbackData.collectAsState()

    var width by remember { mutableIntStateOf(0) }
    val position by VideoPlayerHost.position.collectAsState(0L)
    val duration by VideoPlayerHost.duration.collectAsState(0L)
    val slideBarShape = RoundedCornerShape(size = 8.dp)
    val progress = position.toFloat() / duration.toFloat()


    var pausedByScrub by remember { mutableStateOf(false) }
    var thumbFocused by remember { mutableStateOf(false) }

    Box(
        modifier = Modifier
            .weight(1f)
            .onGloballyPositioned(
                onGloballyPositioned = {
                    width = it.size.width
                }
            )
            .heightIn(min = 26.dp)
            .pointerInput(Unit) {
                detectTapGestures { offset ->
                    onUserInteraction()
                    val clickRelativeOffset = offset.x / width.toFloat()
                    val newPosition = duration.milliseconds * clickRelativeOffset.toDouble()
                    player.seekTo(newPosition.toLong(DurationUnit.MILLISECONDS))
                }
            },
        contentAlignment = Alignment.CenterStart,
    ) {
        Box(
            modifier = Modifier
                .focusable(enabled = false)
                .fillMaxWidth()
                .height(8.dp)
                .background(
                    color = Color.Black.copy(alpha = 0.15f),
                    shape = slideBarShape
                ),
        ) {
            Box(
                modifier = Modifier
                    .focusable(enabled = false)
                    .fillMaxWidth(progress)
                    .padding(end = 8.dp)
                    .height(8.dp)
                    .background(
                        color = Color.White.copy(alpha = 0.75f),
                        shape = slideBarShape
                    )
            )

            val density = LocalDensity.current

            val mediaSegments = playbackData?.segments
            if (width > 0 && duration.toDuration(DurationUnit.MILLISECONDS) > Duration.ZERO) {
                mediaSegments?.forEach { segment ->
                    val segStartMs = max(
                        0.0,
                        segment.start.toDuration(DurationUnit.MILLISECONDS)
                            .toDouble(DurationUnit.MILLISECONDS)
                    )
                    val segEndMs = max(
                        segStartMs,
                        segment.end.toDuration(DurationUnit.MILLISECONDS)
                            .toDouble(DurationUnit.MILLISECONDS)
                    )
                    val durMs = duration.toDouble().coerceAtLeast(1.0)

                    if (segStartMs >= durMs) return@forEach

                    val startPx = (width * (segStartMs / durMs)).toFloat()
                    val segPx =
                        (width * ((segEndMs - segStartMs) / durMs)).toFloat().coerceAtLeast(1f)

                    val segDp = with(density) { segPx.toDp() }
                    Box(
                        modifier = Modifier
                            .focusable(enabled = false)
                            .graphicsLayer {
                                translationX = startPx
                                translationY = 16.dp.toPx()
                            }
                            .width(segDp)
                            .height(6.dp)
                            .background(
                                color = segment.color.copy(alpha = 0.75f),
                                shape = RoundedCornerShape(8.dp)
                            )
                    )
                }
            }

            //Generate chapter dots
            val chapters = playbackData?.chapters ?: listOf()
            chapters.forEach { chapter ->
                val chapterDuration = chapter.time.toDuration(DurationUnit.SECONDS)
                    .toDouble(DurationUnit.SECONDS)
                val isAfterCurrentPositon = chapterDuration > position.toDouble()
                val segStartMs = max(
                    0.0,
                    chapterDuration
                )

                val durMs = duration.toDouble().coerceAtLeast(1.0)
                val startPx = (width * (segStartMs / durMs)).toFloat()

                Box(
                    modifier = Modifier
                        .focusable(enabled = false)
                        .graphicsLayer {
                            translationX = startPx
                            translationY = 1f
                        }
                        .size(7.dp)
                        .background(
                            color = (if (isAfterCurrentPositon) Color.White else Color.Black).copy(
                                alpha = 0.75f
                            ),
                            shape = CircleShape
                        )
                )
            }
        }

        //Thumb
        Box(
            modifier = Modifier
                .onFocusChanged { state: FocusState ->
                    thumbFocused = state.isFocused
                }
                .focusable(enabled = true)
                .onKeyEvent { keyEvent: KeyEvent ->
                    if (keyEvent.type != KeyEventType.KeyDown) return@onKeyEvent false

                    onUserInteraction()

                    when (keyEvent.key) {
                        Key.DirectionDown -> {
                            playFocusRequester.requestFocus()
                            true
                        }

                        DirectionLeft -> {
                            // Pause player if playing and mark pausedByScrub
                            if (player.isPlaying) {
                                pausedByScrub = true
                                player.pause()
                            }
                            // step back 1 second
                            val newPos = max(0L, player.currentPosition - 1000L)
                            player.seekTo(newPos)
                            true
                        }

                        DirectionRight -> {
                            if (player.isPlaying) {
                                pausedByScrub = true
                                player.pause()
                            }
                            val newPos = min(player.duration.takeIf { it > 0 } ?: 1L,
                                player.currentPosition + 1000L)
                            player.seekTo(newPos)
                            true
                        }

                        Enter, Key(13), Key.Spacebar -> {
                            if (pausedByScrub) {
                                player.play()
                                pausedByScrub = false
                                true
                            } else false
                        }

                        else -> false
                    }
                }
                .graphicsLayer {
                    translationX = (width * progress) - 4.dp.toPx()
                }
                .background(
                    color = Color.White,
                    shape = CircleShape,
                )
                .width(8.dp)
                .height(if (thumbFocused) 21.dp else 8.dp)
        )
    }
}

val MediaSegment.color: Color
    get() = when (this.type) {
        MediaSegmentType.COMMERCIAL -> Color.Magenta
        MediaSegmentType.PREVIEW -> Color(255, 128, 0)
        MediaSegmentType.RECAP -> Color(135, 206, 250)
        MediaSegmentType.OUTRO -> Color.Yellow
        MediaSegmentType.INTRO -> Color.Green
    }
