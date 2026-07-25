# Flutter + Electrician Simulator App ProGuard rules for R8 full mode
# Keeps Flutter engine, plugins, and AdMob from being stripped

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Mobile Ads
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.android.gms.internal.** { *; }
-keep class com.google.ads.** { *; }

# Printing & PDF
-keep class com.itextpdf.** { *; }
-keep class android.print.** { *; }

# url_launcher, share_plus, package_info, image_picker, sqflite, path_provider
-keep class androidx.core.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.julienr.** { *; }

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep annotations
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# Flutter wrapper
-keep class io.flutter.embedding.** { *; }

# Don't obfuscate Dart - Flutter handles its own obfuscation
-keep class dart.ffi.** { *; }

# Keep model classes (Gson/Moshi not used but safe)
-keep class com.muspec.electriciansimulator.** { *; }

# R8 full mode compatibility
-dontwarn **
-dontnote **
