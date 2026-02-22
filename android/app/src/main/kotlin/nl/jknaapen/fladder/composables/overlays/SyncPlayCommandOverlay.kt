package nl.jknaapen.fladder.composables.overlays

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.scaleIn
import androidx.compose.animation.scaleOut
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.filled.Forward
import io.github.rabehx.iconsax.filled.Pause
import io.github.rabehx.iconsax.filled.Play
import io.github.rabehx.iconsax.filled.Refresh
import io.github.rabehx.iconsax.filled.Stop
import nl.jknaapen.fladder.api.SyncPlayCommandType
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate
import nl.jknaapen.fladder.objects.VideoPlayerObject

/**
 * Centered overlay showing SyncPlay command being processed.
 * Mirrors the Flutter SyncPlayCommandIndicator design.
 */
@Composable
fun BoxScope.SyncPlayCommandOverlay(
    modifier: Modifier = Modifier
) {
    val syncPlayState by VideoPlayerObject.syncPlayCommandState.collectAsState()
    val visible by remember(syncPlayState) {
        derivedStateOf {
            syncPlayState.processing && syncPlayState.commandType != SyncPlayCommandType.NONE
        }
    }

    AnimatedVisibility(
        visible = visible,
        modifier = modifier.align(Alignment.Center),
        enter = fadeIn() + scaleIn(initialScale = 0.8f),
        exit = fadeOut() + scaleOut(targetScale = 0.8f)
    ) {
        Box(
            modifier = Modifier
                .shadow(
                    elevation = 20.dp,
                    shape = RoundedCornerShape(20.dp),
                    ambientColor = Color.Black.copy(alpha = 0.3f),
                    spotColor = Color.Black.copy(alpha = 0.3f)
                )
                .background(
                    color = MaterialTheme.colorScheme.surface.copy(alpha = 0.9f),
                    shape = RoundedCornerShape(20.dp)
                )
                .border(
                    width = 2.dp,
                    color = MaterialTheme.colorScheme.primary.copy(alpha = 0.5f),
                    shape = RoundedCornerShape(20.dp)
                )
                .padding(24.dp)
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                CommandIcon(commandType = syncPlayState.commandType)

                Spacer(modifier = Modifier.height(12.dp))

                Translate(
                    callback = { cb ->
                        when (syncPlayState.commandType) {
                            SyncPlayCommandType.PAUSE -> Localized.syncPlayCommandPausing(cb)
                            SyncPlayCommandType.UNPAUSE -> Localized.syncPlayCommandPlaying(cb)
                            SyncPlayCommandType.SEEK -> Localized.syncPlayCommandSeeking(cb)
                            SyncPlayCommandType.STOP -> Localized.syncPlayCommandStopping(cb)
                            else -> Localized.syncPlayCommandSyncing(cb)
                        }
                    },
                    key = syncPlayState.commandType
                ) { label ->
                    Text(
                        text = label,
                        style = MaterialTheme.typography.titleMedium.copy(
                            fontWeight = FontWeight.SemiBold,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                    )
                }

                Spacer(modifier = Modifier.height(4.dp))

                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.Center
                ) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(12.dp),
                        strokeWidth = 2.dp,
                        color = MaterialTheme.colorScheme.primary
                    )

                    Spacer(modifier = Modifier.width(8.dp))

                    Translate({ Localized.syncPlaySyncingWithGroup(it) }) { syncingText ->
                        Text(
                            text = syncingText,
                            style = MaterialTheme.typography.bodySmall.copy(
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun CommandIcon(commandType: SyncPlayCommandType) {
    val (icon, color) = when (commandType) {
        SyncPlayCommandType.PAUSE -> Pair(Iconsax.Filled.Pause, MaterialTheme.colorScheme.secondary)
        SyncPlayCommandType.UNPAUSE -> Pair(Iconsax.Filled.Play, MaterialTheme.colorScheme.primary)
        SyncPlayCommandType.SEEK -> Pair(Iconsax.Filled.Forward, MaterialTheme.colorScheme.tertiary)
        SyncPlayCommandType.STOP -> Pair(Iconsax.Filled.Stop, MaterialTheme.colorScheme.error)
        else -> Pair(Iconsax.Filled.Refresh, MaterialTheme.colorScheme.primary)
    }

    Box(
        modifier = Modifier
            .background(
                color = color.copy(alpha = 0.15f),
                shape = CircleShape
            )
            .padding(16.dp),
        contentAlignment = Alignment.Center
    ) {
        Icon(
            imageVector = icon,
            contentDescription = commandType.name,
            modifier = Modifier.size(48.dp),
            tint = color
        )
    }
}

