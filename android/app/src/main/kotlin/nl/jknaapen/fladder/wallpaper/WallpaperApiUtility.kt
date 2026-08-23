package nl.jknaapen.fladder.wallpaper

import FlutterError
import android.content.Intent
import androidx.core.content.FileProvider
import java.io.File

class WallpaperApiUtility(
    val applicationContext: android.content.Context,
    private val launcher: androidx.activity.result.ActivityResultLauncher<android.content.Intent>
) : WallpaperApi {
    private var pendingCallback: ((Result<Boolean>) -> Unit)? = null

    override fun openWallpaperPopup(filePath: String, callback: (Result<Boolean>) -> Unit) {
        this.pendingCallback = callback

        try {
            val file = File(filePath)

            val uri =
                FileProvider.getUriForFile(
                    applicationContext,
                    "${applicationContext.packageName}.wallpaper_provider",
                    file
                )

            val intent = Intent(Intent.ACTION_ATTACH_DATA).apply {
                addCategory(Intent.CATEGORY_DEFAULT)
                setDataAndType(uri, "image/*")
                putExtra("mimeType", "image/*")
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }

            launcher.launch(android.content.Intent.createChooser(intent, "Set wallpaper as:"))
        } catch (e: Exception) {
            // Pigeon handles exceptions gracefully and passes them back to Dart
            throw FlutterError("INTENT_ERROR", "Failed to launch intent: ${e.message}", null)
        }
    }

    fun onResult(success: Boolean) {
        pendingCallback?.invoke(Result.success(success))
        pendingCallback = null
    }
}