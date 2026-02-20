package nl.jknaapen.fladder.composables.controls

import MediaSegment
import MediaSegmentType
import TVGuideModel
import android.os.Build
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateDpAsState
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
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
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
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.fastCoerceIn
import androidx.media3.exoplayer.ExoPlayer
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.capitalize
import nl.jknaapen.fladder.utility.formatTime
import nl.jknaapen.fladder.utility.measureTextWidth
import kotlin.math.max
import kotlin.math.min
import kotlin.time.Duration
import kotlin.time.Duration.Companion.milliseconds
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@Composable
internal fun ProgressBar(
    modifier: Modifier = Modifier,
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit = {}
) {
    val tvGuide by VideoPlayerObject.tvGuide.collectAsState(null)

    tvGuide?.let {
        TVProgressBar(
            modifier = modifier,
            player = player,
            tvGuide = it,
            bottomControlFocusRequester = bottomControlFocusRequester,
            onUserInteraction = onUserInteraction
        )
    } ?: run {
        StandardProgressBar(
            modifier = modifier,
            player = player,
            bottomControlFocusRequester = bottomControlFocusRequester,
            onUserInteraction = onUserInteraction
        )
    }
}

@Composable
internal fun TVProgressBar(
    modifier: Modifier = Modifier,
    player: ExoPlayer,
    tvGuide: TVGuideModel,
    bottomControlFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit = {}
) {
    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState(null)
    val currentProgram = tvGuide.currentProgram

    var displayDuration by remember { mutableLongStateOf(0L) }
    var displayPosition by remember { mutableLongStateOf(0L) }

    LaunchedEffect(currentProgram) {
        while (true) {
            if (currentProgram != null && player.isPlaying) {
                val now = System.currentTimeMillis()
                val start = currentProgram.startMs
                val end = currentProgram.endMs

                displayPosition = if (now < start) 0L else now - start
                displayDuration = end - start
            }
            delay(1000)
        }
    }

    fun calculatedDateFromLong(ms: Long): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val instant = java.time.Instant.ofEpochMilli(ms)
            val zoneId = java.time.ZoneId.systemDefault()
            java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME
                .withZone(zoneId)
                .format(instant)
        } else {
            val calendar = java.util.Calendar.getInstance()
            calendar.timeInMillis = ms
            val tz = calendar.timeZone
            val sdf = java.text.SimpleDateFormat(
                "yyyy-MM-dd'T'HH:mm:ssXXX",
                java.util.Locale.getDefault()
            )
            sdf.timeZone = tz
            sdf.format(calendar.time)
        }
    }

    Column(
        verticalArrangement = Arrangement.spacedBy(4.dp, alignment = Alignment.CenterVertically)
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            currentProgram?.let { program ->
                Translate(
                    { Localized.endsAt(calculatedDateFromLong(program.endMs), it) },
                    program.endMs
                ) { endDateString ->
                    val programLabel = listOf(
                        program.name,
                        endDateString
                    ).filterNot { it.isBlank() }.joinToString(separator = " - ")
                    if (programLabel.isNotBlank()) {
                        Text(
                            text = programLabel,
                            style = MaterialTheme.typography.titleMedium.copy(
                                color = Color.White,
                                fontWeight = FontWeight.Bold
                            ),
                            modifier = Modifier.weight(1f),
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    }
                }
            }
            VideoLabel(playbackData?.mediaInfo?.playbackType?.name?.capitalize)
            VideoLabel(playbackData?.mediaInfo?.videoInformation)
        }

        Row(
            horizontalArrangement = Arrangement.spacedBy(
                12.dp,
                alignment = Alignment.CenterHorizontally
            ),
            verticalAlignment = Alignment.CenterVertically,
            modifier = modifier.fillMaxWidth()
        ) {
            val timeTextStyle = MaterialTheme.typography.titleMedium.copy(
                fontWeight = FontWeight.Bold
            )

            val textWidth = measureTextWidth("-" + formatTime(displayDuration), timeTextStyle)

            Text(
                formatTime(displayPosition),
                color = Color.White,
                modifier = Modifier.widthIn(min = textWidth),
                textAlign = TextAlign.Start,
                maxLines = 1,
                style = timeTextStyle
            )
            SimpleProgressBar(
                player,
                bottomControlFocusRequester,
                onUserInteraction,
                0L,
                false,
                duration = displayDuration,
                position = displayPosition,
                onTempPosChanged = {
                },
                onScrubbingChanged = {
                }
            )
            Text(
                "-" + formatTime(
                    (displayDuration - displayPosition).fastCoerceIn(
                        minimumValue = 0L,
                        maximumValue = displayDuration
                    )
                ),
                color = Color.White,
                textAlign = TextAlign.End,
                modifier = Modifier.widthIn(min = textWidth),
                maxLines = 1,
                style = timeTextStyle
            )
        }
    }
}

