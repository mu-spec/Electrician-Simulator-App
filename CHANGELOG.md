# Changelog

## 2.1.0-production-wiring-audit — 2026-07-17

### Changed

- Removed image-generation prompt contamination from all 300 wiring instruction steps.
- Replaced generic safety, mistake, testing, and professional-note text with category-specific production guidance.
- Replaced three materially ambiguous visuals: two-gang switching, single-phase generator changeover, and three-phase CT energy monitoring.
- Added persistent concept-only safety notices to the wiring detail page and fullscreen diagram viewer.
- Routed wiring standards references through the 50-language localization system.
- Updated all 50 records to content version `2.1.0-production-wiring-audit`.
- Added every revised wiring string to all 49 translated-language catalogs.

### Added

- Added `scripts/wiring_audit.py` and Codemagic enforcement for wiring content and asset integrity.
- Added `test/wiring_quality_test.dart` with structure, contamination, asset, and critical-topology regression checks.
- Added `WIRING_PRODUCTION_AUDIT_REPORT.md` and `docs/WIRING_ASSET_INVENTORY.csv`.

## 2.1.0-production-quiz-audit — 2026-07-17

### Changed

- Replaced 80 repeated placeholder/demo quiz questions (`q121`–`q200`) with unique production-quality questions.
- Recalculated and manually reviewed numerical, electrical-safety, circuits, motors, solar, standards, and master-level answer keys.
- Reordered options to remove answer-position bias: A, B, C, and D now each contain exactly 50 correct answers.
- Replaced weak/demo-style distractors in 37 questions with plausible technical distractors.
- Reworded 22 incomplete statement-style stems and clarified image/authority questions.
- Updated all 200 quiz records to content version `2.1.0-production-audit`.
- Added translations for every new quiz string across all 49 translated locales.

### Added

- Added `scripts/quiz_audit.py` and Codemagic enforcement for quiz-bank structure and answer balance.
- Added `test/quiz_quality_test.dart` with structural, distribution, anti-template, and numerical-answer regression tests.
- Added `docs/QUIZ_ANSWER_KEY.csv` and `QUIZ_PRODUCTION_AUDIT_REPORT.md` for editorial review.

## 2.0.0-prd-phase1-2-alignment — 2026-07-10

### Added

- Compared workspace app against attached PRD Phase 1 and Phase 2 requirements.
- Expanded calculators from 24 to 50 with working calculation-engine cases.
- Expanded wiring diagrams from 31 to 50 with offline SVG assets and metadata.
- Expanded quiz bank from 120 to 200 questions with balanced category totals.
- Added personal notes for theory articles and wiring diagrams.
- Added SQLite notes table with database migration to version 2.
- Added basic local Job Manager with project/client/site/status/notes tracking.
- Added PRD compliance audit document.

### Notes

- Real AdMob, real in-app purchases/RevenueCat, Firebase sync, and hosted downloadable videos require external accounts/API keys and Play Console configuration.

## 2.0.0-phase2i — 2026-07-10

### Added

- Added closed beta feedback screen with category, rating, message, optional contact, app version info, email launch, and fallback copyable message.
- Added Settings → Send Beta Feedback entry.
- Added beta QA documentation, beta tester guide, Play Store listing draft, privacy policy, Data Safety notes, and release build guide.
- Added `scripts/beta_build_check.sh` to run pub get, analyze, tests, APK build, and AAB build locally.
- Added Android package visibility queries for `mailto` and `https` URL launch support.

### Changed

- Updated app version to `2.0.0+20`.
- Updated Android app label to `Electrician Simulator App`.
- Updated Settings app card to show `Version 2.0.0 Closed Beta`.
- Content manifest updated to `2.0.0-phase2i`.

## 2.0.0-phase2h — 2026-07-10

### Added

