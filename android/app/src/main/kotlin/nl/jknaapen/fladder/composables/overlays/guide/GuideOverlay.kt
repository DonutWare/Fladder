package nl.jknaapen.fladder.composables.overlays.guide

import GuideChannel
import GuideProgram
import androidx.activity.compose.BackHandler
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.background
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.key
import androidx.compose.ui.platform.LocalDensity
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.CHANNEL_WIDTH
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.TIME_LINE_HEIGHT
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.WIDTH_PER_MINUTE
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.conditional
import nl.jknaapen.fladder.utility.keyEvent
import nl.jknaapen.fladder.utility.visible
import kotlin.time.Duration.Companion.minutes
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@Composable
fun GuideOverlay(
    modifier: Modifier = Modifier,
    overlay: @Composable BoxScope.(showControls: Boolean) -> Unit,
) {
    val tvGuide by VideoPlayerObject.tvGuide.collectAsState()
    var channels by remember { mutableStateOf(tvGuide?.channels ?: emptyList()) }
    val showGuide by VideoPlayerObject.guideVisible.collectAsState(false)

    BackHandler(
        enabled = showGuide
    ) {
        if (showGuide) {
            VideoPlayerObject.guideVisible.value = false
        }
    }

    val focusRequester = remember { FocusRequester() }

    val startDate = tvGuide?.startMs ?: 0L
    val endDate = tvGuide?.endMs ?: 0L
    var now by remember { mutableLongStateOf(System.currentTimeMillis()) }

    val isBuffering by VideoPlayerObject.buffering.collectAsState(true)

    fun loadChannel(selectedChannel: GuideChannel) {
        if (isBuffering) return
        VideoPlayerObject.videoPlayerControls?.loadProgram(selectedChannel) {
            VideoPlayerObject.guideVisible.value = false
        }
    }

    LaunchedEffect(key1 = showGuide) {
        while (showGuide) {
            now = System.currentTimeMillis()
            delay(1.minutes)
        }
    }

    val currentProgram = tvGuide?.currentProgram
    var selectedProgram by remember { mutableStateOf<GuideProgram?>(null) }

    val activeProgram by remember {
        derivedStateOf {
            selectedProgram ?: currentProgram
        }
    }

    val currentChannel by remember { mutableStateOf(channels.firstOrNull { it.channelId == currentProgram?.channelId }) }

    var showConfirmDialog by remember { mutableStateOf(false) }
    var pendingChannel by remember { mutableStateOf<GuideChannel?>(null) }
    var pendingProgram by remember { mutableStateOf<GuideProgram?>(null) }

    val horizontalScrollState = rememberScrollState()
    val guideListState = rememberLazyListState()

    val programFlatMap = remember(channels) {
        channels.flatMap { it.programs }
    }

    val focusRequesters = remember(programFlatMap) {
        programFlatMap.associateWith { FocusRequester() }
    }

    LaunchedEffect(showGuide) {
        if (!showGuide || currentProgram == null) return@LaunchedEffect
        focusRequesters.entries.firstOrNull { it.key.id == currentProgram.id }?.value?.let {
            delay(250)
            it.requestFocus()
            it.captureFocus()
        }
    }

    val density = LocalDensity.current
    LaunchedEffect(key1 = showGuide) {
        val ap = activeProgram
        if (!showGuide || ap == null) return@LaunchedEffect

        delay(250)

        val widthPerMinutePx = with(density) { WIDTH_PER_MINUTE.toPx() }

        val minutesFromStart = ((ap.startMs - startDate) / 60000.0).toFloat()
        val targetX = (minutesFromStart * widthPerMinutePx).toInt().coerceAtLeast(0)

        val maxX = horizontalScrollState.maxValue
        val scrollToX = targetX.coerceIn(0, maxX)

        val channelIndex = channels.indexOfFirst { it.channelId == ap.channelId }
        if (channelIndex >= 0) {
            horizontalScrollState.animateScrollTo(scrollToX)
            guideListState.animateScrollToItem(channelIndex + 1)
        }
    }

    Box(
        modifier = modifier
            .fillMaxSize()
            .background(color = Color.Black)
            .focusRequester(focusRequester)
            .conditional(showGuide, modifier = {
                keyEvent { keyEvent ->
                    when (keyEvent.key) {
                        Key.Back, Key.Escape, Key.ButtonB, Key.Backspace -> {
                            if (showGuide) {
                                VideoPlayerObject.guideVisible.value = false
                                return@keyEvent true
                            } else {
                                return@keyEvent false
                            }
                        }
                    }
                    return@keyEvent false
                }
            })
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .visible(showGuide),
        ) {
            GuideDetailView(
                modifier = Modifier.align(Alignment.End),
                currentChannel = currentChannel,
                activeProgram = activeProgram,
            )

            Box(
                modifier = Modifier
                    .weight(1f)
                    .fillMaxWidth(1f)
            ) {
                GuideRows(
                    modifier = Modifier.fillMaxSize(),
                    channels = channels,
                    currentChannel = currentChannel,
                    startDate = startDate,
                    endDate = endDate,
                    horizontalScrollState = horizontalScrollState,
                    focusRequesters = focusRequesters,
                    listState = guideListState,
                    now = now,
                    onProgramSelected = { channel, program ->
                        if (selectedProgram?.id == program.id && currentChannel?.channelId != program.channelId) {
                            pendingChannel = channel
                            pendingProgram = program
                            showConfirmDialog = true
                        }
                        selectedProgram = program
                    },
                )
            }
        }

        val animatedSizeFraction by animateFloatAsState(
            if (showGuide) 0.5f else 1f,
            label = "guideSizeFraction"
        )

        Box(
            modifier = Modifier
                .fillMaxSize(animatedSizeFraction)
                .align(Alignment.TopStart)
        ) {
            overlay(!showGuide)
        }

        ChannelSwitchConfirmDialog(
            show = showConfirmDialog,
            channel = pendingChannel,
            program = pendingProgram,
            onConfirm = {
                pendingChannel?.let { channel ->
                    loadChannel(channel)
                    VideoPlayerObject.guideVisible.value = false
                }
                showConfirmDialog = false
                pendingChannel = null
                pendingProgram = null
            },
            onDismiss = {
                showConfirmDialog = false
                pendingChannel = null
                pendingProgram = null
            }
        )
    }
}

