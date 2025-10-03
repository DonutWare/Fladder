package nl.jknaapen.fladder

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.graphics.Color
import com.materialkolor.PaletteStyle
import com.materialkolor.dynamiccolor.ColorSpec
import com.materialkolor.rememberDynamicColorScheme

@Composable
fun VideoPlayerTheme(
    content: @Composable () -> Unit
) {
    val colorScheme = rememberDynamicColorScheme(
        seedColor = Color(0xFFFF9800),
        isDark = true,
        specVersion = ColorSpec.SpecVersion.SPEC_2025,
        style = PaletteStyle.Expressive,
    )
    
    MaterialTheme(
        colorScheme = colorScheme,
    ) {
        CompositionLocalProvider {
            content()
        }
    }
}

