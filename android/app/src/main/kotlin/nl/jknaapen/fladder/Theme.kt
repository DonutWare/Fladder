package nl.jknaapen.fladder

import android.os.Build
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import com.materialkolor.PaletteStyle
import com.materialkolor.dynamiccolor.ColorSpec
import com.materialkolor.rememberDynamicColorScheme
import nl.jknaapen.fladder.objects.PlayerSettingsObject

@Composable
fun VideoPlayerTheme(
    content: @Composable () -> Unit
) {
    val context = LocalContext.current

    val themeColor by PlayerSettingsObject.themeColor.collectAsState(null)

    val generatedScheme = rememberDynamicColorScheme(
        seedColor = themeColor ?: Color(0xFFFF9800),
        isDark = true,
        specVersion = ColorSpec.SpecVersion.SPEC_2025,
        style = PaletteStyle.Expressive,
    )

    val chosenScheme: ColorScheme =
        if (themeColor == null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            dynamicLightColorScheme(context)
        } else {
            generatedScheme
        }

    MaterialTheme(
        colorScheme = chosenScheme,
    ) {
        content()
    }
}

