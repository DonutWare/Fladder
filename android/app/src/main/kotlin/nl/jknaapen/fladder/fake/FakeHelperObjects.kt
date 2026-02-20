package nl.jknaapen.fladder.fake

import GuideChannel
import GuideProgram
import TVGuideModel
import android.os.Build
import androidx.annotation.RequiresApi
import nl.jknaapen.fladder.utility.toEpochMillis
import java.time.LocalDateTime

@RequiresApi(Build.VERSION_CODES.O)
object FakeHelperObjects {
    private const val POSTER_URL =
        "https://www.originalfilmart.com/cdn/shop/files/harry_potter_and_the_sorcerers_stone_2001_original_film_art_5000x.webp?v=1684872812"

    private const val CHANNEL_LOGO =
        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Flogos-world.net%2Fwp-content%2Fuploads%2F2021%2F02%2FComedy-Central-Logo.png&f=1&nofb=1&ipt=78f29573e1e410cc56ecd655b1ce12b9376d322fa8f4a35dd907c59168612ce9"


    val tvGuide by lazy {
        TVGuideModel(
            channels = channels,
            startMs = startDate.toEpochMillis(),
            endMs = startDate.plusHours(24).toEpochMillis(),
            currentProgram = channels.mapNotNull { channel ->
                channel.programs.find { program ->
                    val nowMs = LocalDateTime.now().toEpochMillis()
                    program.startMs <= nowMs && program.endMs > nowMs
                }
            }.randomOrNull()
        )
    }

    val startDate: LocalDateTime by lazy {
        LocalDateTime.now().minusMinutes(15)
    }

    val channels by lazy {
        List(25) { channelIndex ->
            GuideChannel(
                channelId = "ch-$channelIndex",
                name = "Channel ${channelIndex + 1}",
                logoUrl = CHANNEL_LOGO,
                programsLoaded = true,
                programs = run {
                    val programList = mutableListOf<GuideProgram>()
                    var lastEnd = startDate
                    repeat(10) { programIndex ->
                        val duration = listOf(30, 45, 60, 90).random()
                        var programStart = lastEnd
                        val programEnd = programStart.plusMinutes(duration.toLong())
                        if (programIndex == 0 && channelIndex % 2 == 0) {
                            // Make the first program of every other channel start earlier to simulate
                            // currently running programs
                            programStart = programStart.minusMinutes((15..90).random().toLong())
                        }
                        val program = GuideProgram(
                            "prog${channelIndex}_$programIndex",
                            "ch-$channelIndex",
                            "Program ${(65 + (programIndex % 26)).toChar()}${programIndex + 1}",
                            programStart.toEpochMillis(),
                            programEnd.toEpochMillis(),
                            POSTER_URL,
                            "A fake program description.",
                            "Subtitle ${(65 + (programIndex % 26)).toChar()}${programIndex + 1}"
                        )
                        programList.add(program)
                        lastEnd = programEnd
                    }
                    programList
                }
            )
        }
    }
}