@Composable
internal fun StandardProgressBar(
    modifier: Modifier = Modifier,
    player: ExoPlayer,
    bottomControlFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit = {}
) {
    val position by VideoPlayerObject.position.collectAsState(0L)
    val duration by VideoPlayerObject.duration.collectAsState(0L)

    val endTimeString by VideoPlayerObject.endTime.collectAsState(null)

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

    Column(
        verticalArrangement = Arrangement.spacedBy(4.dp, alignment = Alignment.CenterVertically)
    ) {
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
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Translate({ Localized.endsAt(endTimeString ?: "", it) }, endTimeString) { translation ->
                val progressBarTopLabel = listOf(
                    playableData?.currentItem?.subTitle,
                    translation,
                )

                val label = progressBarTopLabel.filterNot { it.isNullOrBlank() }
                    .joinToString(separator = " - ")
                if (label.isNotBlank()) {
                    Text(
                        text = label,
                        style = MaterialTheme.typography.titleMedium.copy(
                            color = Color.White,
                            fontWeight = FontWeight.Bold
                        ),
                        modifier = Modifier.weight(1f),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                }
            }

            VideoLabel(playableData?.mediaInfo?.playbackType?.name?.capitalize)
            VideoLabel(playableData?.mediaInfo?.videoInformation)
        }
        Row(
            horizontalArrangement = Arrangement.spacedBy(
                12.dp,
                alignment = Alignment.CenterHorizontally
            ),
            verticalAlignment = Alignment.CenterVertically,
            modifier = modifier.fillMaxWidth()
        ) {
            val timeTextStyle = MaterialTheme.typography.titleMedium.copy(
                fontWeight = FontWeight.Bold
            )

            //Calculate min width to stop resizing of progressbar
            val textWidth = measureTextWidth("-" + formatTime(duration), timeTextStyle)

            Text(
                formatTime(currentPosition),
                color = Color.White,
                modifier = Modifier.widthIn(min = textWidth),
                textAlign = TextAlign.Start,
                maxLines = 1,
                style = timeTextStyle
            )
            SimpleProgressBar(
                player,
                bottomControlFocusRequester,
                onUserInteraction,
                tempPosition,
                scrubbingTimeLine,
                duration = duration,
                position = position,
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
                textAlign = TextAlign.End,
                modifier = Modifier.widthIn(min = textWidth),
                maxLines = 1,
                style = timeTextStyle
            )
        }
    }
}

@Composable
private fun VideoLabel(value: String?) {
    if (value.isNullOrBlank()) return

    Box(
        modifier = Modifier
            .background(
                color = MaterialTheme.colorScheme.surfaceContainer,
                shape = RoundedCornerShape(8.dp)
            )
            .wrapContentSize()
            .padding(horizontal = 6.dp, vertical = 4.dp),
        contentAlignment = Alignment.Center
    ) {
        Text(
            value,
            style = MaterialTheme.typography.titleMedium.copy(
                fontWeight = FontWeight.SemiBold,
            ),
            color = MaterialTheme.colorScheme.onSurface
        )
    }
}

