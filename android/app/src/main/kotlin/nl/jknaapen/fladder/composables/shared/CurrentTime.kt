package nl.jknaapen.fladder.composables.shared

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate
import java.time.ZoneId
import kotlin.time.Clock
import kotlin.time.ExperimentalTime
import kotlin.time.toJavaInstant

@OptIn(ExperimentalTime::class)
@RequiresApi(Build.VERSION_CODES.O)
@Composable
internal fun CurrentTime(
    modifier: Modifier = Modifier,
) {
    val zone = ZoneId.systemDefault()

    var currentTime by remember { mutableStateOf(Clock.System.now()) }

    LaunchedEffect(Unit) {
        while (true) {
            currentTime = Clock.System.now()
            val delayMs = 60_000L - (currentTime.toEpochMilliseconds() % 60_000L)
            delay(delayMs)
        }
    }

    val endZoned = currentTime.toJavaInstant().atZone(zone)

    Translate(
        {
            Localized.hoursAndMinutes(endZoned.toOffsetDateTime().toString(), it)
        },
        key = currentTime,
    ) { time ->
        Text(
            modifier = modifier,
            text = time,
            style = MaterialTheme.typography.titleLarge,
            color = Color.White
        )
    }
}