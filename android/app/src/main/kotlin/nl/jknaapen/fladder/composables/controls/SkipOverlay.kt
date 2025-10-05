package nl.jknaapen.fladder.composables.controls

import MediaSegment
import MediaSegmentType
import SegmentSkip
import SegmentType
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeContentPadding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.defaultSelected
import nl.jknaapen.fladder.utility.leanBackEnabled
import kotlin.time.Duration.Companion.milliseconds

@RequiresApi(Build.VERSION_CODES.O)
@Composable
internal fun BoxScope.SegmentSkipOverlay(
    modifier: Modifier = Modifier,
) {
    val isAndroidTV = leanBackEnabled(LocalContext.current)
    val focusRequester = remember { FocusRequester() }

    val state by VideoPlayerObject.implementation.playbackData.collectAsState()
    val position by VideoPlayerObject.position.collectAsState(0L)

    val segments = state?.segments ?: emptyList()
    val player = VideoPlayerObject.implementation.player
    val skipMap by PlayerSettingsObject.skipMap.collectAsState(mapOf())

    var isFocused by remember { mutableStateOf(false) }

    LaunchedEffect(segments, skipMap) { }

    if (segments.isEmpty() || player == null) return

    val activeSegment = segments.firstOrNull { it.start <= position && it.end >= position }

    val segmentType = activeSegment?.type?.toSegment
    val skip = skipMap[segmentType]

    fun skipSegment(segment: MediaSegment) {
        player.seekTo(segment.end + 250.milliseconds.inWholeMilliseconds)
    }

    LaunchedEffect(activeSegment, position, skipMap) {
        if (skipMap.isEmpty()) return@LaunchedEffect
        if (activeSegment != null) {
            if (skip == SegmentSkip.SKIP) {
                skipSegment(activeSegment)
            }
        }
    }

    LaunchedEffect(activeSegment) {
        if (activeSegment != null) {
            focusRequester.captureFocus()
        }
    }

    val shape = RoundedCornerShape(8.dp)

    AnimatedVisibility(
        activeSegment != null && skip == SegmentSkip.ASK,
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .safeContentPadding()
    ) {
        Box {
            FilledTonalButton(
                modifier = modifier
                    .align(alignment = Alignment.CenterEnd)
                    .focusRequester(focusRequester)
                    .onFocusChanged { state ->
                        isFocused = state.isFocused
                    }
                    .border(
                        width = 2.dp,
                        color = if (isFocused) Color.White.copy(alpha = 0.4f) else Color.Transparent,
                        shape = shape,
                    )
                    .defaultSelected(true),
                contentPadding = PaddingValues(horizontal = 12.dp),
                shape = shape,
                colors = ButtonDefaults.filledTonalButtonColors(
                    containerColor = Color.White.copy(alpha = 0.75f),
                    contentColor = Color.Black,
                ),
                onClick = {
                    activeSegment?.let {
                        player.seekTo(it.end)
                    }
                }
            ) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(12.dp),
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    if (isAndroidTV) {
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .background(
                                    color = Color.Black.copy(alpha = 0.15f),
                                    shape = CircleShape,
                                )
                                .border(
                                    width = 1.5.dp,
                                    color = Color.Black.copy(alpha = 0.15f),
                                    shape = CircleShape,
                                )
                        ) {
                            Box(
                                modifier = Modifier
                                    .padding(7.dp)
                                    .fillMaxSize()
                                    .background(
                                        color = Color.White,
                                        shape = CircleShape,
                                    )
                            ) {

                            }
                        }
                    }
                    activeSegment?.let {
                        Text(
                            "Skip ${it.name.lowercase()}",
                            style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold)
                        )
                    }
                }
            }
        }
    }
}

private val MediaSegmentType.toSegment: SegmentType
    get() = when (this) {
        MediaSegmentType.COMMERCIAL -> SegmentType.COMMERCIAL
        MediaSegmentType.PREVIEW -> SegmentType.PREVIEW
        MediaSegmentType.RECAP -> SegmentType.RECAP
        MediaSegmentType.INTRO -> SegmentType.INTRO
        MediaSegmentType.OUTRO -> SegmentType.OUTRO
    }