@Composable
internal fun RowScope.SimpleProgressBar(
    player: ExoPlayer,
    playFocusRequester: FocusRequester,
    onUserInteraction: () -> Unit,
    tempPosition: Long,
    scrubbingTimeLine: Boolean,
    duration: Long = 0L,
    position: Long = 0L,
    onTempPosChanged: (Long) -> Unit = {},
    onScrubbingChanged: (Boolean) -> Unit = {}
) {
    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState()

    var width by remember { mutableIntStateOf(0) }
    val playerPosition by VideoPlayerObject.position.collectAsState(0L)
    val playerDuration by VideoPlayerObject.duration.collectAsState(0L)

    val effectiveDuration = if (duration > 0L) duration else playerDuration
    val effectivePosition = if (position > 0L || duration > 0L) position else playerPosition

    val slideBarShape = RoundedCornerShape(size = 8.dp)

    var thumbFocused by remember { mutableStateOf(false) }

    var internalTempPosition by remember { mutableLongStateOf(0L) }

    val progress by remember(
        scrubbingTimeLine,
        tempPosition,
        effectivePosition,
        effectiveDuration
    ) {
        derivedStateOf {
            if (effectiveDuration <= 0L) return@derivedStateOf 0f
            if (scrubbingTimeLine) {
                tempPosition.toFloat() / effectiveDuration.toFloat()
            } else {
                effectivePosition.toFloat() / effectiveDuration.toFloat()
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
            .heightIn(min = 32.dp)
            .pointerInput(Unit) {
                detectTapGestures { offset ->
                    onUserInteraction()
                    val clickRelativeOffset = offset.x / width.toFloat()
                    val newPosition =
                        effectiveDuration.milliseconds * clickRelativeOffset.toDouble()
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
                        internalTempPosition =
                            (effectiveDuration.milliseconds * relative.toDouble())
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
                    color = Color.White.copy(
                        alpha = 0.15f
                    ),
                    shape = slideBarShape
                ),
        ) {

            val animatedBarColor by animateColorAsState(
                if (thumbFocused) MaterialTheme.colorScheme.primary else Color.White,
                label = "progressBarColor"
            )
            Box(
                modifier = Modifier
                    .focusable(enabled = false)
                    .fillMaxHeight()
                    .fillMaxWidth(progress)
                    .padding(end = 8.dp)
                    .background(
                        color = animatedBarColor,
                        shape = slideBarShape
                    )
            )

            val density = LocalDensity.current

            val mediaSegments = playbackData?.segments
            if (width > 0 && effectiveDuration.toDuration(DurationUnit.MILLISECONDS) > Duration.ZERO) {
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
                    val durMs = effectiveDuration.toDouble().coerceAtLeast(1.0)

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
                                translationY = 14.dp.toPx()
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
                val isAfterCurrentPositon = chapterDuration > effectivePosition.toDouble()
                val segStartMs = max(
                    0.0,
                    chapterDuration
                )

                val durMs = effectiveDuration.toDouble().coerceAtLeast(1.0)
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
                                alpha = 0.15f
                            ) else MaterialTheme.colorScheme.onPrimary.copy(alpha = 0.7f),
                            shape = CircleShape
                        )
                )
            }
        }

        val animatedThumbHeight by animateDpAsState(
            if (thumbFocused) 28.dp else 14.dp,
            label = "Thumb height"
        )


        var direction by remember { mutableIntStateOf(0) }
        var speed by remember { mutableLongStateOf(1L) }
        val scrubSpeedDivider = 15L

        val lastInteraction = remember { mutableLongStateOf(System.currentTimeMillis()) }

        // Restart the multiplier
        LaunchedEffect(lastInteraction.longValue) {
            delay(500.milliseconds)
            speed = 1L
        }

        fun updateLastInteraction() {
            lastInteraction.longValue = System.currentTimeMillis()
        }

        val scrubSpeed = playbackData?.trickPlayModel?.interval ?: 5.seconds.inWholeMilliseconds

        fun scrubSpeedResult(): Long {
            return (scrubSpeed * (speed / scrubSpeedDivider).coerceIn(
                1L..60.seconds.inWholeMilliseconds
            ))
        }

        //Thumb
        Box(
            modifier = Modifier
                .onFocusChanged { state: FocusState ->
                    thumbFocused = state.isFocused
                    if (!state.isFocused) {
                        onScrubbingChanged(false)
                    } else {
                        onTempPosChanged(effectivePosition)
                    }
                }
                .focusable(enabled = true)
                .onKeyEvent { keyEvent ->
                    if (keyEvent.type != KeyEventType.KeyDown) return@onKeyEvent false

                    onUserInteraction()

                    when (keyEvent.key) {
                        Key.DirectionDown -> {
                            playFocusRequester.requestFocus()
                            onScrubbingChanged(false)
                            true
                        }

                        DirectionLeft -> {
                            if (direction != -1) {
                                direction = -1
                                speed = 1L
                            } else {
                                speed++
                            }
                            if (!scrubbingTimeLine) {
                                onTempPosChanged(effectivePosition)
                                onScrubbingChanged(true)
                                player.pause()
                            }
                            val newPos = max(
                                0L,
                                tempPosition - scrubSpeedResult()
                            )
                            onTempPosChanged(newPos)
                            updateLastInteraction()
                            true
                        }

                        DirectionRight -> {
                            if (direction != 1) {
                                direction = 1
                                speed = 1L
                            } else {
                                speed++
                            }
                            if (!scrubbingTimeLine) {
                                onTempPosChanged(effectivePosition)
                                onScrubbingChanged(true)
                                player.pause()
                            }
                            val newPos = min(player.duration.takeIf { it > 0 } ?: 1L,
                                tempPosition + scrubSpeedResult())
                            onTempPosChanged(newPos)
                            updateLastInteraction()
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
                .width(14.dp)
                .height(animatedThumbHeight)
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
