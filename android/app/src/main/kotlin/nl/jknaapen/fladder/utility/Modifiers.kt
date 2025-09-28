package nl.jknaapen.fladder.utility

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * Adds a subtle background when focused is true. Use this to visually mark the focused/selected
 * element in D-pad / keyboard navigation.
 */
fun Modifier.highlightOnFocus(
    color: Color = Color.White.copy(alpha = 0.85f),
    width: Dp = 1.5.dp,
    shape: Shape = RoundedCornerShape(16.dp)
): Modifier = composed {
    var hasFocus by remember { mutableStateOf(false) }
    val highlightModifier = remember {
        Modifier
            .clip(RoundedCornerShape(8.dp))
            .background(
                color = color.copy(alpha = 0.25f),
                shape = shape,
            )
            .border(
                width = width,
                color = color.copy(alpha = 0.5f),
                shape = shape
            )
    }

    this
        .onFocusChanged { focusState ->
            hasFocus = focusState.hasFocus
        }
        .then(if (hasFocus) highlightModifier else Modifier)
}


/**
 * Requests focus on first composition when [defaultSelected] is true.
 * Returns a modifier with a focus requester attached so it can be combined with focusable()/onKeyEvent.
 */
@Composable
fun Modifier.defaultSelected(defaultSelected: Boolean): Modifier {
    val requester = remember { FocusRequester() }
    LaunchedEffect(defaultSelected) {
        if (defaultSelected) requester.requestFocus()
    }
    return this.focusRequester(requester)
}

/**
 * Conditional if modifier
 */
@Composable
fun Modifier.conditional(condition: Boolean, modifier: Modifier.() -> Modifier): Modifier {
    return if (condition) {
        then(modifier(Modifier))
    } else {
        this
    }
}

@Composable
fun Modifier.visible(
    visible: Boolean,
): Modifier {
    val alphaAnimated by animateFloatAsState(if (visible) 1f else 0f)
    return this
        .graphicsLayer {
            alpha = alphaAnimated
        }
        .then(
            if (!visible) Modifier.pointerInput(Unit) {} else Modifier
        )
}
