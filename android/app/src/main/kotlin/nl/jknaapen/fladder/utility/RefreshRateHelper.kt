package nl.jknaapen.fladder.utility

import android.hardware.display.DisplayManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.Display
import android.view.Window
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeoutOrNull
import kotlin.math.roundToInt
import kotlin.time.Duration.Companion.seconds

private const val TAG = "RefreshRateHelper"

suspend fun applyRefreshRate(
    window: Window,
    displayManager: DisplayManager,
    videoWidth: Int,
    videoHeight: Int,
    frameRate: Float,
) = withContext(Dispatchers.IO) {
    val display = displayManager.getDisplay(Display.DEFAULT_DISPLAY)
    val displayModes = display.supportedModes
        .orEmpty()
        .map { RefreshRateDisplayMode(it) }
        .sortedWith(
            compareByDescending<RefreshRateDisplayMode> { it.physicalWidth * it.physicalHeight }
                .thenBy { it.refreshRateRounded }
        )

    val currentMode = display.mode
    val targetMode = findDisplayMode(
        displayModes = displayModes,
        streamWidth = videoWidth,
        streamHeight = videoHeight,
        targetFrameRate = frameRate,
    )

    Log.d(TAG, "Video: ${videoWidth}x${videoHeight} @ ${frameRate}fps — target mode: $targetMode, current: $currentMode")

    if (targetMode == null || targetMode.modeId == currentMode.modeId) return@withContext

    val listener = DisplayChangeListener(display.displayId)
    displayManager.registerDisplayListener(listener, Handler(Looper.getMainLooper()))
    try {
        withContext(Dispatchers.Main) {
            val attrs = window.attributes
            attrs.preferredDisplayModeId = targetMode.modeId
            window.attributes = attrs
        }
        withTimeoutOrNull(5.seconds) { listener.deferred.await() }
    } finally {
        displayManager.unregisterDisplayListener(listener)
    }

    // Wait for non-seamless switches (https://developer.android.com/media/optimize/performance/frame-rate)
    val targetRateMillis = (targetMode.refreshRate * 1000).roundToInt()
    val currentRateMillis = (currentMode.refreshRate * 1000).roundToInt()
    val isSeamless = targetRateMillis == currentRateMillis ||
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            currentMode.alternativeRefreshRates
                .map { (it * 1000).roundToInt() }
                .any { it % targetRateMillis == 0 }
        } else {
            false
        }
    if (!isSeamless) {
        delay(2.seconds)
    }
}

fun resetRefreshRate(window: Window) {
    val attrs = window.attributes
    attrs.preferredDisplayModeId = 0
    window.attributes = attrs
}

private fun findDisplayMode(
    displayModes: List<RefreshRateDisplayMode>,
    streamWidth: Int,
    streamHeight: Int,
    targetFrameRate: Float,
): RefreshRateDisplayMode? {
    val streamRate = (targetFrameRate * 1000).roundToInt()
    val candidates = displayModes
        .filter { it.physicalWidth >= streamWidth && it.physicalHeight >= streamHeight }
        .filter { frameRateMatches(it.refreshRateRounded, streamRate) }

    // Exact resolution + exact frame rate
    return candidates.firstOrNull {
        it.physicalWidth == streamWidth && it.physicalHeight == streamHeight && it.refreshRateRounded == streamRate
    }
        // Next highest resolution + exact frame rate
        ?: candidates.lastOrNull {
            it.physicalWidth >= streamWidth && it.physicalHeight >= streamHeight && it.refreshRateRounded == streamRate
        }
        // Exact resolution + acceptable frame rate
        ?: candidates.lastOrNull {
            it.physicalWidth == streamWidth && it.physicalHeight == streamHeight
        }
        // Next highest resolution + acceptable frame rate
        ?: candidates.lastOrNull {
            it.physicalWidth >= streamWidth && it.physicalHeight >= streamHeight
        }
        // Highest resolution at exact frame rate
        ?: displayModes
            .filter { it.refreshRateRounded == streamRate }
            .maxByOrNull { it.physicalWidth * it.physicalHeight }
        // Fallback: highest resolution
        ?: displayModes.maxByOrNull { it.physicalWidth * it.physicalHeight }
}

private fun frameRateMatches(refreshRateRounded: Int, streamRate: Int): Boolean {
    return refreshRateRounded % streamRate == 0 ||
        refreshRateRounded == (streamRate * 2.5).roundToInt()
}

data class RefreshRateDisplayMode(
    val modeId: Int,
    val physicalWidth: Int,
    val physicalHeight: Int,
    val refreshRate: Float,
) {
    val refreshRateRounded: Int = (refreshRate * 1000).roundToInt()

    constructor(mode: Display.Mode) : this(
        mode.modeId,
        mode.physicalWidth,
        mode.physicalHeight,
        mode.refreshRate,
    )
}

private class DisplayChangeListener(val displayId: Int) : DisplayManager.DisplayListener {
    val deferred = CompletableDeferred<Unit>()
    override fun onDisplayAdded(displayId: Int) {}
    override fun onDisplayRemoved(displayId: Int) {}
    override fun onDisplayChanged(displayId: Int) {
        if (displayId == this.displayId) deferred.complete(Unit)
    }
}
