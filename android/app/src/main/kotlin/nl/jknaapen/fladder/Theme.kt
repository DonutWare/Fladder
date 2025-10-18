package nl.jknaapen.fladder

import android.os.Build
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Typography
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
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
            dynamicDarkColorScheme(context)
        } else {
            generatedScheme
        }

    MaterialTheme(
        colorScheme = chosenScheme,
        typography = customTypography
    ) {
        content()
    }
}

val customTypography: Typography
    @Composable
    get() {
        val rubikFamily = FontFamily(
            Font(R.font.rubik_light, FontWeight.Light),
            Font(R.font.rubik_normal, FontWeight.Normal),
            Font(R.font.rubik_italic, FontWeight.Normal, FontStyle.Italic),
            Font(R.font.rubik_medium, FontWeight.Medium),
            Font(R.font.rubik_bold, FontWeight.Bold)
        )

        val defaultTypography = MaterialTheme.typography

        return defaultTypography.copy(
            displayLarge = defaultTypography.displayLarge.copy(fontFamily = rubikFamily),
            displayMedium = defaultTypography.displayMedium.copy(fontFamily = rubikFamily),
            displaySmall = defaultTypography.displaySmall.copy(fontFamily = rubikFamily),

            headlineLarge = defaultTypography.headlineLarge.copy(fontFamily = rubikFamily),
            headlineMedium = defaultTypography.headlineMedium.copy(fontFamily = rubikFamily),
            headlineSmall = defaultTypography.headlineSmall.copy(fontFamily = rubikFamily),

            titleLarge = defaultTypography.titleLarge.copy(fontFamily = rubikFamily),
            titleMedium = defaultTypography.titleMedium.copy(fontFamily = rubikFamily),
            titleSmall = defaultTypography.titleSmall.copy(fontFamily = rubikFamily),

            bodyLarge = defaultTypography.bodyLarge.copy(fontFamily = rubikFamily),
            bodyMedium = defaultTypography.bodyMedium.copy(fontFamily = rubikFamily),
            bodySmall = defaultTypography.bodySmall.copy(fontFamily = rubikFamily),

            labelLarge = defaultTypography.labelLarge.copy(fontFamily = rubikFamily),
            labelMedium = defaultTypography.labelMedium.copy(fontFamily = rubikFamily),
            labelSmall = defaultTypography.labelSmall.copy(fontFamily = rubikFamily)
        )
    }