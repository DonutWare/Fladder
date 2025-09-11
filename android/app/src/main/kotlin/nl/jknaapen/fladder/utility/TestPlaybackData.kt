package nl.jknaapen.fladder.utility

import AudioTrack
import Chapter
import PlayableData
import SubtitleTrack
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit

val testPlaybackData = PlayableData(
    id = "8lsf8234l99sdf923lsd8f23j98j",
    title = "Big buck bunny",
    startPosition = 0,
    description = "Short description of the movie that is being watched",
    defaultSubtrack = 1,
    defaultAudioTrack = 1,
    subtitleTracks = listOf(
        SubtitleTrack(
            name = "English",
            languageCode = "EN",
            codec = "SRT",
            index = 1,
            external = false,
        ),
        SubtitleTrack(
            name = "Dutch",
            languageCode = "NL",
            codec = "SRT",
            index = 2,
            external = false,
        ),
    ),
    audioTracks = listOf(
        AudioTrack(
            name = "English",
            languageCode = "EN",
            codec = "AC3",
            index = 1,
            external = false,
        ),
        AudioTrack(
            name = "Dutch",
            languageCode = "NL",
            codec = "SRT",
            index = 2,
            external = false,
        ),
    ),
    chapters = listOf(
        Chapter(
            name = "Chapter 1",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 5.seconds.toLong(DurationUnit.MILLISECONDS),
        ),
        Chapter(
            name = "Chapter 2",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 10.seconds.toLong(DurationUnit.MILLISECONDS),
        ),
        Chapter(
            name = "Chapter 3",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 15.seconds.toLong(DurationUnit.MILLISECONDS),
        ),
        Chapter(
            name = "Chapter 4",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 20.seconds.toLong(DurationUnit.MILLISECONDS),
        ),
        Chapter(
            name = "Chapter 5",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 25.seconds.toLong(DurationUnit.MILLISECONDS),
        ),
        Chapter(
            name = "Chapter 6",
            url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmosshoptalk.com%2Fwp-content%2Fuploads%2F2022%2F09%2FChapter-1_01.jpg&f=1&nofb=1&ipt=5e303e3979332ac9b0f3d1b7961dbeeab8fe488a5b2420654877ebb154347d8c",
            time = 30.seconds.toLong(DurationUnit.MILLISECONDS),
        )
    ),
    skipForward = 30.seconds.toLong(DurationUnit.MILLISECONDS),
    skipBackward = 15.seconds.toLong(DurationUnit.MILLISECONDS),
    segments = listOf(),
    url = "https://github.com/ietf-wg-cellar/matroska-test-files/raw/refs/heads/master/test_files/test5.mkv",
)