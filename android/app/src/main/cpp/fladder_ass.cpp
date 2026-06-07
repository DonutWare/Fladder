#include <jni.h>
#include <dlfcn.h>
#include <android/log.h>

#define LOG_TAG "FladderAss"
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

extern "C"
JNIEXPORT jboolean JNICALL
Java_nl_jknaapen_fladder_player_AssFontConfigurator_nativeSetFonts(
        JNIEnv *env,
        jobject,
        jlong nativeRenderer,
        jstring defaultFontPath,
        jstring defaultFamily
) {
    if (nativeRenderer == 0) {
        LOGE("nativeSetFonts missing renderer");
        return JNI_FALSE;
    }

    void *library = dlopen("libass.so", RTLD_NOW);
    if (library == nullptr) {
        LOGE("dlopen libass.so failed: %s", dlerror());
        return JNI_FALSE;
    }

    typedef void (*AssSetFontsFn)(void *, const char *, const char *, int, const char *, int);
    auto assSetFonts = reinterpret_cast<AssSetFontsFn>(dlsym(library, "ass_set_fonts"));
    if (assSetFonts == nullptr) {
        LOGE("dlsym ass_set_fonts failed: %s", dlerror());
        return JNI_FALSE;
    }

    const char *fontPath = defaultFontPath == nullptr
                           ? nullptr
                           : env->GetStringUTFChars(defaultFontPath, nullptr);
    const char *family = env->GetStringUTFChars(defaultFamily, nullptr);
    // ASS_FONTPROVIDER_AUTODETECT is 1 in libass. update=true rebuilds provider after addFont().
    assSetFonts(reinterpret_cast<void *>(nativeRenderer), fontPath, family, 1, nullptr, 1);
    env->ReleaseStringUTFChars(defaultFamily, family);
    if (fontPath != nullptr) {
        env->ReleaseStringUTFChars(defaultFontPath, fontPath);
    }
    return JNI_TRUE;
}
