package nl.jknaapen.fladder.utility

import android.app.Activity
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat

@Composable
fun ImmersiveSystemBars(isImmersive: Boolean) {
    val view = LocalView.current
    LaunchedEffect(view) {
        val activity = view.context as? Activity
        val window = activity?.window
        if (window != null) {
            WindowCompat.setDecorFitsSystemWindows(window, false)
        }
    }

    DisposableEffect(view, isImmersive) {
        val activity = view.context as? Activity
        val window = activity?.window
        val controller = window?.let { WindowInsetsControllerCompat(it, view) }

        if (isImmersive) {
            controller?.hide(androidx.core.view.WindowInsetsCompat.Type.systemBars())
            controller?.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        } else {
            controller?.show(androidx.core.view.WindowInsetsCompat.Type.systemBars())
        }

        onDispose { }
    }
}