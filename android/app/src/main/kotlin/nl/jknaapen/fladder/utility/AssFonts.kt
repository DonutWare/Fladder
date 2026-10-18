package nl.jknaapen.fladder.utility

import android.content.Context
import android.util.Log
import io.github.peerless2012.ass.media.AssHandler
import java.io.File
import java.util.Collections
import java.util.WeakHashMap

/**
 * Gives libass fonts to render ASS/SSA subtitles with.
 *
 * libass is built for Android without a font provider, and ass-kt hardcodes
 *
 *     ass_set_fonts(renderer, NULL, "sans-serif", ASS_FONTPROVIDER_FONTCONFIG, NULL, 1)
 *
 * so with no fonts registered every glyph lookup fails, `renderFrame()` returns a frame
 * with no images, and `AssSubtitleParser.parse()` never emits a cue. The subtitle track is
 * selectable and nothing appears on screen, with no error.
 *
 * Registering fonts is necessary but not sufficient. libass picks a font in this order
 * (`ass_font_select` in ass_fontselect.c):
 *
 *   1. the family the script asks for   - "Arial", "Nirmala UI", … rarely present
 *   2. `family_default`                 - "sans-serif" per the call above
 *   3. the provider's `get_fallback`    - no provider exists; fontconfig is absent
 *   4. `path_default`                   - NULL, and ass-kt cannot set it
 *
 * Only step 2 is reachable from here, so the fallback font has to actually be named
 * "sans-serif". [renameFontFamily] rewrites its name table to say so.
 */
object AssFonts {

    private const val TAG = "AssFonts"

    /** Droid Sans Fallback, already shipped for mpv's `subtitleFontFile`. Covers CJK. */
    private const val BUNDLED_FONT = "flutter_assets/assets/mp-font.ttf"

    /** Must match the `family_default` ass-kt passes to `ass_set_fonts`. */
    private const val DEFAULT_FAMILY = "sans-serif"

    /**
     * Registered under their real names so a script naming one resolves at step 1.
     * Skipped when missing or oversized: libass copies each buffer into native memory.
     */
    private val SYSTEM_FONTS = listOf(
        "/system/fonts/Roboto-Regular.ttf",
        "/system/fonts/Roboto-Bold.ttf",
        "/system/fonts/DroidSans.ttf",
        "/system/fonts/DroidSans-Bold.ttf",
    )

    private const val MAX_SYSTEM_FONT_BYTES = 8L * 1024 * 1024

    /** name table ids holding a family name, plus the full name that often shares its bytes. */
    private val FAMILY_NAME_IDS = setOf(1, 4, 16)

    /** Fonts live on the Ass instance, which outlives individual media items. */
    private val installed: MutableSet<AssHandler> =
        Collections.newSetFromMap(WeakHashMap<AssHandler, Boolean>())

    @Synchronized
    fun install(context: Context, handler: AssHandler) {
        if (!installed.add(handler)) return

        try {
            val bundled = context.assets.open(BUNDLED_FONT).use { it.readBytes() }
            if (!renameFontFamily(bundled, DEFAULT_FAMILY)) {
                Log.e(TAG, "could not rename bundled font to $DEFAULT_FAMILY; ASS subtitles will not render")
            }
            handler.ass.addFont("mp-font.ttf", bundled)
        } catch (e: Exception) {
            Log.e(TAG, "could not load $BUNDLED_FONT; ASS subtitles will not render", e)
        }

        for (path in SYSTEM_FONTS) {
            val file = File(path)
            if (!file.isFile || file.length() !in 1..MAX_SYSTEM_FONT_BYTES) continue
            try {
                handler.ass.addFont(file.name, file.readBytes())
            } catch (e: Exception) {
                Log.w(TAG, "could not add $path", e)
            }
        }
    }

    /**
     * Rewrites every family-name record in the sfnt `name` table to [newFamily], in place.
     *
     * Only shortens strings, never grows them, so the string storage keeps its layout and no
     * offsets outside the name records change. Records are patched in their own encoding
     * (UTF-16BE for Windows platform 3, single byte otherwise), and ids 1/4/16 are rewritten
     * together because font compilers routinely point several records at the same bytes.
     */
    internal fun renameFontFamily(font: ByteArray, newFamily: String): Boolean {
        fun u16(offset: Int): Int =
            ((font[offset].toInt() and 0xFF) shl 8) or (font[offset + 1].toInt() and 0xFF)

        fun u32(offset: Int): Long = (u16(offset).toLong() shl 16) or u16(offset + 2).toLong()

        fun setU16(offset: Int, value: Int) {
            font[offset] = (value ushr 8).toByte()
            font[offset + 1] = value.toByte()
        }

        if (font.size < 12) return false
        // Font collections have a different header; the bundled font is a plain sfnt.
        if (String(font, 0, 4, Charsets.US_ASCII) == "ttcf") return false

        var nameTable = -1
        for (i in 0 until u16(4)) {
            val record = 12 + i * 16
            if (record + 16 > font.size) return false
            if (String(font, record, 4, Charsets.US_ASCII) == "name") {
                nameTable = u32(record + 8).toInt()
                break
            }
        }
        if (nameTable < 0 || nameTable + 6 > font.size) return false

        val recordCount = u16(nameTable + 2)
        val storage = nameTable + u16(nameTable + 4)
        var patched = 0

        for (i in 0 until recordCount) {
            val record = nameTable + 6 + i * 12
            if (record + 12 > font.size) break
            if (u16(record + 6) !in FAMILY_NAME_IDS) continue

            val length = u16(record + 8)
            val offset = storage + u16(record + 10)
            if (offset < 0 || offset + length > font.size) continue

            val replacement = if (u16(record) == 3) {
                newFamily.toByteArray(Charsets.UTF_16BE)
            } else {
                newFamily.toByteArray(Charsets.US_ASCII)
            }
            if (replacement.size > length) continue

            replacement.copyInto(font, offset)
            setU16(record + 8, replacement.size)
            patched++
        }

        return patched > 0
    }
}
