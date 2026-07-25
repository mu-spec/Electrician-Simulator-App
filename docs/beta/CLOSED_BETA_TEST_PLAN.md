# VoltMaster Pro — Closed Beta Test Plan

Version: 2.0.0+20  
Phase: 2I Closed Beta Candidate  
Target group: 50 electricians / apprentices / electrical engineers

## Beta Goals

1. Validate app stability on real Android devices.
2. Verify electrical formulas and wiring guidance with field users.
3. Collect feedback on Urdu mode, Pakistan standards, and usability.
4. Confirm offline-first content works without internet.
5. Prepare Play Store closed testing evidence and final launch fixes.

## Tester Profile

- 20 working electricians
- 10 electrical apprentices/students
- 10 solar installers/technicians
- 5 industrial/motor control users
- 5 electrical engineers/supervisors

## Device Coverage

Test at least:

- Android 8 / 9 low-end phone
- Android 10 / 11 mid-range phone
- Android 12 / 13 common device
- Android 14 / 15 modern device
- Small screen phone
- Large screen phone
- Dark mode and light mode
- English and Urdu mode

## Test Areas

### 1. Installation and Launch

- Install closed beta build successfully.
- App opens without crash.
- Splash screen displays correctly.
- No debug banner.
- Navigation works.

### 2. Theory Academy

- Browse categories.
- Search articles.
- Open long article.
- Bookmark article.
- Switch to Urdu and read article.
- Verify safety disclaimers are understandable.

### 3. Calculators

Test at least:

- Ohm's Law
- Power Calculator
- Voltage Drop
- Cable Size
- Motor FLC
- Transformer Size
- Solar Array
- Breaker Sizing
- Battery Bank
- Power Factor Correction
- Short Circuit Current

Report any formula mismatch or unclear unit.

### 4. Wiring Diagrams

- Open residential diagram.
- Open DB diagram.
- Open motor diagram.
- Open solar diagram.
- Open generator/ATS diagram.
- Use full-screen zoom/pan.
- Read steps, safety warnings, testing procedure.

### 5. Quiz

- Play category quiz.
- Play random quiz.
- Test image-based question.
- Finish quiz and review results.

### 6. Pakistan Standards

- Open Pakistan Standards from Home.
- Search K-Electric / DISCO / PEC / net metering.
- Open standard detail.
- Open related content links.
- Confirm disclaimers are clear.

### 7. Video Tutorials

- Open Video Tutorials.
- Search videos.
- Open video detail.
- Tap YouTube button.
- Confirm offline warning is visible.

### 8. Global Search

Search for:

- earthing
- K-Electric
- motor starter
- voltage drop
- solar
- RCD
- Urdu

Confirm result opens correct screen.

### 9. Feedback

- Open Settings → Send Beta Feedback.
- Submit bug/correction suggestion.
- Confirm email/fallback behavior.

## Pass Criteria

Closed beta is acceptable when:

- No critical crashes reported by testers.
- No dangerous formula/wiring error remains unresolved.
- Urdu mode has no blocking layout overflow.
- Main content works offline.
- Feedback flow works.
- Release AAB builds successfully.

## Severity Levels

### Critical

- App crash on launch
- Dangerous electrical advice
- Incorrect formula with safety risk
- Broken release build

### High

- Major screen unusable
- Wrong quiz answer
- Broken diagram asset
- Urdu layout unreadable

### Medium

- Spelling/wording issue
- Minor UI overflow
- Search misses expected content

### Low

- Cosmetic issue
- Feature suggestion
- Better wording request
