package nl.jknaapen.fladder.objects

import AutoNextType
import PlayerSettings
import PlayerSettingsPigeon
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.map
import kotlin.time.DurationUnit
import kotlin.time.toDuration

object PlayerSettingsObject : PlayerSettingsPigeon {
    val settings: MutableStateFlow<PlayerSettings?> = MutableStateFlow(null)
    val skipMap = settings.map { it?.skipTypes ?: mapOf() }

    val forwardSpeed =
        settings.map {
            (it?.skipForward ?: 1L).toDuration(DurationUnit.MILLISECONDS)
        }
    val backwardSpeed = settings.map {
        (it?.skipBackward ?: 1L).toDuration(
            DurationUnit.MILLISECONDS
        )
    }

    val themeColor = settings.map { settings ->
        settings?.themeColor.let {
            if (it == null) null else Color(it)
        }
    }

    val autoNextType = settings.map { settings ->
        settings?.autoNextType ?: AutoNextType.OFF
    }

    override fun sendPlayerSettings(playerSettings: PlayerSettings) {
        settings.value = playerSettings
    }
}