package nl.jknaapen.fladder.composables.controls

import MediaSegment
import MediaSegmentType
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.foundation.background
import androidx.compose.foundation.focusable
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableLongStateOf
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
import androidx.compose.ui.input.key.Key.Companion.Back
import androidx.compose.ui.input.key.Key.Companion.ButtonSelect
import androidx.compose.ui.input.key.Key.Companion.DirectionCenter
import androidx.compose.ui.input.key.Key.Companion.DirectionLeft
import androidx.compose.ui.input.key.Key.Companion.DirectionRight
import androidx.compose.ui.input.key.Key.Companion.Enter
import androidx.compose.ui.input.key.Key.Companion.Escape
import androidx.compose.ui.input.key.Key.Companion.Spacebar
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.fastCoerceIn
import androidx.media3.exoplayer.ExoPlayer
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.formatTime
import kotlin.math.max
import kotlin.math.min
import kotlin.time.Duration
import kotlin.time.Duration.Companion.milliseconds
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@RequiresApi(Build.VERSION_CODES.O)
@Composable
internal fun ProgressBar(
    modifier: Modifier = Modifier,
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit = {}
) {
    val position by VideoPlayerObject.position.collectAsState(0L)
    val duration by VideoPlayerObject.duration.collectAsState(0L)

    var tempPosition by remember { mutableLongStateOf(position) }
    var scrubbingTimeLine by remember { mutableStateOf(false) }

    val playableData by VideoPlayerObject.implementation.playbackData.collectAsState(null)

    val currentPosition by remember {
        derivedStateOf {
            if (scrubbingTimeLine) {
                tempPosition
            } else {
                position
            }
        }
    }

    Column {
        val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState(null)
        if (scrubbingTimeLine)
            FilmstripTrickPlayOverlay(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(125.dp)
                    .padding(bottom = 32.dp)
                    .align(alignment = Alignment.CenterHorizontally),
                currentPosition = tempPosition.milliseconds,
                trickPlayModel = playbackData?.trickPlayModel
            )
        Row(
            horizontalArrangement = Arrangement.spacedBy(4.dp)
        ) {
            val subTitle = playableData?.subTitle
            subTitle?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.bodyLarge.copy(color = Color.White),
                )
            }
            VideoEndTime()
        }
        Row(
            horizontalArrangement = Arrangement.spacedBy(
                8.dp,
                alignment = Alignment.CenterHorizontally
            ),
            verticalAlignment = Alignment.CenterVertically,
            modifier = modifier.fillMaxWidth()
        ) {
            Text(
                formatTime(currentPosition),
                color = Color.White,
                style = MaterialTheme.typography.titleMedium
            )
            SimpleProgressBar(
                player,
                bottomControlFocusRequester,
                onUserInteraction,
                tempPosition,
                scrubbingTimeLine,
                onTempPosChanged = {
                    tempPosition = it
                },
                onScrubbingChanged = {
                    scrubbingTimeLine = it
                }
            )
            Text(
                "-" + formatTime(
                    (duration - currentPosition).fastCoerceIn(
                        minimumValue = 0L,
                        maximumValue = duration
                    )
                ),
                color = Color.White,
                style = MaterialTheme.typography.titleMedium
            )
        }
    }

}

