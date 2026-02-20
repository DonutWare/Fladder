package nl.jknaapen.fladder.composables.overlays.guide

import GuideChannel
import GuideProgram
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import nl.jknaapen.fladder.objects.Localized
import nl.jknaapen.fladder.objects.Translate

@Composable
fun ChannelSwitchConfirmDialog(
    show: Boolean,
    channel: GuideChannel?,
    program: GuideProgram?,
    onConfirm: () -> Unit,
    onDismiss: () -> Unit
) {
    if (show && channel != null && program != null) {
        Translate(Localized::watch) { watch ->
            Translate(Localized::decline) { decline ->
                AlertDialog(
                    onDismissRequest = onDismiss,
                    title = {
                        Translate(Localized::switchChannel) {
                            Text(it)
                        }
                    },
                    text = {
                        Translate({
                            Localized.switchChannelDesc(
                                program.name,
                                channel.name,
                                it
                            )
                        }) {
                            Text(it)
                        }
                    },
                    confirmButton = {
                        Button(onClick = onConfirm) {
                            Text(watch)
                        }
                    },
                    dismissButton = {
                        TextButton(onClick = onDismiss) {
                            Text(decline)
                        }
                    },
                    shape = RoundedCornerShape(12.dp)
                )
            }
        }
    }
}
