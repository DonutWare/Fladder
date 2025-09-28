package nl.jknaapen.fladder

import NativeVideoActivity
import PlayerSettingsPigeon
import StartResult
import VideoPlayerApi
import VideoPlayerControlsCallback
import VideoPlayerListenerCallback
import android.content.Intent
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.ryanheise.audioservice.AudioServiceFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import nl.jknaapen.fladder.objects.PlayerSettingsObject
import nl.jknaapen.fladder.objects.VideoPlayerObject
import nl.jknaapen.fladder.utility.leanBackEnabled

class MainActivity : AudioServiceFragmentActivity(), NativeVideoActivity {
    private lateinit var videoPlayerLauncher: ActivityResultLauncher<Intent>
    private var videoPlayerCallback: ((Result<StartResult>) -> Unit)? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val videoPlayerHost = VideoPlayerObject
        NativeVideoActivity.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            this
        )
        VideoPlayerApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            videoPlayerHost.implementation
        )
        videoPlayerHost.videoPlayerListener =
            VideoPlayerListenerCallback(flutterEngine.dartExecutor.binaryMessenger)

        videoPlayerHost.videoPlayerControls =
            VideoPlayerControlsCallback(flutterEngine.dartExecutor.binaryMessenger)

        PlayerSettingsPigeon.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            api = PlayerSettingsObject
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

            callback?.invoke(Result.success(startResult))
        }
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
        VideoPlayerObject.currentActivity?.finish()
    }

    override fun isLeanBackEnabled(): Boolean = leanBackEnabled(applicationContext)
}
