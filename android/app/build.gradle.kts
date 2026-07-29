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
    ndkVersion = flutter.ndkVersion

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

        // NOTE:
        // Do NOT set ndk.abiFilters when using Flutter --split-per-abi /
        // --target-platform (causes Gradle ABI conflict).
        // ABI is locked via Flutter build flags to arm64 only:
        //   --target-platform android-arm64
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
            // Proguard rules in proguard-rules.pro keep Flutter engine & AdMob
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
