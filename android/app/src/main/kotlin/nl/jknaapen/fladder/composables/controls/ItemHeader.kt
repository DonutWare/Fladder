package nl.jknaapen.fladder.composables.controls

import PlayableData
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import coil3.compose.AsyncImage

@Composable
fun ItemHeader(
    modifier: Modifier = Modifier,
    state: PlayableData?
) {
    val title = state?.currentItem?.title
    val logoUrl = state?.currentItem?.logoUrl

    Box(
        modifier = modifier
            .fillMaxWidth()
            .statusBarsPadding(),
        contentAlignment = Alignment.CenterStart
    ) {
        if (!logoUrl.isNullOrBlank()) {
            AsyncImage(
                model = logoUrl,
                contentDescription = title ?: "logo",
                alignment = Alignment.CenterStart,
                modifier = Modifier
                    .fillMaxHeight(0.20f)
                    .fillMaxWidth(0.45f)
            )
        } else {
            title?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.headlineMedium.copy(
                        color = Color.White,
                        fontWeight = FontWeight.Bold
                    ),
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )
            }
        }
    }
}
