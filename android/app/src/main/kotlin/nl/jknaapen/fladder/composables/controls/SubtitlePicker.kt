package nl.jknaapen.fladder.composables.controls

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.window.Dialog
import androidx.media3.common.MimeTypes
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import nl.jknaapen.fladder.utility.getSubtitleTracks
import nl.jknaapen.fladder.utility.setSubtitleTrack

@OptIn(UnstableApi::class)
@Composable
fun SubtitlePicker(
    subtitles: List<SubtitleTrack>,
    current: SubtitleTrack,
    player: ExoPlayer,
    trackSelector: DefaultTrackSelector,
    onSelected: (SubtitleTrack) -> Unit = {},
    onDismissRequest: () -> Unit,
) {
    val subTracks = player.getSubtitleTracks()
    Dialog(
        onDismissRequest,
    ) {
        Surface {
            Column {
                subTracks.forEachIndexed { index, subtitle ->
                    TextButton(
                        onClick = {
                            player.setSubtitleTrack(subtitle)
                        }
                    ) {
                        Text(
                            text = subtitle.label,
                            color = if (current == subtitle) Color.Green else Color.Black
                        )
                    }
                }
            }
        }
    }
}

/** Data class to unify internal/external subtitle info */
data class SubtitleTrack(
    val displayName: String,
    val language: String,
    val isExternal: Boolean,
    val url: String? = null, // only for external
    val mimeType: String = MimeTypes.APPLICATION_SUBRIP // default: SRT
)