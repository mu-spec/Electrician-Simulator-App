# In-App Privacy Policy Link — Final Blocker Cleared

Package: `com.koreappstek.ElectricianSimulatorApp`
Date: 2026-07-29

Two files changed.

---

## What this fixes

Google Play's User Data policy requires the privacy policy in **two** places:

> "All apps must post a privacy policy link in the designated field within Play
> Console, **and** a privacy policy link or text within the app itself."

The Play Console field is your senior's job. This adds the second half.

---

## 1. `lib/presentation/screens/settings/settings_screen.dart`

A **Privacy Policy** tile now sits in Settings → About, between "Send Feedback"
and "Rate App". Tapping it opens the hosted policy in the user's browser.

```dart
_SettingsTile(
  icon: Icons.privacy_tip_outlined,
  iconColor: AppTheme.primaryBlue,
  title: l10n.t('privacyPolicy'),
  onTap: () => _openPrivacyPolicy(context),
),
```

### Already translated into all 50 languages

The `privacyPolicy` key still existed in every locale map from the earlier
version of this screen, so nothing new had to be translated:

| Locale | Label |
|---|---|
| en | Privacy Policy |
| ur | رازداری کی پالیسی |
| ja | プライバシーポリシー |
| ko | 개인 정보 보호 정책 |
| it | politica sulla riservatezza |

`AppLocalizations.t()` falls back to English if a key is ever missing, so the
tile can never render a blank label.

### Fallback if no browser is available

If `launchUrl` fails or returns false, a dialog shows the URL as selectable
text so the user can still copy it. This matters on locked-down devices and
some Android TV or emulator images where no browser handles `https` intents.

```dart
void _showLinkError(BuildContext context, AppLocalizations l10n) { ... }
```

The URL is stored once as a `static const`, so there is a single place to edit
if it ever changes.

---

## 2. `docs/play_store/EXTERNAL_POLICY_LINKS.md`

Rewritten to record the live Google Docs URL, note that it must be kept in sync
between Play Console and the app, and mark the old Netlify links as superseded.

---

## Verification done

- URL returns **HTTP 200** (checked 2026-07-29)
- Brace and paren balance confirmed — 451 to 503 lines
- All imports still used: `url_launcher` 2 uses, `AppLocalizations` 7 uses
- `localization_audit.py` brand guard still passes — no hard-coded app title
  was introduced in this file

`flutter` is unavailable in the sandbox, so please run `flutter analyze` and
`flutter test` locally before pushing.

---

## A note on the Google Docs URL

The `/pub` link works and satisfies the requirement, but a published Google Doc
is a slightly unusual host for a store privacy policy. Two things to watch:

1. **It must stay published.** If anyone un-publishes the document or changes
   its sharing settings, the URL dies — and a dead policy URL is a common
   rejection reason. Worth re-checking right before submission.
2. **Google Docs pages are heavy** and render inconsistently on small screens.
   If review ever objects, the styled HTML in `docs/web/privacy_policy.html`
   can be hosted on Netlify or GitHub Pages as a cleaner replacement.

Neither is a blocker today. The link works.

---

## Apply and push

```cmd
cd "D:\Apps\Electrician Simulator App\VoltMaster-Pro"
```

Extract `privacy_policy_link.zip` over the project, overwriting when prompted.

```cmd
flutter clean
flutter pub get
flutter analyze
flutter run
```

In the running app: **Settings → About → Privacy Policy**. Confirm it opens the
document in the browser.

```cmd
git add -A
git commit -m "feat(settings): add in-app privacy policy link

Google Play's User Data policy requires a privacy policy link inside the
app in addition to the Play Console listing field. Adds a Privacy Policy
tile to Settings > About that opens the hosted policy externally, with a
selectable-URL dialog as a fallback when no browser can handle the link.

The privacyPolicy localization key already existed in all 50 locales, so
no new translations were needed.

Also records the live policy URL in EXTERNAL_POLICY_LINKS.md and marks
the previous Netlify links as superseded."

git push origin main
```
