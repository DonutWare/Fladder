package nl.jknaapen.fladder.composables.dialogs

import Chapter
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.defaultSelected

@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun ChapterSelectionSheet(
    onSelected: (Chapter) -> Unit,
    onDismiss: () -> Unit
) {
    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState()
    val chapters = playbackData?.chapters ?: listOf()
    val currentPosition by VideoPlayerObject.position.collectAsState(0L)

    var currentChapter: Chapter? by remember {
        mutableStateOf(
            chapters[chapters.indexOfCurrent(
                currentPosition
            )]
        )
    }

    val lazyListState = rememberLazyListState()

    LaunchedEffect(Unit) {
        lazyListState.animateScrollToItem(
            chapters.indexOfCurrent(currentPosition)
        )
    }

    CustomModalBottomSheet(
        onDismiss,
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)
                .wrapContentHeight(),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Text(
                "Chapters",
                style = MaterialTheme.typography.titleLarge,
                color = Color.White
            )
            LazyRow(
                state = lazyListState,
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                chapters.forEachIndexed { index, chapter ->
                    val selectedChapter = currentChapter == chapter
                    val isCurrentChapter = chapters.indexOfCurrent(currentPosition) == index
                    item {
                        Column(
                            modifier = Modifier
                                .background(
                                    color = Color.Black.copy(alpha = 0.75f),
                                    shape = RoundedCornerShape(8.dp)
                                )
                                .border(
                                    width = 2.dp,
                                    color = Color.White.copy(alpha = if (selectedChapter) 1f else 0f),
                                    shape = RoundedCornerShape(8.dp)
                                )
                                .defaultSelected(index == 0)
                                .onFocusChanged {
                                    if (it.isFocused) {
                                        currentChapter = chapter
                                    }
                                }
                                .clickable(
                                    onClick = {
                                        onSelected(chapter)
                                    }
                                )
                                .padding(horizontal = 8.dp),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(
                                8.dp,
                                alignment = Alignment.CenterVertically
                            ),
                        ) {
                            Row(
                                horizontalArrangement = Arrangement.spacedBy(
                                    8.dp,
                                    alignment = Alignment.CenterHorizontally
                                ),
                                verticalAlignment = Alignment.CenterVertically,
                            ) {
                                Text(
                                    chapter.name,
                                    style = MaterialTheme.typography.bodyLarge,
                                    color = Color.White
                                )
                            }
                            AsyncImage(
                                model = chapter.url,
                                modifier = Modifier
                                    .clip(
                                        shape = RoundedCornerShape(24.dp)
                                    )
                                    .heightIn(min = 125.dp, max = 150.dp)
                                    .border(
                                        width = 2.dp,
                                        color = Color.White.copy(alpha = if (isCurrentChapter) 1f else 0f),
                                        shape = RoundedCornerShape(24.dp)
                                    ),
                                contentDescription = ""
                            )
                        }
                    }
                }
            }
        }
    }
}

private fun List<Chapter>.indexOfCurrent(currentPosition: Long): Int {
    return this.indexOfFirst { chapter ->
        val nextChapterTime =
            this.getOrNull(this.indexOf(chapter) + 1)?.time ?: Long.MAX_VALUE
        currentPosition >= chapter.time && currentPosition < nextChapterTime
    }
}