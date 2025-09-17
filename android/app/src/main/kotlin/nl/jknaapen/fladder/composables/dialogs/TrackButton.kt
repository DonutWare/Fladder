package nl.jknaapen.fladder.composables.dialogs

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.LocalTextStyle
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@Composable
internal fun TrackButton(
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
    selected: Boolean = false,
    content: @Composable () -> Unit,
) {
    val backgroundColor = if (selected) Color.White else Color.Black
    val textColor = if (selected) Color.Black else Color.White
    val textStyle =
        MaterialTheme.typography.bodyLarge.copy(color = textColor, fontWeight = FontWeight.Bold)

    val interactionSource = remember { MutableInteractionSource() }

    TextButton(
        modifier = modifier
            .background(
                color = backgroundColor.copy(alpha = 0.65f),
                shape = RoundedCornerShape(12.dp),
            )
            .padding(12.dp)
            .clickable(
                onClick = onClick,
                interactionSource = interactionSource,
                indication = null,
            ),
        onClick = onClick,
        interactionSource = interactionSource,
    ) {
        CompositionLocalProvider(LocalTextStyle provides textStyle) {
            content()
        }
    }
}