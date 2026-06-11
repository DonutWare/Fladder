package nl.jknaapen.fladder.player

import java.nio.ByteBuffer
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class DvBitstreamSanitizerTest {
    @Test
    fun stripsHdr10PlusPrefixSeiBetweenVclNals() {
        val vcl1 = annexBNal(1, byteArrayOf(0x01, 0x02))
        val vcl2 = annexBNal(1, byteArrayOf(0x03, 0x04))
        val buffer = bufferOf(vcl1, hdr10PlusSei(), vcl2)
        val originalLimit = buffer.limit()

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertArrayEquals(concat(vcl1, vcl2), remainingBytes(buffer))
        assertTrue(buffer.limit() < originalLimit)
        assertEquals(0, buffer.position())
    }

    @Test
    fun stripsSuffixSei() {
        val vcl = annexBNal(1, byteArrayOf(0x01))
        val suffixSei = annexBNal(40, hdr10PlusSeiPayload())
        val buffer = bufferOf(vcl, suffixSei)

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertArrayEquals(vcl, remainingBytes(buffer))
    }

    @Test
    fun handles3ByteStartCodes() {
        val vcl1 = annexBNal(1, byteArrayOf(0x01, 0x02), startCodeLen = 3)
        val sei = annexBNal(39, hdr10PlusSeiPayload(), startCodeLen = 3)
        val vcl2 = annexBNal(1, byteArrayOf(0x03), startCodeLen = 3)
        val buffer = bufferOf(vcl1, sei, vcl2)

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertArrayEquals(concat(vcl1, vcl2), remainingBytes(buffer))
    }

    @Test
    fun preservesNonHdr10PlusT35Sei() {
        val sei = annexBNal(
            39,
            byteArrayOf(0x04, 0x07, 0x00, 0x00, 0x3C, 0x00, 0x01, 0x04, 0x00)
        )
        val buffer = bufferOf(annexBNal(1, byteArrayOf(0x01)), sei, annexBNal(1, byteArrayOf(0x02)))
        val original = remainingBytes(buffer)

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertArrayEquals(original, remainingBytes(buffer))
    }

    @Test
    fun rpuModeStripsRpuAndElButKeepsHdr10PlusSei() {
        val vcl = annexBNal(1, byteArrayOf(0x01))
        val rpu = annexBNal(62, byteArrayOf(0x19, 0x08))
        val el = annexBNal(63, byteArrayOf(0x42))
        val sei = hdr10PlusSei()
        val buffer = bufferOf(vcl, rpu, sei, el)

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = false, stripDvRpu = true)

        assertArrayEquals(concat(vcl, sei), remainingBytes(buffer))
    }

    @Test
    fun respectsPositionAndRestoresIt() {
        val prefix = byteArrayOf(0xAA.toByte(), 0xBB.toByte())
        val vcl = annexBNal(1, byteArrayOf(0x01))
        val content = concat(prefix, vcl, hdr10PlusSei())
        val buffer = ByteBuffer.wrap(content.copyOf())
        buffer.position(prefix.size)

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertEquals(prefix.size, buffer.position())
        assertArrayEquals(vcl, remainingBytes(buffer))
        assertEquals(0xAA.toByte(), buffer.get(0))
        assertEquals(0xBB.toByte(), buffer.get(1))
    }

    @Test
    fun worksOnDirectBuffers() {
        val vcl = annexBNal(1, byteArrayOf(0x01, 0x02))
        val content = concat(vcl, hdr10PlusSei())
        val buffer = ByteBuffer.allocateDirect(content.size)
        buffer.put(content)
        buffer.flip()

        DvBitstreamSanitizer.sanitize(buffer, stripHdr10PlusSei = true, stripDvRpu = false)

        assertArrayEquals(vcl, remainingBytes(buffer))
    }

    private fun annexBNal(nalUnitType: Int, payload: ByteArray, startCodeLen: Int = 4): ByteArray {
        val startCode = if (startCodeLen == 3) byteArrayOf(0, 0, 1) else byteArrayOf(0, 0, 0, 1)
        val header = byteArrayOf(((nalUnitType shl 1) and 0x7E).toByte(), 0x01)
        return concat(startCode, header, payload)
    }

    private fun hdr10PlusSeiPayload(): ByteArray =
        byteArrayOf(0x04, 0x07, 0xB5.toByte(), 0x00, 0x3C, 0x00, 0x01, 0x04, 0x00, 0x80.toByte())

    private fun hdr10PlusSei(): ByteArray = annexBNal(39, hdr10PlusSeiPayload())

    private fun concat(vararg parts: ByteArray): ByteArray {
        val result = ByteArray(parts.sumOf { it.size })
        var offset = 0
        for (part in parts) {
            part.copyInto(result, offset)
            offset += part.size
        }
        return result
    }

    private fun bufferOf(vararg parts: ByteArray): ByteBuffer = ByteBuffer.wrap(concat(*parts))

    private fun remainingBytes(buffer: ByteBuffer): ByteArray {
        val copy = ByteArray(buffer.remaining())
        buffer.duplicate().get(copy)
        return copy
    }
}
