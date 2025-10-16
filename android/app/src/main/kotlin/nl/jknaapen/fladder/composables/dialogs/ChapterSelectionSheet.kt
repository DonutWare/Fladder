package nl.jknaapen.fladder.composables.dialogs

import Chapter
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.highlightOnFocus

@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun ChapterSelectionSheet(
    onSelected: (Chapter) -> Unit,
    onDismiss: () -> Unit
) {
    val playbackData by VideoPlayerObject.implementation.playbackData.collectAsState()
    val chapters = playbackData?.chapters ?: listOf()
    val currentPosition by VideoPlayerObject.position.collectAsState(0L)

    val focusRequesters = remember(chapters) {
        chapters.associateWith { FocusRequester() }
    }

    if (chapters.isEmpty()) return

    val lazyListState = rememberLazyListState()

    val currentChapterIndex = remember(currentPosition) {
        chapters.indexOfCurrent(currentPosition)
    }

    val currentChapter = chapters.getOrNull(currentChapterIndex)

    LaunchedEffect(currentChapter) {
        lazyListState.animateScrollToItem(chapters.indexOf(currentChapter))
        focusRequesters[currentChapter]?.requestFocus()
    }

    CustomModalBottomSheet(
        onDismiss,
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .fillMaxHeight(0.55f)
                .wrapContentHeight()
                .padding(horizontal = 16.dp, vertical = 16.dp)
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
                    val isCurrentChapter = chapters.indexOfCurrent(currentPosition) == index
                    item {
                        Column(
                            modifier = Modifier

                                .padding(horizontal = 8.dp),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(
                                8.dp,
                                alignment = Alignment.CenterVertically
                            ),
                        ) {
                            AsyncImage(
                                model = chapter.url,
                                modifier = Modifier
                                    .focusRequester(focusRequesters[chapter]!!)
                                    .highlightOnFocus(
                                        color = MaterialTheme.colorScheme.primary,
                                        width = 3.dp,
                                        shape = RoundedCornerShape(24.dp)
                                    )
                                    .clickable(
                                        onClick = {
                                            onSelected(chapter)
                                        }
                                    )
                                    .aspectRatio(1.67f)
                                    .clip(shape = RoundedCornerShape(24.dp))
                                    .weight(1f),
                                contentDescription = "",
                                contentScale = ContentScale.FillBounds
                            )
                            Row(
                                horizontalArrangement = Arrangement.spacedBy(
                                    8.dp,
                                    alignment = Alignment.Start
                                ),
                                verticalAlignment = Alignment.CenterVertically,
                            ) {
                                if (isCurrentChapter)
                                    Box(
                                        modifier = Modifier
                                            .size(16.dp)
                                            .background(
                                                color = MaterialTheme.colorScheme.primary,
                                                shape = CircleShape
                                            )
                                    )
                                Text(
                                    chapter.name,
                                    style = MaterialTheme.typography.bodyLarge,
                                    color = Color.White
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

private fun List<Chapter>.indexOfCurrent(currentPosition: Long): Int {
    if (isEmpty()) return 0

    for (i in indices) {
        val chapter = this[i]
        val nextTime = getOrNull(i + 1)?.time ?: Long.MAX_VALUE
        if (currentPosition in chapter.time until nextTime) return i
    }

    return if (currentPosition < first().time) 0 else lastIndex
}
