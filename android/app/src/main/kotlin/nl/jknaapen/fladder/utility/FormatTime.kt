package nl.jknaapen.fladder.utility

fun formatTime(ms: Long): String {
    if (ms < 0) {
        return "0:00"
    }
    val totalSeconds = ms / 1000
    val minutes = totalSeconds / 60
    val seconds = totalSeconds % 60
    return "%d:%02d".format(minutes, seconds)
}
