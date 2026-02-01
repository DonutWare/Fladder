package nl.jknaapen.fladder.composables.overlays.guide

import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clipToBounds
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.CHANNEL_WIDTH
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.WIDTH_PER_MINUTE

@Composable
fun NowIndicator(
    modifier: Modifier = Modifier,
    now: Long,
    startDate: Long,
    endDate: Long,
    horizontalScrollState: ScrollState,
    totalWidth: Dp,
) {
    if (now !in startDate..endDate) return

    val density = LocalDensity.current
    val scrollOffsetPx by remember {
        derivedStateOf { horizontalScrollState.value }
    }
    val scrollOffsetDp = with(density) { scrollOffsetPx.toDp() }
    val nowOffsetMinutes = ((now - startDate).toDouble() / 60000.0).toFloat()
    val rawNowX = (WIDTH_PER_MINUTE * nowOffsetMinutes) - scrollOffsetDp
    val nowXPosition = rawNowX.coerceIn(0.dp, totalWidth)

    Row(
        modifier = modifier.fillMaxSize()
    ) {
        Spacer(modifier = Modifier.width(CHANNEL_WIDTH))
        Box(
            modifier = Modifier
                .width(totalWidth)
                .fillMaxHeight()
                .clipToBounds()
        ) {
            Box(
                modifier = Modifier
                    .offset(x = nowXPosition + 4.dp, y = 0.dp)
                    .align(Alignment.TopStart)
                    .wrapContentSize()
                    .background(
                        MaterialTheme.colorScheme.primary,
                        shape = MaterialTheme.shapes.small
                    )
            ) {
                val formatter = SimpleDateFormat("HH:mm", Locale.getDefault())
                formatter.timeZone = TimeZone.getDefault()
                Text(
                    formatter.format(Date(now)),
                    modifier = Modifier.padding(4.dp),
                    style = MaterialTheme.typography.bodySmall,
                )
            }

            Box(
                modifier = Modifier
                    .offset(x = nowXPosition)
                    .fillMaxHeight()
                    .width(2.dp)
                    .background(MaterialTheme.colorScheme.primary)
            )
        }
    }
}
