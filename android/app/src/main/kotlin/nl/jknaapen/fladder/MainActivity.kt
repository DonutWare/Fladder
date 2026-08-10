package nl.jknaapen.fladder

import BatteryOptimizationPigeon
import FlutterError
import LocalNetworkAccessPigeon
import NativeVideoActivity
import PlayerSettingsPigeon
import StartResult
import TranslationsPigeon
import VideoPlayerApi
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import android.annotation.SuppressLint
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.PowerManager
import android.net.Uri
import android.util.Log
import android.provider.Settings
import androidx.core.content.ContextCompat
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.ui.platform.LocalContext
import androidx.core.content.FileProvider
import com.ryanheise.audioservice.AudioServiceFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.TranslationsMessenger
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.leanBackEnabled
import androidx.core.net.toUri
import nl.jknaapen.fladder.wallpaper.WallpaperApi
import nl.jknaapen.fladder.wallpaper.WallpaperApiUtility
import java.io.File
import java.util.Objects

class WallpaperFileProvider : FileProvider()

/// Referenced by name rather than via [android.Manifest.permission] so the app
/// still compiles against SDKs that predate the constant.
private const val LOCAL_NETWORK_PERMISSION = "android.permission.ACCESS_LOCAL_NETWORK"
private const val LOCAL_NETWORK_PERMISSION_SDK = 36

class MainActivity : AudioServiceFragmentActivity(), NativeVideoActivity {
    private lateinit var videoPlayerLauncher: ActivityResultLauncher<Intent>
    private var videoPlayerCallback: ((Result<StartResult>) -> Unit)? = null
    private var localNetworkCallback: ((Result<Boolean>) -> Unit)? = null

    private val localNetworkPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        val callback = localNetworkCallback
        localNetworkCallback = null
        callback?.invoke(Result.success(granted))
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val videoPlayerHost = VideoPlayerObject
        NativeVideoActivity.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            this
        )
        WallpaperApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            WallpaperApiUtility(this, wallpaperLauncher)
        )
        VideoPlayerApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            videoPlayerHost.implementation
        )
        videoPlayerHost.videoPlayerListener =
            VideoPlayerListenerCallback(flutterEngine.dartExecutor.binaryMessenger)

        videoPlayerHost.videoPlayerControls =
            VideoPlayerControlsCallback(flutterEngine.dartExecutor.binaryMessenger)

        TranslationsMessenger.translation =
            TranslationsPigeon(flutterEngine.dartExecutor.binaryMessenger)

        PlayerSettingsPigeon.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            api = PlayerSettingsObject
        )

        BatteryOptimizationPigeon.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            api = object : BatteryOptimizationPigeon {
                override fun isIgnoringBatteryOptimizations(): Boolean {
                    val pm = getSystemService(POWER_SERVICE) as PowerManager
                    return pm.isIgnoringBatteryOptimizations(packageName)
                }

                override fun openBatteryOptimizationSettings() {
                    startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
                }
            }
        )

        LocalNetworkAccessPigeon.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            api = object : LocalNetworkAccessPigeon {
                override fun isPermissionRequired(): Boolean =
                    Build.VERSION.SDK_INT >= LOCAL_NETWORK_PERMISSION_SDK

                override fun hasLocalNetworkAccess(): Boolean {
                    if (!isPermissionRequired()) return true
                    return ContextCompat.checkSelfPermission(
                        this@MainActivity,
                        LOCAL_NETWORK_PERMISSION
                    ) == PackageManager.PERMISSION_GRANTED
                }

                override fun requestLocalNetworkAccess(callback: (Result<Boolean>) -> Unit) {
                    if (hasLocalNetworkAccess()) {
                        callback(Result.success(true))
                        return
                    }
                    // Only one system dialog can be in flight; don't drop the pending callback.
                    if (localNetworkCallback != null) {
                        callback(Result.success(false))
                        return
                    }
                    try {
                        localNetworkCallback = callback
                        localNetworkPermissionLauncher.launch(LOCAL_NETWORK_PERMISSION)
                    } catch (e: Exception) {
                        localNetworkCallback = null
                        callback(Result.failure(e))
                    }
                }

                override fun openAppSettings() {
                    startActivity(
                        Intent(
                            Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                            Uri.fromParts("package", packageName, null)
                        )
                    )
                }
            }
        )

        videoPlayerLauncher = registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ) { result ->
            val callback = videoPlayerCallback
            videoPlayerCallback = null

            val startResult = if (result.resultCode == RESULT_OK) {
                StartResult(resultValue = result.data?.getStringExtra("result") ?: "Finished")
            } else {
                StartResult(resultValue = "Cancelled")
            }

            VideoPlayerObject.implementation.player?.stop()
            VideoPlayerObject.implementation.player?.release()
            callback?.invoke(Result.success(startResult))
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Ensure the Activity's intent is updated so Flutter (and plugins / AutoRoute) receive runtime deep-links.
        setIntent(intent)
    }

    private val wallpaperLauncher = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()
    ) { result ->
        // Handle the result of the wallpaper intent if needed
    }

    override fun launchActivity(callback: (Result<StartResult>) -> Unit) {
        try {
            videoPlayerCallback = callback
            val intent = Intent(this, VideoPlayerActivity::class.java)
            videoPlayerLauncher.launch(intent)
        } catch (e: Exception) {
            e.printStackTrace()
            callback(Result.failure(e))
        }
    }

    override fun disposeActivity() {
        VideoPlayerObject.implementation.player?.stop()
        VideoPlayerObject.implementation.player?.release()
        VideoPlayerObject.currentActivity?.finish()
    }

    override fun isLeanBackEnabled(): Boolean = leanBackEnabled(applicationContext)
}
