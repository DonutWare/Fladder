package nl.jknaapen.fladder.composables.shared


import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.delay
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone

@Composable
internal fun CurrentTime(
    modifier: Modifier = Modifier,
) {
    var currentTimeMillis by remember { mutableLongStateOf(System.currentTimeMillis()) }

    LaunchedEffect(Unit) {
        while (true) {
            currentTimeMillis = System.currentTimeMillis()
            val delayMs = 60_000L - (currentTimeMillis % 60_000L)
            delay(delayMs)
        }
    }

    val isoUtc = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.getDefault()).apply {
        timeZone = TimeZone.getTimeZone("UTC")
    }.format(Date(currentTimeMillis))

    Translate(
        { localeCode ->
            Localized.hoursAndMinutes(isoUtc, localeCode)
        },
        key = currentTimeMillis,
    ) { time ->
        Text(
            modifier = modifier,
            text = time,
            style = MaterialTheme.typography.displaySmall,
            color = Color.White
        )
    }
}