package nl.jknaapen.fladder.composables.controls

import TrickPlayModel
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.IntSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex
import coil3.compose.AsyncImagePainter
import coil3.compose.rememberAsyncImagePainter
import coil3.imageLoader
import coil3.request.ImageRequest
import coil3.toBitmap
import kotlin.time.Duration

private data class ThumbnailData(val tileUrl: String, val offset: Pair<Double, Double>)

@Composable
fun FilmstripTrickPlayOverlay(
    modifier: Modifier = Modifier,
    currentPosition: Duration,
    trickPlayModel: TrickPlayModel?,
    thumbnailsToShowOnEachSide: Int = 2,
) {
    if (trickPlayModel == null) {
        return
    }

    val context = LocalContext.current
    LaunchedEffect(trickPlayModel) {
        trickPlayModel.images.forEach { imageUrl ->
            val request = ImageRequest.Builder(context)
                .data(imageUrl)
                .build()
            context.imageLoader.enqueue(request)
        }
    }

    val uniqueThumbnails = remember(currentPosition, trickPlayModel, thumbnailsToShowOnEachSide) {
        val currentFrameIndex = (currentPosition.inWholeMilliseconds / trickPlayModel.interval)
            .toInt()
            .coerceIn(0, (trickPlayModel.thumbnailCount - 1).toInt())

        val currentFrame = trickPlayModel.getThumbnailDetailsForIndex(currentFrameIndex)
        if (currentFrame == null) return@remember emptyList()

        val foundThumbnails = mutableSetOf(currentFrame)
        val previousFrames = mutableListOf<ThumbnailData>()
        val nextFrames = mutableListOf<ThumbnailData>()

        var searchIndex = currentFrameIndex - 1
        while (previousFrames.size < thumbnailsToShowOnEachSide && searchIndex >= 0) {
            trickPlayModel.getThumbnailDetailsForIndex(searchIndex)?.let {
                if (foundThumbnails.add(it)) previousFrames.add(it)
            }
            searchIndex--
        }

        searchIndex = currentFrameIndex + 1
        while (nextFrames.size < thumbnailsToShowOnEachSide && searchIndex < trickPlayModel.thumbnailCount) {
            trickPlayModel.getThumbnailDetailsForIndex(searchIndex)?.let {
                if (foundThumbnails.add(it)) nextFrames.add(it)
            }
            searchIndex++
        }

        if (previousFrames.size < thumbnailsToShowOnEachSide) {
            var extraNeeded = thumbnailsToShowOnEachSide - previousFrames.size
            while (extraNeeded > 0 && searchIndex < trickPlayModel.thumbnailCount) {
                trickPlayModel.getThumbnailDetailsForIndex(searchIndex)?.let {
                    if (foundThumbnails.add(it)) {
                        nextFrames.add(it)
                        extraNeeded--
                    }
                }
                searchIndex++
            }
        } else if (nextFrames.size < thumbnailsToShowOnEachSide) {
            var extraNeeded = thumbnailsToShowOnEachSide - nextFrames.size
            searchIndex = currentFrameIndex - previousFrames.size - 1
            while (extraNeeded > 0 && searchIndex >= 0) {
                trickPlayModel.getThumbnailDetailsForIndex(searchIndex)?.let {
                    if (foundThumbnails.add(it)) {
                        previousFrames.add(it)
                        extraNeeded--
                    }
                }
                searchIndex--
            }
        }

        previousFrames.reversed() + currentFrame + nextFrames
    }

    val currentFrameData = trickPlayModel.getThumbnailDetailsForIndex(
        (currentPosition.inWholeMilliseconds / trickPlayModel.interval).toInt()
    )

    Row(
        modifier = modifier,
        verticalAlignment = Alignment.CenterVertically
    ) {
        uniqueThumbnails.forEach { thumbnailData ->
            val isCenter = thumbnailData == currentFrameData
            val scale = if (isCenter) 1.2f else 1.0f
            val alpha = if (isCenter) 1.0f else 0.7f

            Thumbnail(
                modifier = Modifier
                    .weight(1f)
                    .zIndex(if (isCenter) 1f else 0f)
                    .fillMaxHeight()
                    .padding(horizontal = 4.dp)
                    .padding(bottom = 8.dp)
                    .scale(scale)
                    .graphicsLayer {
                        this.alpha = alpha
                    },
                trickPlayModel = trickPlayModel,
                tileUrl = thumbnailData.tileUrl,
                offset = thumbnailData.offset
            )
        }
    }
}

@Composable
private fun Thumbnail(
    modifier: Modifier = Modifier,
    trickPlayModel: TrickPlayModel,
    tileUrl: String,
    offset: Pair<Double, Double>,
) {
    val context = LocalContext.current
    val painter = rememberAsyncImagePainter(
        ImageRequest.Builder(context)
            .data(tileUrl)
            .build()
    )
    val imageState by painter.state.collectAsState()

    Box(
        modifier = modifier
            .aspectRatio(16f / 9f)
            .clip(
                shape = RoundedCornerShape(12.dp)
            )
    ) {
        when (val state = imageState) {
            is AsyncImagePainter.State.Success -> {
                val imageBitmap = state.result.image.toBitmap().asImageBitmap()
                Canvas(modifier = Modifier.matchParentSize()) {
                    val (offsetX, offsetY) = offset
                    drawImage(
                        image = imageBitmap,
                        srcOffset = IntOffset(offsetX.toInt(), offsetY.toInt()),
                        srcSize = IntSize(
                            trickPlayModel.width.toInt(),
                            trickPlayModel.height.toInt()
                        ),
                        dstSize = IntSize(size.width.toInt(), size.height.toInt())
                    )
                }
            }

            else -> return@Box
        }
    }
}


val TrickPlayModel.imagesPerTile: Int
    get() = (tileWidth * tileHeight).toInt()

private fun TrickPlayModel.getThumbnailDetailsForIndex(index: Int): ThumbnailData? {
    val safeIndex = index.coerceIn(0, (thumbnailCount - 1).toInt())
    val indexOfTile = (safeIndex / imagesPerTile).coerceIn(0, images.size - 1)
    val tileUrl = images.getOrNull(indexOfTile) ?: return null

    val tileIndex = safeIndex % imagesPerTile
    val column = tileIndex % tileWidth
    val row = tileIndex / tileWidth
    val offset = Pair(
        (width * column).toDouble(),
        (height * row).toDouble()
    )

    return ThumbnailData(tileUrl, offset)
}