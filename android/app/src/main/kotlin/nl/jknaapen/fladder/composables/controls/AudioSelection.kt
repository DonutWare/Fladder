package nl.jknaapen.fladder.composables.controls

import androidx.annotation.OptIn
import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.window.Dialog
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import nl.jknaapen.fladder.utility.getAudioTracks
import nl.jknaapen.fladder.utility.setAudioTrack

@OptIn(UnstableApi::class)
@Composable
fun AudioPicker(
    audioTracks: List<AudioEntry>,
    player: ExoPlayer,
    current: AudioEntry,
    trackSelector: DefaultTrackSelector,
    onSelected: (AudioEntry) -> Unit = {},
    onDismissRequest: () -> Unit,
) {
    val audioTracks = player.getAudioTracks()

    Dialog(
        onDismissRequest
    ) {
        Surface {
            Column {
                Text("Select audio track")
                audioTracks.forEachIndexed { index, track ->
                    TextButton(
                        onClick = {
                            player.setAudioTrack(track)
//                            val parameters = trackSelector.buildUponParameters()
//                                .setRendererDisabled(C.TRACK_TYPE_AUDIO, false)
//                                .setPreferredAudioLanguage(track.language)
//                            trackSelector.setParameters(parameters)
//                            onSelected(track)
                        }
                    ) {
                        Text(
                            text = track.label,
                            color = if (current == track) Color.Green else Color.Black
                        )
                    }
                }
            }
        }
    }
}

/** Data class for audio tracks */
data class AudioEntry(
    val displayName: String,
    val language: String
)