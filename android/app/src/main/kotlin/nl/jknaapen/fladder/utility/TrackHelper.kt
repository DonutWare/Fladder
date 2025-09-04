package nl.jknaapen.fladder.utility

import androidx.annotation.OptIn
import androidx.media3.common.C
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector

data class AudioTrack(
    val rendererIndex: Int,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String
)

data class SubtitleTrack(
    val rendererIndex: Int,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String
)

@OptIn(UnstableApi::class)
fun ExoPlayer.getAudioTracks(): List<AudioTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<AudioTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_AUDIO) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups.get(groupIndex)
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    AudioTrack(
                        rendererIndex = rendererIndex,
                        trackIndex = trackIndex,
                        groupIndex = groupIndex,
                        label = format.label ?: format.language ?: "Audiotrack: $trackIndex",
                    )
                )
            }
        }
    }
    return result
}

@OptIn(UnstableApi::class)
fun ExoPlayer.setAudioTrack(audioTrack: AudioTrack) {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    val mapped = selector.currentMappedTrackInfo ?: return
    val groups = mapped.getTrackGroups(audioTrack.rendererIndex)
    if (audioTrack.groupIndex >= groups.length) return

    val override =
        DefaultTrackSelector.SelectionOverride(audioTrack.groupIndex, audioTrack.trackIndex)
    val params = selector.buildUponParameters()
        .setRendererDisabled(audioTrack.rendererIndex, false)
        .setSelectionOverride(audioTrack.rendererIndex, groups, override)
    selector.setParameters(params)
}

@OptIn(UnstableApi::class)
fun ExoPlayer.getSubtitleTracks(): List<SubtitleTrack> {
    val selector = trackSelector as? DefaultTrackSelector ?: return emptyList()
    val mapped = selector.currentMappedTrackInfo ?: return emptyList()
    val result = mutableListOf<SubtitleTrack>()

    for (rendererIndex in 0 until mapped.rendererCount) {
        if (mapped.getRendererType(rendererIndex) != C.TRACK_TYPE_TEXT) continue

        val groups = mapped.getTrackGroups(rendererIndex)
        for (groupIndex in 0 until groups.length) {
            val group = groups.get(groupIndex)
            for (trackIndex in 0 until group.length) {
                val format = group.getFormat(trackIndex)
                result.add(
                    SubtitleTrack(
                        rendererIndex = rendererIndex,
                        trackIndex = trackIndex,
                        groupIndex = groupIndex,
                        label = format.label ?: format.language ?: "Subtitletrack: $trackIndex",
                    )
                )
            }
        }
    }
    return result
}

@OptIn(UnstableApi::class)
fun ExoPlayer.setSubtitleTrack(subtitleTrack: SubtitleTrack) {
    val selector = trackSelector as? DefaultTrackSelector ?: return
    val mapped = selector.currentMappedTrackInfo ?: return
    val groups = mapped.getTrackGroups(subtitleTrack.rendererIndex)
    if (subtitleTrack.groupIndex >= groups.length) return

    val override =
        DefaultTrackSelector.SelectionOverride(subtitleTrack.groupIndex, subtitleTrack.trackIndex)
    val params = selector.buildUponParameters()
        .setRendererDisabled(subtitleTrack.rendererIndex, false)
        .setSelectionOverride(subtitleTrack.rendererIndex, groups, override)
    selector.setParameters(params)
}