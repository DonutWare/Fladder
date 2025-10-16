package nl.jknaapen.fladder.composables.overlays

import AutoNextType
import MediaSegmentType
import androidx.activity.compose.LocalActivity
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
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
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.CloseCircle
import io.github.rabehx.iconsax.filled.Next
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import nl.jknaapen.fladder.composables.controls.CustomButton
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.conditional
import nl.jknaapen.fladder.utility.highlightOnFocus
import nl.jknaapen.fladder.utility.visible
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@Composable
internal fun NextUpOverlay(
    modifier: Modifier = Modifier,
    content: @Composable BoxScope.(Boolean) -> Unit,
) {
    val nextVideo by VideoPlayerObject.nextUpVideo.collectAsState(null)

    val nextType by PlayerSettingsObject.autoNextType.collectAsState(AutoNextType.OFF)
    var disableUntilNextVideo by remember { mutableStateOf(false) }

    if (nextType == AutoNextType.OFF || nextVideo == null) {
        return Box(
            modifier = Modifier.fillMaxSize()
        ) {
            content(true)
        }
    }

    val isConditionMet = showNextUp()

    var nextUpVisible by remember { mutableStateOf(false) }
    val focusRequester = remember { FocusRequester() }
    var timeUntilNextVideo by remember { mutableIntStateOf(30) }

    fun reInitNextUp() {
        nextUpVisible = false
        disableUntilNextVideo = false
    }

    LaunchedEffect(isConditionMet) {
        if (isConditionMet && !nextUpVisible && !disableUntilNextVideo) {
            nextUpVisible = true
            timeUntilNextVideo = 30
            focusRequester.requestFocus()
        } else if (!isConditionMet) {
            nextUpVisible = false
        }
    }

    val isBuffering by VideoPlayerObject.buffering.collectAsState(true)

    LaunchedEffect(nextVideo) {
        reInitNextUp()
    }

    fun loadNextVideo() {
        if (isBuffering) return
        VideoPlayerObject.videoPlayerControls?.loadNextVideo {}
        reInitNextUp()
    }

    val showNextUp = nextUpVisible && !disableUntilNextVideo

    LaunchedEffect(showNextUp) {
        if (showNextUp) {
            while (timeUntilNextVideo > 0 && isActive) {
                delay(1000)
                timeUntilNextVideo -= 1
            }
            loadNextVideo()
        }
    }

    val activity = LocalActivity.current

    val animatedDp by animateDpAsState(if (showNextUp) 16.dp else 0.dp, label = "paddingDp")
    val animatedSizeFraction by animateFloatAsState(
        if (showNextUp) 0.6f else 1f,
        label = "sizeFraction"
    )

    Box(
        modifier = modifier.background(
            color = Color(0xFF0E0E0E),
        ),
    ) {
        Box(
            modifier = Modifier
                .padding(animatedDp)
                .align(Alignment.CenterStart)
                .fillMaxSize(fraction = animatedSizeFraction)
                .conditional(showNextUp) {
                    highlightOnFocus(
                        width = if (showNextUp) 2.dp else 0.dp,
                        useClip = false,
                    )
                }
                .clickable(
                    enabled = showNextUp,
                    onClick = {
                        disableUntilNextVideo = true
                    }
                )
        ) {
            content(!showNextUp)
        }

        Column(
            modifier = Modifier
                .wrapContentHeight()
                .fillMaxWidth(fraction = 0.4f)
                .align(Alignment.CenterEnd)
                .visible(showNextUp)
                .padding(16.dp)
                .background(
                    color = MaterialTheme.colorScheme.surfaceContainer,
                    shape = RoundedCornerShape(8.dp)
                )
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            Column(
                modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Text(
                    "Next-up in $timeUntilNextVideo seconds",
                    style = MaterialTheme.typography.titleLarge,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    color = MaterialTheme.colorScheme.onSurface
                )
                Box(
                    modifier = Modifier
                        .align(alignment = Alignment.CenterHorizontally)
                        .fillMaxWidth(fraction = 0.1f)
                        .heightIn(2.dp)
                        .background(
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.1f),
                            shape = RoundedCornerShape(16.dp),
                        )
                )
                MediaInfo()
            }
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
            ) {
                CustomButton(
                    modifier = Modifier.focusRequester(focusRequester),
                    onClick = ::loadNextVideo,
                ) {
                    Row(
                        horizontalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Text("Next")
                        Icon(Iconsax.Filled.Next, contentDescription = "Play next video")
                    }
                }
                activity?.let {
                    CustomButton(
                        onClick = {
                            reInitNextUp()
                            activity.finish()
                        },
                    ) {
                        Row(
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            Text("Close")
                            Icon(Iconsax.Filled.CloseCircle, contentDescription = "Close Icon")
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun MediaInfo() {
    val onSurfaceColor = MaterialTheme.colorScheme.onSurface

    val nextUpVideo by VideoPlayerObject.nextUpVideo.collectAsState(null)

    nextUpVideo?.let { video ->
        Column(
            verticalArrangement = Arrangement.spacedBy(6.dp),
        ) {
            Text(
                video.title,
                style = MaterialTheme.typography.titleMedium,
                color = onSurfaceColor
            )
            if (video.title != video.subTitle && video.subTitle != null)
                Text(
                    video.subTitle,
                    style = MaterialTheme.typography.bodyMedium,
                    color = onSurfaceColor.copy(alpha = 0.65f)
                )
            AsyncImage(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(ratio = 1.67f)
                    .clip(RoundedCornerShape(16.dp)),
                model = video.primaryPoster,
                contentDescription = "ItemPoster"
            )

            video.overview?.let { overview ->
                Text(
                    overview,
                    style = MaterialTheme.typography.bodyMedium,
                    overflow = TextOverflow.Ellipsis,
                    maxLines = 4,
                    color = onSurfaceColor
                )
            }
        }
    }
}

@Composable
private fun showNextUp(): Boolean {
    val nextType by PlayerSettingsObject.autoNextType.collectAsState(AutoNextType.OFF)
    val durationMs by VideoPlayerObject.duration.collectAsState(0L)
    val positionMs by VideoPlayerObject.position.collectAsState(0L)
    val buffering by VideoPlayerObject.buffering.collectAsState(true)

    val videoDuration = durationMs.toDuration(DurationUnit.MILLISECONDS)
    val videoPosition = positionMs.toDuration(DurationUnit.MILLISECONDS)

    if (nextType == AutoNextType.OFF || videoDuration < 40.seconds || buffering) {
        return false
    }

    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState()
    val credits =
        (playbackData?.segments ?: listOf()).firstOrNull { it.type == MediaSegmentType.OUTRO }

    val timeToVideoEnd = (videoDuration - videoPosition).absoluteValue
    val nearEndOfVideo = timeToVideoEnd < 32.seconds

    when (nextType) {
        AutoNextType.STATIC -> {
            if (nearEndOfVideo) return true
        }

        AutoNextType.SMART -> {
            if (credits != null) {
                val maxTimePct = 90.0
                val resumeDuration = videoDuration * (maxTimePct / 100)

                val creditsEnd = credits.end.toDuration(DurationUnit.MILLISECONDS)
                val creditsStart = credits.start.toDuration(DurationUnit.MILLISECONDS)

                val timeLeftAfterCredits = videoDuration - creditsEnd

                if (creditsEnd > resumeDuration && timeLeftAfterCredits < 30.seconds) {
                    if (videoPosition >= creditsStart) {
                        return true
                    }
                } else if (nearEndOfVideo) {
                    return true
                }
            } else {
                if (nearEndOfVideo) {
                    return true
                }
            }
        }

        AutoNextType.OFF -> return false
    }

    return false
}