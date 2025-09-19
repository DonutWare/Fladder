package nl.jknaapen.fladder.utility

import androidx.annotation.OptIn
import androidx.media3.common.C
import androidx.media3.common.TrackSelectionOverride
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector

data class InternalTrack(
    val rendererIndex: Int,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String
)

@OptIn(UnstableApi::class)
fun ExoPlayer.getAudioTracks(): List<InternalTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<InternalTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_AUDIO) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups[groupIndex]
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    InternalTrack(
                        rendererIndex = rendererIndex,
                        groupIndex = groupIndex,
                        trackIndex = trackIndex,
                        label = format.label ?: format.language ?: "Audiotrack: $trackIndex",
                    )
                )
            }
        }
    }
    return result
}

@OptIn(UnstableApi::class)
fun ExoPlayer.setInternalAudioTrack(audioTrack: InternalTrack) {
    try {
        val selector = trackSelector as? DefaultTrackSelector ?: return
        val mapped = selector.currentMappedTrackInfo ?: return
        val groups = mapped.getTrackGroups(audioTrack.rendererIndex)
        if (audioTrack.groupIndex >= groups.length) return

        val group = groups[audioTrack.groupIndex]
        val override = TrackSelectionOverride(group, audioTrack.trackIndex)

        selector.setParameters(
            selector.buildUponParameters()
                .setRendererDisabled(audioTrack.rendererIndex, false)
                .build()
        )

        this.trackSelectionParameters = this.trackSelectionParameters
            .buildUpon()
            .setOverrideForType(override)
            .build()
    } catch (e: Exception) {
        e.printStackTrace()
    }
}

@OptIn(UnstableApi::class)
fun ExoPlayer.clearAudioTrack(disable: Boolean = true) {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    selector.setParameters(
        selector.buildUponParameters()
            .setRendererDisabled(C.TRACK_TYPE_AUDIO, disable)
            .build()
    )
}

@OptIn(UnstableApi::class)
fun ExoPlayer.getSubtitleTracks(): List<InternalTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<InternalTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_TEXT) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups[groupIndex]
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    InternalTrack(
                        rendererIndex = rendererIndex,
                        groupIndex = groupIndex,
                        trackIndex = trackIndex,
                        label = format.label ?: format.language ?: "Subtitletrack: $trackIndex",
                    )
                )
            }
        }
    }
    return result
}

@OptIn(UnstableApi::class)
fun ExoPlayer.clearSubtitleTrack() {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    val newParams = selector.buildUponParameters()
        .setRendererDisabled(C.TRACK_TYPE_TEXT, false) // keep text renderer active
        .setPreferredTextLanguage(null)                // don't auto-pick a language
        .setTrackTypeDisabled(C.TRACK_TYPE_TEXT, true) // <– disables selection of *any* text track
        .build()
    selector.setParameters(newParams)
}

@OptIn(UnstableApi::class)
fun ExoPlayer.enableSubtitles(language: String? = null) {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    val newParams = selector.buildUponParameters()
        .setTrackTypeDisabled(C.TRACK_TYPE_TEXT, false) // allow text again
        .setPreferredTextLanguage(language)             // optional: auto-pick by language
        .build()
    selector.setParameters(newParams)
}


@OptIn(UnstableApi::class)
fun ExoPlayer.setInternalSubtitleTrack(subtitleTrack: InternalTrack) {
    try {
        enableSubtitles()
        val selector = trackSelector as? DefaultTrackSelector ?: return
        val mapped = selector.currentMappedTrackInfo ?: return
        val groups = mapped.getTrackGroups(subtitleTrack.rendererIndex)
        if (subtitleTrack.groupIndex >= groups.length) return

        val group = groups[subtitleTrack.groupIndex]
        val override = TrackSelectionOverride(group, subtitleTrack.trackIndex)

        selector.setParameters(
            selector.buildUponParameters()
                .setRendererDisabled(subtitleTrack.rendererIndex, false)
                .build()
        )

        // Apply override (replaces other text overrides)
        this.trackSelectionParameters = this.trackSelectionParameters
            .buildUpon()
            .setOverrideForType(override)
            .build()
    } catch (e: Exception) {
        e.printStackTrace()
    }
}