- Added Video Tutorials module with 20 offline tutorial placeholders.
- Added 5 video categories: Safety Tutorials, Wiring Tutorials, Calculation Walkthroughs, Solar & Backup, and Pakistan Standards.
- Added `TutorialVideo` and `VideoCategory` models.
- Added `VideoContent` offline content source with YouTube links and related content references.
- Added Videos screen with category filters, search, offline notice, and video detail pages.
- Added YouTube external-launch support using `url_launcher`.
- Added related content navigation from videos to theory articles, calculators, wiring diagrams, and Pakistan standards notes.
- Added enhanced Global Search screen covering theory, calculators, wiring diagrams, quiz questions, Pakistan standards, and video tutorials.
- Added search filters by content type, suggestions, and recent search persistence with Hive.
- Added Home and Settings access points for Global Search and Video Tutorials.
- Added video content validation and tests.

### Changed

- Search index now includes `SearchContentType.video`.
- Content manifest updated to `2.0.0-phase2h`.
- Content validator now validates video categories, YouTube URLs, metadata, and related content links.

## 2.0.0-phase2g — 2026-07-10

### Added

- Added English/Urdu localization system with `AppLocalizations` and app-wide locale delegate.
- Added `LocaleCubit` with persisted language selection using Hive.
- Added Urdu RTL support through Flutter locale/directionality.
- Added Settings → Language selector with English and Urdu options.
- Added localized UI strings for main navigation, home, theory, calculators, wiring, quiz, settings, and standards screens.
- Added `LocalizedContent` helper for Urdu rendering of major content titles, categories, theory article bodies, calculator names/descriptions, wiring names/descriptions, quiz category labels, and Pakistan standards labels.
- Added Urdu-friendly generated theory article renderer with Urdu sections, safety notes, formulas, common mistakes, professional tips, and Pakistan reference note.

### Changed

- MaterialApp now includes `flutter_localizations`, supported locales (`en`, `ur`), and persisted locale state.
- Content manifest updated to `2.0.0-phase2g` with supported languages `en` and `ur`.
- Home, Theory, Calculators, Wiring, Quiz, Settings, and Pakistan Standards screens now use localized UI labels where implemented.

## 2.0.0-phase2f — 2026-07-10

### Added

- Added dedicated Pakistan Standards module with 18 educational reference notes.
- Added categories for PEC Awareness, Earthing & Protection, WAPDA/DISCO/K-Electric, Solar & Net Metering, and Workplace Safety.
- Added `PakistanStandard` and `PakistanStandardCategory` models.
- Added `PakistanStandardsContent` offline content source.
- Added searchable Pakistan Standards screen with category filters.
- Added standards detail screen with key points, field checklist, warnings, disclaimers, and linked app content.
- Added related content navigation from standards to theory articles, calculators, wiring diagrams, and quiz categories.
- Added Pakistan Standards access from Home and Settings.
- Added Pakistan standards to global search index foundation.
- Added validation for standards category counts and related content IDs.
- Added tests for standards metadata, disclaimers, category counts, and search indexing.

### Changed

- Content manifest updated to `2.0.0-phase2f`.
- Content validator now supports Pakistan standards content validation.

## 2.0.0-phase2e — 2026-07-10

### Added

- Expanded quiz bank from 20 questions to 120 questions.
- Added 8 quiz categories with 15 questions each: Basics, Safety, Circuits, Calculations, Motors, Solar, PEC & Pakistan Standards, and Master Level.
- Added master-level questions, safety scenarios, calculation questions, Pakistan/local standards awareness questions, and image-based questions using offline SVG diagram assets.
- Added question metadata: tags, keywords, related article IDs, PEC/reference notes, image assets, difficulty, explanations, and content versioning.
- Added image rendering support in quiz play screen for SVG and raster image questions.
- Added difficulty badge and PEC/reference note display during quiz review.
- Added tests for 100+ quiz questions, category count accuracy, image asset existence, valid answer indexes, and metadata completeness.

### Changed

