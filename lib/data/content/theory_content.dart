import '../../models/theory_article.dart';

class TheoryContent {
// ==================== THEORY CATEGORIES ====================
  static const List<TheoryCategory> theoryCategories = [
    TheoryCategory(id: 'basics', name: 'Electrical Basics', iconName: 'bolt', colorHex: '#2563EB', articleCount: 8, description: 'Foundational electrical concepts, units, symbols, conductors, AC/DC, and nameplate reading.', keywords: ['voltage', 'current', 'resistance', 'units', 'symbols', 'AC', 'DC']),
    TheoryCategory(id: 'components', name: 'Components', iconName: 'memory', colorHex: '#7C3AED', articleCount: 8, description: 'Resistors, capacitors, inductors, protection devices, relays, contactors, and surge protection.', keywords: ['resistor', 'capacitor', 'inductor', 'relay', 'contactor', 'MCB', 'RCD']),
    TheoryCategory(id: 'circuits', name: 'Circuits & Laws', iconName: 'electrical_services', colorHex: '#10B981', articleCount: 7, description: 'Circuit laws, AC behavior, star/delta, load balancing, faults, and practical troubleshooting.', keywords: ['series', 'parallel', 'Kirchhoff', 'power factor', 'star delta', 'faults']),
    TheoryCategory(id: 'power', name: 'Power Systems', iconName: 'power', colorHex: '#F59E0B', articleCount: 8, description: 'Single/three phase supply, distribution boards, grounding, harmonics, generators, and protection coordination.', keywords: ['single phase', 'three phase', 'DB', 'earthing', 'harmonics', 'generator']),
    TheoryCategory(id: 'motors', name: 'Motors & Drives', iconName: 'settings', colorHex: '#8B5CF6', articleCount: 7, description: 'AC/DC motors, starters, VFDs, overload relays, protection, and troubleshooting.', keywords: ['motor', 'DOL', 'star delta', 'VFD', 'overload', 'troubleshooting']),
    TheoryCategory(id: 'safety', name: 'Safety & Codes', iconName: 'shield', colorHex: '#EF4444', articleCount: 8, description: 'Shock protection, PPE, safe isolation, LOTO, RCDs, fire safety, overheating, and code awareness.', keywords: ['safety', 'PPE', 'LOTO', 'RCD', 'shock', 'fire', 'overheating']),
    TheoryCategory(id: 'renewable', name: 'Solar & EV', iconName: 'wb_sunny', colorHex: '#06B6D4', articleCount: 7, description: 'Solar PV panels, inverters, batteries, charge controllers, grid-tie, and hybrid systems.', keywords: ['solar', 'PV', 'inverter', 'battery', 'grid tie', 'hybrid']),
    TheoryCategory(id: 'modern', name: 'Modern Systems', iconName: 'home', colorHex: '#0F766E', articleCount: 6, description: 'Smart home wiring, EV charging, EMC/EMI, monitoring, ATS, and smart protective devices.', keywords: ['smart home', 'EV charging', 'EMC', 'energy monitoring', 'ATS', 'smart breaker']),
  ];

