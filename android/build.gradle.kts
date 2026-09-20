// AGP 9 requires every library to compile against an SDK at least as high
// as its AndroidX dependencies demand. Flutter plugin subprojects keep the
// compileSdk declared in their own build.gradle (e.g. share_plus 7.2.2 uses
// android-33), which fails checkReleaseAarMetadata under AGP 9 and Flutter
// no longer syncs it automatically. Align all plugin library modules with
// the app's compileSdk. App module (:app) already sets 36 explicitly.
//
// ORDERING MATTERS: this must run BEFORE the evaluationDependsOn(":app")
// block below. That block forces :app (and transitively every plugin
// subproject) to evaluate; Gradle 9 throws "Cannot run afterEvaluate when
// the project is already evaluated" if we register hooks afterwards.
// Registering first also means our hook runs before AGP finalizes the DSL.
subprojects {
    afterEvaluate {
        extensions.findByType(com.android.build.api.dsl.LibraryExtension::class.java)?.let { libraryExtension ->
            if ((libraryExtension.compileSdk ?: 0) < 36) {
                libraryExtension.compileSdk = 36
            }
        }
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
