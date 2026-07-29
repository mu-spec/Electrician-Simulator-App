# Google Play Data Safety Notes — VoltMaster Pro

Last reviewed: 2026-07-29
Package: `com.koreappstek.ElectricianSimulatorApp`

Use this when filling the Play Console **Data safety** form.

> **Read this first.** The answers below describe the app **as currently built**,
> where advertising is switched off in code. If ads are ever re-enabled, jump to
> [If ads are re-enabled](#if-ads-are-re-enabled) — the answers change materially
> and submitting the wrong ones is a false declaration.

---

## Current build state: ads are OFF

The `google_mobile_ads` package is a declared dependency, but every ad path is
short-circuited in `lib/core/ads/ad_service.dart`:

```dart
bool get isAdsFree => true;                    // line 64  — ADS DISABLED GLOBALLY
Future<void> initialize() async {
  _initialized = true; return;                 // line 74  — ADS DISABLED
  ...                                          // unreachable below this point
}
```

Because `initialize()` returns before `MobileAds.instance.initialize()`, the SDK
never starts, no ad is ever requested, and no advertising ID is ever read.
`BannerAdWidget.build()` returns `SizedBox.shrink()` whenever `isAdsFree` is true,
so no banner renders either.

**Net effect: the shipped app collects and transmits nothing.**

---

## Data collection

Does the app collect or share user data?

```text
No
```

No data is collected, transmitted, or shared.

---

## Local data (not "collected" under Play's definition)

Stored on-device only, in app-private storage (SQLite + Hive):

- bookmarks
- saved calculations
- quiz results and reading progress
- language preference
- recent searches
- job/project notes and invoice drafts

Play's Data safety form only covers data that **leaves the device**. On-device-only
storage is **not** declared as collection. Nothing here is uploaded.

---

## Permissions

### `INTERNET`
Declared in `AndroidManifest.xml`. Used to open YouTube tutorial links and email
support links in external apps. No app-owned server is contacted.

### `CAMERA`
Declared in `AndroidManifest.xml`. Used by the **Resistor Scanner**
(`lib/presentation/screens/tools/resistor_scanner_screen.dart`) via `image_picker`,
so the user can photograph a resistor and manually pick colour bands.

**The photo is processed on-device and never uploaded or stored off-device.**
When the form asks about Photos/Camera, declare it as *not collected* and state
in the justification that images stay local.

### `AD_ID`
Not declared manually. The `google_mobile_ads` SDK merges
`com.google.android.gms.permission.AD_ID` into the final manifest automatically,
even while ads are disabled in code.

Play's advertising-ID question asks whether the app **uses** the ID, not whether
the permission is merged. With ads off, the ID is never read, so answer **No** —
but see the note below.

> **Recommended:** if ads are staying off for launch, remove the merged permission
> explicitly so the manifest matches the declaration:
>
> ```xml
> <uses-permission android:name="com.google.android.gms.permission.AD_ID"
>     tools:node="remove" />
> ```
>
> Cleaner still: drop `google_mobile_ads` from `pubspec.yaml` entirely until ads
> are actually needed.

---

## Account creation

Not required. The app has no login, no accounts, no user profiles.

---

## Analytics

None. No analytics SDK is present — no Firebase, no third-party trackers.

---

## Crash reporting

No crash-reporting SDK. Play Console's own Android Vitals still provides
OS-level crash data, which does not need declaring.

---

## Advertising

**Current build: no ads served.** See [Current build state](#current-build-state-ads-are-off).

---

## Data deletion

In-app: `Settings → Clear All Local Data` wipes saved calculations, bookmarks and
quiz history. Uninstalling also removes everything.

---

## Privacy policy

Play Console requires a publicly hosted privacy-policy URL regardless of how
little data is collected. The in-app links were removed deliberately; the policy
now lives only in the store listing.

Current hosted URLs are recorded in `docs/play_store/EXTERNAL_POLICY_LINKS.md`.
Keep them reachable — a dead policy URL is a common review rejection.

The hosted policy must describe the app **as shipped**: local-only storage, camera
used on-device for resistor decoding, and internet used only for outbound links.

---

## If ads are re-enabled

Re-enabling means deleting the three `ADS DISABLED` short-circuits in
`ad_service.dart`. Before doing that, all of the following must be handled:

1. **Swap the test IDs.** `lib/core/ads/ad_helper.dart` currently ships Google's
   public sample IDs (`ca-app-pub-3940256099942544/...`), as does the AdMob app ID
   in `AndroidManifest.xml`. Serving live traffic on sample IDs earns no revenue
   and violates AdMob policy. Register the app in AdMob under
   `com.koreappstek.ElectricianSimulatorApp` and substitute real unit IDs.

2. **Add a UMP consent flow.** There is currently no consent handling anywhere in
   the codebase. Google requires a certified CMP for EEA/UK users. The
   `google_mobile_ads` package bundles the User Messaging Platform; call
   `ConsentInformation.instance.requestConsentInfoUpdate(...)` and show the form
   **before** `MobileAds.instance.initialize()`.

3. **Configure messages in AdMob Console** under Privacy & messaging — a GDPR
   message for EEA/UK and a US-states message for CCPA/CPRA.

4. **Update this file and the hosted privacy policy** to disclose Google AdMob as
   a third party, advertising-ID collection, and a link to
   <https://policies.google.com/technologies/partner-sites>.

5. **Change the Data safety answers** to:
   - Data collected: **Yes**
   - Device or other IDs → Advertising ID → **Collected and shared**
   - Purpose: **Advertising or marketing**
   - Data is **not** encrypted-in-transit-exempt; confirm Google's standard handling

Submitting the "No data collected" answers above while live ads are running would
be a false declaration and is grounds for suspension.
