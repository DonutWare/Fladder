package nl.jknaapen.fladder.utility

import androidx.compose.foundation.border
import androidx.compose.foundation.shape.CircleShape
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
import androidx.compose.ui.unit.dp

/**
 * Adds a subtle background when [selected] is true. Use this to visually mark the focused/selected
 * element in D-pad / keyboard navigation.
 */
fun Modifier.highlightOnFocus(color: Color? = null): Modifier = composed {
    // 1. Remember the focus state.
    var hasFocus by remember { mutableStateOf(false) }

    // 2. Conditionally create the highlight modifier.
    //    Remembering this modifier avoids recreating it on every recomposition.
    val highlightModifier = remember {
        Modifier
            .clip(RoundedCornerShape(8.dp))
            .border(
                width = 1.5.dp,
                color = color ?: Color.White.copy(alpha = 0.85f),
                shape = CircleShape
            )
    }

    this
        // 3. Always listen for focus changes to update the state.
        .onFocusChanged { focusState ->
            hasFocus = focusState.hasFocus
        }
        // 4. Apply the highlight modifier only when the composable has focus.
        .then(if (hasFocus) highlightModifier else Modifier)
}


/**
 * Requests focus on first composition when [defaultSelected] is true.
 * Returns a modifier with a focus requester attached so it can be combined with focusable()/onKeyEvent.
 *
 * Usage:
 * val modifier = Modifier.defaultSelected(true)
 * Box(modifier = modifier.focusable(...)) { ... }
 */
@Composable
fun Modifier.defaultSelected(defaultSelected: Boolean): Modifier {
    val requester = remember { FocusRequester() }
    LaunchedEffect(defaultSelected) {
        if (defaultSelected) requester.requestFocus()
    }
    return this.focusRequester(requester)
}
