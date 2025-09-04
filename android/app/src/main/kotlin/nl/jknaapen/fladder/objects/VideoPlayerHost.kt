package nl.jknaapen.fladder.objects

import VideoPlayerListener
import nl.jknaapen.fladder.VideoPlayerActivity
import nl.jknaapen.fladder.messengers.VideoPlayerImplementation

object VideoPlayerHost {
    val implementation: VideoPlayerImplementation = VideoPlayerImplementation()
    var callBack: VideoPlayerListener? = null
    var currentActivity: VideoPlayerActivity? = null
}