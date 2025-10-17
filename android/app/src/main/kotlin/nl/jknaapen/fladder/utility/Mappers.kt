package nl.jknaapen.fladder.utility

import VideoPlayerFit
import androidx.media3.common.util.UnstableApi
import androidx.media3.ui.AspectRatioFrameLayout

val VideoPlayerFit?.toExoPlayerFit: Int
    @UnstableApi
    get() = when (this) {
        VideoPlayerFit.FILL -> AspectRatioFrameLayout.RESIZE_MODE_FILL
        VideoPlayerFit.CONTAIN -> AspectRatioFrameLayout.RESIZE_MODE_FIT
        VideoPlayerFit.COVER -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
        VideoPlayerFit.FIT_WIDTH -> AspectRatioFrameLayout.RESIZE_MODE_FIXED_WIDTH
        VideoPlayerFit.FIT_HEIGHT -> AspectRatioFrameLayout.RESIZE_MODE_FIXED_HEIGHT
        VideoPlayerFit.NONE -> AspectRatioFrameLayout.RESIZE_MODE_FIXED_WIDTH
        VideoPlayerFit.SCALE_DOWN -> AspectRatioFrameLayout.RESIZE_MODE_FIT
        null -> AspectRatioFrameLayout.RESIZE_MODE_FIT
    }