  // ==================== THEORY ARTICLES ====================
  // Professional rewrite (2026-07-13): all 59 articles upgraded to Tier-A teaching quality.
  static const List<TheoryArticle> theoryArticles = [
    TheoryArticle(
      id: 'basics_01',
      title: 'What is Electricity?',
      category: 'basics',
      content: '''## Introduction
Electricity is the controlled movement of electric charge. In wires and cables, that charge is usually carried by electrons. Understanding voltage, current, and resistance is the foundation of every electrical job.

## Electric Charge
Matter contains positive and negative charge.
- **Positive charge** is associated with protons
- **Negative charge** is associated with electrons

Like charges repel and opposite charges attract. In metal conductors, free electrons move easily. Electricians often talk about **conventional current** (positive to negative), even though electrons actually move the other way.

## Current, Voltage and Resistance
### Current (I)
Current is the rate of charge flow, measured in **amperes (A)**.
**Formula:** I = Q / t
Where Q is charge in coulombs and t is time in seconds.

### Voltage (V)
Voltage is electrical pressure, or potential difference, measured in **volts (V)**. It is the force that pushes current through a circuit.

### Resistance (R)
Resistance opposes current flow, measured in **ohms (Ω)**.
**Formula:** R = ρ × (L / A)
Where ρ = resistivity, L = length, A = cross-sectional area.

## AC and DC
1. **Direct Current (DC)** flows in one direction (batteries, solar PV, electronics)
2. **Alternating Current (AC)** reverses direction many times per second (mains supply)

Pakistan household supply is normally **230V AC, 50Hz**.

## Worked Example
A 100W resistive lamp on 230V draws:
I = P / V = 100 / 230 ≈ **0.43A**

## Field Notes
- Voltage can exist even when almost no current is flowing
- Loose joints add resistance and create heat
- Always prove dead before touching conductors

## Safety
Never assume a circuit is off. Test with a correctly rated tester, wear proper PPE, and follow safe isolation procedure.''',
      difficulty: 'beginner',
      tags: ['fundamentals', 'current', 'voltage', 'resistance'],
      readTimeMinutes: 6,
      summary: 'A clear introduction to charge, voltage, current, resistance, AC/DC, and a Pakistan household example.',
      keywords: ['charge', 'ampere', 'volt', 'ohm', 'AC', 'DC', 'Pakistan 230V'],
      relatedArticleIds: ['basics_02', 'basics_04', 'basics_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['I = Q / t', 'R = ρ × (L / A)', 'I = P / V'],
      safetyNotes: ['Household mains can be lethal. Isolate, lock off, and verify zero energy before work.'],
      commonMistakes: ['Confusing voltage presence with current flow', 'Ignoring high-resistance joints that overheat under load'],
      professionalTips: ['Write units next to every site reading', 'Teach helpers conventional current vs electron flow early'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_02',
      title: 'Ohm\'s Law Explained',
      category: 'basics',
      content: '''## Introduction
Ohm's Law is the most used relationship in basic electrical work. It links voltage, current, and resistance for linear conductors at steady temperature.

## The Formula
**V = I × R**

Where:
- V = voltage in volts
- I = current in amperes
- R = resistance in ohms

### Triangle Method
Cover the value you need:
- Cover V → I × R
- Cover I → V / R
- Cover R → V / I

## Worked Examples
### Example 1 — Find current
12V across 4Ω:
I = 12 / 4 = **3A**

### Example 2 — Find resistance
Heater draws 10A from 230V:
R = 230 / 10 = **23Ω**

### Example 3 — Find voltage
5A through 8Ω:
V = 5 × 8 = **40V**

## Power Forms
Using P = V × I with Ohm's Law:
- **P = I² × R**
- **P = V² / R**

These are vital for heat dissipation and load checks.

## Where Ohm's Law Applies
Applies well to:
- Copper/aluminum conductors at roughly constant temperature
- Linear resistors

Does **not** fully describe:
- Diodes and transistors
- Many lamps as they warm up
- Motors during starting
- Superconductors

## Field Application
Use Ohm's Law for quick checks, not as the only design method for cable sizing or protection. Real installations also need ambient temperature, grouping, length, and code tables.

## Common Mistakes
- Using cold resistance of a heating element to predict running current
- Forgetting that measured voltage may already include drop in long cables
- Applying Ohm's Law alone to nonlinear electronics

## Professional Tips
- Measure voltage at the load under operating current
- If voltage is low and current is high, suspect overload or low resistance fault
- Cross-check with power readings where possible

## Safety
Do not open live circuits to "measure resistance." Isolate first. Resistance measurements are done on de-energized equipment.''',
      difficulty: 'beginner',
      tags: ['ohms-law', 'fundamentals', 'formula'],
      readTimeMinutes: 7,
      summary: 'Learn V = I × R with the triangle method, practical examples, limits of Ohm\'s Law, and power links.',
      keywords: ['V=IR', 'triangle method', 'power', 'linear resistance'],
      relatedArticleIds: ['basics_01', 'basics_03', 'basics_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['V = I × R', 'I = V / R', 'R = V / I', 'P = I² × R', 'P = V² / R'],
      safetyNotes: ['Never measure resistance on a live circuit. Isolate and prove dead first.'],
      commonMistakes: ['Treating every device as a fixed linear resistor', "Designing cables from Ohm's Law alone without code tables"],
      professionalTips: ['Memorize all three triangle forms and both power forms', 'Always note temperature and load condition with resistance readings'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_03',
      title: 'Electrical Power & Energy',
      category: 'basics',
      content: '''## Introduction
Power is how fast energy is used. Energy is power used over time. Your electricity bill is based on energy in kilowatt-hours (kWh), not only on amps.

## Power Formulas
1. **P = V × I** (single-phase, unity power factor)
2. **P = I² × R**
3. **P = V² / R**

### Units
| Unit | Symbol | Notes |
|------|--------|-------|
| Watt | W | 1 joule/second |
| Kilowatt | kW | 1,000 W |
| Megawatt | MW | 1,000,000 W |
| Horsepower | HP | about 746 W |

## Energy
**E = P × t**

If a 2kW load runs for 5 hours:
E = 2 × 5 = **10 kWh**

## Pakistan Bill Example
Assume an air conditioner averages about 2,000W and runs 8 hours/day for 30 days:

Energy = 2 kW × 8 h × 30 = **480 kWh**

At Rs. 30/kWh (illustrative rate only):
480 × 30 = **Rs. 14,400/month**

Always use actual tariff slabs and measured consumption for real estimates.

## Power Factor in AC
For AC loads:
- **Apparent power S** = V × I (VA)
- **Real power P** = V × I × cosφ (W)
- **Reactive power Q** = V × I × sinφ (VAR)

Heaters and pure resistors have PF near 1. Motors and transformers usually have lagging PF below 1.

## Three-Phase Power
**P = √3 × V_L × I_L × PF**

Where V_L is line voltage and I_L is line current. Common industrial supply in Pakistan is about **400V line-to-line, 50Hz**.

## Field Application
- Compare nameplate kW/kVA with measured current
- Low PF means higher current for the same useful work
- Oversized current increases cable heat and losses

## Common Mistakes
- Confusing kW with kVA
- Estimating bills from amp readings alone
- Ignoring duty cycle (hours of use)

## Professional Tips
- For motor loads, record voltage, current, and estimated PF
- Use true-RMS meters on distorted waveforms
- Separate continuous loads from occasional loads when planning capacity

## Safety
High-power circuits store dangerous energy and produce severe arc risk. Isolate correctly and verify capacity before adding large loads.''',
      difficulty: 'beginner',
      tags: ['power', 'energy', 'kwh', 'power-factor'],
      readTimeMinutes: 8,
      summary: 'Watts, kWh billing, power factor, three-phase power, and a Pakistan home energy example.',
      keywords: ['watt', 'kWh', 'power factor', 'three-phase', 'billing'],
      relatedArticleIds: ['basics_02', 'circuits_04', 'power_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['P = V × I', 'E = P × t', 'P = √3 × V_L × I_L × PF', 'S = V × I'],
      safetyNotes: ['Large loads need verified cable, breaker, and service capacity before connection.'],
      commonMistakes: ['Mixing kW and kVA in generator or transformer sizing', 'Ignoring hours of use when estimating energy cost'],
      professionalTips: ['Write both power and operating hours on every load schedule', 'Check tariff assumptions before promising payback figures'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_04',
      title: 'Voltage, Current & Resistance Deep Dive',
      category: 'basics',
      content: '''## Introduction
Voltage, current, and resistance always work together. Good electricians measure them correctly and understand what each reading means under load.

## Voltage in Practice
Voltage is measured **between two points**. A healthy supply can still show near-normal voltage with no load, then collapse under heavy current because of weak joints, undersized cables, or a soft source.

Typical Pakistan low-voltage values (educational):
- Single-phase: about **230V** phase to neutral
- Three-phase: about **400V** line to line

Always confirm actual site voltage before commissioning equipment.

## Current in Practice
Current flows only through a complete path. High current means more heating in cables and connections (I²R losses). Clamp meters measure current without opening the circuit, but jaws must fully close around one conductor only.

## Resistance and Heat
Resistance is not only inside loads. Loose terminals, corroded lugs, and damaged strands create unwanted resistance. That local resistance becomes a hot spot and a fire risk.

**R = ρL/A** shows why long thin cables drop more voltage than short thick ones.

## Worked Example
A cable carries 20A and has 0.5Ω unwanted joint resistance:
Power lost as heat = I²R = 20² × 0.5 = **200W** at one bad joint.
That is enough to damage insulation over time.

## How to Measure Correctly
1. Measure supply voltage off-load and on-load
2. Measure load current during normal operation
3. Compare voltage at source and at load ends
4. Investigate abnormal drop, heat, or smell at joints

## Common Mistakes
- Reading voltage only with equipment off
- Clamping a multi-core cable and getting near-zero current
- Ignoring warm terminals because "voltage looks fine"

## Professional Tips
- Record readings with date, load condition, and meter type
- Use infrared temperature checks on boards under load where permitted
- Treat unexplained voltage drop as a joint or sizing problem until proven otherwise

## Safety
Voltage may be present with almost no current. Never touch conductors based on "it should be off." Isolate, lock, and prove dead on all relevant conductors.''',
      difficulty: 'beginner',
      tags: ['voltage', 'current', 'resistance'],
      readTimeMinutes: 8,
      summary: 'How electrical pressure, flow, and opposition behave on real sites, with measurement and heat risks.',
      keywords: ['potential difference', 'electron flow', 'I2R heating', 'voltage drop'],
      relatedArticleIds: ['basics_01', 'basics_02', 'safety_08'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['V = I × R', 'I = V / R', 'P = I² × R'],
      safetyNotes: ['Always test for voltage with a correctly rated instrument before and after isolation.'],
      commonMistakes: ['Assuming no current means no hazard', 'Ignoring loose connections that create local heating'],
      professionalTips: ['Compare source and load voltages under real operating current', 'Photograph thermal or joint issues for the job record'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_05',
      title: 'Electrical Units, Symbols & Prefixes',
      category: 'basics',
      content: '''## Introduction
Wrong units cause wrong cable sizes, wrong breaker choices, and dangerous assumptions. Clean unit discipline is a professional habit.

## Core Electrical Units
| Quantity | Unit | Symbol |
|----------|------|--------|
| Voltage | volt | V |
| Current | ampere | A |
| Resistance | ohm | Ω |
| Power | watt | W |
| Energy | watt-hour | Wh or kWh |
| Frequency | hertz | Hz |
| Capacitance | farad | F |
| Inductance | henry | H |

## Common Prefixes
- **m** (milli) = × 0.001 → 20mA = 0.020A
- **k** (kilo) = × 1,000 → 2.5kW = 2,500W
- **M** (mega) = × 1,000,000 → 1MΩ = 1,000,000Ω
- **µ** (micro) = × 0.000001 → 10µF capacitor

**Formulas:** 1 kW = 1000 W · 1 mA = 0.001 A

## Symbols on Drawings
Learn the common schematic marks used on single-line diagrams and control drawings: supply, earth, fuse, circuit breaker, contactor, motor, lamp, switch, and transformer. If a symbol is unclear, check the drawing legend before guessing.

## Worked Conversion
A motor nameplate shows 0.75kW.
0.75kW = 750W ≈ 750 / 746 ≈ **1 HP** (approx).
A leakage reading of 28mA = **0.028A**. That matters when checking RCD behavior.

## Field Application
Write every site value with a unit: "11.8A", not "11.8". On boards and reports, keep phase labels, cable sizes (mm²), and breaker ratings (A/kA) consistent.

## Common Mistakes
- Mixing W and kW in solar or generator sizing
- Reading mA as A on a meter range
- Writing cable size without mm²

## Professional Tips
- Standardize your notebook format: V, A, kW, PF, Hz
- Convert everything to base units before using formulas
- Teach apprentices unit checks before calculation checks

## Safety
Meter ranges and units protect you. A wrong range can hide a live hazard or destroy an instrument. Confirm function (VAC/VDC/A/Ω) before every test.''',
      difficulty: 'beginner',
      tags: ['units', 'symbols', 'prefixes'],
      readTimeMinutes: 7,
      summary: 'Use SI units, common electrical symbols, and metric prefixes correctly so site notes and designs stay clear.',
      keywords: ['SI units', 'kilo', 'milli', 'schematic symbols', 'nameplate units'],
      relatedArticleIds: ['basics_01', 'basics_08', 'circuits_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['1 kW = 1000 W', '1 mA = 0.001 A', '1 MΩ = 1,000,000 Ω'],
      safetyNotes: ['Confirm meter function and range before testing. Wrong mode can create false safety confidence.'],
      commonMistakes: ['Dropping units from notes', 'Confusing mA and A on leakage or control readings'],
      professionalTips: ['Always pair a number with its unit and measurement point', 'Keep a small unit conversion card in the tool bag'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_06',
      title: 'Conductors, Insulators & Semiconductors',
      category: 'basics',
      content: '''## Introduction
Every circuit needs a path for current and insulation to keep that current where it belongs. Material choice affects voltage drop, heat, corrosion, and safety.

## Conductors
Metals with free electrons make good conductors. In installation work the common choices are:
- **Copper:** excellent conductivity, easier termination, widely used
- **Aluminum:** lighter and cheaper for some feeders, needs correct lugs and anti-oxidation practice

**R = ρL/A** — higher resistivity, longer length, or smaller area increases resistance.

## Insulators
Insulation resists current flow. Selection depends on voltage, temperature, moisture, sunlight, oil, and mechanical abuse.
Common examples: PVC, XLPE, rubber compounds, ceramics, and air clearances on boards.
Damaged, overheated, or UV-cracked insulation is a shock and fire hazard.

## Semiconductors
Semiconductors (silicon devices) can act as controlled conductors. They appear in diodes, rectifiers, transistors, inverters, VFDs, LED drivers, and solar electronics. They are sensitive to heat, polarity, surges, and poor cooling.

## Field Application
- Match conductor material to terminals and lugs
- Do not mix copper and aluminum without approved bi-metal connectors
- Check insulation temperature class against enclosure and ambient conditions
- Keep semiconductor equipment ventilated and dry

## Worked Idea
If cable length doubles and cross-section stays the same, resistance roughly doubles and voltage drop roughly doubles for the same current. That is why long runs often need larger mm².

## Common Mistakes
- Undersizing cable because "copper is copper"
- Re-terminating aluminum with copper-only lugs
- Ignoring insulation temperature after enclosure heat build-up

## Professional Tips
- Inspect conductor strands for corrosion or cut wires before termination
- Torque terminals to manufacturer guidance where available
- Record cable type, size, and route on as-built notes

## Safety
Never rely on damaged insulation. Isolate before handling suspect cables. Semiconductor DC bus circuits in drives and solar equipment can remain hazardous after AC isolation.''',
      difficulty: 'beginner',
      tags: ['conductors', 'insulation', 'semiconductors'],
      readTimeMinutes: 8,
      summary: 'Why copper and aluminum conduct, how insulation is chosen, and where semiconductors appear in modern electrical work.',
      keywords: ['copper', 'aluminum', 'PVC', 'XLPE', 'resistivity', 'diode'],
      relatedArticleIds: ['basics_04', 'safety_08', 'components_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['R = ρ × L / A'],
      safetyNotes: ['Treat damaged insulation as live hazard until isolated and proven dead.'],
      commonMistakes: ['Mixing Cu/Al terminations incorrectly', 'Choosing insulation only by price, not environment'],
      professionalTips: ['Use correct lugs and joint compound for aluminum', 'Check free air vs enclosed ampacity conditions'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_07',
      title: 'AC Frequency, Phase Angle & RMS',
      category: 'basics',
      content: '''## Introduction
AC values change every instant. Electricians use RMS values because they represent the equivalent heating effect of DC. Phase angle explains why motors and capacitors behave differently from heaters.

## Frequency and Period
Pakistan public supply frequency is normally **50Hz**.
**T = 1 / f**
At 50Hz, one cycle lasts **20ms**.

## Peak vs RMS
For a sine wave:
**V_rms = V_peak / √2 ≈ 0.707 × V_peak**

Example:
230V RMS ≈ **325V peak**

Equipment labels and most meters use RMS. Insulation and peak stress still care about the higher instantaneous value.

## Phase Angle
In pure resistance, voltage and current peak together (phase angle ≈ 0°, PF ≈ 1).
Inductive loads (motors, coils) make current lag voltage.
Capacitive loads make current lead voltage.
Phase difference is why apparent power and real power are not always equal.

## Why This Matters on Site
- True-RMS meters are needed on distorted VFD/LED waveforms
- Motor current can look "high" while useful kW is moderate if PF is low
- Capacitor banks change phase relationship and can improve lagging PF

## Worked Example
If peak voltage is 325V:
V_rms = 325 / √2 ≈ **230V**
If a load draws 10A at PF 0.8 on 230V single-phase:
P = 230 × 10 × 0.8 = **1,840W**

## Common Mistakes
- Assuming meter peak and RMS are interchangeable
- Using average-responding meters on non-sine waveforms
- Ignoring phase sequence when commissioning three-phase motors

## Professional Tips
- Note whether readings are RMS, peak, or average
- For three-phase, confirm phase rotation before final coupling
- Record both current and estimated PF on motor reports

## Safety
Peak voltage is higher than the RMS value printed on labels. Treat AC mains with full respect even when a "230V" label looks familiar.''',
      difficulty: 'journeyman',
      tags: ['AC', 'frequency', 'phase', 'RMS'],
      readTimeMinutes: 8,
      summary: 'Understand 50Hz AC, RMS values, peak voltage, phase angle, and why meters show heating-equivalent values.',
      keywords: ['50Hz', 'RMS', 'peak voltage', 'phase angle', 'power factor'],
      relatedArticleIds: ['circuits_02', 'basics_03', 'circuits_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['T = 1 / f', 'Vrms = Vpeak / √2', 'P = V × I × PF'],
      safetyNotes: ['Remember AC peak stress is higher than RMS. Use correctly rated PPE and instruments.'],
      commonMistakes: ['Confusing peak and RMS', 'Diagnosing motor load from current alone without PF context'],
      professionalTips: ['Prefer true-RMS instruments around VFDs and electronic loads', 'Check phase rotation on every new three-phase motor install'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'basics_08',
      title: 'Reading Electrical Nameplates',
      category: 'basics',
      content: '''## Introduction
A nameplate is the manufacturer's operating contract with you. If site voltage, frequency, current, or duty does not match the plate, do not energize until the conflict is resolved.

## What to Record Every Time
- Rated voltage and number of phases
- Frequency (50/60Hz)
- Rated current or FLC
- Power (kW/HP) or apparent power (kVA)
- Power factor and efficiency if shown
- IP rating / insulation class / duty cycle
- Connection diagram (star/delta, etc.)
- Serial number and model

## Motor Nameplates
For three-phase motors, note kW or HP, V, A, rpm, PF, efficiency, cosφ, and connection options (e.g. 230V Δ / 400V Y). Wrong connection is a common burnout cause.

## Transformers and Boards
Transformer plates show primary/secondary voltages, kVA, vector group, impedance, and cooling class. Breakers show rated current, breaking capacity (kA), curve type, and poles.

## Worked Check
A motor plate shows 400V, 50Hz, 10A FLC.
If site supply is 380–415V at 50Hz, voltage is usually acceptable.
If someone feeds it at 230V three-phase by mistake, current and torque behavior will be wrong and damage is likely.

## Field Application
Photograph nameplates before install. Transfer key data to the DB schedule, overload setting sheet, and maintenance file. Compare cable and protection ratings against plate current, not against guesswork.

## Common Mistakes
- Setting overload from cable size instead of motor FLC
- Ignoring dual-voltage connection diagrams
- Energizing 60Hz-only equipment on 50Hz without engineering review

## Professional Tips
- If the plate is painted over or missing, stop and identify the equipment properly
- For replacement motors, match or improve efficiency class where practical
- Keep a nameplate log for generators, ATS, pumps, and rooftop plant

## Safety
Nameplate current is not a target to exceed. Continuous overload shortens insulation life and raises fire risk. Verify isolation before cleaning or reading plates inside panels.''',
      difficulty: 'beginner',
      tags: ['nameplate', 'ratings', 'motors', 'equipment'],
      readTimeMinutes: 7,
      summary: 'How to read motor, transformer, breaker, and appliance nameplates so installation decisions stay within safe limits.',
      keywords: ['FLC', 'kVA', 'IP rating', 'star delta plate', 'duty cycle'],
      relatedArticleIds: ['motors_01', 'motors_06', 'power_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not open live panels just to read a plate. Isolate if the plate is not safely visible.'],
      commonMistakes: ['Guessing ratings when the plate is unreadable', 'Using cable ampacity as the motor overload setting'],
      professionalTips: ['Photo + notebook entry for every important nameplate', 'Cross-check plate data against protection and cable schedules'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_01',
      title: 'Resistors and Practical Uses',
      category: 'components',
      content: '''## Introduction
Resistors control current and create voltage drops. In power work you meet them in controls, heaters, electronics boards, and sensing circuits.

## What a Resistor Does
A resistor converts electrical energy into heat while limiting current. Key ratings are resistance (Ω), tolerance (%), and power (W). Exceeding power rating burns the part.

## Useful Formulas
**P = I² × R** and **P = V² / R**
Example: 230V across 2,300Ω dissipates P = 230² / 2300 = **23W**. A 5W resistor would fail quickly.

## Common Types
- Fixed carbon/metal film for electronics
- Wirewound for higher power
- Power resistors / braking resistors on drives
- Heating elements (specialized resistive loads)

## Field Application
- Check color code or printed value before install
- Allow free air around power resistors
- A burnt resistor often points to another fault (shorted device, wrong supply)

## Common Mistakes
- Matching ohms but ignoring wattage
- Mounting a power resistor against plastic with no heat path
- Replacing a safety fusible resistor with an ordinary type

## Professional Tips
- Measure resistance out of circuit when possible
- Note smell/discoloration as evidence of overload history
- For voltage dividers, confirm both resistors and load effect

## Safety
Power resistors run hot by design. Keep clearances, use guards where needed, and isolate before touching.''',
      difficulty: 'beginner',
      tags: ['resistor', 'power-rating', 'voltage-divider'],
      readTimeMinutes: 7,
      summary: 'How resistors limit current, divide voltage, dissipate heat, and fail in real circuits.',
      keywords: ['ohm', 'wattage', 'voltage divider', 'wirewound'],
      relatedArticleIds: ['basics_02', 'components_02'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['P = I² × R', 'P = V² / R', 'V = I × R'],
      safetyNotes: ['Allow cooling time. Power resistors can cause burns after shutdown.'],
      commonMistakes: ['Replacing by resistance only and ignoring power rating', 'Assuming a burnt resistor is the root cause'],
      professionalTips: ['Derate power resistors in hot enclosures', 'Document replacement values and ratings'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_02',
      title: 'Capacitors in AC and DC Circuits',
      category: 'components',
      content: '''## Introduction
Capacitors store energy in an electric field. They pass changing signals, support motors, smooth DC, and correct power factor — but they can hold a dangerous charge after switch-off.

## Basic Behavior
On DC, a healthy capacitor charges then blocks steady current. On AC, it continually charges and discharges, so current can flow. Capacitive reactance:
**Xc = 1 / (2πfC)**

## Motor Capacitors
- **Start capacitors** provide high torque briefly and are switched out
- **Run capacitors** stay in circuit and are continuous-duty rated
Never swap them. Wrong type causes poor starting, overheating, or failure.

## Power Factor and Filtering
Capacitor banks can improve lagging PF on inductive plants. In electronics and drives, capacitors smooth rectified DC. Always check voltage rating, ripple current, and temperature.

## Worked Idea
If C increases or frequency increases, Xc falls and capacitor current rises. That is why PF capacitors must be sized for system voltage and harmonic conditions.

## Safety Notes
- Discharge with an approved method before handling
- Shorting with a screwdriver is unsafe practice
- Stored energy in VFD/solar DC buses can remain after isolation

## Common Mistakes
- Using a start capacitor as a run capacitor
- Ignoring voltage rating and surge environment
- Forgetting discharge wait time on equipment

## Professional Tips
- Read µF and voltage off the can before ordering spares
- Investigate why a capacitor failed (overvoltage, heat, harmonics)
- For PF banks, check reactor/harmonic requirements''',
      difficulty: 'journeyman',
      tags: ['capacitor', 'PFC', 'motor-capacitor'],
      readTimeMinutes: 8,
      summary: 'Capacitor behavior in AC/DC, motor start/run types, residual charge danger, and power-factor uses.',
      keywords: ['Xc', 'microfarad', 'start capacitor', 'run capacitor', 'residual charge'],
      relatedArticleIds: ['circuits_04', 'motors_01', 'components_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Xc = 1 / (2πfC)', 'Q ≈ V² / Xc (idealized)'],
      safetyNotes: ['Capacitors can retain lethal charge. Isolate and discharge using approved procedures.'],
      commonMistakes: ['Interchanging start and run capacitors', 'Handling terminals without verifying discharge'],
      professionalTips: ['Label capacitor function in the panel', 'Record µF, V, and temperature class on spare lists'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_03',
      title: 'Inductors, Coils and Chokes',
      category: 'components',
      content: '''## Introduction
Inductors and coils are everywhere: contactor coils, motor windings, chokes, and transformers. They store energy in a magnetic field and oppose sudden current changes.

## Inductive Reactance
**XL = 2πfL**
Higher frequency or higher inductance means more opposition to AC current.

## Practical Coils
- Contactor/relay coils create magnetic pull to close contacts
- Chokes smooth current or reduce interference
- Motor and transformer windings are distributed inductances with resistance and core effects

## Back EMF
When coil current is interrupted, the magnetic field collapses and can produce a high voltage spike. Suppression diodes, RC snubbers, or varistors are used on DC/AC coils as specified.

## Field Application
- Coil voltage must match control supply (e.g. 230V AC vs 24V DC)
- Buzzing coils can mean low voltage, dirt, or mechanical binding
- Overheated coils often indicate stuck mechanisms or wrong voltage

## Common Mistakes
- Feeding a 24V DC coil from 230V AC
- Omitting suppression on sensitive PLC outputs
- Ignoring control-voltage drop on long cable runs

## Professional Tips
- Measure control voltage at the coil while picking up
- Keep spare coils by voltage and frequency rating
- Check armature air gap and shading ring issues on AC contactors

## Safety
Interrupting inductive loads can arc. Use rated contactors and never assume a coil circuit is harmless low energy without checking the supply.''',
      difficulty: 'journeyman',
      tags: ['inductor', 'coil', 'choke', 'back-EMF'],
      readTimeMinutes: 7,
      summary: 'How coils resist current change, create magnetic force in contactors, and generate back EMF.',
      keywords: ['XL', 'contactor coil', 'snubber', 'magnetic field'],
      relatedArticleIds: ['components_05', 'motors_01', 'modern_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['XL = 2πfL'],
      safetyNotes: ['Inductive kick can damage electronics and shock if suppression is missing.'],
      commonMistakes: ['Wrong coil voltage', 'No surge suppression on control outputs'],
      professionalTips: ['Verify pickup/dropout voltage under load', 'Listen for abnormal coil noise during commissioning'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_04',
      title: 'Diodes and Rectifiers',
      category: 'components',
      content: '''## Introduction
Diodes allow current mainly in one direction. Rectifiers use diodes to convert AC to DC for electronics, battery chargers, drives, and control supplies.

## Diode Basics
Forward direction conducts after a small voltage drop. Reverse direction blocks until reverse rating is exceeded. Polarity matters: reverse installation stops operation or destroys the device.

## Rectifiers
- Half-wave uses one diode (more ripple, less efficient)
- Full-wave bridge is common for DC supplies
A simple estimate sometimes used educationally: **Vdc ≈ 0.9 × Vac** for ideal full-wave unloaded sine conditions (real supplies differ with load, filters, and regulation).

## Ratings That Matter
- Reverse voltage (PIV/VRRM)
- Average and surge current
- Heat sink / temperature limits
- Recovery behavior in fast switching circuits

## Field Application
- Verify DC polarity before connecting batteries or boards
- Check heatsinking on power rectifier packs
- Ripple problems can overheat capacitors downstream

## Common Mistakes
- Reversing bridge modules
- Undersizing surge current for transformer inrush
- Ignoring cooling in enclosed power supplies

## Professional Tips
- Mark DC+ and DC− clearly after rectifiers
- Use isolation and approved procedures around live DC buses
- Investigate repeated diode failures for overvoltage or miswiring root causes

## Safety
Rectified DC does not cross zero like AC and can sustain arcs. Treat DC bus circuits with extra caution.''',
      difficulty: 'journeyman',
      tags: ['diode', 'rectifier', 'bridge', 'polarity'],
      readTimeMinutes: 7,
      summary: 'Diode polarity, rectification, ripple basics, and practical ratings for field electronics and power supplies.',
      keywords: ['PIV', 'bridge rectifier', 'DC bus', 'polarity'],
      relatedArticleIds: ['components_02', 'renewable_03', 'motors_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Vdc ≈ 0.9 × Vac (idealized full-wave educational estimate)'],
      safetyNotes: ['DC bus circuits can remain energized after AC isolation. Verify zero energy.'],
      commonMistakes: ['Ignoring polarity', 'Replacing diodes without checking surge and voltage ratings'],
      professionalTips: ['Label rectifier outputs', 'Measure ripple when DC loads misbehave'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_05',
      title: 'Relays and Contactors',
      category: 'components',
      content: '''## Introduction
Relays and contactors are electrically operated switches. Relays usually handle control-level loads; contactors are built for motors and heavier power switching.

## Key Parts
- Coil (electromagnet)
- Main power contacts
- Auxiliary contacts for status, holding, and interlocking
- Enclosure/arc system on power contactors

## Selection Rules
1. Coil voltage and type must match control supply
2. Main contacts must suit current **and** load type (motor, resistive, lighting)
3. Utilization category and duty matter for motors
4. Aux contacts are not a substitute for power contacts

## Holding and Interlocks
A common start circuit uses a normally open auxiliary as a seal-in/holding contact. Emergency stop and overload contacts are usually wired to break the coil circuit. Mechanical and electrical interlocks prevent dangerous simultaneous actions (for example star and delta contactors both closing).

## Field Application
- Inspect contact wear and pitting
- Check coil voltage during start
- Confirm interlocks on reversing and star-delta starters

## Common Mistakes
- Choosing a contactor by amp number only, ignoring motor duty
- Using tiny relay contacts on inductive power loads
- Missing interlock on reversing starters

## Professional Tips
- Keep the control schematic in the panel pocket
- Replace contact kits as a set when worn
- Verify E-stop actually drops the contactor coil, not only a PLC bit, where hardwired safety is required

## Safety
Contactor terminals can be live even when the motor is stopped if isolation is wrong. Isolate at the correct device and prove dead.''',
      difficulty: 'journeyman',
      tags: ['relay', 'contactor', 'interlock', 'coil'],
      readTimeMinutes: 8,
      summary: 'Coil voltage, contact ratings, holding circuits, interlocking, and practical selection for power and control.',
      keywords: ['seal-in', 'NO NC', 'motor contactor', 'electrical interlock'],
      relatedArticleIds: ['motors_03', 'motors_04', 'components_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Verify hardwired emergency stop action on the contactor coil circuit where required.'],
      commonMistakes: ['No interlock on mutually exclusive contactors', 'Underrated contacts for motor starting'],
      professionalTips: ['Test both mechanical and electrical interlocks', 'Record coil voltage and contactor size on the as-built'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_06',
      title: 'Fuses, MCBs, MCCBs and RCDs',
      category: 'components',
      content: '''## Introduction
Protective devices prevent cables and equipment from being destroyed by overload, short circuit, or dangerous earth leakage. Using the wrong device is a major field error.

## Device Roles
- **Fuse:** sacrificial overcurrent device, very high fault breaking in many types
- **MCB:** miniature circuit breaker for final circuits, thermal + magnetic trip
- **MCCB:** higher current molded-case breaker for feeders and larger loads
- **RCD/RCCB:** trips on imbalance between live and neutral (earth leakage), not on pure overcurrent
- **RCBO:** combines overcurrent and residual-current functions in one device

## Coordination Basics
Breaker/fuse rating must protect the cable. Never oversize protection just to stop nuisance trips. Find the real cause: overload, wrong curve, shared neutrals, moisture, or faults.

## RCD Notes
Typical final-circuit sensitivity often discussed educationally is 30mA for personal protection, with other ratings used for different purposes. Electronic loads may need correct RCD type (for example Type A considerations). Always follow manufacturer and current local rules.

## Field Application
- Match poles and neutral arrangements
- Label every outgoing way
- Test RCD trip function with an approved tester on a schedule

## Common Mistakes
- Using an RCD as if it were short-circuit protection alone
- Mixing neutrals across different RCD groups
- Upsizing MCB instead of fixing cable or load issues

## Professional Tips
- Record breaking capacity (kA) against estimated fault level
- Select trip curves with load inrush in mind
- Keep spare devices by rating and curve, not only by amp number

## Safety
A closed breaker is not proof of a healthy circuit. After trips, investigate before repeated resets. Isolate before changing devices.''',
      difficulty: 'journeyman',
      tags: ['MCB', 'MCCB', 'fuse', 'RCD', 'protection'],
      readTimeMinutes: 9,
      summary: 'What each protective device does, how they differ, and how to coordinate them with cable size and load type.',
      keywords: ['overcurrent', 'earth leakage', 'breaking capacity', 'RCBO', 'trip curve'],
      relatedArticleIds: ['components_07', 'safety_06', 'power_08'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not repeatedly reset a tripping device without finding the fault cause.'],
      commonMistakes: ['Oversizing breakers to hide faults', 'Shared neutrals causing RCD trips'],
      professionalTips: ['Protect the cable first, then the load', 'Document device type, rating, curve, and kA'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_07',
      title: 'Circuit Breaker Curves and Ratings',
      category: 'components',
      content: '''## Introduction
Two breakers with the same amp rating can behave very differently. Curve type and fault ratings decide whether a device trips usefully or nuisance-trips — and whether it can safely interrupt a fault.

## Thermal and Magnetic Regions
Most MCBs combine:
- Thermal trip for overload (slower)
- Magnetic trip for short circuit (fast)
The curve sets how sensitive the magnetic region is to surges.

## Common Curve Families (educational)
- **B curve:** lower instantaneous threshold, often lighting/resistive style circuits
- **C curve:** general purpose, moderate inrush
- **D curve:** higher inrush tolerance, often motors/transformers
Always confirm the manufacturer chart for exact multiples and times.

## Breaking Capacity
**Icu/Ics** class ratings describe fault interruption capability. The device must be suitable for the available fault current at the installation point. A high-quality amp rating is useless if fault level exceeds breaking capacity.

## Selectivity / Coordination
Good design tries to trip only the nearest upstream device. Poor coordination blackouts whole boards for a small final-circuit fault. Use manufacturer selectivity tables where available.

## Field Application
- Motor circuits often need curves that tolerate starting current
- LED drivers and transformers can also inrush
- Downstream devices should clear faults before upstream feeders when possible

## Common Mistakes
- Buying "32A" without checking curve and kA
- Cascading random brands without selectivity data
- Using lighting-style curves on heavy motor loads

## Professional Tips
- Put curve type on the DB schedule (e.g. C20, D32)
- Estimate fault level changes after transformer or generator source changes
- After a violent trip, inspect the device and terminations

## Safety
Never substitute a higher-rated breaker as a convenience fix. That can leave cable unprotected and create fire risk.''',
      difficulty: 'master',
      tags: ['trip-curve', 'Icu', 'selectivity', 'inrush'],
      readTimeMinutes: 9,
      summary: 'B/C/D curves, breaking capacity, motor inrush, and basic selectivity concepts for professional protection choices.',
      keywords: ['B curve', 'C curve', 'D curve', 'Icu', 'selectivity'],
      relatedArticleIds: ['components_06', 'motors_03', 'power_08'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Breaker rating must protect the smallest conductor in the circuit.'],
      commonMistakes: ['Ignoring breaking capacity', 'Using wrong curve for motor starting'],
      professionalTips: ['Record curve + kA on every important feeder', 'Use manufacturer tables for selectivity claims'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'components_08',
      title: 'Surge Protection Devices SPD',
      category: 'components',
      content: '''## Introduction
Surge protection devices divert or limit short-duration overvoltages from lightning coupling and switching events. They support equipment survival but do not replace good earthing, bonding, or wiring practice.

## Why Surges Happen
Lightning energy and switching of large inductive loads can create fast high-voltage spikes. Sensitive electronics, controls, and solar inverters are especially vulnerable.

## SPD Placement Concepts
Educational cascade thinking often uses coordinated stages near service entrance and near sensitive equipment. Follow manufacturer topology for type/class selection and backup protection requirements.

## Installation Critical Points
- Short, straight bonding conductors
- Correct polarity/terminal identification
- Solid connection to earth/bonding system
- Coordination with upstream overcurrent protection as specified
Long SPD leads add impedance and reduce clamping effectiveness.

## Field Application
Inspect status indicators, replace end-of-life cartridges, and re-check connections after major electrical work or known surge events.

## Common Mistakes
- Long coiled earth leads on SPDs
- Expecting SPD to fix chronic poor earthing alone
- Leaving failed modules in service unnoticed

## Professional Tips
- Photograph SPD status windows during maintenance rounds
- Coordinate SPDs with solar, VFD, and data-line protection needs
- Keep spare cartridges for critical sites

## Safety
SPDs connect to live systems. Isolate before replacement. Confirm the earthing system is intact; an SPD cannot protect properly on a broken earth path.''',
      difficulty: 'journeyman',
      tags: ['SPD', 'surge', 'lightning', 'earthing'],
      readTimeMinutes: 8,
      summary: 'How SPDs limit transient overvoltage, why earthing and lead length matter, and common installation mistakes.',
      keywords: ['transient', 'clamping', 'bonding', 'Type 1 Type 2'],
      relatedArticleIds: ['power_05', 'renewable_03', 'modern_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Isolate supply before replacing SPD modules. Verify earth continuity.'],
      commonMistakes: ['Long lead lengths', 'Ignoring status failure indication'],
      professionalTips: ['Keep leads short and direct', 'Include SPD checks in preventive maintenance'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_01',
      title: 'Series & Parallel Circuits',
      category: 'circuits',
      content: '''## Introduction
Series and parallel connections decide how voltage and current divide. Home power circuits are almost always parallel so each load gets full supply voltage.

## Series Circuits
Components share one path.
- Same current: I = I1 = I2 = I3
- Voltages add: V = V1 + V2 + V3
- Resistances add: R = R1 + R2 + R3

## Series Example
2Ω, 4Ω, 6Ω in series on 12V:
R = 12Ω, I = 1A
V drops: 2V, 4V, 6V

## Parallel Circuits
Components share the same two nodes.
- Same voltage across branches
- Currents add: I = I1 + I2 + I3
- 1/R = 1/R1 + 1/R2 + 1/R3

## Parallel Example
2Ω, 4Ω, 4Ω in parallel on 12V:
1/R = 1/2 + 1/4 + 1/4 = 1 → R = 1Ω
I total = 12A; branch currents 6A, 3A, 3A

## House Wiring
Socket and lighting circuits are wired in parallel so one appliance can operate independently. Series connection of general loads is not used for normal outlet wiring.

## Kirchhoff Laws
**KCL:** sum of currents into a node equals sum leaving.
**KVL:** around a closed loop, sum of voltage rises equals sum of drops.
These laws remain true even when circuits get messy.

## Common Mistakes
- Expecting series voltage at every parallel load
- Adding parallel resistances directly instead of reciprocal method
- Opening a neutral in multi-load circuits without understanding consequences

## Professional Tips
- Sketch the path before measuring
- Measure branch currents when imbalance is suspected
- Use KVL thinking to find hidden voltage drop across bad joints

## Safety
Parallel house circuits still need correct breakers and cable sizes per circuit. Independence of loads does not remove overcurrent risk.''',
      difficulty: 'journeyman',
      tags: ['series', 'parallel', 'kirchhoff'],
      readTimeMinutes: 8,
      summary: 'Series and parallel rules, house wiring practice, worked examples, and Kirchhoff laws for troubleshooting.',
      keywords: ['KCL', 'KVL', 'branch current', 'voltage division'],
      relatedArticleIds: ['circuits_03', 'basics_02', 'circuits_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['R_series = R1+R2+R3', '1/R_parallel = 1/R1+1/R2+1/R3'],
      safetyNotes: ['Isolate before opening joints to reconfigure circuits.'],
      commonMistakes: ['Wiring general outlets in series', 'Wrong parallel resistance calculation'],
      professionalTips: ['Draw before you diagnose', 'Compare calculated and measured branch currents'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_02',
      title: 'AC vs DC Systems',
      category: 'circuits',
      content: '''## Introduction
AC and DC are both essential. The grid delivers AC because transformation and long-distance transmission are efficient. Solar, batteries, electronics, and EVs rely heavily on DC.

## Direct Current (DC)
- Flows in one direction
- Sources: batteries, PV modules, rectifiers
- Voltage ideally steady (ignoring ripple)
- Common in controls, telecom, solar, EVs

## Alternating Current (AC)
- Reverses direction periodically
- Sources: generators and utility grid
- Easy to step up/down with transformers
- Standard for homes and industry

## Why AC Dominates the Grid
1. Transformers enable efficient high-voltage transmission
2. Lower current at high voltage reduces I²R losses
3. Rotating generation naturally produces AC
4. AC arcs can clear more readily at current zero crossings

## AC Parameters
- Frequency in Pakistan: normally **50Hz**
- Period T = 1/f = 20ms
- **Vrms = Vpeak / √2**
- 230V RMS ≈ 325V peak
- Industrial three-phase often about **400V** line-to-line

## Three-Phase Advantage
Three waveforms 120° apart give smoother power for motors and better conductor utilization for large loads.

## Common Mistakes
- Treating AC peak and RMS as identical
- Connecting DC-rated only devices to AC without checking
- Ignoring that DC arcs are harder to interrupt

## Professional Tips
- Confirm VAC vs VDC meter range every time
- For mixed systems (solar/hybrid), identify AC and DC isolation points separately
- Label polarity on all DC circuits

## Safety
AC mains peak is higher than the RMS label. DC distribution can remain dangerous after AC isolation. Prove dead on the conductors you will touch.''',
      difficulty: 'journeyman',
      tags: ['AC', 'DC', 'RMS', 'three-phase'],
      readTimeMinutes: 8,
      summary: 'Compare AC and DC sources, RMS values, why AC dominates transmission, and Pakistan supply norms.',
      keywords: ['230V', '400V', '50Hz', 'peak', 'RMS'],
      relatedArticleIds: ['basics_07', 'power_03', 'renewable_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['T = 1 / f', 'Vrms = Vpeak / √2'],
      safetyNotes: ['Use the correct meter mode for AC or DC. Wrong mode creates false confidence.'],
      commonMistakes: ['Mixing AC/DC ratings', 'Ignoring DC isolation in hybrid systems'],
      professionalTips: ['Mark AC and DC boards clearly', 'Teach peak vs RMS with the 230V/325V example'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_03',
      title: 'Kirchhoff Laws for Troubleshooting',
      category: 'circuits',
      content: '''## Introduction
Kirchhoff laws are not only exam theory. They tell you where current disappeared and where voltage was lost across a bad joint, long cable, or overloaded path.

## KCL — Current Law
At any node, currents in equal currents out.
If one branch current is missing from the total, that branch is open, switched off, or mis-measured.

## KVL — Voltage Law
Around a closed loop, the sum of voltage rises equals the sum of drops.
If supply is 230V but load only sees 210V, the missing 20V is being dropped somewhere in the path: cable, joint, contactor, or connector.

## Field Method
1. Sketch the circuit path
2. Measure source voltage
3. Measure voltage at the load
4. Measure intermediate points under load
5. Compare branch currents with clamp meter

## Worked Idea
Supply 230V, load voltage 205V at 12A.
Path drop = 25V.
Approximate path resistance = V/I = 25/12 ≈ **2.1Ω** total unwanted resistance in that path — investigate joints and cable size.

## Common Mistakes
- Measuring only off-load voltage
- Forgetting return path (neutral/earth issues)
- Clamping multiple conductors and trusting the reading

## Professional Tips
- Troubleshoot under realistic load
- Wiggle test suspects only when safe and authorized
- Record before/after voltages at the same points

## Safety
Probing inside live panels requires qualification, PPE, and rated instruments. If in doubt, isolate and use dead testing methods.''',
      difficulty: 'journeyman',
      tags: ['KCL', 'KVL', 'troubleshooting', 'voltage-drop'],
      readTimeMinutes: 8,
      summary: 'Use KCL and KVL as practical troubleshooting tools for missing currents and hidden voltage drops.',
      keywords: ['node current', 'loop voltage', 'path resistance', 'under-load test'],
      relatedArticleIds: ['circuits_01', 'basics_04', 'safety_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['ΣI in = ΣI out', 'ΣV loop = 0', 'R ≈ Vdrop / I'],
      safetyNotes: ['Live troubleshooting needs proper PPE and a risk assessment mindset.'],
      commonMistakes: ['No-load measurements that hide voltage drop', 'Ignoring neutral path drops'],
      professionalTips: ['Measure stepwise along the path', 'Use both voltage and current evidence'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_04',
      title: 'Power Factor in AC Circuits',
      category: 'circuits',
      content: '''## Introduction
Power factor is the ratio of useful real power to total apparent power. Low PF means you push more current through cables and transformers for the same useful work.

## Definitions
**PF = kW / kVA**
Also PF = cosφ for simple sinusoidal cases.
**kVAR = √(kVA² − kW²)**

## Why Low PF Hurts
- Higher current for same kW
- More cable and transformer heating
- Larger voltage drop
- Possible utility penalties on industrial tariffs

## Typical Causes
Induction motors lightly loaded, welders, older magnetic ballasts, and some industrial plants with many inductive machines.

## Correction Concept
Capacitors supply leading vars that offset lagging motor vars. Correction must be sized carefully. Overcorrection can create leading PF and resonance issues, especially with harmonics.

## Worked Example
A load draws 50kW at 0.8 PF.
kVA = 50 / 0.8 = **62.5kVA**
Current is based on kVA, not kW. Improving PF toward 0.95 reduces kVA and line current.

## Field Application
- Measure kW, kVA, and PF with a suitable power meter
- Correct at motor terminals or board level according to design
- Re-check after large process changes

## Common Mistakes
- Installing random capacitors without measurement
- Correcting on highly harmonic-polluted buses without reactors/filters review
- Confusing PF improvement with energy-efficiency miracles

## Professional Tips
- Target a practical PF band, not an unstable perfect 1.0 under all conditions
- Record day/night PF profiles on industrial sites
- Coordinate with harmonic studies where VFDs dominate

## Safety
Capacitor banks store energy and can back-feed. Isolate and discharge using approved procedures before work.''',
      difficulty: 'journeyman',
      tags: ['power-factor', 'kVAR', 'capacitors'],
      readTimeMinutes: 9,
      summary: 'What power factor means, why low PF increases current, and how correction is applied carefully.',
      keywords: ['cos phi', 'lagging', 'leading', 'capacitor bank'],
      relatedArticleIds: ['basics_03', 'components_02', 'power_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['PF = kW / kVA', 'kVAR = √(kVA² - kW²)', 'kVA = kW / PF'],
      safetyNotes: ['Discharge capacitor equipment before maintenance.'],
      commonMistakes: ['Blind capacitor installation', 'Ignoring harmonics when applying PF correction'],
      professionalTips: ['Measure first, correct second', 'Watch for overcorrection and resonance symptoms'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_05',
      title: 'Star and Delta Connections',
      category: 'circuits',
      content: '''## Introduction
Star (wye) and delta are the two fundamental three-phase connection methods. Motors, heaters, and transformers use them carefully according to voltage ratings.

## Star Relationships
In a balanced star system:
**V_line = √3 × V_phase**
**I_line = I_phase**
Neutral may exist at the star point.

## Delta Relationships
In a balanced delta system:
**V_line = V_phase**
**I_line = √3 × I_phase**

## Motor Nameplate Pairs
Many motors show dual voltage, for example 230V Δ / 400V Y. That means:
- Delta on the lower voltage supply
- Star on the higher voltage supply
Wrong choice can overvoltage windings or produce weak torque.

## Star-Delta Starting Link
Star-delta starters begin in star to reduce starting current and torque, then transition to delta for run. This is only valid for motors designed for that method.

## Field Checks
- Verify terminal links bridge according to the plate diagram
- Confirm supply is actually 230V or 400V class before linking
- Check phase sequence after connection

## Common Mistakes
- Installing delta links on a 400V supply for a 230Δ/400Y motor
- Missing a link and creating single-phasing symptoms
- Assuming all motors can star-delta start

## Professional Tips
- Photograph terminal box before and after linking
- Use the exact diagram on that motor, not memory from another brand
- Measure no-load currents after first energization

## Safety
Wrong three-phase links can destroy a motor quickly. If uncertain, stop and confirm plate data before power-up.''',
      difficulty: 'journeyman',
      tags: ['star', 'delta', 'motor-connection', 'line-phase'],
      readTimeMinutes: 9,
      summary: 'Line and phase relationships in star/delta, motor nameplate pairs, and wrong-connection risks.',
      keywords: ['wye', 'line voltage', 'phase voltage', 'terminal box'],
      relatedArticleIds: ['motors_04', 'power_03', 'motors_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Vline = √3 × Vphase (star)', 'Iline = √3 × Iphase (delta)'],
      safetyNotes: ['Confirm nameplate voltage pair before applying supply.'],
      commonMistakes: ['Wrong star/delta links for supply voltage', 'Assuming every motor supports star-delta starting'],
      professionalTips: ['Match links to the plate diagram only', 'Record connection method in the maintenance file'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_06',
      title: 'Three-Phase Load Balancing',
      category: 'circuits',
      content: '''## Introduction
A three-phase system works best when currents on L1, L2, and L3 are similar under normal operation. Large imbalance wastes capacity and creates heat.

## Why Balance Matters
- Uneven transformer heating
- Neutral overload with non-linear or uneven single-phase loads
- Voltage imbalance that stresses motors
- Nuisance trips and poor generator performance

## What Causes Imbalance
- Too many heavy single-phase loads on one phase
- Failed loads on one phase
- Uneven DB scheduling
- Harmonic-rich loads raising neutral current

## Field Method
1. Measure phase currents during realistic peak use
2. Map large single-phase circuits on the DB chart
3. Move circuits between phases where safe and authorized
4. Re-measure after changes

## Practical Target
Perfect balance is rare. Aim for reasonable spread and investigate large permanent differences. For motors, also check voltage imbalance, not only current.

## Common Mistakes
- Balancing only on Sunday morning light load
- Ignoring neutral current on harmonic-heavy boards
- Moving circuits without updating labels and schedules

## Professional Tips
- Put phase labels on every single-phase breaker
- Keep an updated loading schedule for commercial DBs
- Recheck balance after major tenancy or machine changes

## Safety
Rearranging live board tails is hazardous. Prefer planned isolation windows and qualified procedures.''',
      difficulty: 'journeyman',
      tags: ['load-balance', 'neutral', 'phases'],
      readTimeMinutes: 8,
      summary: 'Why unbalanced phases overheat neutrals and transformers, and how to balance distribution boards in practice.',
      keywords: ['phase current', 'neutral current', 'DB schedule', 'voltage imbalance'],
      relatedArticleIds: ['power_03', 'power_04', 'power_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not rearrange live conductors without proper isolation and authorization.'],
      commonMistakes: ['Balancing at no-load only', 'Leaving DB charts outdated after circuit moves'],
      professionalTips: ['Measure at peak operating time', 'Track neutral current on mixed electronic loads'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'circuits_07',
      title: 'Open Circuit, Short Circuit and Earth Fault',
      category: 'circuits',
      content: '''## Introduction
Most electrical faults fall into a few families. Knowing the difference helps you test safely and choose the right fix instead of random part swapping.

## Open Circuit
The path is broken. Current stops in that branch.
Symptoms: dead load, zero current, possible voltage on one side only.
Causes: broken conductor, failed switch, burnt joint, tripped device, loose termination.

## Short Circuit
Live conductors connect through a very low impedance path.
Symptoms: explosive trip, arc flash risk, blackened cables, welded contacts.
Protection must clear this very fast.

## Earth Fault
A live conductor contacts earthed metal or earth path.
Symptoms: RCD trip, tingling metalwork, scorched earth conductor, residual-current readings.
This is a major shock risk.

## Quick Diagnosis Mindset
- No voltage at load, voltage at source → open path
- Instant heavy trip with damage signs → short or severe fault
- Breaker/RCD trip with metalwork issues → earth fault path likely

## Field Application
Use isolation, proving dead, continuity, insulation resistance, and careful visual inspection. Do not repeatedly force energy into a faulted circuit.

## Common Mistakes
- Resetting breakers into a bolted fault repeatedly
- Replacing breakers without finding the short
- Ignoring intermittent earth faults that trip only when wet or vibrating

## Professional Tips
- Smell, look, then measure
- Segregate circuits to isolate the faulty way
- Record megger values with test voltage and ambient notes

## Safety
Short-circuit energy can cause arc burns. Wear PPE appropriate to the task and never treat metal enclosures as safe without testing.''',
      difficulty: 'beginner',
      tags: ['open-circuit', 'short-circuit', 'earth-fault'],
      readTimeMinutes: 8,
      summary: 'Recognize open, short, and earth faults, their symptoms, and the protection response each needs.',
      keywords: ['fault types', 'insulation resistance', 'RCD trip', 'arc damage'],
      relatedArticleIds: ['safety_06', 'components_06', 'safety_02'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not re-energize a circuit that shows clear short or earth-fault evidence until repaired and retested.'],
      commonMistakes: ['Breaker reset gambling', 'Replacing protection instead of locating the fault'],
      professionalTips: ['Divide and conquer by isolating subcircuits', 'Use IR testing after visual repairs'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_01',
      title: 'Transformers Explained',
      category: 'power',
      content: '''## Introduction
A transformer transfers AC power between circuits by electromagnetic induction. It changes voltage and current levels while keeping frequency the same.

## Principle
AC in the primary creates a changing magnetic field in the core. That field induces voltage in the secondary. No direct electrical connection is required in an isolating transformer.

## Turns Ratio
**V2 / V1 = N2 / N1 = I1 / I2** (ideal)
- Step-up: more secondary turns, higher voltage, lower current
- Step-down: fewer secondary turns, lower voltage, higher current

## Common Types
1. Power transformers for transmission-level duties
2. Distribution transformers for local supply
3. Instrument transformers (CT/PT)
4. Autotransformers
5. Isolation transformers
Industry size labels vary; always use the nameplate kVA and voltage, not informal categories alone.

## Sizing Idea
For load power P (watts) and power factor PF:
**Transformer kVA ≈ P / (1000 × PF)**
Then add design margin (often discussed educationally around 20–25%) after diversity and future load review.

## Losses and Cooling
- Iron/core losses: hysteresis and eddy currents
- Copper losses: I²R in windings
Cooling classes include ONAN, ONAF, OFAF and others on oil units; dry-type units use air/ventilation designs.

## Basic Tests
Turns ratio, insulation resistance, winding resistance, and oil BDV (where applicable) are common maintenance checks for qualified teams.

## Common Mistakes
- Sizing only on kW and forgetting PF
- Ignoring inrush when selecting upstream protection
- Poor ventilation around dry-type units

## Professional Tips
- Record primary/secondary voltages and tap position
- Check neutral earthing arrangement after install
- Investigate abnormal noise, oil leaks, or temperature rise early

## Safety
Transformer work involves hazardous voltage and stored energy. Only qualified personnel should test or connect transformers.''',
      difficulty: 'journeyman',
      tags: ['transformer', 'turns-ratio', 'kVA'],
      readTimeMinutes: 9,
      summary: 'Transformer principle, turns ratio, types, losses, sizing margin, cooling, and basic tests.',
      keywords: ['Faraday', 'step down', 'distribution transformer', 'ONAN'],
      relatedArticleIds: ['power_03', 'basics_03', 'power_08'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['V2/V1 = N2/N1 = I1/I2', 'kVA ≈ P / (1000 × PF)'],
      safetyNotes: ['Qualified personnel only. Prove isolation on both sides before work.'],
      commonMistakes: ['Forgetting PF in kVA sizing', 'Blocking transformer ventilation'],
      professionalTips: ['Photograph nameplate and vector group', 'Include future load in sizing discussions'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_02',
      title: 'Single-Phase Supply Systems',
      category: 'power',
      content: '''## Introduction
Most homes and small shops use single-phase supply. Correct identification of live, neutral, and protective earth is essential for safe wiring.

## Basic Arrangement
A typical single-phase final circuit includes:
- Live (phase) conductor
- Neutral conductor (current-carrying return)
- Protective earth (safety path, not a normal return substitute)

## Important Distinction
Neutral is part of the normal current path. Earth is for fault protection and exposed-conductive-part safety. Never swap their roles.

## Distribution Practice
Main isolator, metering, residual-current protection where required, and MCBs for final circuits are common board elements. Every circuit should be identifiable and isolatable.

## Field Application
- Verify polarity
- Confirm earth continuity
- Label ways in the consumer unit/DB
- Check voltage under load at far sockets

## Common Mistakes
- Using earth as neutral
- Shared neutrals creating RCD headaches
- No accessible isolation for a circuit under work

## Professional Tips
- Map socket groups before renovation work
- Test RCD function on a maintenance schedule
- Record circuit descriptions that a future electrician can understand

## Safety
Single-phase 230V can kill. Isolate the correct breaker, lock/tag where required, and prove dead at the point of work.''',
      difficulty: 'beginner',
      tags: ['single-phase', 'neutral', 'earthing', 'DB'],
      readTimeMinutes: 7,
      summary: 'Single-phase live-neutral-earth arrangement, common household practice, and protection basics.',
      keywords: ['phase', 'neutral', 'protective earth', 'consumer unit'],
      relatedArticleIds: ['power_04', 'power_05', 'safety_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Prove dead at the conductors you will touch, not only at the breaker handle position.'],
      commonMistakes: ['Neutral/earth confusion', 'Unlabeled single-phase boards'],
      professionalTips: ['Keep a circuit chart inside the DB door', 'Check polarity on new socket outlets'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_03',
      title: 'Three-Phase Supply Systems',
      category: 'power',
      content: '''## Introduction
Three-phase systems deliver power efficiently for motors and large buildings. In Pakistan, industrial low-voltage systems are commonly about 400V line-to-line at 50Hz.

## Line and Phase
Line voltage is measured between phases. Phase voltage is measured phase to neutral in a star system.
Rough educational relation: 400V line ≈ 230V phase.

## Power Formula
**P = √3 × V_L × I_L × PF**

## Phase Sequence
Wrong sequence reverses three-phase motors. Always verify rotation before mechanical coupling on pumps, fans, and conveyors.

## Board Practice
- Clear phase identification
- Balanced loading where practical
- Correct protective devices and fault ratings
- Safe access and labeling

## Common Mistakes
- Assuming rotation is correct after a utility or generator changeover
- Mixing phase colors/labels inconsistently
- Working in three-phase boards without adequate PPE and planning

## Professional Tips
- Use a phase rotation meter during commissioning
- Re-check rotation after any supply-side change
- Document which phase feeds major single-phase subloads

## Safety
Three-phase boards present higher fault energy. Restrict access, isolate properly, and treat every exposed bus as hazardous until proven otherwise.''',
      difficulty: 'journeyman',
      tags: ['three-phase', '400V', 'phase-sequence'],
      readTimeMinutes: 8,
      summary: 'Three-phase line/phase concepts, rotation, balancing, and safe industrial board practice.',
      keywords: ['line voltage', 'rotation', 'industrial supply', '√3'],
      relatedArticleIds: ['circuits_05', 'circuits_06', 'motors_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['P = √3 × V × I × PF'],
      safetyNotes: ['Use appropriate PPE and procedures for three-phase panel work.'],
      commonMistakes: ['Skipping rotation checks', 'Poor phase labeling'],
      professionalTips: ['Rotation test every new motor install', 'Update drawings after phase changes'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_04',
      title: 'Distribution Boards and Sub-DBs',
      category: 'power',
      content: '''## Introduction
A distribution board is the traffic control center of an installation. Poor DB work causes trips, downtime, and fires — even when cables in the walls are fine.

## Good DB Traits
- Logical layout and spare ways where practical
- Clear circuit labels
- Separated RCD groups with correct neutrals
- Adequate fault ratings
- Neat dressing without stressed terminals

## Sub-DBs
Larger buildings use sub-mains to local boards. Each sub-DB needs correct isolation, protection, earthing/bonding, and an up-to-date schedule.

## Fire Risk Hotspots
Loose incoming lugs, undersized neutral bars, shared neutrals across RCD groups, and overloaded ways are common heat sources.

## Field Application
- Torque critical terminations as specified
- Thermal checks under load when permitted
- Update charts after every modification

## Common Mistakes
- Mixing neutrals between RCD sections
- Unlabeled breakers
- Filling boards beyond safe heat/spacing practice

## Professional Tips
- Leave maintainable spare capacity when possible
- Number wires to match the schedule
- Photograph completed boards for records

## Safety
Live DB work is high risk. Prefer isolation. If diagnostic live work is unavoidable, use qualified procedures and barriers.''',
      difficulty: 'journeyman',
      tags: ['DB', 'sub-main', 'labeling', 'RCD-groups'],
      readTimeMinutes: 8,
      summary: 'DB layout quality, labeling, neutral grouping, torque discipline, and sub-board planning.',
      keywords: ['consumer unit', 'neutral bar', 'schedule', 'termination'],
      relatedArticleIds: ['power_02', 'components_06', 'safety_08'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Isolate and prove dead before rearranging DB tails.'],
      commonMistakes: ['Shared neutrals across RCDs', 'No circuit chart'],
      professionalTips: ['Label as if a stranger must maintain it tomorrow', 'Re-torque after thermal cycling on critical lugs'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_05',
      title: 'Earthing and Grounding Fundamentals',
      category: 'power',
      content: '''## Introduction
Earthing and bonding give fault current a reliable path and keep exposed metal near safe potential during faults. A rod in the soil alone is not a complete safety system.

## Core Ideas
- **Protective earth** connects exposed metal to the earthing arrangement
- **Bonding** connects simultaneous touchable metal parts to reduce voltage differences
- Protective devices must operate when earth faults occur

## System Families (educational overview)
You may meet TN-S, TN-C-S, TT and other arrangements depending on supply and local practice. Each has rules for neutral-earth relationships and protection. Identify the actual system before altering connections.

## Electrode Reality
A low electrode resistance helps in many systems, but values and methods depend on design and local requirements. Educational talk of single target ohms is not a substitute for testing to the applicable standard.

## Field Checks
- Continuity of protective conductors
- Tight earth bar joints
- No open bonds on pipework/structural metal where required
- Correct main earthing terminal connections

## Common Mistakes
- Using earth as a neutral
- Leaving painted joints as "bonded"
- Assuming a rod reading alone proves installation safety

## Professional Tips
- Draw the earthing arrangement for complex sites
- Retest after major renovations
- Coordinate earthing with SPDs, generators, and solar systems

## Safety
During earth faults, metalwork can become live if protection or bonding fails. Test before touch and never remove an earth to "see if that stops the trip" on energized systems.''',
      difficulty: 'journeyman',
      tags: ['earthing', 'bonding', 'electrode', 'TN-S'],
      readTimeMinutes: 9,
      summary: 'Protective earthing vs bonding, electrode limits, common system concepts, and testing mindset.',
      keywords: ['protective conductor', 'main earthing terminal', 'TT', 'bonding'],
      relatedArticleIds: ['safety_06', 'components_08', 'modern_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never open protective earth connections on energized equipment to diagnose trips.'],
      commonMistakes: ['Rod-only thinking', 'Earth used as neutral'],
      professionalTips: ['Document electrode and bond test results', 'Coordinate generator and inverter earthing carefully'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_06',
      title: 'Harmonics in Electrical Systems',
      category: 'power',
      content: '''## Introduction
Harmonics are extra frequency components that distort the pure 50Hz sine wave. Nonlinear loads such as VFDs, UPS units, LED drivers, and rectifiers are common sources.

## Why Harmonics Matter
- Extra heating in transformers and cables
- Neutral overload in some three-phase systems with triplen harmonics
- Nuisance trips and control interference
- Metering errors on poor instruments

## THD Concept
**THD ≈ (harmonic RMS / fundamental RMS) × 100**
Higher THD means a dirtier waveform.

## Field Clues
Hot neutrals, buzzing transformers, overloaded UPS inputs, and true-RMS vs average meter disagreements can all point to waveform distortion.

## Mitigation Directions
- Better load distribution
- K-rated or suitable transformers where designed
- Line reactors / filters / active solutions per engineering study
- Separate sensitive circuits when practical

## Common Mistakes
- Using average-responding meters around VFDs
- Adding PF capacitors without harmonic review
- Ignoring neutral size on heavily electronic floors

## Professional Tips
- Use true-RMS and power-quality tools for serious diagnosis
- Log symptoms against process equipment operating times
- Involve specialists for large harmonic problems

## Safety
Do not "fix" harmonic heat by upsizing protection blindly. Find the thermal path and waveform cause.''',
      difficulty: 'master',
      tags: ['harmonics', 'THD', 'neutral', 'VFD'],
      readTimeMinutes: 8,
      summary: 'Where harmonics come from, how they overheat neutrals and transformers, and practical mitigation habits.',
      keywords: ['nonlinear load', 'triplen', 'power quality', 'true RMS'],
      relatedArticleIds: ['motors_05', 'circuits_04', 'modern_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['THD = harmonic RMS / fundamental RMS × 100'],
      safetyNotes: ['Hot neutrals and transformers are fire risks. Investigate abnormal heat promptly.'],
      commonMistakes: ['Blind capacitor addition on harmonic-rich buses', 'Trusting non-true-RMS readings near drives'],
      professionalTips: ['Measure neutral current on electronic-heavy boards', 'Coordinate filters with the equipment vendor'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_07',
      title: 'Generator Basics for Backup Power',
      category: 'power',
      content: '''## Introduction
Standby generators keep critical loads alive during outages. The most dangerous installation error is backfeeding the utility, which can kill line workers and destroy equipment.

## Basic Ratings
Generators are often rated in kVA and kW.
**kVA = kW / PF**
Starting of motors may demand much higher short-time capacity than running kW.

## Changeover Rules
Use a proper manual changeover switch or ATS that prevents utility and generator from connecting together. Improvised double-feed arrangements are unacceptable.

## Load Planning
Separate essential and non-essential loads. Do not expect a small generator to run the entire house/plant without a curated load list.

## Earthing and Neutral
Neutral switching and earthing arrangements depend on system design and local rules. Copying another site blindly can create dangerous neutral-earth faults.

## Common Mistakes
- Backfeeding through a normal DB without interlock
- Undersizing for motor starting
- No periodic test runs under load

## Professional Tips
- Perform planned transfer tests
- Keep fuel, battery, and cooling maintenance on schedule
- Label essential circuits clearly

## Safety
Never connect a generator into a building in a way that can energize utility lines. Use approved transfer equipment only.''',
      difficulty: 'journeyman',
      tags: ['generator', 'backup', 'changeover', 'backfeed'],
      readTimeMinutes: 8,
      summary: 'Generator sizing concepts, backfeed danger, changeover/ATS needs, and earthing/neutral caution.',
      keywords: ['kVA', 'ATS', 'essential loads', 'anti-backfeed'],
      relatedArticleIds: ['modern_05', 'power_04', 'motors_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['kVA = kW / PF'],
      safetyNotes: ['Anti-backfeed interlocking is mandatory for grid-connected premises using generators.'],
      commonMistakes: ['Improvised changeover', 'No load schedule for essential circuits'],
      professionalTips: ['Test under realistic load', 'Document neutral-earth arrangement'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'power_08',
      title: 'Protection Coordination Basics',
      category: 'power',
      content: '''## Introduction
Protection coordination (selectivity) aims to clear a fault at the smallest practical zone. Poor coordination turns a socket fault into a full-building blackout.

## Key Inputs
- Available fault current at each board
- Device time-current curves
- Cable damage limits
- Motor starting and transformer inrush
- Manufacturer selectivity tables

## Coordination Idea
Downstream device should open first for faults in its zone. Upstream device provides backup if the downstream device fails.

## Practical Limits
Perfect selectivity is not always possible at every current level. Designers balance safety, cost, and operational continuity.

## Field Application
- Record device types, curves, and ratings accurately
- After upgrades, re-check that new breakers still coordinate
- Investigate unexpected upstream trips as coordination or fault-level issues

## Common Mistakes
- Mixing random devices without curve checks
- Ignoring fault level after adding generators or parallel transformers
- Upsizing upstream devices until "nuisance trips stop" without analysis

## Professional Tips
- Keep a single-line diagram with protection settings
- Use manufacturer data for claims of total/partial selectivity
- Review settings after major load changes

## Safety
Coordination must never sacrifice fault-clearing speed needed for shock and fire protection.''',
      difficulty: 'master',
      tags: ['coordination', 'selectivity', 'fault-current', 'time-current'],
      readTimeMinutes: 9,
      summary: 'How protective devices should cascade so faults trip the nearest breaker, not the whole facility.',
      keywords: ['time-current curve', 'backup protection', 'selectivity table', 'fault level'],
      relatedArticleIds: ['components_07', 'power_01', 'components_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not disable or oversize protection to hide coordination problems.'],
      commonMistakes: ['Random breaker substitution', 'No single-line protection documentation'],
      professionalTips: ['Update settings sheets after every change', 'Study trips with fault location evidence'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_01',
      title: 'Induction Motors',
      category: 'motors',
      content: '''## Introduction
The three-phase induction motor is the industrial workhorse: rugged, simple, and efficient when applied correctly.

## Principle
Stator windings create a rotating magnetic field. That field induces rotor current, producing torque. The rotor runs slightly slower than synchronous speed.

## Synchronous Speed
**Ns = (120 × f) / P**
At 50Hz:
| Poles | Ns (rpm) |
|-------|----------|
| 2 | 3000 |
| 4 | 1500 |
| 6 | 1000 |
| 8 | 750 |

## Slip
**s = (Ns − Nr) / Ns**
Typical full-load slip is often a few percent.

## Starting Methods
1. DOL — simple, high starting current
2. Star-delta — reduced start current/torque for suitable motors
3. Soft starter — voltage ramp
4. VFD — speed control and controlled starting

## Full Load Current
If P is in **horsepower**:
**I = (P × 746) / (√3 × V × η × PF)**
If P is in **kW**, use P×1000 in the numerator instead of P×746.
A rough educational thumb-check sometimes used near 400–415V is about 1.5A per HP, but always prefer nameplate current.

## Common Faults
Single-phasing, bearing failure, insulation failure, overload, misalignment, and wrong connection.

## Protection
Overload relay set to nameplate FLC, short-circuit protection, phase-failure protection where needed, and proper isolation.

## Common Mistakes
Setting overload from cable size instead of FLC; ignoring ventilation; wrong star/delta links.

## Professional Tips
Record no-load and loaded currents on all phases; prefer higher efficiency replacements when suitable; check mechanical load before condemning the motor.

## Safety
Motor circuits need isolation and lockout before work. Capacitors and driven loads may store energy or create restart hazards.''',
      difficulty: 'journeyman',
      tags: ['induction-motor', 'slip', 'FLC', 'starters'],
      readTimeMinutes: 9,
      summary: 'Three-phase induction motor principle, synchronous speed, slip, starters, FLC formula, and protection.',
      keywords: ['squirrel cage', 'RMF', 'IE3', 'nameplate FLC'],
      relatedArticleIds: ['motors_03', 'motors_04', 'motors_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Ns = (120 × f) / P', 's = (Ns - Nr) / Ns', 'I = (HP × 746) / (√3 × V × η × PF)'],
      safetyNotes: ['Lock out motor supplies and address mechanical restart hazards before work.'],
      commonMistakes: ['Wrong FLC units in formula (HP vs kW)', 'Overload set from cable rating'],
      professionalTips: ['Always use nameplate current for overload setup', 'Measure all three phase currents'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_02',
      title: 'DC Motors and Applications',
      category: 'motors',
      content: '''## Introduction
DC motors still appear in older machinery, specialized drives, cranes, and some mobile equipment. They can provide strong controllable torque, but they need correct controllers, protection, and maintenance.

## Basic Idea
Educational relation: **Torque ∝ φ × Ia**.
Higher armature current generally means higher torque, within thermal and commutation limits.

## Practical Traits
- High starting torque capability in many designs
- Starting current can be large without proper control
- Brush and commutator wear on brushed machines
- Controllers must match motor voltage, current, and field arrangement
- Ventilation and cleanliness strongly affect life

## Field Application
Inspect brush length and sparking patterns, verify controller current limits, keep ventilation paths clean, and confirm polarity/field connections after service. Record nameplate volts, amps, and field data before replacement.

## Common Faults
Worn brushes, dirty commutators, open field circuits, controller parameter mistakes, overloaded mechanical drives, and poor cooling.

## Common Mistakes
Direct-on starting large DC motors without limiting; ignoring brush maintenance until commutator damage is severe; mixing controller profiles between motor types.

## Professional Tips
Log brush replacements and spark observations; check mechanical load before condemning the motor electrically; use manufacturer service data for modern DC drive systems.

## Safety
Armature circuits can deliver high fault current. Isolate fully and beware stored energy in drive systems before opening covers.''',
      difficulty: 'journeyman',
      tags: ['DC-motor', 'brushes', 'torque'],
      readTimeMinutes: 8,
      summary: 'DC motor behavior, high starting current caution, brush maintenance, and modern application notes.',
      keywords: ['armature', 'commutator', 'field winding', 'drive controller'],
      relatedArticleIds: ['motors_01', 'motors_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Torque ∝ flux × armature current'],
      safetyNotes: ['Isolate DC drive systems completely; verify bus discharge where applicable.'],
      commonMistakes: ['No current limit at start', 'Neglected brush gear'],
      professionalTips: ['Use manufacturer setup parameters', 'Track brush wear trends'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_03',
      title: 'DOL Starters Explained',
      category: 'motors',
      content: '''## Introduction
A DOL (Direct-On-Line) starter connects the motor directly to full supply voltage. It is simple and robust, but starting current is high and must be acceptable to the supply and process.

## Main Parts
- Main contactor
- Overload relay
- Short-circuit protection (MCCB/fuses)
- Start/Stop control circuit
- Optional indicators, interlocks, and emergency stop

## Starting Current
Educational range often quoted: about **6–8× FLC**, depending on motor design and load. Weak supplies may dip voltage during start and affect nearby equipment.

## Control Basics
Stop buttons are commonly wired normally closed so a broken wire fails safe and de-energizes the coil. Overload contacts should drop out the contactor when tripped. A holding/seal-in auxiliary keeps the contactor latched after the start button is released.

## Field Checks
Confirm contactor duty rating, set overload to nameplate FLC, verify coil voltage, and test emergency stop action. Measure start voltage dip on sensitive sites.

## Common Mistakes
No overload or wrong setting; undersized contactor for motor starting duty; stop circuit not truly breaking coil power; no short-circuit device coordination.

## Professional Tips
Measure start impact on supply voltage; label control wires to the schematic; inspect contact wear on frequent-start applications; keep spare contacts/coils for critical machines.

## Safety
Verify isolation before work inside starter panels. Confirm STOP/E-stop remove coil power where hardwired safety is required.''',
      difficulty: 'journeyman',
      tags: ['DOL', 'contactor', 'overload', 'control-circuit'],
      readTimeMinutes: 8,
      summary: 'Direct-On-Line starter power/control wiring concepts, starting current, and protection essentials.',
      keywords: ['direct on line', 'seal-in', 'FLC setting', 'motor starter'],
      relatedArticleIds: ['components_05', 'motors_06', 'motors_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Test that STOP and E-stop actually de-energize the contactor coil.'],
      commonMistakes: ['Missing overload protection', 'Contactor underrated for starting duty'],
      professionalTips: ['Set overload from nameplate, not guesswork', 'Record start frequency for contact life planning'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_04',
      title: 'Star-Delta Starters Explained',
      category: 'motors',
      content: '''## Introduction
Star-delta starting reduces starting current and torque by first connecting windings in star, then changing to delta for running.

## Why Current Falls in Star
In star, each winding sees lower voltage, so starting current and torque drop — often discussed educationally around one-third of direct delta values for ideal cases.

## Critical Hardware Needs
Line, star, and delta contactors; timer/transition control; electrical and mechanical interlocks so star and delta cannot close together; correct overload placement per design.

## Transition Issues
Too fast or too slow changeover can cause torque dips, current spikes, or mechanical stress.

## Field Commissioning
Confirm nameplate allows star-delta; verify terminal wiring; test interlocks before first power; check rotation and run currents in delta.

## Common Mistakes
Using star-delta on unsuitable motors; missing interlocks; wrong timer setting.

## Professional Tips
Keep the schematic in the starter door; measure line current during start and after transition; consider soft starters/VFDs for smoother process needs.

## Safety
A star-delta contactor weld or interlock failure can create severe faults. Prove interlocks during maintenance.''',
      difficulty: 'master',
      tags: ['star-delta', 'transition', 'interlock'],
      readTimeMinutes: 9,
      summary: 'When star-delta is valid, how reduced starting works, interlocking needs, and transition pitfalls.',
      keywords: ['reduced voltage starting', 'timer', 'mechanical interlock', 'run delta'],
      relatedArticleIds: ['circuits_05', 'motors_03', 'motors_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never defeat star/delta interlocks. Simultaneous closure can short phases.'],
      commonMistakes: ['No interlock', 'Star-delta on non-compatible motor'],
      professionalTips: ['Commission with rotation and current checks', 'Document transition time that works for the load'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_05',
      title: 'VFD Basics',
      category: 'motors',
      content: '''## Introduction
A Variable Frequency Drive controls motor speed by varying output frequency and voltage. It improves process control and soft starting, but introduces noise and insulation stresses.

## Basic Control Idea
**Ns = 120 × f / P**. V/f control keeps motor flux roughly constant over much of the speed range.

## Installation Essentials
Correct motor data in parameters; suitable motor cable type/length; solid grounding/bonding and EMC practices; ventilation and dust control.

## Side Effects to Manage
Bearing/insulation stress on long runs; EMI into sensors; supply-side harmonics; braking energy needing resistors or regeneration options.

## Field Tips
Do not open motor output isolators under load unless manufacturer allows; separate control and power wiring; clamp screens as specified.

## Common Mistakes
Treating a VFD like a simple contactor starter; ignoring EMC earthing; wrong motor parameters.

## Professional Tips
Save parameter backups; log fault codes with conditions; coordinate inverter-duty motors for tough applications.

## Safety
VFDs contain DC bus capacitors that can remain charged after power-off. Wait the stated discharge time and verify zero energy.''',
      difficulty: 'master',
      tags: ['VFD', 'V/f', 'EMC', 'motor-cable'],
      readTimeMinutes: 9,
      summary: 'How VFDs control speed, insulation and EMC stresses, cable/grounding practice, and safe isolation notes.',
      keywords: ['inverter duty', 'carrier frequency', 'braking resistor', 'EMC filter'],
      relatedArticleIds: ['modern_03', 'power_06', 'motors_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Ns = 120 × f / P'],
      safetyNotes: ['Wait for DC bus discharge. Verify zero energy before opening a VFD.'],
      commonMistakes: ['Poor screening/grounding', 'Disconnecting output under load against manufacturer rules'],
      professionalTips: ['Commission with correct motor data', 'Keep a parameter backup and fault log'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_06',
      title: 'Overload Relays and Motor Protection',
      category: 'motors',
      content: '''## Introduction
Overload relays protect motors from prolonged excess current that would overheat windings. They are not a substitute for short-circuit protective devices.

## Correct Setting Basis
Set from motor **nameplate full-load current**, following manufacturer instructions. Do not set from cable ampacity or contactor size alone.

## What Overloads Cover
Sustained overload and many phase-unbalance/phase-loss situations (device dependent). They generally do not replace fuses/MCCBs for bolted short circuits.

## Nuisance Trip Checks
Mechanical overload, low voltage, single phasing, high enclosure ambient, wrong class/setting, too-frequent starts.

## Field Application
Record FLC and final set point on the starter label; investigate trips; do not just upsize settings.

## Common Mistakes
Raising overload setting to keep production running; poor short-circuit coordination; ignoring ambient effects.

## Professional Tips
Prefer electronic overloads where advanced features help; compare three-phase currents; know the process duty cycle.

## Safety
A motor that repeatedly trips is giving a warning. Forcing higher settings can burn the motor and create fire risk.''',
      difficulty: 'journeyman',
      tags: ['overload', 'thermal-relay', 'phase-loss'],
      readTimeMinutes: 8,
      summary: 'Set overloads from nameplate FLC, understand what they do not protect against, and diagnose nuisance trips.',
      keywords: ['FLC setting', 'trip class', 'phase failure', 'thermal memory'],
      relatedArticleIds: ['motors_03', 'motors_01', 'components_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not defeat overload protection to clear nuisance trips.'],
      commonMistakes: ['Setting from cable size', 'Ignoring mechanical load issues'],
      professionalTips: ['Label the set current on the starter', 'Measure phase currents before changing settings'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'motors_07',
      title: 'Motor Troubleshooting Workflow',
      category: 'motors',
      content: '''## Introduction
Effective motor troubleshooting is systematic: safety first, then symptoms, supply, protection, motor, and mechanical load.

## Step 1 — Safe Condition
Isolate, lock/tag, and prove dead before opening terminal boxes or couplings. Note capacitors, VFDs, or automatic restart sources.

## Step 2 — Gather Clues
Trip type, smell, noise, vibration, heat, recent work, and process changes.

## Step 3 — Electrical Checks
Supply voltage/balance, phase currents under load, insulation resistance where appropriate, starter condition, overload setting, terminations.

## Step 4 — Mechanical Checks
Coupling alignment, bearings, free rotation of driven equipment, and process blockages.

## Decision Mindset
Balanced high currents often point to mechanical overload. Strong imbalance points to supply/connection/winding issues. Poor insulation requires repair before re-energizing.

## Common Mistakes
Replacing the motor first; skipping mechanical inspection; ignoring drive fault histories.

## Professional Tips
Use one standard checklist; record readings; communicate with operators about process constraints.

## Safety
Prevent remote or automatic restart with proper lockout at the correct isolator.''',
      difficulty: 'journeyman',
      tags: ['troubleshooting', 'diagnostics', 'phase-current'],
      readTimeMinutes: 8,
      summary: 'A safe, ordered workflow to diagnose motor problems without random part replacement.',
      keywords: ['checklist', 'balanced current', 'insulation test', 'mechanical load'],
      relatedArticleIds: ['motors_06', 'safety_03', 'motors_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Confirm lockout against remote/auto start before mechanical work.'],
      commonMistakes: ['Parts swapping without diagnosis', 'Skipping mechanical checks'],
      professionalTips: ['Follow the same workflow every time', 'Document readings for handover'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_01',
      title: 'Electrical Safety Rules',
      category: 'safety',
      content: '''## Introduction
Electrical accidents are almost always preventable. Professional safety is a system of habits, not a single slogan.

## Golden Rules
1. Assume circuits are live until proven dead
2. Use voltage-rated PPE and insulated tools
3. Isolate, lock, tag, and verify zero energy
4. Prefer dead work over live work
5. Use instruments with correct CAT rating
6. Maintain earthing/bonding integrity
7. Keep water and damaged gear away from work
8. Know emergency disconnects and first response

## LOTO Sequence (educational)
Shut off → lock → tag → test tester on known live → prove dead at point of work → re-check tester.

## PPE Basics
Insulated gloves rated for the task, eye protection, suitable clothing, dielectric footwear where required, and arc-rated PPE when risk assessment demands it.

## First Aid Mindset
Do not touch a victim still in contact with electricity. Switch off or separate with an insulated method, call emergency help, and provide CPR only if trained.

## Pakistan Practice Notes
Work should follow current local regulations, utility rules, and licensed-practice requirements. Treat any code numbers in training material as educational until verified against the latest official text.

## Common Mistakes
Working live for convenience; using damaged gloves/tools; skipping prove-dead; removing earth connections casually.

## Professional Tips
Hold a short pre-task brief on complex jobs; stop work when conditions change; keep rescue and burn response knowledge current.

## Safety
Electricity cannot be seen. Your tester and isolation discipline are part of your body protection system.''',
      difficulty: 'beginner',
      tags: ['safety', 'PPE', 'LOTO', 'shock'],
      readTimeMinutes: 9,
      summary: 'Golden rules for electrical work: assume live, isolate, PPE, LOTO, tools, earthing, and emergency response.',
      keywords: ['prove dead', 'CAT rating', 'emergency response', 'safe isolation'],
      relatedArticleIds: ['safety_03', 'safety_05', 'safety_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Test the tester before and after proving dead.'],
      commonMistakes: ['Assuming off means safe', 'Using damaged PPE'],
      professionalTips: ['Make prove-dead a non-negotiable habit', 'Document LOTO on team jobs'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_02',
      title: 'Electric Shock Effects and Response',
      category: 'safety',
      content: '''## Introduction
Electric shock can stop breathing, disrupt heart rhythm, burn tissue, and cause secondary injuries from falls. Fast, correct response saves lives.

## What Affects Severity
Current magnitude and path through the body, duration, voltage, AC/DC nature, and skin condition (wet skin lowers resistance).

## Immediate Response
1. Do not touch the victim if still energized
2. Switch off supply or separate safely
3. Call emergency services
4. Check responsiveness and breathing
5. Begin CPR if trained and required
6. Treat burns with cool running water, not ice or ointments as first action

## After the Event
Even if the person "feels fine," medical evaluation matters. Internal injury and heart rhythm issues may not be obvious.

## Prevention Link
RCD protection, earthing, insulation, isolation discipline, and dry working conditions reduce shock risk dramatically.

## Common Mistakes
Touching the victim too early; using water on electrical fires/scenes incorrectly; delaying emergency calls.

## Professional Tips
Know site emergency numbers and main isolator locations before work starts; practice rescue awareness with the team.

## Safety
Your first duty is not becoming the second victim.''',
      difficulty: 'beginner',
      tags: ['shock', 'first-aid', 'fibrillation'],
      readTimeMinutes: 7,
      summary: 'How shock harms the body, what affects severity, and the correct emergency response sequence.',
      keywords: ['CPR', 'current path', 'burns', 'emergency call'],
      relatedArticleIds: ['safety_01', 'safety_06', 'safety_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never touch an energized victim with bare hands.'],
      commonMistakes: ['Skipping medical review after shock', 'Incorrect separation technique'],
      professionalTips: ['Locate isolators before work', 'Keep first-aid training current'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_03',
      title: 'Lockout/Tagout Procedure',
      category: 'safety',
      content: '''## Introduction
LOTO prevents unexpected re-energization while people are working. A breaker in the off position without control of that breaker is not true isolation control.

## Core Steps
1. Identify all energy sources
2. Notify affected people
3. Shut down equipment normally if safe
4. Isolate electrical (and other) sources
5. Apply locks and tags
6. Release or guard stored energy
7. Verify zero energy
8. Perform work
9. Controlled restoration

## Stored Energy Examples
Capacitor banks, VFD DC bus, UPS systems, generators, compressed air, raised loads, and rotating machines that can generate.

## Multi-Person Work
Each worker should have personal control philosophy according to site procedure. Never remove another person's lock without authorized process.

## Common Mistakes
Tag only with no lock; locking the wrong isolator; forgetting alternate feeds or control power; no verification.

## Professional Tips
Use an energy-source checklist on complex machines; photograph lock points on recurring equipment; audit LOTO compliance.

## Safety
If you cannot prove isolation, do not begin physical work.''',
      difficulty: 'journeyman',
      tags: ['LOTO', 'isolation', 'stored-energy'],
      readTimeMinutes: 8,
      summary: 'Why switching off is not enough, how to lock/tag/verify, and stored-energy traps in modern systems.',
      keywords: ['personal lock', 'zero energy', 'alternate feed', 'UPS'],
      relatedArticleIds: ['safety_05', 'motors_05', 'power_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Verify zero energy after locking, not before only.'],
      commonMistakes: ['Wrong isolator locked', 'Forgotten stored energy'],
      professionalTips: ['List every source on complex machines', "Never borrow someone else's lock"],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_04',
      title: 'PPE for Electricians',
      category: 'safety',
      content: '''## Introduction
PPE is your last line of defense, not a license for unsafe methods. It must fit the voltage, fault risk, and environment of the job.

## Common PPE Items
Insulated gloves with protectors, safety glasses/face protection, flame-resistant/arc-rated clothing when required, insulated tools, dielectric footwear, helmet/hearing protection as needed.

## Inspection Habits
Check gloves for pinholes/damage before use, replace cracked tool insulation, and discard contaminated or expired protective gear according to policy.

## Instrument PPE
Your multimeter and voltage detector are part of protection. Use correct CAT rating and leads for the measurement point. A wrong instrument can fail violently under fault.

## Arc Flash Awareness
Fault energy depends on available current and clearing time. Panel work may require higher PPE levels after risk assessment. When unsure, isolate rather than improvise.

## Common Mistakes
Using fashion gloves as electrical gloves; damaged safety glasses; metal jewelry around live work; cheap unrated testers.

## Professional Tips
Store gloves properly; keep spare PPE in the vehicle; match PPE to the written method statement on high-risk jobs.

## Safety
Damaged PPE is false security. If in doubt, replace it.''',
      difficulty: 'beginner',
      tags: ['PPE', 'gloves', 'CAT', 'arc-flash'],
      readTimeMinutes: 7,
      summary: 'Select, inspect, and use electrical PPE and instruments matched to the task risk.',
      keywords: ['insulated gloves', 'arc rated', 'CAT III CAT IV', 'insulated tools'],
      relatedArticleIds: ['safety_01', 'safety_05', 'components_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Inspect PPE before every use. Replace damaged gear immediately.'],
      commonMistakes: ['Unrated testers', 'Jewelry on live tasks'],
      professionalTips: ['Treat meter leads as safety equipment', 'Keep a PPE inspection routine'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_05',
      title: 'Safe Isolation Procedure',
      category: 'safety',
      content: '''## Introduction
Safe isolation is the most important fieldwork skill. The goal is certainty that the conductors you will touch cannot kill you.

## Recommended Sequence
1. Identify the correct circuit and all sources
2. Isolate using the proper device
3. Secure isolation (lock/tag as required)
4. Select an approved voltage indicator
5. Prove the indicator on a known live source
6. Test all relevant conductors at the point of work
7. Re-prove the indicator on known live
8. Begin work only after zero energy is confirmed

## What to Test
All phases, neutral where relevant, and any parallel or control supplies that could reappear at the work point.

## Good Practice
Use dedicated proving units where required by procedure. Do not rely on a nearby lamp or "the machine looks off."

## Common Mistakes
Testing only one phase; not re-checking the tester; isolating a contactor instead of a true isolator; forgetting UPS/generator backfeeds.

## Professional Tips
Speak the steps aloud on team jobs; mark the isolation point; keep the keys under the working person's control.

## Safety
If any step is uncertain, stop. Uncertainty is a warning light.''',
      difficulty: 'journeyman',
      tags: ['safe-isolation', 'prove-dead', 'voltage-indicator'],
      readTimeMinutes: 8,
      summary: 'A practical prove-dead sequence: identify, isolate, lock, test tester, test circuit, re-test tester.',
      keywords: ['known live source', 'point of work', 'true isolator', 're-prove'],
      relatedArticleIds: ['safety_03', 'safety_01', 'power_02'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Prove the tester before and after circuit testing.'],
      commonMistakes: ['Single-conductor testing only', 'Using non-approved indicators'],
      professionalTips: ['Follow the same sequence every time', 'Account for alternate supplies'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_06',
      title: 'RCD and RCCB Protection',
      category: 'safety',
      content: '''## Introduction
An RCD monitors whether current leaving on live conductors returns on neutral. Imbalance indicates leakage to earth and can trip to reduce shock risk.

## What RCDs Do
They detect residual/leakage current. They do not replace overcurrent devices for short-circuit and overload protection unless combined (RCBO).

## Typical Sensitivities (educational)
Personal protection discussions often use 30mA devices on socket circuits, with other ratings for different applications. Always follow current local rules and manufacturer guidance.

## Type Awareness
Electronic loads, inverters, and EV equipment may require specific RCD types. Using the wrong type can refuse to trip or nuisance-trip.

## Common Trip Causes
Moisture, damaged insulation, shared neutrals across groups, stacked leakage from many electronic loads, and genuine earth faults.

## Field Application
Test with an approved RCD tester on a schedule; investigate trips; do not bridge out RCDs permanently.

## Common Mistakes
Mixing neutrals between RCD sections; assuming RCD means earthing is optional; repeated reset without diagnosis.

## Professional Tips
Separate high-leakage loads when practical; record trip history; verify earth continuity still exists.

## Safety
An RCD is not a guarantee. Safe isolation and good wiring practice remain mandatory.''',
      difficulty: 'journeyman',
      tags: ['RCD', 'RCCB', '30mA', 'earth-leakage'],
      readTimeMinutes: 8,
      summary: 'How residual-current devices detect imbalance, what they do and do not protect, and common trip causes.',
      keywords: ['residual current', 'RCBO', 'shared neutral', 'Type A'],
      relatedArticleIds: ['components_06', 'power_05', 'modern_02'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never permanently defeat an RCD to clear nuisance trips.'],
      commonMistakes: ['Shared neutrals', 'Relying on RCD instead of earthing'],
      professionalTips: ['Use proper RCD testers', 'Group circuits thoughtfully to manage leakage'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_07',
      title: 'Electrical Fire Safety',
      category: 'safety',
      content: '''## Introduction
Electrical fires often start at loose terminations, overloaded cables, damaged insulation, and failed devices. Early heat and smell are warnings.

## Common Causes
Loose lugs, overloaded circuits, undersized cables, poor joints, failed appliances, moisture tracking, and ignored nuisance trips.

## Emergency Actions
1. Switch off supply if safe to reach
2. Evacuate if smoke or spread risk is present
3. Call emergency services
4. Use a suitable extinguisher only if trained and safe
Never use water on energized electrical equipment.

## Extinguisher Notes
CO₂ and clean-agent types are commonly discussed for electrical equipment; powder may be used in some settings but can damage equipment and reduce visibility. Follow site fire plan.

## After the Fire
Do not re-energize until inspected and repaired. Hidden insulation damage can re-ignite.

## Common Mistakes
Ignoring warm breakers; forcing larger fuses; blocking panel ventilation; using water casually.

## Professional Tips
Thermal inspection programs catch problems early; keep DB interiors clean; torque critical joints on maintenance cycles.

## Safety
Life safety beats equipment safety. Evacuate when conditions exceed your training.''',
      difficulty: 'beginner',
      tags: ['fire', 'CO2', 'overheating', 'extinguisher'],
      readTimeMinutes: 7,
      summary: 'Common electrical fire causes, extinguisher choices, and safe actions during and after an electrical fire.',
      keywords: ['loose terminal', 'thermal damage', 'extinguisher type', 're-energize ban'],
      relatedArticleIds: ['safety_08', 'power_04', 'components_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not use water on energized electrical fires.'],
      commonMistakes: ['Upsizing protection to stop heat trips', 'Re-energizing without inspection'],
      professionalTips: ['Investigate heat/smell immediately', 'Keep extinguishers accessible and inspected'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'safety_08',
      title: 'Cable Overheating and Thermal Risk',
      category: 'safety',
      content: '''## Introduction
Cable temperature is controlled by current, ambient conditions, grouping, insulation type, and joint quality. Overheating destroys insulation long before a cable "looks broken."

## Heating Physics
Heat rises with **I²R**. A modest extra resistance at a lug can create a local furnace even when the cable mid-run feels cooler.

## Ampacity Factors
Installation method, ambient temperature, bunching of circuits, enclosure heat, and insulation temperature class all change safe current-carrying capacity. Tables in standards exist for this reason.

## Hotspot Checklist
- Loose or undersized lugs
- Mixed Cu/Al joints done poorly
- Overloaded circuits
- High ambient roof spaces
- Damaged strands reducing effective area

## Field Detection
Smell, discoloration, melted insulation, infrared checks under load, and voltage-drop clues all help. Investigate repeated thermal trips seriously.

## Common Mistakes
Covering cables with insulation materials; overfilling conduit; ignoring grouping factors; relying only on breaker rating without cable checks.

## Professional Tips
Design with realistic ambient and future load; leave maintainable terminations; re-check torque on critical feeders during PM.

## Safety
Thermally damaged cable may fail violently later. Replace compromised sections rather than taping over heat damage.''',
      difficulty: 'journeyman',
      tags: ['cable-heating', 'ampacity', 'terminations'],
      readTimeMinutes: 8,
      summary: 'Why cables overheat, how installation method changes capacity, and how to find thermal weak points.',
      keywords: ['I2R', 'grouping factor', 'lug temperature', 'insulation class'],
      relatedArticleIds: ['basics_04', 'power_04', 'components_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['P_heat = I² × R'],
      safetyNotes: ['Do not re-terminate and re-energize heat-damaged cable without full inspection/replacement as needed.'],
      commonMistakes: ['Ignoring installation method in sizing', 'Tape-over of burnt insulation'],
      professionalTips: ['Check terminations under load temperature programs', 'Record ambient and grouping assumptions in designs'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_01',
      title: 'Solar PV System Basics',
      category: 'renewable',
      content: '''## Introduction
Solar PV converts sunlight into DC electricity. A complete system may include modules, mounting, inverters, protection, cabling, and optional batteries/storage.

## How PV Works
Photons free electrons in semiconductor cells. Module current and voltage combine in series/parallel strings to match inverter windows.

## Module Types (typical ranges)
- Monocrystalline: higher efficiency, common today
- Polycrystalline: older/common mid-efficiency
- Thin-film: specialized/flexible use cases

## Key Terms
Wp rating under standard test conditions, efficiency, temperature coefficient, and annual degradation.

## Educational Sizing Steps
1. Estimate daily kWh need
2. Apply system loss factor
3. Divide by local peak sun hours estimate
4. Choose module count and inverter size with margins
Example method only — real designs use site irradiance data, shade analysis, and current regulations.

## Pakistan Context Notes
Net-metering and interconnection rules are set by regulators and DISCOs and change over time. Always verify current NEPRA/DISCO requirements before promising export credits or system sizes.

## Maintenance
Clean modules as needed for dust, inspect terminations annually, monitor inverter faults, and manage shading.

## Common Mistakes
Sizing from bill rumor only; ignoring shade; undersized DC protection; no roof structural check.

## Professional Tips
Photograph string labels and inverter setpoints; document as-built single-line; train owners on isolation points.

## Safety
PV strings can be live in daylight even when the AC main is off. Use DC-rated isolation and PPE.''',
      difficulty: 'journeyman',
      tags: ['solar', 'PV', 'net-metering', 'sizing'],
      readTimeMinutes: 10,
      summary: 'Solar PV components, educational sizing steps, Pakistan context notes, and maintenance basics.',
      keywords: ['Wp', 'inverter', 'string', 'DISCO', 'peak sun hours'],
      relatedArticleIds: ['renewable_02', 'renewable_03', 'renewable_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Array kWp ≈ Daily_kWh / (PSH × system_efficiency_factor)'],
      safetyNotes: ['Assume DC side may be energized in daylight. Use DC-rated procedures.'],
      commonMistakes: ['Ignoring shade and temperature effects', 'Skipping utility approval where required'],
      professionalTips: ['Use site-specific irradiance thinking', 'Keep as-built documents for service teams'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_02',
      title: 'Solar Panel Types and Ratings',
      category: 'renewable',
      content: '''## Introduction
Panel selection is more than watt-peak shopping. Voltage windows, temperature, mechanical strength, and degradation decide long-term success.

## Important Ratings
- Pmax / Wp
- Vmp / Imp
- Voc / Isc
- Temperature coefficients
- Maximum system voltage

## Temperature Effect
As modules heat up, voltage usually falls and real power is less than cool-lab STC values. Cold mornings can raise Voc — critical for inverter maximum DC voltage checks.

## String Design Link
Series modules add voltage; parallel strings add current. Design must keep operating voltage inside inverter MPPT range and Voc under absolute maximum in the coldest expected condition.

## Field Application
Verify flash-test/nameplate data, orientation, tilt, and shade free zones. Inspect connectors for correct mating and weather sealing.

## Common Mistakes
Counting only watts; ignoring Voc vs inverter limit; cheap connectors mixed incorrectly.

## Professional Tips
Leave documentation of module model and serial maps; plan walkways for safe roof maintenance.

## Safety
Damaged modules and connectors can arc. Isolate strings with approved DC procedures before handling.''',
      difficulty: 'beginner',
      tags: ['modules', 'Voc', 'Isc', 'temperature'],
      readTimeMinutes: 7,
      summary: 'Module ratings, temperature effects on Voc, and why nameplate STC differs from roof reality.',
      keywords: ['STC', 'MPPT window', 'string voltage', 'connectors'],
      relatedArticleIds: ['renewable_01', 'renewable_03', 'renewable_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Respect DC arc risk on PV connectors and damaged modules.'],
      commonMistakes: ['No cold-temperature Voc check', 'Mixing incompatible connectors'],
      professionalTips: ['Design for hot power and cold voltage extremes', 'Map module positions for warranty claims'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_03',
      title: 'Solar Inverter Types',
      category: 'renewable',
      content: '''## Introduction
The inverter is the brain and power converter of most solar systems. It must match array electrical windows, grid rules, and optional battery systems.

## Common Categories
- Grid-tie string inverters
- Hybrid inverters with battery ports
- Microinverters / module-level concepts in some designs
- Off-grid inverters for standalone systems

## Critical Limits
Maximum DC voltage/current, MPPT ranges, AC output current, overload behavior, and anti-islanding/grid-code features for grid-connected units.

## Isolation Needs
Both AC and DC isolation points matter for service. Hybrid systems also need clear battery isolation and shutdown sequences.

## Field Application
Commission with correct grid profile settings where applicable; verify earthing; test protection trips; document firmware/settings.

## Common Mistakes
Array Voc above inverter max; wrong battery chemistry settings on hybrids; blocked inverter ventilation.

## Professional Tips
Save setting screenshots; keep a shutdown procedure for owners; monitor derating in high ambient rooms.

## Safety
Follow manufacturer shutdown sequence. Capacitors and PV inputs can remain hazardous after switch-off.''',
      difficulty: 'journeyman',
      tags: ['inverter', 'string-inverter', 'hybrid', 'isolation'],
      readTimeMinutes: 8,
      summary: 'String, hybrid, and related inverter types, DC/AC limits, and isolation responsibilities.',
      keywords: ['MPPT', 'anti-islanding', 'hybrid inverter', 'DC isolator'],
      relatedArticleIds: ['renewable_06', 'renewable_07', 'renewable_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Use the manufacturer shutdown sequence before service.'],
      commonMistakes: ['Ignoring DC voltage windows', 'Poor ventilation causing thermal derating'],
      professionalTips: ['Record grid code/profile settings', 'Label AC and DC isolators clearly'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_04',
      title: 'Battery Basics for Solar Systems',
      category: 'renewable',
      content: '''## Introduction
Batteries store energy for backup and time-shifting. They can deliver very high fault current and require DC-rated protection and correct charge control.

## Energy Math
**Wh = V × Ah**
Usable energy depends on allowed depth of discharge and efficiency, not only nameplate Ah.

## Chemistry Notes
Lead-acid family systems are familiar and sensitive to deep discharge/ventilation needs. Lithium systems usually need a compatible BMS and inverter settings. Follow manufacturer limits strictly.

## Protection
Use DC-rated breakers/fuses, correct cable size, proper lugs, and battery isolators. Shorted battery cables are extremely dangerous.

## Field Application
Set charge voltages to chemistry; manage temperature; keep terminals clean and torque-correct; ventilate rooms as required.

## Common Mistakes
AC breakers on DC battery circuits; undersized cables; wrong charge profile; no strain relief on terminals.

## Professional Tips
Calculate autonomy with realistic loads; label battery banks clearly; plan replacement access.

## Safety
Remove metal jewelry when working on battery banks. Have an emergency plan for short-circuit events.''',
      difficulty: 'journeyman',
      tags: ['battery', 'Ah', 'BMS', 'lithium'],
      readTimeMinutes: 8,
      summary: 'Battery energy units, lead-acid vs lithium practical differences, protection needs, and safety.',
      keywords: ['depth of discharge', 'DC fuse', 'BMS', 'autonomy'],
      relatedArticleIds: ['renewable_05', 'renewable_07', 'components_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Wh = V × Ah'],
      safetyNotes: ['Battery short-circuit current is extreme. Use insulated tools and DC-rated protection.'],
      commonMistakes: ['Wrong chemistry charge settings', 'AC-rated only protection on DC'],
      professionalTips: ['Size cables for continuous charge/discharge current', 'Keep a battery maintenance log'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_05',
      title: 'Charge Controllers PWM vs MPPT',
      category: 'renewable',
      content: '''## Introduction
Charge controllers protect batteries from uncontrolled PV charging. MPPT and PWM types behave differently and are not free substitutes.

## PWM Concept
PWM controllers essentially connect the array to the battery in a controlled switching manner and are best when module voltage is well matched to battery voltage.

## MPPT Concept
MPPT controllers track a higher-efficiency operating point and can convert excess array voltage into additional charge current within design limits. They are often better with higher-voltage arrays.

## Selection Checks
- Max PV voltage/current
- Battery voltage system
- Charge algorithms for chemistry
- Temperature compensation features
- Environmental rating

## Field Application
Set battery type correctly, verify cable sizing, and confirm the array stays within controller Voc limits on cold days.

## Common Mistakes
Exceeding Voc; wrong battery type menu; undersized controller current rating; poor ventilation.

## Professional Tips
Label controller setpoints; monitor charge stages during first week; keep firmware notes if supported.

## Safety
Controllers and battery terminals can be live from PV and battery at once. Isolate both sides before service.''',
      difficulty: 'journeyman',
      tags: ['MPPT', 'PWM', 'controller'],
      readTimeMinutes: 7,
      summary: 'Differences between PWM and MPPT charge control, voltage matching, and setup discipline.',
      keywords: ['array voltage', 'charge stage', 'temperature compensation', 'Voc limit'],
      relatedArticleIds: ['renewable_02', 'renewable_04', 'renewable_01'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Isolate PV and battery before working on a controller.'],
      commonMistakes: ['Voc overload', 'Wrong chemistry profile'],
      professionalTips: ['Design cold-temperature voltage margin', 'Document final menu settings'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_06',
      title: 'Grid-Tie Solar Systems',
      category: 'renewable',
      content: '''## Introduction
Grid-tie systems export or offset energy with the utility network. They require compliant protection and formal interconnection processes.

## Non-Negotiables
- Utility/DISCO approval where required
- Compliant inverter grid functions
- Correct isolation and labeling
- Metering arrangement as per local program rules

## Anti-Islanding
Inverters must stop energizing the grid during utility outages so line workers are not fed from rooftop systems.

## Design Notes
Array and inverter matching, AC interconnection point capacity, surge protection, earthing, and documentation all matter as much as panel count.

## Regulatory Note
Net-metering thresholds, tariffs, and technical rules change. Verify current NEPRA/DISCO documents before design sign-off.

## Common Mistakes
Connecting without approval; missing AC/DC labels; no maintenance access; ignoring export limits.

## Professional Tips
Provide owners a one-page shutdown guide; keep application documents with as-builts; test isolation points after commissioning.

## Safety
During grid outages, assume PV equipment may still have live DC and inverter internals until properly shut down and verified.''',
      difficulty: 'master',
      tags: ['grid-tie', 'anti-islanding', 'net-metering'],
      readTimeMinutes: 8,
      summary: 'Utility-connected PV essentials: approvals, anti-islanding, protection, and metering discipline.',
      keywords: ['interconnection', 'export', 'DISCO approval', 'islanding'],
      relatedArticleIds: ['renewable_01', 'renewable_03', 'power_04'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never backfeed the grid through non-compliant connections.'],
      commonMistakes: ['Skipping utility process', 'Poor shutdown labeling for owners'],
      professionalTips: ['Track regulation updates', 'Hand over clear isolation instructions'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'renewable_07',
      title: 'Hybrid Solar Systems',
      category: 'renewable',
      content: '''## Introduction
Hybrid systems combine solar, battery storage, and grid interaction. They can support selected loads during outages when designed and programmed correctly.

## Architecture Ideas
- Essential loads sub-board on backup output
- Non-essential loads remain grid-only
- Charge/discharge limits protect battery life
- Clear operating modes (grid support, backup, passthrough)

## Critical Settings
Battery chemistry profile, depths of discharge, charge rates, grid export permissions, and transfer behavior must match the hardware.

## Neutral-Earth Behavior
Backup mode can change neutral-earth relationships. Follow inverter manufacturer earthing instructions carefully to avoid dangerous configurations.

## Field Application
Commission with a load priority list, test transfer under controlled conditions, and train users on what the system will and will not power.

## Common Mistakes
Trying to back up the whole house on a small battery; wrong earthing in backup mode; no owner training.

## Professional Tips
Publish an essential-load schedule on the DB; monitor first-week event logs; leave service contact details on the inverter door.

## Safety
Hybrid systems have multiple live sources: grid, PV, and battery. Isolate all relevant sources before work.''',
      difficulty: 'master',
      tags: ['hybrid', 'backup-loads', 'battery-inverter'],
      readTimeMinutes: 8,
      summary: 'Hybrid PV with batteries: load splitting, backup behavior, neutral-earth caution, and commissioning focus.',
      keywords: ['essential loads', 'transfer', 'multi-source isolation', 'backup output'],
      relatedArticleIds: ['renewable_04', 'renewable_03', 'modern_05'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Identify and isolate grid, PV, and battery sources before service.'],
      commonMistakes: ['No essential-load plan', 'Ignoring backup-mode earthing instructions'],
      professionalTips: ['Test backup transfer during commissioning', 'Keep a user mode guide near the inverter'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_01',
      title: 'Smart Home Wiring Basics',
      category: 'modern',
      content: '''## Introduction
Smart switches, relays, sensors, and hubs add control convenience. Electrical fundamentals still rule: correct conductors, ratings, isolation, labeling, and maintainability.

## Neutral Reality
Many smart switches need a neutral in the switch box. Older switch-loop wiring without neutral needs different product choices or a wiring update. Confirm box wiring before promising a retrofit.

## Load and Contact Ratings
Relay contacts inside smart devices are often small. Do not switch heavy inductive loads beyond ratings. Use contactors or properly rated modules for motors, heaters, and large lighting banks.

## Good Installation Habits
- Maintain manual isolation at the DB
- Label smart circuits in both the board and the app with the same names
- Separate power-limited control wiring as required
- Keep a recovery plan if Wi-Fi or hub power fails
- Provide physical override for critical lighting where practical

## Common Mistakes
Overloading tiny smart relays; no neutral planning; treating app-off as electrical isolation; unlabeled modules stuffed in ceilings.

## Professional Tips
Document device models and pairing info for the owner; leave spare ways and access for service; test behavior after router/power outages.

## Safety
Smart control is not lockout. Physically isolate and prove dead before electrical work on any controlled circuit.''',
      difficulty: 'journeyman',
      tags: ['smart-home', 'neutral', 'relay', 'labeling'],
      readTimeMinutes: 8,
      summary: 'Neutral requirements for smart devices, load limits, isolation, and maintainable wiring practice.',
      keywords: ['smart switch', 'Wi-Fi relay', 'switch loop', 'manual override'],
      relatedArticleIds: ['power_02', 'components_05', 'modern_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['App off is not electrical isolation. Lock out at the breaker/isolator.'],
      commonMistakes: ['Ignoring neutral requirements', 'Overloading smart relay contacts'],
      professionalTips: ['Label physical and digital circuit names the same', 'Plan offline fallback for critical lights'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_02',
      title: 'EV Charging Basics',
      category: 'modern',
      content: '''## Introduction
EV charging is often a high, long-duration load. It needs a dedicated verified circuit, correct protection, and confirmation that the supply can support it.

## Power Idea
**P = V × I** (single-phase)
Three-phase chargers use three-phase power relationships. Continuous loading means cable and breaker selection must respect continuous-duty practice and manufacturer instructions.

## Installation Priorities
- Dedicated circuit and isolation
- Correct breaker/RCD/RCBO type for the charger
- Earth continuity and electrode/bonding integrity
- Cable size for run length and continuous current
- Load management if service capacity is limited

## Modes (educational overview)
Mode 2 portable arrangements and Mode 3 dedicated EVSE wallboxes are commonly discussed. Follow the charger manual and local rules for the exact installation method.

## Field Application
Measure available capacity, check diversity of other large loads (AC, oven, well pump), and label the EV circuit clearly.

## Common Mistakes
Using random socket extensions as permanent charging; wrong RCD type; ignoring voltage drop on long runs; no service-capacity check.

## Professional Tips
Offer load-management options when main service is tight; document torque and test results; educate users about connector care.

## Safety
Damaged connectors and wet connections are hazards. Isolate before service and keep outdoor equipment correctly IP-rated.''',
      difficulty: 'master',
      tags: ['EV', 'EVSE', 'Mode-3', 'load-management'],
      readTimeMinutes: 8,
      summary: 'EV charger power levels, dedicated circuits, RCD type needs, earthing, and service capacity checks.',
      keywords: ['dedicated circuit', 'Type A RCD', 'continuous load', 'service capacity'],
      relatedArticleIds: ['safety_06', 'power_03', 'power_02'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['P = V × I'],
      safetyNotes: ['Install EVSE only on verified capacity with correct protective devices.'],
      commonMistakes: ['Extension-cord charging as permanent solution', 'Skipping earthing verification'],
      professionalTips: ['Check diversity with other large loads', 'Use manufacturer protection guidance exactly'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_03',
      title: 'EMC and EMI Fundamentals',
      category: 'modern',
      content: '''## Introduction
EMC is about equipment operating without causing or suffering from electromagnetic interference. Poor EMC practice creates random sensor faults, network drops, and control glitches.

## Common Sources
VFDs, inverters, switch-mode power supplies, contactors, and poorly dressed high-frequency return paths.

## Practical Controls
- Separate power and signal cables where possible
- Use manufacturer-specified screened motor cables
- Bond screens correctly (not random pigtail habits when instructions say otherwise)
- Maintain low-impedance grounding
- Add filters/reactors when the design requires them

## Field Symptoms
PLC inputs flickering, analog sensors noisy, RS-485/Ethernet issues near drives, nuisance trips without clear power faults.

## Common Mistakes
Unscreened long VFD motor cables; coiled excess motor cable in the panel; signal cables strapped to VFD outputs; open shield drains.

## Professional Tips
Read the drive EMC manual section; dress cables for short return paths; test after each major wiring change.

## Safety
EMC hardware does not replace safe isolation or protective earthing for shock protection.''',
      difficulty: 'master',
      tags: ['EMC', 'EMI', 'shielding', 'VFD'],
      readTimeMinutes: 8,
      summary: 'Reduce electromagnetic interference from drives and switch-mode equipment with routing, shielding, and grounding discipline.',
      keywords: ['screened cable', 'bonding', 'filter', 'signal integrity'],
      relatedArticleIds: ['motors_05', 'power_06', 'components_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Do not remove protective earth connections while chasing noise issues on live systems.'],
      commonMistakes: ['Ignoring manufacturer EMC wiring', 'Routing signals with VFD outputs'],
      professionalTips: ['Follow the drive EMC chapter literally', 'Prove improvements with before/after symptom logs'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_04',
      title: 'Energy Monitoring Systems',
      category: 'modern',
      content: '''## Introduction
Energy monitoring only helps when sensors are installed correctly and circuits are identified accurately. Bad data creates bad decisions.

## Core Pieces
Voltage references, current transformers (CTs) or sensors, meter/gateway, and software dashboards.

## CT Rules
- Match CT ratio to meter
- Observe arrow/orientation toward load as specified
- Do not leave CT secondaries open on live primary current for conventional CTs
- Size CTs for normal and peak currents

## Data Quality
Label every channel to the real DB way. Energy = power × time only becomes useful with correct scaling and timestamps.

## Field Application
Install during planned isolation when possible; photograph CT placements; verify kW readings against known loads during commissioning.

## Common Mistakes
Reversed CTs; unlabeled channels; CTs on mixed multi-circuit bundles; wrong CT ratio programming.

## Professional Tips
Start with main incomer and large feeders; validate with a portable meter; keep a channel map in the panel.

## Safety
Working in live boards for CT install is high risk. Prefer isolation and qualified procedures.''',
      difficulty: 'journeyman',
      tags: ['energy-meter', 'CT', 'monitoring'],
      readTimeMinutes: 7,
      summary: 'CT orientation, circuit labeling, and safe installation habits for useful energy monitoring data.',
      keywords: ['CT ratio', 'channel map', 'kWh', 'commissioning'],
      relatedArticleIds: ['basics_03', 'power_04', 'modern_06'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: ['Energy = Power × Time'],
      safetyNotes: ['Do not open conventional CT secondaries under load.'],
      commonMistakes: ['Unlabeled meter channels', 'Wrong CT orientation/ratio'],
      professionalTips: ['Commission against a known load', 'Keep a paper channel map in the DB'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_05',
      title: 'Generator ATS Systems',
      category: 'modern',
      content: '''## Introduction
An Automatic Transfer Switch (ATS) moves selected loads between utility and generator power. Its first safety job is preventing both sources from connecting together and backfeeding the grid.

## Core Functions
- Sense utility failure and restoration
- Start the generator when automatic control is used
- Transfer load when generator voltage/frequency are ready
- Re-transfer and cooldown according to settings
- Maintain mechanical and electrical interlocking at all times

## Neutral and Earthing
Whether neutral is switched depends on system design and local requirements. Incorrect neutral handling can create parallel neutral paths, nuisance trips, or dangerous touch voltages. Follow the project earthing design, not habit from another site.

## Commissioning Tests
Simulate utility loss under controlled conditions, verify timing, confirm no source overlap, test manual modes, and document final setpoints. Repeat transfer tests on a maintenance schedule.

## Common Mistakes
Improvised contactor changeovers without rated ATS interlocks; no test schedule; unknown neutral strategy; no labeling of source sides.

## Professional Tips
Label utility and generator sides clearly; keep a transfer test log; coordinate ATS timers with generator controller setpoints; train operators on manual emergency procedures.

## Safety
Backfeed risk is life-critical for utility workers. Never bypass ATS interlocks to force power onto a building or feeder.''',
      difficulty: 'master',
      tags: ['ATS', 'transfer-switch', 'interlock', 'neutral'],
      readTimeMinutes: 8,
      summary: 'ATS operation, anti-backfeed interlocking, sensing, neutral considerations, and commissioning tests.',
      keywords: ['utility sensing', 'generator start', 'source interlocking', 'transfer test'],
      relatedArticleIds: ['power_07', 'power_05', 'renewable_07'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Never defeat ATS interlocks. Backfeed can kill utility workers.'],
      commonMistakes: ['Unrated improvised transfer schemes', 'No periodic transfer testing'],
      professionalTips: ['Document neutral strategy', 'Run scheduled transfer tests under load when safe'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
    TheoryArticle(
      id: 'modern_06',
      title: 'Smart Breakers and Connected Protection',
      category: 'modern',
      content: '''## Introduction
Smart breakers and connected protective devices add measurement, status, and sometimes remote control. They support faster fault finding, but they do not replace protection engineering or physical lockout discipline.

## Useful Features
Trip logs, energy data, remote status, alarms, event history, and integration into building dashboards can reduce downtime on large sites.

## First Selection Criteria
Rated current, trip curve/characteristics, breaking capacity (kA), poles, and coordination remain primary. Connectivity is a secondary benefit. A smart device with inadequate fault rating is still the wrong device.

## Remote Control Caution
Remote open/close can improve operations, but must never replace physical lockout/tagout for human work on downstream equipment. Network commands can fail, lag, or be issued by the wrong user.

## Cyber and Access
Change default passwords, restrict who can operate remote controls, segment networks where practical, and maintain update policies for connected electrical gear.

## Common Mistakes
Buying smart devices with inadequate kA rating; relying on app state as isolation proof; leaving default credentials; no paper single-line diagram backup.

## Professional Tips
Integrate smart events into maintenance workflows; keep updated single-line diagrams; verify firmware update responsibility with the client; prioritize protection settings documentation.

## Safety
A green app icon is not a lockout. Isolate and prove dead for hands-on work every time.''',
      difficulty: 'journeyman',
      tags: ['smart-breaker', 'IoT', 'remote-monitoring'],
      readTimeMinutes: 8,
      summary: 'What connected breakers can monitor, why protection ratings still come first, and cyber/access caution.',
      keywords: ['trip log', 'remote open', 'breaking capacity', 'access control'],
      relatedArticleIds: ['components_07', 'modern_04', 'safety_03'],
      pecReferences: ['Educational reference only. Always verify current PEC, IEC, DISCO/WAPDA/K-Electric, NEPRA, manufacturer, and local authority requirements before installation or maintenance.'],
      formulas: [],
      safetyNotes: ['Remote control is not LOTO. Use physical isolation before work.'],
      commonMistakes: ['Connectivity over protection ratings', 'Default passwords left active'],
      professionalTips: ['Prioritize Icu/curve/coordination first', 'Treat remote power control as a controlled privilege'],
      lastReviewed: '2026-07-13',
      contentVersion: '2.1.0-theory-rewrite',
    ),
  ];
}
