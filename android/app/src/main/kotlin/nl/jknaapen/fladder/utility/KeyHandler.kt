package nl.jknaapen.fladder.utility

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.KeyEvent
import androidx.compose.ui.input.key.KeyEventType
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.input.key.type

private val HANDLED_KEYS = setOf(
    Key.MediaStop,
    Key.X,
    Key.MediaPlay,
    Key.MediaPlayPause,
    Key.MediaPause,
    Key.P,
    Key.Back,
    Key.Escape,
    Key.ButtonB,
    Key.Backspace,
    Key.DirectionLeft,
    Key.DirectionRight,
)

@Composable
fun Modifier.keyEvent(
    additionalKeys: Set<Key> = emptySet(),
    onKeyEvent: (KeyEvent) -> Boolean
): Modifier {
    val allKeys = HANDLED_KEYS + additionalKeys
    return this
        .onKeyEvent { keyEvent: KeyEvent ->
            val ignoreKeys =
                keyEvent.type != KeyEventType.KeyDown && !allKeys.contains(keyEvent.key)
            if (ignoreKeys) {
                return@onKeyEvent false
            } else {
                return@onKeyEvent onKeyEvent(keyEvent)
            }
        }
}
