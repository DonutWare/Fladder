package nl.jknaapen.fladder.objects

import PlayerSettings
import PlayerSettingsPigeon
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.map

object PlayerSettingsObject : PlayerSettingsPigeon {
    val settings: MutableStateFlow<PlayerSettings?> = MutableStateFlow(null)
    val skipMap = settings.map { it?.skipTypes ?: mapOf() }

    override fun sendPlayerSettings(playerSettings: PlayerSettings) {
        settings.value = playerSettings
    }
}