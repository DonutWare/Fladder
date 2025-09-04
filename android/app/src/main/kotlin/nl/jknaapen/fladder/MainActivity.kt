package nl.jknaapen.fladder

import NativeVideoActivity
import StartResult
import VideoPlayerApi
import VideoPlayerListener
import android.content.Intent
import com.ryanheise.audioservice.AudioServiceFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import nl.jknaapen.fladder.objects.VideoPlayerHost

class MainActivity : AudioServiceFragmentActivity(), NativeVideoActivity {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val videoPlayerHost = VideoPlayerHost
        NativeVideoActivity.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            this
        )
        VideoPlayerApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            videoPlayerHost.implementation
        )
        videoPlayerHost.callBack =
            VideoPlayerListener(flutterEngine.dartExecutor.binaryMessenger)
    }


    override fun launchActivity(): StartResult {
        try {
            val intent = Intent(this@MainActivity, VideoPlayerActivity::class.java)
            startActivity(intent)
        } catch (e: Exception) {
            print(e)
            return StartResult(resultValue = "Error")
        }
        return StartResult(resultValue = "Closed")
    }

    override fun disposeActivity() {
//        VideoPlayerHost.currentActivity?.finish()
    }
}
