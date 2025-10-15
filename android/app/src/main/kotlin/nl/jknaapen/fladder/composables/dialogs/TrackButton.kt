package nl.jknaapen.fladder.composables.dialogs

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalTextStyle
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.TickSquare
import nl.jknaapen.fladder.composables.controls.CustomButton
import nl.jknaapen.fladder.utility.defaultSelected

@Composable
internal fun TrackButton(
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
    selected: Boolean = false,
    content: @Composable () -> Unit,
) {
    val textStyle =
        MaterialTheme.typography.bodyMedium.copy(fontWeight = FontWeight.Bold)

    CustomButton(
        backgroundColor = Color.White.copy(alpha = 0.25f),
        modifier = modifier
            .padding(vertical = 6.dp, horizontal = 12.dp)
            .defaultMinSize(minHeight = 40.dp)
            .defaultSelected(selected),
        onClick = onClick,
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            if (selected) {
                Icon(
                    imageVector = Iconsax.Filled.TickSquare,
                    contentDescription = "",
                )
            }
            CompositionLocalProvider(LocalTextStyle provides textStyle) {
                content()
            }
        }
    }
}