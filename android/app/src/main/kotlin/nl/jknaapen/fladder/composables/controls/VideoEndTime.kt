package nl.jknaapen.fladder.composables.controls

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import nl.jknaapen.fladder.objects.VideoPlayerObject
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import kotlin.time.Clock
import kotlin.time.ExperimentalTime
import kotlin.time.toJavaInstant

@RequiresApi(Build.VERSION_CODES.O)
@OptIn(ExperimentalTime::class)
@Composable
fun VideoEndTime() {
    val startInstant = remember { Clock.System.now() }
    val durationMs by VideoPlayerObject.duration.collectAsState(initial = 0L)
    val zone = ZoneId.systemDefault()

    val javaInstant = remember(startInstant) { startInstant.toJavaInstant() }
    val endJavaInstant = remember(javaInstant, durationMs) {
        javaInstant.plusMillis(durationMs)
    }
    val endZoned = remember(endJavaInstant, zone) {
        endJavaInstant.atZone(zone)
    }

    val formatter = DateTimeFormatter.ofPattern("hh:mm a")
    val formattedEnd = remember(endZoned, formatter) {
        endZoned.format(formatter)
    }

    Text(
        text = "ends at $formattedEnd",
        style = MaterialTheme.typography.titleLarge.copy(
            color = Color.White,
            fontWeight = FontWeight.Bold
        ),
    )
}
