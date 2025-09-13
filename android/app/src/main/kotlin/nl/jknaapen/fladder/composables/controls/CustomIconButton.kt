package nl.jknaapen.fladder.composables.controls

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.derivedStateOf
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
import nl.jknaapen.fladder.utility.highlightOnFocus

@Composable
internal fun CustomIconButton(
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
    enabled: Boolean = true,
    enableFocusIndicator: Boolean = true,
    enableScaledFocus: Boolean = false,
    backgroundColor: Color = Color.Transparent,
    foreGroundColor: Color = Color.White,
    backgroundFocusedColor: Color = Color.Transparent,
    foreGroundFocusedColor: Color = Color.White,
    icon: @Composable () -> Unit,
) {
    val interactionSource = remember { MutableInteractionSource() }
    var isFocused by remember { mutableStateOf(false) }
    val currentContentColor by remember {
        derivedStateOf {
            if (isFocused) {
                foreGroundFocusedColor
            } else {
                foreGroundColor
            }
        }
    }

    val currentBackgroundColor by remember {
        derivedStateOf {
            if (isFocused) {
                backgroundFocusedColor
            } else {
                backgroundColor
            }
        }
    }

    Box(
        modifier = modifier
            .wrapContentSize() // parent expands to fit children
            .conditional(enableScaledFocus) {
                scale(if (isFocused) 1.05f else 1f)
            }
            .conditional(enableFocusIndicator) {
                highlightOnFocus()
            }
            .background(currentBackgroundColor, shape = RoundedCornerShape(8.dp))
            .onFocusChanged { isFocused = it.isFocused }
            .clickable(
                enabled = enabled,
                interactionSource = interactionSource,
                indication = null,
                onClick = onClick
            )
            .alpha(if (enabled) 1f else 0.5f),
        contentAlignment = Alignment.Center
    ) {
        CompositionLocalProvider(LocalContentColor provides currentContentColor) {
            Box(modifier = Modifier.padding(8.dp)) {
                icon()
            }
        }
    }
}