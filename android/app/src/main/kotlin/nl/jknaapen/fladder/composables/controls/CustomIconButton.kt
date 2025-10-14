package nl.jknaapen.fladder.composables.controls

import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.scale
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import nl.jknaapen.fladder.utility.conditional

@Composable
internal fun CustomIconButton(
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
    enabled: Boolean = true,
    enableScaledFocus: Boolean = false,
    backgroundColor: Color = Color.White.copy(alpha = 0.1f),
    foreGroundColor: Color = Color.White,
    backgroundFocusedColor: Color = Color.White,
    foreGroundFocusedColor: Color = Color.Black,
    icon: @Composable () -> Unit,
) {
    val interactionSource = remember { MutableInteractionSource() }
    var isFocused by remember { mutableStateOf(false) }

    val currentContentColor by animateColorAsState(
        if (isFocused) {
            foreGroundFocusedColor
        } else {
            foreGroundColor
        }, label = "buttonContentColor"
    )

    val currentBackgroundColor by animateColorAsState(
        if (isFocused) {
            backgroundFocusedColor
        } else {
            backgroundColor
        }, label = "buttonBackground"
    )

    Box(
        modifier = modifier
            .conditional(enableScaledFocus) {
                scale(if (isFocused) 1.05f else 1f)
            }
            .background(currentBackgroundColor, shape = CircleShape)
            .onFocusChanged { isFocused = it.isFocused }
            .clickable(
                enabled = enabled,
                interactionSource = interactionSource,
                indication = null,
                onClick = onClick
            )
            .alpha(if (enabled) 1f else 0.15f),
        contentAlignment = Alignment.Center
    ) {
        CompositionLocalProvider(LocalContentColor provides currentContentColor) {
            Box(modifier = Modifier.padding(12.dp)) {
                icon()
            }
        }
    }
}