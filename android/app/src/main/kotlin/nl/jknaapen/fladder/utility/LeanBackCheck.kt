package nl.jknaapen.fladder.utility

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build

fun leanBackEnabled(context: Context): Boolean {
    val pm = context.packageManager
    val leanBackEnabled = pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK)
    val leanBackOnly = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK_ONLY)
    } else {
        false
    }
    return leanBackEnabled || leanBackOnly
}