- Quiz category icons now support motors, solar, standards, and master-level categories.
- Content validator now checks quiz category `totalQuestions` against actual question count.
- Quiz enrichment now preserves Phase 2E authored metadata instead of replacing it with older category defaults.

## 2.0.0-phase2d — 2026-07-10

### Added

- Expanded Wiring Diagrams from 8 diagrams to 31 offline SVG diagrams.
- Added new wiring categories: Residential Wiring, Distribution Boards, Motor Control, Solar PV, Generator & ATS, and Smart Home.
- Added residential, three-phase DB, smart switch, solar grid-tie, generator ATS, timer motor, SPD, RCD, load balancing, and battery bank diagram topics.
- Added generated offline SVG files for every Phase 2D diagram under `assets/diagrams/`.
- Added safety warnings, common mistakes, testing procedures, professional notes, standards reference notes, tags, keywords, difficulty, and related diagram links to every diagram.
- Added wiring search by title, description, category, tags, keywords, and components.
- Added detail-page cards for safety warnings, common mistakes, testing procedure, and professional notes.
- Added tests for 25+ diagrams, SVG file existence, diagram metadata, and category count accuracy.

### Changed

- Wiring diagram viewer remains offline-first and supports full-screen zoom/pan for SVG diagrams.
- Content validator now checks wiring category `diagramCount` against actual diagram totals.
- Wiring category icons updated for residential, solar, generator, and smart home categories.

## 2.0.0-phase2c — 2026-07-10

### Added

- Expanded calculators from 8 to 24 working calculators.
- Added dedicated `CalculationEngine` with production calculation logic and validation.
- Added Conduit Fill, LED Savings, Battery Bank, Voltage Divider, Ground Rod Resistance, Harmonics THD, Power Factor Correction, kW/HP conversions, Single/Three-Phase Current, Cable Resistance, Short Circuit Current, UPS Backup Time, Capacitor Bank Size, and Earthing Conductor Size calculators.
- Added calculator engine tests covering every calculator.
- Added professional notes, safety notes, and accuracy warnings in calculator detail UI.

### Changed

- Calculator detail screen now uses centralized calculation engine instead of embedded page logic.
- Ohm's Law now supports optional inputs correctly; users can enter any two known values.
- Power Calculator reactive power formula corrected to `Q = √(S² - P²)`.
- Calculator search now checks formulas, tags, and keywords.
- New calculator icons are supported in calculator and home screens.

## 2.0.0-phase2b — 2026-07-10

### Added

- Expanded Theory Academy from 9 articles to 59 articles.
- Added new `components` theory category.
- Added new `modern` theory category.
- Added professional articles for capacitors, inductors, relays, contactors, SPDs, harmonics, generators, grounding, EMC/EMI, smart home wiring, EV charging, ATS, and more.
- Added Phase 2B article metadata: summaries, keywords, related article IDs, formulas, safety notes, common mistakes, professional tips, PEC/local authority educational notes, and content versioning.
- Added tests for 50+ article target and category count accuracy.

### Changed

- Theory category counts now match actual article totals.
- Theory Academy search now checks title, summary, category, tags, keywords, and article content.
- Content validator now flags mismatched theory category article counts.
- Theory UI now supports icons for Components and Modern Systems categories.

## 2.0.0-phase2a2 — 2026-07-10

### Added

- Content quality standards and reusable templates.
- Content enrichment layer for Phase 1 bundled data.
- Rich metadata for current theory articles, calculators, quiz questions, and wiring diagrams.
- Stronger content validation for IDs, difficulty, language, search metadata, safety notes, related content, and wiring test procedures.
- Tests for Phase 2A.2 metadata enrichment and search index coverage.

### Changed

- `AppRepository` now returns enriched content objects while preserving the same public API used by existing screens.
- Models now include full `copyWith` support for metadata enrichment.
- Content manifest updated to `2.0.0-phase2a2`.

### Notes

- Run `flutter analyze` and `flutter test` locally because Flutter/Dart are not installed in the current workspace sandbox.
