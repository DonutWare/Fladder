package nl.jknaapen.fladder.composables.overlays.guide

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.VerticalDivider
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import kotlin.time.DurationUnit
import kotlin.time.toDuration
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.TIME_LINE_HEIGHT
import nl.jknaapen.fladder.composables.overlays.guide.GuideConstants.WIDTH_PER_MINUTE

@Composable
fun TimeLine(
    modifier: Modifier = Modifier,
    startDate: Long,
    endDate: Long,
) {
    Row(
        modifier = modifier
            .height(TIME_LINE_HEIGHT + 4.dp)
    ) {
        val totalDuration =
            (endDate - startDate).toDuration(unit = DurationUnit.MILLISECONDS)
        val totalMinutes = totalDuration.inWholeMinutes
        val formatter = SimpleDateFormat("HH:mm", Locale.getDefault())
        formatter.timeZone = TimeZone.getDefault()
        val stepSize: Long = 15
        for (minute in 0 until totalMinutes step stepSize) {
            val displayDate = Date(startDate + (minute * 60000))
            Row(
                modifier = Modifier
                    .width(WIDTH_PER_MINUTE * stepSize.toFloat())
                    .fillMaxHeight(),
                horizontalArrangement = Arrangement.spacedBy(
                    6.dp,
                    Alignment.Start
                ),
                verticalAlignment = Alignment.Bottom,
            ) {
                VerticalDivider()
                Text(
                    modifier = Modifier.padding(vertical = 3.dp),
                    text = formatter.format(displayDate),
                    style = MaterialTheme.typography.bodySmall.copy(
                        color = MaterialTheme.colorScheme.onSurface
                    )
                )
            }
        }
    }
}
