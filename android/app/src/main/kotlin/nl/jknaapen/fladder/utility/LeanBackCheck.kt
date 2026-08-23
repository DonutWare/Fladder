package nl.jknaapen.fladder.utility

import android.app.UiModeManager
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration

fun leanBackEnabled(context: Context): Boolean {
    val pm = context.packageManager
    if (pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK)) {
        return true
    }

    val uiModeManager = context.getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
    return uiModeManager.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION
}