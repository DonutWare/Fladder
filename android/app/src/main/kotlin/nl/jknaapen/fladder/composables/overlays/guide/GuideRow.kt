package nl.jknaapen.fladder.composables.overlays.guide

import GuideChannel
import GuideProgram
import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.coerceAtLeast
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage
import nl.jknaapen.fladder.composables.controls.CustomButton
import nl.jknaapen.fladder.objects.VideoPlayerObject
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import kotlin.time.DurationUnit
import kotlin.time.toDuration
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.CHANNEL_HEIGHT
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.CHANNEL_WIDTH
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.WIDTH_PER_MINUTE

@Composable
fun GuideRow(
    modifier: Modifier = Modifier,
    channel: GuideChannel,
    currentChannel: GuideChannel?,
    startDate: Long,
    horizontalScrollState: ScrollState,
    focusRequesters: Map<GuideProgram, FocusRequester>,
    totalWidth: Dp,
    onProgramSelected: (GuideChannel, GuideProgram) -> Unit,
) {
    var programmes by remember { mutableStateOf(channel.programs) }
    var hasLoadedPrograms by remember { mutableStateOf(channel.programsLoaded) }

    val localFocusRequesters = remember(programmes) {
        programmes.associateWith { FocusRequester() }
    }

    LaunchedEffect(channel.channelId) {
        if (!hasLoadedPrograms) {
            VideoPlayerObject.videoPlayerControls?.fetchProgramsForChannel(channel.channelId) { programs ->
                programmes = programs.getOrNull() ?: emptyList()
                hasLoadedPrograms = true
            }
        }
    }

    Row(
        modifier = modifier
            .height(CHANNEL_HEIGHT)
            .clip(MaterialTheme.shapes.small)
    ) {
        Column(
            modifier = Modifier
                .height(CHANNEL_HEIGHT)
                .width(CHANNEL_WIDTH)
                .background(if (currentChannel?.channelId == channel.channelId) MaterialTheme.colorScheme.primaryContainer else MaterialTheme.colorScheme.surface),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center,
        ) {
            channel.logoUrl?.let {
                AsyncImage(
                    model = it,
                    contentDescription = null,
                    modifier = Modifier
                        .fillMaxHeight()
                        .aspectRatio(ratio = 0.75f)
                        .clip(RoundedCornerShape(6.dp))
                )
            }
            Text(
                channel.name,
                style = MaterialTheme.typography.bodyMedium.copy(
                    color = MaterialTheme.colorScheme.onSurface
                )
            )
        }

        Box(
            modifier = Modifier
                .weight(1f)
                .horizontalScroll(horizontalScrollState)
        ) {
            Box(
                modifier = Modifier
                    .height(CHANNEL_HEIGHT)
                    .width(totalWidth)
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxSize()
                        .clip(MaterialTheme.shapes.small)
                ) {
                    if (!hasLoadedPrograms) {
                        Box(
                            modifier = Modifier
                                .width(CHANNEL_WIDTH)
                                .fillMaxHeight()
                                .padding(4.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            CircularProgressIndicator(modifier = Modifier.size(24.dp))
                        }
                    } else if (programmes.isEmpty()) {
                        CustomButton(
                            modifier = Modifier
                                .width(CHANNEL_WIDTH)
                                .fillMaxHeight()
                                .padding(1.dp)
                                .background(
                                    MaterialTheme.colorScheme.surfaceContainer,
                                    shape = MaterialTheme.shapes.small
                                )
                                .border(
                                    1.dp,
                                    Color.White.copy(alpha = 0.18f),
                                    MaterialTheme.shapes.small
                                ),
                            onClick = { /* No action */ },
                            shape = MaterialTheme.shapes.small,
                            backgroundFocusedColor = Color.White.copy(alpha = 0.35f),
                            foreGroundFocusedColor = MaterialTheme.colorScheme.onSurface,
                        ) {
                            Text(
                                "No programs",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    } else {
                        programmes.mapIndexed { index, program ->
                            val offsetSinceStart = if (index == 0) {
                                val minutes =
                                    (program.startMs - startDate).toDuration(unit = DurationUnit.MILLISECONDS).inWholeMinutes
                                (WIDTH_PER_MINUTE * minutes.toFloat()).coerceAtLeast(0.dp)
                            } else 0.dp

                            val previousSameProgram =
                                programmes.getOrNull(index - 1)?.name == program.name

                            val visibleStart = maxOf(program.startMs, startDate)
                            val visibleDuration =
                                (program.endMs - visibleStart).toDuration(unit = DurationUnit.MILLISECONDS)
                            val programWidth =
                                WIDTH_PER_MINUTE * visibleDuration.inWholeMinutes.toFloat()

                            GuideProgram(
                                program = program,
                                programWidth = programWidth,
                                offsetSinceStart = offsetSinceStart,
                                previousSameProgram = previousSameProgram,
                                focusRequester = localFocusRequesters[program]
                                    ?: focusRequesters[program]
                                    ?: FocusRequester(),
                                onClick = {
                                    onProgramSelected(channel, program)
                                },
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun GuideProgram(
    modifier: Modifier = Modifier,
    program: GuideProgram,
    programWidth: Dp,
    offsetSinceStart: Dp,
    previousSameProgram: Boolean,
    focusRequester: FocusRequester,
    onClick: () -> Unit,
) {
    val smallSize = programWidth < CHANNEL_WIDTH || program.primaryPoster.isNullOrBlank()
    val programColor = generateColorFromString(program.name)

    CustomButton(
        modifier = modifier
            .padding(start = offsetSinceStart.coerceAtLeast(0.dp))
            .padding(1.dp)
            .focusRequester(focusRequester)
            .background(
                programColor.copy(alpha = 0.25f),
                shape = MaterialTheme.shapes.small,
            )
            .border(
                width = 1.dp,
                shape = MaterialTheme.shapes.small,
                color = programColor.copy(0.3f)
            )
            .width(programWidth)
            .clip(MaterialTheme.shapes.small)
            .fillMaxHeight(),
        shape = MaterialTheme.shapes.small,
        backgroundFocusedColor = Color.White.copy(alpha = 0.35f),
        foreGroundFocusedColor = MaterialTheme.colorScheme.onSurface,
        clickAnimation = false,
        padding = 0.dp,
        onClick = onClick,
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(6.dp)
        ) {
            if (!previousSameProgram && !smallSize) {
                program.primaryPoster.let {
                    AsyncImage(
                        model = it,
                        contentDescription = null,
                        modifier = Modifier
                            .aspectRatio(ratio = 0.75f)
                            .fillMaxHeight()
                            .offset(x = (-2).dp)
                            .clip(RoundedCornerShape(4.dp))
                    )
                }
            }
            Column(
                modifier = Modifier
                    .fillMaxHeight()
                    .padding(horizontal = if (previousSameProgram || smallSize) 6.dp else 0.dp)
                    .weight(1f),
                horizontalAlignment = Alignment.Start,
                verticalArrangement = Arrangement.Center,
            ) {
                Text(
                    program.name,
                    style = MaterialTheme.typography.titleMedium,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                if (program.subTitle?.lowercase() != program.name.lowercase()) {
                    program.subTitle?.let {
                        Text(
                            it,
                            style = MaterialTheme.typography.bodyMedium,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    }
                }
                Row {
                    val formatter = SimpleDateFormat(
                        "HH:mm",
                        Locale.getDefault()
                    )
                    formatter.timeZone = TimeZone.getDefault()
                    val startDateTime = Date(program.startMs)
                    val endDateTime = Date(program.endMs)
                    Text(
                        "${formatter.format(startDateTime)} - ${
                            formatter.format(
                                endDateTime
                            )
                        }",
                        style = MaterialTheme.typography.bodySmall,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                }
            }
        }
    }
}

private fun generateColorFromString(input: String): Color {
    val hash = input.hashCode()
    val r = (hash and 0xFF0000) shr 16
    val g = (hash and 0x00FF00) shr 8
    val b = (hash and 0x0000FF)
    return Color(r, g, b)
}
