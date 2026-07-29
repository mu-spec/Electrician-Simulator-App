# Electrician Simulator App — Play Store Listing Draft

Package: `com.koreappstek.ElectricianSimulatorApp`
Last verified against source: 2026-07-29

> Every count below was checked against the code. Do not raise a number without
> re-counting — overstating features is a Play Store Misrepresentation violation.

## App Name

Electrician Simulator App

## Short Description

Electrical theory, calculators, wiring diagrams, quizzes & Pakistan standards — offline.

## Full Description

Electrician Simulator App is an offline-first electrical engineering companion designed for electricians, apprentices, students, solar technicians, and electrical professionals.

Learn electrical theory, perform practical calculations, review wiring diagrams, practice quiz questions, and access Pakistan-focused reference notes in one app.

## Key Features

### Theory Academy
- 59 electrical theory articles
- Beginner, journeyman, and master levels
- Topics include AC/DC, power, transformers, motors, safety, solar, smart systems, and EV charging

### Smart Calculators
- 50 practical calculators, including:
- Ohm's Law
- Power Calculator
- Voltage Drop
- Cable Size
- Motor FLC
- Transformer Size
- Solar Array Sizer
- Breaker Sizing
- Battery Bank
- Power Factor Correction
- Short Circuit Current
- UPS Backup Time
- Conduit Fill
- Harmonics THD

### Wiring Diagrams
- 20 offline wiring diagrams
- Residential wiring
- Distribution boards
- Motor starters
- Solar PV systems
- Generator and ATS
- Smart home wiring
- Full-screen zoom and pan

### Quiz & Practice
- 200 quiz questions
- Category quizzes
- Random quiz mode
- Master-level questions
- Detailed explanations

### Pakistan Standards References
- PEC awareness
- WAPDA / DISCO / K-Electric notes
- Solar net metering awareness
- Earthing and protection references
- Safety and inspection checklists

### 50 Languages
- 50 languages supported, including English, Urdu, Hindi, Arabic, Spanish, French, German, Chinese, Japanese and more
- Full RTL support for Urdu, Arabic, Farsi and Hebrew

### Offline First
- Most content works without internet
- Videos are listed offline but require internet to watch on YouTube

## Safety Disclaimer

Electrician Simulator App is for educational reference only. Electrical work can be dangerous and may be fatal if performed incorrectly. Always verify calculations, diagrams, and installation practices with the latest official electrical codes, PEC/local authority requirements, utility/DISCO/K-Electric requirements, manufacturer instructions, and qualified/licensed professionals.

## Category

Education / Tools

## Tags / Keywords

Electrical calculator, electrician app, wiring diagrams, Ohm's law, voltage drop, cable size, motor FLC, solar calculator, Pakistan electrical code, PEC, WAPDA, K-Electric, electrical quiz, electrical engineering

---

## Verified counts — 2026-07-29

| Claim | Source of truth | Actual |
|---|---|---|
| Theory articles | `TheoryArticle(` in `theory_content.dart` | **59** |
| Calculators | `CalculatorModel(` in `calculator_content.dart` | **50** |
| Wiring diagrams | `WiringDiagram(` in `wiring_content.dart` | **20** |
| Quiz questions | `QuizQuestion(` in `quiz_content.dart` | **200** |
| Languages | `supportedLanguages` in `app_localizations.dart` | **50** |

## Changes made to this draft

1. **App name** — was "VoltMaster Pro", now matches `android:label`, iOS
   `CFBundleDisplayName`, and the in-app title in all 50 locales.

2. **Wiring diagrams: "30+" → "20"** — the app registers 20 `WiringDiagram`
   entries. There are 50 image files in `assets/diagrams/`, but only 20 are
   wired into content, so 20 is the number a user actually sees.

3. **Removed the word "SVG"** — the draft said "30+ offline SVG wiring diagrams",
   but every file in `assets/diagrams/` is `.webp`, not SVG. That was a second
   inaccurate claim.

4. **Understated counts corrected upward** — the draft said "50+ articles" and
   "100+ quiz questions" while the app ships 59 and 200. Exact numbers are
   stronger marketing and remove any ambiguity.

5. **Language claim rewritten** — the draft advertised only "English and Urdu"
   plus an "Urdu Language Support" section, but the app supports **50 languages**.
   This was a significant undersell of the app's biggest differentiator.

6. **"Image-based questions" removed** from the quiz section — not verified in
   the quiz content; re-add only if confirmed.
