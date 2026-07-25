# VoltMaster Pro — Production Wiring Library Audit

**Audit date:** 2026-07-17  
**Library:** 50 concept diagrams in 6 categories

## Final automated result

```text
Diagrams: 50
Categories:
  Residential: 11
  Distribution: 9
  Motors: 8
  Solar: 8
  Generator: 7
  Smart: 7
Instruction steps: 300
WebP assets: 50
Missing assets: 0
Duplicate image files: 0
Unexpected image dimensions: 0
Production wiring audit: PASS
```

Run:

```bash
python3 scripts/wiring_audit.py
```

Codemagic now executes this audit before Flutter tests.

## Issues found

### 1. Generated-prompt contamination in all 50 records

Every diagram contained image-generation prompt fragments or old production markers. The audit initially reported 100 failures: one contamination failure and one stale content-version failure for every diagram.

Across the 300 steps, there were 260 injected annotations such as:

```text
[Refer to ultra-realistic PNG diagram for visual]
as in PNG
Thermal Overload Relay TOR with dial FLC...
Red Live wire (thick red arrow...)
Blue Neutral wire (blue arrow...)
```

Some annotations incorrectly mentioned motor overload relays inside socket, distribution, solar, and smart-home instructions.

**Fix:** Removed all generated-prompt text and rewrote the affected instructions as equipment-neutral, professional steps.

### 2. Generic safety and testing text

Most records reused one of only two generic safety/mistake/testing templates. This did not adequately explain category-specific risks.

**Fix:** Added dedicated production guidance for:

- Residential isolation, polarity, protective-conductor continuity, RCD/RCBO checks, and local conductor identification
- Distribution-board arc-flash, alternate supplies, neutral grouping, fault levels, coordination, phase sequence, and torque
- Motor power/control isolation, stored energy, interlocks, overload settings, VFD testing, current balance, and rotation
- Solar PV daylight voltage, battery fault current, DC-rated protection, polarity, cold-condition Voc, MPPT limits, and anti-islanding
- Generator backfeed prevention, transfer interlocks, automatic start, neutral/earth engineering, phase sequence, voltage, and frequency
- Smart-device remote energization, physical isolation, contactor interfaces, CT safety, safe defaults, and calibrated verification

### 3. Unsafe or ambiguous visual concepts

Three raster illustrations contained material safety ambiguity:

- `res_09.webp` visually suggested neutral/protective conductors could be connected at switching terminals.
- `generator_01.webp` routed protective earth through the manual changeover concept.
- `smart_07.webp` labeled the voltage reference as being fused “to neutral.”

**Fix:** Replaced all three with deterministic concept drawings showing:

- Neutral going directly to luminaires and protective earth remaining continuous in the two-gang circuit
- A two-pole single-phase changeover for L/N while protective earth remains unswitched
- CTs on individual phase conductors and voltage-reference wiring only according to protected manufacturer terminals

### 4. Image-specific ratings and colors

Many steps treated colors, ratings, and terminal positions shown in the illustrations as universal installation requirements.

**Fix:** Removed image-specific terminal/color instructions and added a prominent warning that colors and numeric ratings are illustrative only.

### 5. Standards references were displayed without localization

`standardsReferences` were appended directly in the UI instead of passing through the exact localization system.

**Fix:** Routed standards references through `LocalizedContent.textList(...)` and added all revised wiring text to every translated catalog.

## Production safeguards added

The wiring detail page and fullscreen viewer now display a persistent warning:

> Concept diagram only — not an installation drawing. Do not copy conductor colors, terminal numbers, protection ratings, or connections without checking the actual equipment schematic, latest local requirements, and a qualified electrical professional.

All records now use:

```text
contentVersion: 2.1.0-production-wiring-audit
```

## Automated regression protection

Added:

```text
scripts/wiring_audit.py
test/wiring_quality_test.dart
docs/WIRING_ASSET_INVENTORY.csv
```

The audit enforces:

- 50 unique diagrams and titles
- Exact category totals
- 50 readable, unique 1000×545 WebP assets
- Five to nine steps per diagram
- Complete components, safety, mistakes, tests, notes, and standards lists
- No generated-prompt contamination
- Current production content version
- Critical topology guidance for the corrected two-gang, generator changeover, and CT monitor diagrams

## Engineering limitation

The library is now explicitly presented as a conceptual educational reference. The remaining raster illustrations are not certified construction drawings and cannot represent every equipment model, earthing system, conductor-identification scheme, protective-device rating, or local rule. Terminal-level installation must use the actual manufacturer schematic and a competent design reviewed for the installation jurisdiction.
