# VoltMaster Pro — 50-Language Localization Audit

**Audit date:** 2026-07-16  
**Source branch reviewed:** `main`  
**Supported locales:** 50 total (`en` plus 49 translated locales)

## Result

The automated coverage audit now passes with **100% structural translation-key coverage** for the user-visible strings included in the app's localization corpus.

```text
Supported languages: 50
Base exact keys per translated language: 1457
Audit-generated exact keys per translated language: 3722
Total exact lookup coverage per translated language: 5179
Rewarded-ad strings checked: 8
App-title language entries checked: 50
RESULT: PASS
```

Run the audit at any time:

```bash
python3 scripts/localization_audit.py
```

Codemagic now runs this command before Flutter tests.

## Important findings before the fix

1. The newer rewarded-ad labels were not present in the 49 translated catalogs.
2. The home/settings app name was rendered as a hard-coded English string.
3. Theory article summaries and bodies were replaced by generic non-English templates rather than their exact translated content.
4. Theory information-card values could fall back to English after content rewrites.
5. Wiring steps, components, warnings, mistakes, test procedures, and professional notes used partial technical-word replacement or generic repeated messages.
6. Quiz answer options and explanations used partial or generic fallback text.
7. Standards list items used generic templates instead of the source-specific translated items.
8. Certification, video, bookmark, search-result, standard-authority, share, validation, and selected metadata paths still rendered raw English values.

## Fixes implemented

- Added an exact supplemental catalog for every one of the 49 translated locales.
- Added exact lookup through `DataTranslations.translate(...)`.
- Reworked `LocalizedContent` so theory, wiring, quiz, calculator, and standards content uses exact translation entries.
- Localized theory subcards and all wiring-detail subcards.
- Added all Settings rewarded-ad labels/messages, including **Watch Ad · Remove Ads 24h**.
- Routed the app title through `appTitle` on the home screen, Settings card, splash screen, and `MaterialApp` title.
- Localized dynamic certification, video, bookmark, standards, search, share, calculator-note, validation, and saved-calculation labels.
- Added placeholder validation for dynamic strings such as `{field}` and `{value}`.
- Added a regression audit and Codemagic step so missing strings fail CI.

## Translation architecture

The original reviewed catalog remains in:

```text
lib/core/localization/data_translations.dart
```

New exact coverage entries are split by locale to keep Dart analysis manageable:

```text
lib/core/localization/generated_translations.dart
lib/core/localization/generated_translations/translations_*.dart
```

The source-string manifest used by the audit is:

```text
scripts/localization_required_strings.json
```

## Quality statement

The audit can prove that every audited source string has a non-empty lookup entry in all 49 translated locales and that the application no longer falls back to English on the corrected paths. Automated checks cannot certify that every sentence is culturally or technically perfect in every language. Electrical terminology, legal text, and safety-critical instructions should still receive native-speaker/professional review before a worldwide production release.
