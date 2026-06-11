package nl.jknaapen.fladder.player

import java.nio.ByteBuffer

/**
 * In-place sanitizer for HEVC Annex B buffers carrying both Dolby Vision and HDR10+
 * dynamic metadata. Some Android TV chipsets fail when a native DV decoder also
 * receives in-band HDR10+ SEI, so keep only the dynamic metadata for the selected
 * decode path.
 */
object DvBitstreamSanitizer {
    private const val NAL_TYPE_PREFIX_SEI = 39
    private const val NAL_TYPE_SUFFIX_SEI = 40
    private const val NAL_TYPE_UNSPEC62 = 62
    private const val NAL_TYPE_UNSPEC63 = 63

    private const val SEI_PAYLOAD_TYPE_ITU_T_T35 = 4

    fun sanitize(data: ByteBuffer, stripHdr10PlusSei: Boolean, stripDvRpu: Boolean) {
        val startPos = data.position()
        val limit = data.limit()
        var writePos = startPos
        var nalStartIndex = -1
        var startCodeLen = 0

        var i = startPos
        while (i <= limit) {
            val atEnd = i == limit
            var foundStartCode = false
            var nextStartCodeLen = 0
            if (!atEnd && i + 2 < limit && data.get(i).toInt() == 0 && data.get(i + 1).toInt() == 0) {
                if (data.get(i + 2).toInt() == 1) {
                    foundStartCode = true
                    nextStartCodeLen = 3
                } else if (data.get(i + 2).toInt() == 0 && i + 3 < limit && data.get(i + 3).toInt() == 1) {
                    foundStartCode = true
                    nextStartCodeLen = 4
                }
            }

            if (foundStartCode || atEnd) {
                if (nalStartIndex >= 0) {
                    val nalDataStart = nalStartIndex + startCodeLen
                    val nalEnd = i
                    var strip = false

                    if (nalEnd - nalDataStart >= 2) {
                        val nalUnitType = (data.get(nalDataStart).toInt() and 0x7E) shr 1
                        strip = when (nalUnitType) {
                            NAL_TYPE_UNSPEC62, NAL_TYPE_UNSPEC63 -> stripDvRpu
                            NAL_TYPE_PREFIX_SEI, NAL_TYPE_SUFFIX_SEI ->
                                stripHdr10PlusSei && isHdr10PlusSeiNalUnit(data, nalDataStart + 2, nalEnd)
                            else -> false
                        }
                    }

                    if (!strip) {
                        if (writePos != nalStartIndex) {
                            for (j in nalStartIndex until nalEnd) {
                                data.put(writePos++, data.get(j))
                            }
                        } else {
                            writePos = nalEnd
                        }
                    }
                }
                nalStartIndex = i
                startCodeLen = nextStartCodeLen
                i += if (nextStartCodeLen > 0) nextStartCodeLen else 1
            } else {
                i++
            }
        }

        data.limit(writePos)
        data.position(startPos)
    }

    private fun isHdr10PlusSeiNalUnit(data: ByteBuffer, rbspStart: Int, nalEnd: Int): Boolean {
        var pos = rbspStart
        if (pos >= nalEnd) return false

        var payloadType = 0
        while (pos < nalEnd) {
            val value = data.get(pos++).toInt() and 0xFF
            payloadType += value
            if (value != 0xFF) break
        }

        var payloadSize = 0
        while (pos < nalEnd) {
            val value = data.get(pos++).toInt() and 0xFF
            payloadSize += value
            if (value != 0xFF) break
        }

        if (payloadType != SEI_PAYLOAD_TYPE_ITU_T_T35 || payloadSize < 7 || pos + 7 > nalEnd) {
            return false
        }

        val countryCode = data.get(pos).toInt() and 0xFF
        val providerCode = ((data.get(pos + 1).toInt() and 0xFF) shl 8) or (data.get(pos + 2).toInt() and 0xFF)
        val orientedCode = ((data.get(pos + 3).toInt() and 0xFF) shl 8) or (data.get(pos + 4).toInt() and 0xFF)
        val appIdentifier = data.get(pos + 5).toInt() and 0xFF
        val appVersion = data.get(pos + 6).toInt() and 0xFF

        return countryCode == 0xB5 &&
            providerCode == 0x003C &&
            orientedCode == 0x0001 &&
            appIdentifier == 4 &&
            (appVersion == 0 || appVersion == 1)
    }
}
