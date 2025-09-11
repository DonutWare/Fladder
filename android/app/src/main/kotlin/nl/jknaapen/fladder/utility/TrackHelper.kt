package nl.jknaapen.fladder.utility

import android.net.Uri
import androidx.annotation.OptIn
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.TrackSelectionOverride
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector

data class InternalAudioTrack(
    val rendererIndex: Int,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String
)

data class InternalSubtitleTrack(
    val rendererIndex: Int,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String
)

@OptIn(UnstableApi::class)
fun ExoPlayer.getAudioTracks(): List<InternalSubtitleTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<InternalSubtitleTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_AUDIO) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups[groupIndex]
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    InternalSubtitleTrack(
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
fun ExoPlayer.setInternalAudioTrack(audioTrack: InternalSubtitleTrack) {
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
    // Fully disable audio renderer so no audio track selected
    selector.setParameters(
        selector.buildUponParameters()
            .setRendererDisabled(C.TRACK_TYPE_AUDIO, disable)
            .build()
    )
}

@OptIn(UnstableApi::class)
fun ExoPlayer.getSubtitleTracks(): List<InternalSubtitleTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<InternalSubtitleTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_TEXT) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups[groupIndex]
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    InternalSubtitleTrack(
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
fun ExoPlayer.clearSubtitleTrack(disable: Boolean = true) {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    // Disable text renderer entirely
    selector.setParameters(
        selector.buildUponParameters()
            .setRendererDisabled(C.TRACK_TYPE_TEXT, disable)
            .build()
    )
}

@OptIn(UnstableApi::class)
fun ExoPlayer.setInternalSubtitleTrack(subtitleTrack: InternalSubtitleTrack) {
    try {
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


@OptIn(UnstableApi::class)
fun ExoPlayer.addExternalSubtitle(
    uri: Uri,
    mimeType: String = MimeTypes.APPLICATION_SUBRIP,
    language: String? = null,
    label: String? = null,
    selectionFlags: Int = C.SELECTION_FLAG_DEFAULT
) {
    val subtitleConfig = MediaItem.SubtitleConfiguration.Builder(uri)
        .setMimeType(mimeType)
        .setLanguage(language)
        .setLabel(label)
        .setSelectionFlags(selectionFlags)
        .build()

    val currentItem = currentMediaItem ?: return
    val newItem = currentItem.buildUpon()
        .setSubtitleConfigurations(listOf(subtitleConfig))
        .build()

    val index = currentMediaItemIndex
    replaceMediaItem(index, newItem)
}
