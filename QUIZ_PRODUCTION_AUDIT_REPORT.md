# VoltMaster Pro — Production Quiz Audit

**Audit date:** 2026-07-17  
**Quiz bank:** 200 questions, 8 categories, 25 questions per category

## Final result

```text
Questions: 200
Categories: 8 × 25
Correct option A: 50
Correct option B: 50
Correct option C: 50
Correct option D: 50
Duplicate IDs: 0
Duplicate question text: 0
Repeated four-option sets: 0
Invalid correctIndex values: 0
Missing image assets: 0
Unknown related article IDs: 0
Demo/generic templates: 0
Python production audit: PASS
```

Run the audit:

```bash
python3 scripts/quiz_audit.py
```

Codemagic now runs this audit before Flutter tests.

## Issues found

### 1. Eighty placeholder/demo questions

Questions `q121` through `q200` were templated variations of the same question. They reused the same four options and the same generic explanation across different categories. These were not suitable for a production educational app.

**Fix:** Replaced all 80 with unique, subject-specific questions covering fundamentals, safety, circuits, calculations, motors, solar, standards, and master-level diagnostics.

### 2. Severe answer-position bias

Before correction:

```text
A: 139
B: 50
C: 11
D: 0
```

This made the correct answer predictable and reduced assessment quality.

**Fix:** Reordered options without changing the factual answer. Final distribution is exactly:

```text
A: 50
B: 50
C: 50
D: 50
```

Each category has a `7/6/6/6` distribution across A–D, and adjacent questions in category order do not repeat the same correct-answer position.

### 3. Weak/demo-style distractors

Thirty-seven questions contained distractors such as “All planets,” “Doorbell,” “Paint color only,” and similar obviously unrelated choices.

**Fix:** Replaced these with plausible but clearly incorrect technical distractors while preserving one unambiguous correct answer.

### 4. Statement-style and awkward question stems

Twenty-two stems ended as incomplete statements with a colon rather than a direct question. Five image/authority questions also had awkward wording.

**Fix:** Rewrote the stems as direct, professional questions and clarified image-based wording.

### 5. Pakistan authority wording

One utility question used broad `DISCO/WAPDA/K-Electric/local authority` wording that could confuse the responsible organization.

**Fix:** Updated it to the responsible DISCO, K-Electric, regulator, or local authority and retained the requirement to check current official rules.

## Correctness review

- Recalculated numerical questions for Ohm’s law, power, energy, voltage drop, three-phase current, transformer ratio, battery energy, panel count, Joule heating, synchronous speed, and motor slip.
- Reviewed electrical-safety answers for isolation, verification, stored energy, RCD limitations, LOTO, PPE, shock response, CT safety, and insulation testing.
- Reviewed motor, VFD, star-delta, overload, phase-sequence, and protection-coordination answers.
- Reviewed PV series/parallel behavior, temperature/Voc behavior, MPPT window, battery series/parallel behavior, BMS, DC arcs, anti-islanding, and hybrid commissioning.
- Reworded regulatory questions so they require verification against the latest official authority and manufacturer requirements rather than claiming the app is an approval source.

## Regression protection

Added:

```text
scripts/quiz_audit.py
test/quiz_quality_test.dart
docs/QUIZ_ANSWER_KEY.csv
```

The automated checks enforce:

- 200 unique questions
- 25 questions in each category
- exactly four unique options per question
- valid answer indices
- complete explanations
- no demo templates
- no repeated option sets
- balanced A/B/C/D positions
- no same-position adjacent questions per category
- valid image paths and related-article IDs

## Reference points

The production review used established electrical principles and current official-source checks, including:

- NEPRA Prosumer Regulations / current distributed-generation process: `https://www.nepra.org.pk/Admission%20Notices/2025/12%20Dec/NEPRA%20Prosumer%20Regulations.pdf`
- K-Electric distributed-generation interconnection requirements: `https://ke.com.pk/wp-content/uploads/2025/06/KE-requirements-for-Distributed-Generation-Interconnection.pdf`
- OSHA electrical de-energization verification guidance: `https://www.osha.gov/etools/lockout-tagout/case-studies/overhead-crane-servicing-maintenance`
- U.S. Department of Energy PV temperature behavior: `https://www.energy.gov/cmei/systems/solar-photovoltaic-performance-and-efficiency-basics`

## Production note

This audit materially improves correctness, uniqueness, answer balance, and test quality. It does not replace formal review by a licensed electrical professional familiar with every jurisdiction where the app will be distributed. Time-sensitive code and utility questions are deliberately written to require checking the latest official requirements.