@Composable
private fun GuideRows(
    modifier: Modifier = Modifier,
    currentChannel: GuideChannel? = null,
    channels: List<GuideChannel>,
    startDate: Long,
    endDate: Long,
    horizontalScrollState: ScrollState,
    focusRequesters: Map<GuideProgram, FocusRequester>,
    listState: LazyListState,
    now: Long = System.currentTimeMillis(),
    onProgramSelected: (GuideChannel, GuideProgram) -> Unit,
) {
    val totalMinutes = remember(startDate, endDate) {
        (endDate - startDate).toDuration(unit = DurationUnit.MILLISECONDS).inWholeMinutes
    }
    val totalWidth = WIDTH_PER_MINUTE * totalMinutes.toFloat()

    Box(modifier = modifier) {
        LazyColumn(
            modifier = Modifier.fillMaxSize(),
            state = listState
        ) {
            stickyHeader {
                Row(
                    modifier = Modifier
                        .height(TIME_LINE_HEIGHT)
                        .fillMaxWidth()
                        .background(MaterialTheme.colorScheme.surface)
                ) {
                    Spacer(modifier = Modifier.width(CHANNEL_WIDTH))
                    Box(
                        modifier = Modifier
                            .weight(1f)
                            .horizontalScroll(horizontalScrollState)
                    ) {
                        TimeLine(
                            modifier = Modifier.width(totalWidth),
                            startDate = startDate,
                            endDate = endDate,
                        )
                    }
                }
            }

            itemsIndexed(channels) { _, channel ->
                GuideRow(
                    modifier = Modifier.fillMaxWidth(),
                    channel = channel,
                    currentChannel = currentChannel,
                    startDate = startDate,
                    horizontalScrollState = horizontalScrollState,
                    focusRequesters = focusRequesters,
                    totalWidth = totalWidth,
                    onProgramSelected = onProgramSelected,
                )
            }
        }

        NowIndicator(
            now = now,
            startDate = startDate,
            endDate = endDate,
            horizontalScrollState = horizontalScrollState,
            totalWidth = totalWidth,
        )
    }
}
