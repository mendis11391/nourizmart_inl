# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html


# --- Flutter --- #
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
# --- Flutter --- #

# --- firebase core --- #
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
# --- firebase core --- #

# --- Firebase --- #
-keep class com.google.firebase.** { *; }
-keep class com.firebase.** { *; }
-keep class org.apache.** { *; }
-keepnames class com.fasterxml.jackson.** { *; }
-keepnames class javax.servlet.** { *; }
-keepnames class org.ietf.jgss.** { *; }
-dontwarn org.w3c.dom.**
-dontwarn org.joda.time.**
-dontwarn org.shaded.apache.**
-dontwarn org.ietf.jgss.**
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keep class androidx.lifecycle.DefaultLifecycleObserver

-keep class com.google.firebase.analytics.** { *; }
-keep class com.google.firebase.core.** { *; }
-keep class com.google.firebase.crashlytics.** { *; }
-keep class com.google.android.gms.** { *; }
# --- Firebase --- #

# --- Crashlytics --- #
-keepattributes SourceFile,LineNumberTable        # Keep file names and line numbers.
-keep public class * extends java.lang.Exception  
-keep class com.ito_technologies.soudan.** { *; }
# --- Crashlytics --- #

# --- Connectivity Plus --- #
-keep class io.flutter.plugins.connectivity.** { *; }
-keep class com.connectivityplus.** { *; }
# --- Connectivity Plus --- #

# --- Internet Connectivity Checker Plus --- #
-keep class rocks.outdatedguy.internet_connection_checker_plus.** { *; }
-keep interface rocks.outdatedguy.internet_connection_checker_plus.** { *; }
-keepclassmembers class rocks.outdatedguy.internet_connection_checker_plus.** { *; }
# --- Internet Connectivity Checker Plus --- #

# --- Cupertino Icons --- #
-keep class com.cupertinoicons.** { *; }
# --- Cupertino Icons --- #

# --- Device Info --- #
-keep class io.flutter.plugins.deviceinfo.** { *; }
-keep class com.deviceinfo.** { *; }
-keep class android.os.** { *; }
-keep class android.content.pm.** { *; }
-keep class android.content.res.** { *; }
-keep class android.util.** { *; }
# --- Device Info --- #

# --- Dio --- #
-keep class com.dio.** { *; }
-keep class com.google.gson.** { *; }
-keep class com.squareup.okhttp3.** { *; }
-keep class okio.** { *; }
-keep class dio.** { *; }
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod
# --- Dio --- #

# --- Flutter Svg --- #
-keep class com.flutter_svg.** { *; }
-keep class com.caverock.androidsvg.** { *; }
-keep class com.hoanganhtuan95ptit.flutter_svg.** { *; }
-keep class com.hoanganhtuan95ptit.awesome.* { *; }
-keep class com.hoanganhtuan95ptit.awesome.** { *; }
-keep class com.hoanganhtuan95ptit.awesome.localization_helper.* { *; }
-keep class com.hoanganhtuan95ptit.awesome.localization_helper.** { *; }
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- Flutter Svg --- #

# --- Flutter Toast --- #
-keep class com.pichillilorenzo.fluttertoast.** { *; }
-keep class com.fluttertoast.** { *; }
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- Flutter Toast --- #

# --- Focus Detector --- #
-keep class com.focus_detector.** { *; }
-keep class io.flutter.view.** { *; }
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- Focus Detector --- #

# --- GetX --- #
-keep class $GetX** { *; }
-keep class **.GetXController { *; }
-keep class **.GetXService { *; }
-keep class **.GetXControllerRelease { *; }
-keep class **.GetXServiceRelease { *; }
-keep class com.get.** { *; }
-keep class com.get.rx.** { *; }
-keep class com.get.state.** { *; }
-keep class com.get.utils.** { *; }
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- GetX --- #

# --- GetX Storage --- #
-keep class com.revosleap.data.** { *; }
-keep class com.get_storage.** { *; }
-keep class com.get.** { *; }
-dontwarn com.get.**
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- GetX Storage --- #

# --- Intl --- #
-keep class intl.** { *; }
-keep class com.intl.** { *; }
# --- Intl --- #

# --- Lottie --- #
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**
-keepattributes Signature
-keepattributes SourceFile
-keepattributes LineNumberTable
# --- Lottie --- #