@Composable
internal fun RowScope.SimpleProgressBar(
    player: ExoPlayer,
    playFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit,
    tempPosition: Long,
    scrubbingTimeLine: Boolean,
    onTempPosChanged: (Long) -> Unit = {},
    onScrubbingChanged: (Boolean) -> Unit = {}
) {
    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState()

    var width by remember { mutableIntStateOf(0) }
    val position by VideoPlayerObject.position.collectAsState(0L)
    val duration by VideoPlayerObject.duration.collectAsState(0L)

    val slideBarShape = RoundedCornerShape(size = 8.dp)

    var thumbFocused by remember { mutableStateOf(false) }

    var internalTempPosition by remember { mutableLongStateOf(0L) }

    val progress by remember(scrubbingTimeLine, tempPosition, position) {
        derivedStateOf {
            if (scrubbingTimeLine) {
                tempPosition.toFloat() / duration.toFloat()
            } else {
                position.toFloat() / duration.toFloat()
            }
        }
    }

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
            }
            .pointerInput(Unit) {
                detectDragGestures(
                    onDragStart = { offset ->
                        onScrubbingChanged(true)
                        onUserInteraction()
                        onTempPosChanged(player.currentPosition)
                    },
                    onDrag = { change, dragAmount ->
                        onUserInteraction()
                        change.consume()
                        val relative = change.position.x / size.width.toFloat()
                        internalTempPosition = (duration.milliseconds * relative.toDouble())
                            .toLong(DurationUnit.MILLISECONDS)
                        onTempPosChanged(
                            internalTempPosition
                        )
                    },
                    onDragEnd = {
                        onScrubbingChanged(false)
                        player.seekTo(internalTempPosition)
                    },
                    onDragCancel = {
                        onScrubbingChanged(false)
                    }
                )
            },
        contentAlignment = Alignment.CenterStart,
    ) {
        Box(
            modifier = Modifier
                .focusable(enabled = false)
                .fillMaxWidth()
                .height(8.dp)
                .background(
                    color = Color.Black.copy(
                        alpha = 0.15f
                    ),
                    shape = slideBarShape
                ),
        ) {
            Box(
                modifier = Modifier
                    .focusable(enabled = false)
                    .fillMaxHeight()
                    .fillMaxWidth(progress)
                    .padding(end = 8.dp)
                    .background(
                        color = if (thumbFocused) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.primary.copy(
                            alpha = 0.75f
                        ),
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
                        .align(Alignment.CenterStart)
                        .padding(horizontal = 2.dp)
                        .focusable(enabled = false)
                        .graphicsLayer {
                            translationX = startPx
                        }
                        .padding(vertical = 0.5.dp)
                        .fillMaxHeight()
                        .aspectRatio(ratio = 1f)
                        .background(
                            color = if (isAfterCurrentPositon) Color.White.copy(
                                alpha = 0.5f
                            ) else MaterialTheme.colorScheme.onPrimary.copy(alpha = 0.7f),
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
                    if (!state.isFocused) {
                        onScrubbingChanged(false)
                    } else {
                        onTempPosChanged(position)
                    }
                }
                .focusable(enabled = true)
                .onKeyEvent { keyEvent: KeyEvent ->
                    if (keyEvent.type != KeyEventType.KeyDown) return@onKeyEvent false

                    onUserInteraction()

                    when (keyEvent.key) {
                        Key.DirectionDown -> {
                            playFocusRequester.requestFocus()
                            onScrubbingChanged(false)
                            true
                        }

                        DirectionLeft -> {
                            if (!scrubbingTimeLine) {
                                onTempPosChanged(position)
                                onScrubbingChanged(true)
                                player.pause()
                            }
                            val newPos = max(0L, tempPosition - 3000L)
                            onTempPosChanged(newPos)
                            true
                        }

                        DirectionRight -> {
                            if (!scrubbingTimeLine) {
                                onTempPosChanged(position)
                                onScrubbingChanged(true)
                                player.pause()
                            }
                            val newPos = min(player.duration.takeIf { it > 0 } ?: 1L,
                                tempPosition + 3000L)
                            onTempPosChanged(newPos)
                            true
                        }

                        Enter, Spacebar, ButtonSelect, DirectionCenter -> {
                            if (scrubbingTimeLine) {
                                player.seekTo(tempPosition)
                                player.play()
                                onScrubbingChanged(false)
                                true
                            } else false
                        }

                        Escape, Back -> {
                            if (scrubbingTimeLine) {
                                onScrubbingChanged(false)
                                player.play()
                                true
                            }
                            false
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
