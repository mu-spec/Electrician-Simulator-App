# Electrician Simulator App — Release Build Guide

## Current Version

```text
2.0.0+20
```

## Pre-Build Checklist

Run from project root:

```bash
flutter pub get
flutter analyze
flutter test
```

If all pass, build release artifacts.

## Build APK

```bash
flutter build apk --release
```

APK output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Build Android App Bundle for Play Console

```bash
flutter build appbundle --release
```

AAB output:

```text
build/app/outputs/bundle/release/app-release.aab
```

## Install Release APK on Device

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## Closed Testing Upload

1. Open Google Play Console.
2. Select app or create new app.
3. Go to Testing → Closed testing.
4. Create track.
5. Upload `app-release.aab`.
6. Add tester email list or Google Group.
7. Add release notes.
8. Submit for review.

## Release Notes Draft

```text
Electrician Simulator App 2.0 Closed Beta
- 59 theory articles
- 24 calculators
- 31 wiring diagrams
- 120 quiz questions
- Pakistan standards references
- Urdu language support
- Video tutorial placeholders
- Enhanced global search
- Beta feedback form
```

## Important

Before production release, verify:

- app icon and feature graphic
- privacy policy URL
- screenshots
- content rating
- Data Safety form
- target SDK compliance
- release signing configuration
