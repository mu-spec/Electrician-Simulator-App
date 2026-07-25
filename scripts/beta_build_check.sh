#!/usr/bin/env bash
set -euo pipefail

echo "VoltMaster Pro — Beta Build Check"
echo "================================="

flutter --version
flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release

echo ""
echo "Build complete:"
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
echo "AAB: build/app/outputs/bundle/release/app-release.aab"
