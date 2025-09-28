package nl.jknaapen.fladder.utility

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.O)
fun leanBackEnabled(context: Context): Boolean {
    val pm = context.packageManager
    val leanBackEnabled = pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK)
    val leanBackOnly = pm.hasSystemFeature(PackageManager.FEATURE_LEANBACK_ONLY)
    return leanBackEnabled || leanBackOnly
}