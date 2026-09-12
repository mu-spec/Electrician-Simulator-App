import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

android {
    namespace = "com.koreappstek.ElectricianSimulatorApp"

    // Pinned explicitly rather than inheriting flutter.compileSdkVersion.
    // Google Play requires new apps and updates to target API 36 (Android 16)
    // from 2026-08-31. Inheriting from the Flutter toolchain makes the value
    // depend on whichever SDK is installed on the build machine, so it is not
    // reproducible across machines or CI.
    compileSdk = 36
    // Pinned to NDK r28+, which produces 16 KB-aligned native libraries.
    // Google Play requires 16 KB memory page support for apps targeting
    // Android 15+ (enforced 1 Nov 2025). Inheriting flutter.ndkVersion made
    // this depend on whichever NDK the build machine happened to have.
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.koreappstek.ElectricianSimulatorApp"
        // Android 7.0 (API 24) and above only, through latest Android.
        // minSdk stays at 24: the app still installs on Android 7 and newer.
        minSdk = 24

        // API 36 = Android 16. Required by Google Play for submissions from
        // 2026-08-31. See the edge-to-edge note in AndroidManifest.xml.
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Tell any CMake-built native code to use flexible (16 KB) page
        // alignment. Harmless when no CMake project is present.
        externalNativeBuild {
            cmake {
                arguments += "-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON"
            }
        }

        // ARM64-only ABI intent for this app module's own NDK work.
        //
        // NOTE: ndk.abiFilters alone cannot stop dependency-provided native
        // libraries. The transitive jni plugin
        // (sqflite -> path_provider -> path_provider_android -> jni_flutter
        // -> jni) builds libdartjni.so via CMake inside its own library
        // module, and AGP merges that module's ABIs into the app regardless
        // of the app-level ndk.abiFilters. Flutter's
        // --target-platform android-arm64 only scopes the engine/AOT libs and
        // the ABI-scoped native-asset staging (CopyFlutterJniLibsTask), so it
        // cannot help either. The packaging excludes below are the actual
        // enforcement point for final APK/AAB contents.
        ndk {
            abiFilters += listOf("arm64-v8a")
        }
    }

    // Final packaging gate: exclude every non-ARM64 ABI from the merged JNI
    // libraries, no matter which source supplied them (plugin subprojects,
    // AARs, native assets, app jniLibs). This removes libdartjni.so copies
    // under lib/armeabi-v7a/ and lib/x86_64/ while keeping
    // lib/arm64-v8a/libdartjni.so, applies to both APK and AAB outputs, and
    // prevents any future dependency from silently bundling 32-bit/x86
    // native libraries. Codemagic keeps --target-platform android-arm64 and
    // its ABI verification steps remain enabled.
    packaging {
        jniLibs {
            excludes += setOf(
                "lib/armeabi-v7a/**",
                "lib/x86/**",
                "lib/x86_64/**",
            )
        }
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                println("WARNING: key.properties not found! Falling back to debug signing. Codemagic must handle signing in the post-build step.")
                signingConfig = signingConfigs.getByName("debug")
            }
            // Production optimization enabled: R8 full mode + resource shrinking
            // Saves ~15-18MB when combined with 50-language audit (38MB Dart)
            // Proguard rules in proguard-rules.pro keep the Flutter engine
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
