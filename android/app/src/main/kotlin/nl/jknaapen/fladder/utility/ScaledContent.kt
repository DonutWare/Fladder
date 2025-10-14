package nl.jknaapen.fladder.utility

import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Density

@Composable
fun ScaledContent(
    scale: Float,
    content: @Composable () -> Unit
) {
    val density = LocalDensity.current
    val fontScale = 1f / scale
    CompositionLocalProvider(
        LocalDensity provides Density(
            density = density.density * scale,
            fontScale = fontScale
        )
    ) {
        content()
    }
}