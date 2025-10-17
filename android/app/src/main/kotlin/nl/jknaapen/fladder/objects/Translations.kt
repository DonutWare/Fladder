package nl.jknaapen.fladder.objects

import TranslationsPigeon
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue

val Localized
    get() = TranslationsMessenger.translation

internal object TranslationsMessenger {
    lateinit var translation: TranslationsPigeon
}

@Composable
internal fun Translate(
    callback: ((Result<String>) -> Unit) -> Unit,
    key: Any? = Unit,
    content: @Composable (String) -> Unit
) {
    var value by remember { mutableStateOf<String?>(null) }

    LaunchedEffect(key) {
        callback { result ->
            value = result.getOrNull()
        }
    }

    content(value.orEmpty())
}