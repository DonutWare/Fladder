package nl.jknaapen.fladder.utility

import PlayerOrientations
import android.content.pm.ActivityInfo
import androidx.activity.compose.LocalActivity
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect

@Composable
fun AllowedOrientations(
    allowed: List<PlayerOrientations>,
    content: @Composable () -> Unit
) {
    val activity = LocalActivity.current

    DisposableEffect(allowed) {
        val previousOrientation = activity?.requestedOrientation

        val newOrientation = allowed.toRequestedOrientation()
        activity?.requestedOrientation = newOrientation

        onDispose {
            previousOrientation?.let { activity.requestedOrientation = it }
        }
    }

    content()
}

private fun List<PlayerOrientations>.toRequestedOrientation(): Int {
    val hasPortraitUp = contains(PlayerOrientations.PORTRAIT_UP)
    val hasPortraitDown = contains(PlayerOrientations.PORTRAIT_DOWN)
    val hasLandscapeLeft = contains(PlayerOrientations.LAND_SCAPE_LEFT)
    val hasLandscapeRight = contains(PlayerOrientations.LAND_SCAPE_RIGHT)

    return when {
        hasPortraitUp && hasPortraitDown && !hasLandscapeLeft && !hasLandscapeRight ->
            ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT

        hasLandscapeLeft && hasLandscapeRight && !hasPortraitUp && !hasPortraitDown ->
            ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE

        hasPortraitUp && !hasPortraitDown && !hasLandscapeLeft && !hasLandscapeRight ->
            ActivityInfo.SCREEN_ORIENTATION_PORTRAIT

        hasPortraitDown && !hasPortraitUp && !hasLandscapeLeft && !hasLandscapeRight ->
            ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT

        hasLandscapeLeft && !hasLandscapeRight && !hasPortraitUp && !hasPortraitDown ->
            ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE

        hasLandscapeRight && !hasLandscapeLeft && !hasPortraitUp && !hasPortraitDown ->
            ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE

        hasPortraitUp && hasLandscapeLeft && hasLandscapeRight && hasPortraitDown ->
            ActivityInfo.SCREEN_ORIENTATION_FULL_SENSOR

        else -> ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED
    }
}