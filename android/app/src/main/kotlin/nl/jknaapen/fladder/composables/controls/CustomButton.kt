package nl.jknaapen.fladder.composables.controls

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
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
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type
import androidx.compose.ui.unit.dp

@Composable
internal fun CustomButton(
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

    var isClickAnimationActive by remember { mutableStateOf(false) }
    val isPressed by interactionSource.collectIsPressedAsState()

    isClickAnimationActive = isPressed

    val targetScale = when {
        isClickAnimationActive -> 0.9f
        isFocused && enableScaledFocus -> 1.05f
        else -> 1.0f
    }

    val animatedScale by animateFloatAsState(
        targetValue = targetScale,
        animationSpec = spring(dampingRatio = 0.5f, stiffness = 400f),
        label = "buttonScaleAnimation"
    )

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
            .onKeyEvent { event ->
                if (!enabled || !isFocused) return@onKeyEvent false

                val isDpadClick = event.key == Key.Enter || event.key == Key.DirectionCenter

                if (isDpadClick) {
                    when (event.type) {
                        KeyEventType.KeyDown -> {
                            isClickAnimationActive = true
                            return@onKeyEvent false
                        }

                        KeyEventType.KeyUp -> {
                            isClickAnimationActive = false
                            return@onKeyEvent false
                        }

                        else -> return@onKeyEvent false
                    }
                }
                return@onKeyEvent false
            }
            .scale(animatedScale)
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