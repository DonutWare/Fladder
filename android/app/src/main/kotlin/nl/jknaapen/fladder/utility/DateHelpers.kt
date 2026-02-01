package nl.jknaapen.fladder.utility

import android.os.Build
import androidx.annotation.RequiresApi
import java.time.LocalDateTime
import java.time.ZoneId

@RequiresApi(Build.VERSION_CODES.O)
fun LocalDateTime.toEpochMillis(zone: ZoneId = ZoneId.systemDefault()): Long {
    return this.atZone(zone).toInstant().toEpochMilli()
}