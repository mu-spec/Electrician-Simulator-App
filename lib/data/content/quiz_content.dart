import '../../models/quiz_model.dart';

class QuizContent {
  // ==================== QUIZ CATEGORIES ====================
  static const List<QuizCategory> quizCategories = [
    QuizCategory(
        id: 'basics',
        name: 'Electrical Basics',
        description:
            'Voltage, current, resistance, units, conductors, and core electrical fundamentals.',
        iconName: 'bolt',
        colorHex: '#2563EB',
        totalQuestions: 25,
        keywords: ['voltage', 'current', 'resistance', 'units', 'ohms law']),
    QuizCategory(
        id: 'safety',
        name: 'Safety & Codes',
        description:
            'PPE, safe isolation, shock protection, fire response, and field safety scenarios.',
        iconName: 'shield',
        colorHex: '#EF4444',
        totalQuestions: 25,
        keywords: ['safety', 'PPE', 'LOTO', 'RCD', 'shock']),
    QuizCategory(
        id: 'circuits',
        name: 'Circuits & Systems',
        description:
            'AC/DC, series/parallel, RMS, three-phase, faults, star/delta, and load balancing.',
        iconName: 'electrical_services',
        colorHex: '#10B981',
        totalQuestions: 25,
        keywords: ['AC', 'DC', 'three phase', 'faults', 'star delta']),
    QuizCategory(
        id: 'calculations',
        name: 'Calculations',
        description:
            'Practical formula questions for power, current, voltage drop, transformers, solar, and protection.',
        iconName: 'calculate',
        colorHex: '#F59E0B',
        totalQuestions: 25,
        keywords: ['formula', 'power', 'current', 'voltage drop', 'kVA']),
    QuizCategory(
        id: 'motors',
        name: 'Motors & Drives',
        description:
            'Motor FLC, starters, overloads, VFDs, slip, rotation, and troubleshooting.',
        iconName: 'settings',
        colorHex: '#8B5CF6',
        totalQuestions: 25,
        keywords: ['motor', 'DOL', 'star delta', 'VFD', 'overload']),
    QuizCategory(
        id: 'solar',
        name: 'Solar & Renewable',
        description:
            'PV panels, inverters, batteries, MPPT, grid-tie, hybrid systems, and DC protection.',
        iconName: 'wb_sunny',
        colorHex: '#06B6D4',
        totalQuestions: 25,
        keywords: ['solar', 'PV', 'inverter', 'battery', 'MPPT']),
    QuizCategory(
        id: 'standards',
        name: 'Standards & Codes',
        description:
            'Educational IEC, NEC, BS 7671, PEC, utility, solar grid, safety, and compliance awareness.',
        iconName: 'gavel',
        colorHex: '#0F766E',
        totalQuestions: 25,
        keywords: ['IEC', 'NEC', 'BS 7671', 'PEC', 'utility', 'safety']),
    QuizCategory(
        id: 'master',
        name: 'Master Level',
        description:
            'Advanced protection, harmonics, coordination, earthing design, ATS, EMC, and troubleshooting scenarios.',
        iconName: 'workspace_premium',
        colorHex: '#7C2D12',
        totalQuestions: 25,
        keywords: ['master', 'coordination', 'harmonics', 'earthing', 'ATS']),
  ];

  // ==================== QUIZ QUESTIONS ====================
  static const List<QuizQuestion> quizQuestions = [
    QuizQuestion(
      id: 'q001',
      question: 'What is the SI unit of electrical current?',
      options: ["Ampere", "Volt", "Ohm", "Watt"],
      correctIndex: 0,
      explanation:
          'Current is measured in amperes (A). It describes the rate of flow of electric charge.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_01',
      pecReference: '',
      tags: ['units'],
      keywords: ['ampere', 'current', 'basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q002',
      question:
          'According to Ohm\'s Law, what happens to current if voltage doubles and resistance is unchanged?',
      options: [
        "Current halves",
        "Current doubles",
        "Current becomes zero",
        "Resistance doubles"
      ],
      correctIndex: 1,
      explanation:
          'I = V / R. If V doubles while R is constant, current doubles.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_02',
      pecReference: '',
      tags: ['ohms-law'],
      keywords: ['current', 'voltage', 'basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q003',
      question:
          'Which conductor is commonly used in building wiring because of good conductivity and practical cost?',
      options: ["Copper", "Glass", "Rubber", "PVC"],
      correctIndex: 0,
      explanation:
          'Copper is widely used because it has high conductivity and practical mechanical properties.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_06',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q004',
      question:
          'What does 230 V AC normally represent on a household supply label?',
      options: ["Peak voltage", "Battery voltage", "RMS voltage", "Frequency"],
      correctIndex: 2,
      explanation:
          'AC supply voltage labels normally state RMS value, not peak value.',
      category: 'basics',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_07',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q005',
      question:
          'Which quantity is measured in kilowatt-hours on an electricity bill?',
      options: ["Power", "Resistance", "Frequency", "Energy"],
      correctIndex: 3,
      explanation: 'kWh is energy: power used over time.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_03',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q006',
      question: 'What is the purpose of insulation around a conductor?',
      options: [
        "Prevent unintended contact and leakage",
        "Increase current",
        "Make voltage higher",
        "Replace earth wire"
      ],
      correctIndex: 0,
      explanation:
          'Insulation prevents accidental contact, short circuits, and leakage within its rating.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_06',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q007',
      question: 'Which prefix means one thousand?',
      options: ["milli", "micro", "kilo", "mega"],
      correctIndex: 2,
      explanation: 'Kilo means 1000, so 1 kW = 1000 W.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_05',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q008',
      question:
          'A nameplate showing 50 Hz means the equipment is rated for what?',
      options: [
        "Earth resistance",
        "Cable size",
        "Breaker curve",
        "Supply frequency"
      ],
      correctIndex: 3,
      explanation:
          '50 Hz is the supply frequency rating. Pakistan mains supply is normally 50 Hz.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_08',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q009',
      question:
          'If a 10 Ω resistor carries 2 A, what is the voltage across it?',
      options: ["20 V", "5 V", "10 V", "200 V"],
      correctIndex: 0,
      explanation: 'V = I × R = 2 × 10 = 20 V.',
      category: 'basics',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_02',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q010',
      question:
          'What material property mainly determines conductor resistance for a given length and area?',
      options: ["Color", "Resistivity", "Weight", "Brand"],
      correctIndex: 1,
      explanation:
          'Resistance depends on material resistivity, length, and cross-sectional area.',
      category: 'basics',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_06',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q011',
      question: 'What is the symbol for resistance?',
      options: ["R", "V", "I", "P"],
      correctIndex: 0,
      explanation: 'Resistance is represented by R and measured in ohms.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_02',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q012',
      question: 'Which statement best describes voltage?',
      options: [
        "Rate of energy use",
        "Opposition to current",
        "Potential difference between two points",
        "Number of electrons in a wire"
      ],
      correctIndex: 2,
      explanation:
          'Voltage is electrical potential difference between two points.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_01',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q013',
      question: 'Why should units always be written with measured values?',
      options: [
        "To make notes longer",
        "To avoid calculation and installation mistakes",
        "To replace testing",
        "To remove need for labels"
      ],
      correctIndex: 1,
      explanation:
          'A value without a unit can be misread, causing wrong cable, breaker, or equipment selection.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_05',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q014',
      question: 'What is direct current (DC)?',
      options: [
        "Current that periodically reverses",
        "Current with no voltage",
        "Current only in transformers",
        "Current that flows in one direction"
      ],
      correctIndex: 3,
      explanation:
          'DC flows in one direction, such as from batteries or solar panels.',
      category: 'basics',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'circuits_02',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q015',
      question:
          'Which is safest before reading a motor nameplate inside a panel?',
      options: [
        "Isolate and verify zero energy",
        "Touch terminals first",
        "Use any screwdriver as tester",
        "Ignore PPE for low voltage"
      ],
      correctIndex: 0,
      explanation:
          'Before working inside electrical equipment, isolate and prove dead using proper PPE and tester.',
      category: 'basics',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_08',
      pecReference: '',
      tags: ['basics'],
      keywords: ['basics', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q016',
      question:
          'What is the first practical safety step before touching a circuit conductor?',
      options: [
        "Trust the conductor color without testing",
        "Verify zero energy after isolation",
        "Increase breaker size",
        "Remove earth wire"
      ],
      correctIndex: 1,
      explanation:
          'Always isolate and verify zero energy before touching conductors.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_05',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q017',
      question: 'What does LOTO stand for?',
      options: [
        "Load Output Test Only",
        "Live Operation Tool Order",
        "Lockout/Tagout",
        "Line Open Test Output"
      ],
      correctIndex: 2,
      explanation:
          'LOTO means Lockout/Tagout, used to prevent unexpected energization.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_03',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q018',
      question:
          'Which device is primarily used to reduce shock risk from earth leakage?',
      options: [
        "Contactor",
        "Ordinary switch",
        "MCB used only for overcurrent protection",
        "RCD/RCCB"
      ],
      correctIndex: 3,
      explanation:
          'RCD/RCCB detects leakage imbalance and disconnects supply quickly.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q019',
      question:
          'Which extinguisher type is commonly suitable for energized electrical fires?',
      options: [
        "CO₂",
        "Water jet",
        "Water extinguisher while supply remains energized",
        "Wet-chemical extinguisher intended for cooking oils"
      ],
      correctIndex: 0,
      explanation:
          'CO₂ is non-conductive and commonly used for electrical fires. Always follow local fire guidance.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_07',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q020',
      question: 'What should you do before trusting a voltage tester?',
      options: [
        "Shake it",
        "Test on a known live source",
        "Wash it with water",
        "Set it to amps"
      ],
      correctIndex: 1,
      explanation:
          'Prove the tester on a known live source before and after testing for dead.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_05',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q021',
      question: 'Why are loose terminals dangerous?',
      options: [
        "They create heat and arcing risk",
        "They reduce voltage only",
        "They improve power factor",
        "They make RCD unnecessary"
      ],
      correctIndex: 0,
      explanation:
          'Loose connections create resistance, heat, arcing, and fire risk.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_08',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q022',
      question:
          'If a person is still in contact with live electricity, what should you do first?',
      options: [
        "Pull them with bare hands",
        "Pour water",
        "Apply ointment",
        "Turn off supply or separate using insulated means"
      ],
      correctIndex: 3,
      explanation:
          'Do not touch the victim directly. Isolate power or use insulated means to separate them.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_02',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q023',
      question:
          'Which PPE item helps protect against eye injury while drilling or working in panels?',
      options: [
        "Safety glasses",
        "Hearing protection",
        "Safety footwear",
        "Insulating mat"
      ],
      correctIndex: 0,
      explanation:
          'Safety glasses protect eyes from debris and arc/flash hazards depending on work.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_04',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q024',
      question:
          'What is wrong with replacing a tripping breaker with a larger one without investigation?',
      options: [
        "It improves safety",
        "It may overload the cable and cause fire",
        "It lowers current",
        "It improves earthing"
      ],
      correctIndex: 1,
      explanation:
          'Breakers protect cables. Oversizing can allow dangerous overheating.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'components_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q025',
      question:
          'Which conductor must not be used as a normal load-carrying neutral?',
      options: ["Protective earth", "Phase", "Neutral", "Switched live"],
      correctIndex: 0,
      explanation:
          'Protective earth is for fault current path, not normal load current.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_05',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q026',
      question: 'What does a 30 mA RCD commonly indicate?',
      options: [
        "Overload setting",
        "Cable size",
        "Residual current trip sensitivity",
        "Frequency"
      ],
      correctIndex: 2,
      explanation:
          '30 mA is a common residual-current sensitivity for additional shock protection.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_06',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q027',
      question: 'What is the safest assumption about unknown conductors?',
      options: [
        "They are dead",
        "They are live until tested and proven dead",
        "They are earth wires",
        "They are low current"
      ],
      correctIndex: 1,
      explanation:
          'Treat unknown conductors as live until isolated and verified.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q028',
      question: 'Why should water not be used on energized electrical fires?',
      options: [
        "It is too cold",
        "It makes smoke darker",
        "It reduces oxygen too fast",
        "It can conduct electricity and cause shock"
      ],
      correctIndex: 3,
      explanation:
          'Water can conduct current and create shock risk. Isolate power and use suitable extinguisher.',
      category: 'safety',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_07',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q029',
      question:
          'Which rating should be checked on a multimeter for panel work?',
      options: ["CAT rating", "Screen color", "Brand logo", "Weight"],
      correctIndex: 0,
      explanation:
          'CAT rating indicates suitability for electrical transient environments.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_04',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q030',
      question: 'A circuit is switched off but not locked. What is the risk?',
      options: [
        "No risk exists",
        "Voltage doubles",
        "Someone may re-energize it unexpectedly",
        "RCD stops working"
      ],
      correctIndex: 2,
      explanation:
          'Without lockout/tagout, another person can switch it back on.',
      category: 'safety',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_03',
      pecReference: '',
      tags: ['safety'],
      keywords: ['safety', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q031',
      question: 'In a series circuit, what is the same through all components?',
      options: ["Voltage", "Current", "Resistance", "Power factor"],
      correctIndex: 1,
      explanation: 'Series components carry the same current.',
      category: 'circuits',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'circuits_01',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q032',
      question: 'In a parallel circuit, what is common across each branch?',
      options: ["Current", "Resistance", "Voltage", "Cable length"],
      correctIndex: 2,
      explanation:
          'Parallel branches share the same voltage across the supply points.',
      category: 'circuits',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'circuits_01',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q033',
      question: 'What is Pakistan mains frequency normally?',
      options: ["25 Hz", "50 Hz", "60 Hz", "400 Hz"],
      correctIndex: 1,
      explanation: 'Pakistan mains supply is normally 50 Hz.',
      category: 'circuits',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'circuits_02',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q034',
      question:
          "In a star-connected three-phase system, how is line voltage related to phase voltage?",
      options: [
        "Phase voltage",
        "Phase voltage / 3",
        "√3 × phase voltage",
        "3 × current"
      ],
      correctIndex: 2,
      explanation: 'In star connection, Vline = √3 × Vphase.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_05',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q035',
      question:
          'What fault type occurs when live conductor contacts earth or exposed metalwork?',
      options: [
        "Open circuit",
        "Normal load",
        "High power factor",
        "Earth fault"
      ],
      correctIndex: 3,
      explanation:
          'An earth fault provides unintended current path to earth/exposed conductive parts.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_07',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q036',
      question: 'Why is three-phase power useful for motors?',
      options: [
        "No current flows",
        "It removes need for protection",
        "It creates a rotating magnetic field",
        "It works only with DC"
      ],
      correctIndex: 2,
      explanation:
          'Three-phase supply naturally creates a rotating magnetic field for motors.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_02',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q037',
      question: 'What does RMS value represent for AC?',
      options: [
        "Average color of waveform",
        "Maximum peak only",
        "Frequency ratio",
        "Equivalent DC heating value"
      ],
      correctIndex: 3,
      explanation:
          'RMS is the equivalent DC value producing same heating effect.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_07',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q038',
      question:
          'What happens to total resistance when more resistors are added in parallel?',
      options: [
        "It decreases",
        "It increases",
        "It always becomes zero",
        "It equals largest resistor"
      ],
      correctIndex: 0,
      explanation:
          'Adding parallel branches provides more current paths and reduces total resistance.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_01',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q039',
      question: 'What is an open circuit?',
      options: [
        "Unintended high-current path",
        "Earth leakage only",
        "Perfect conductor",
        "Broken/incomplete path preventing current"
      ],
      correctIndex: 3,
      explanation:
          'An open circuit is an incomplete path, so normal current cannot flow.',
      category: 'circuits',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'circuits_07',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q040',
      question: 'What does phase sequence affect most directly?',
      options: [
        "Color of neutral wire",
        "Battery capacity",
        "Direction of three-phase motor rotation",
        "LED brightness only"
      ],
      correctIndex: 2,
      explanation: 'Changing phase sequence reverses many three-phase motors.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_03',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q041',
      question: 'What is the main reason for balancing three-phase loads?',
      options: [
        "To eliminate voltage",
        "To reduce imbalance and neutral current",
        "To remove earth wire",
        "To make all breakers same brand"
      ],
      correctIndex: 1,
      explanation:
          'Load balancing reduces phase imbalance, neutral current, and transformer stress.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_06',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q042',
      question: "Where is Kirchhoff's Current Law applied?",
      options: [
        "Circuit junction/node",
        "A closed circuit loop",
        "A magnetic core",
        "A waveform peak"
      ],
      correctIndex: 0,
      explanation:
          'KCL states current entering a node equals current leaving it.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'circuits_03',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q043',
      question:
          'Which wire color is commonly used internationally for protective earth?',
      options: ["Blue", "Brown only", "Green/yellow", "Black only"],
      correctIndex: 2,
      explanation:
          'Green/yellow is commonly used for protective earth under IEC-style color coding.',
      category: 'circuits',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q044',
      question: 'What is short circuit current usually limited by?',
      options: [
        "Load energy consumption",
        "Loop/source impedance",
        "Supply frequency",
        "Power factor alone"
      ],
      correctIndex: 1,
      explanation:
          'Fault current is largely limited by source and loop impedance.',
      category: 'circuits',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_08',
      pecReference: '',
      tags: ['circuits'],
      keywords: ['circuits', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q045',
      question:
          'In the two-way staircase wiring diagram, which conductors connect the two switches?',
      options: [
        "Earth only",
        "Neutral only",
        "Traveller wires",
        "Battery leads"
      ],
      correctIndex: 2,
      explanation:
          'Two-way switches use traveller conductors between L1/L2 terminals.',
      category: 'circuits',
      difficulty: 'journeyman',
      imageAsset: 'assets/diagrams/res_02.webp',
      relatedArticleId: 'circuits_01',
      pecReference: '',
      tags: ['image', 'switching'],
      keywords: ['two-way', 'travellers', 'circuits', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q046',
      question:
          "Approximately how much current does a 1000 W heater draw at 230 V?",
      options: ["0.23 A", "2.3 A", "4.35 A", "23 A"],
      correctIndex: 2,
      explanation: 'I = P / V = 1000 / 230 ≈ 4.35 A.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_03',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q047',
      question: "How much current flows when 12 V is applied across 6 Ω?",
      options: ["0.5 A", "6 A", "72 A", "2 A"],
      correctIndex: 3,
      explanation: 'I = V / R = 12 / 6 = 2 A.',
      category: 'calculations',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_02',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q048',
      question: "Which formula gives balanced three-phase real power?",
      options: ["P = V/I", "P = R/V", "P = √3 × V × I × PF", "P = Ah × V only"],
      correctIndex: 2,
      explanation:
          'For balanced three-phase AC, P = √3 × line voltage × line current × power factor.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'basics_03',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q049',
      question:
          "What apparent power is required by a 10 kW load at power factor 0.8?",
      options: ["8 kVA", "10 kVA", "18 kVA", "12.5 kVA"],
      correctIndex: 3,
      explanation: 'kVA = kW / PF = 10 / 0.8 = 12.5 kVA.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_01',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q050',
      question:
          "If current is 20 A, one-way length is 30 m, and resistance is 7.41 Ω/km, what is the approximate single-phase voltage drop?",
      options: ["0.89 V", "8.89 V", "44.5 V", "230 V"],
      correctIndex: 1,
      explanation: 'VD = 2 × 20 × 30 × 7.41 / 1000 ≈ 8.89 V.',
      category: 'calculations',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'safety_08',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q051',
      question:
          "How much current does a 5 kW single-phase load draw at 230 V and power factor 1?",
      options: ["2.17 A", "50 A", "1150 A", "21.7 A"],
      correctIndex: 3,
      explanation: 'I = 5000 / 230 ≈ 21.7 A.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_02',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q052',
      question:
          "Approximately what current does a 7.5 kW motor draw at 400 V, power factor 0.85, and 90% efficiency?",
      options: ["4 A", "14 A", "40 A", "140 A"],
      correctIndex: 1,
      explanation: 'I ≈ 7500 / (1.732×400×0.85×0.9) ≈ 14 A.',
      category: 'calculations',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_01',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q053',
      question: 'What is 10 HP approximately in kW?',
      options: ["0.746 kW", "13.4 kW", "746 kW", "7.46 kW"],
      correctIndex: 3,
      explanation: 'kW = HP × 0.746 = 10 × 0.746 = 7.46 kW.',
      category: 'calculations',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_05',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q054',
      question: 'What is 7.46 kW approximately in HP?',
      options: ["1 HP", "5 HP", "10 HP", "100 HP"],
      correctIndex: 2,
      explanation: 'HP = kW / 0.746 = 7.46 / 0.746 ≈ 10 HP.',
      category: 'calculations',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'basics_05',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q055',
      question:
          "For a voltage divider with equal resistors and 12 V input, what is the output voltage?",
      options: ["0 V", "12 V", "24 V", "6 V"],
      correctIndex: 3,
      explanation: 'Equal R1 and R2 divide voltage equally, so Vout = 6 V.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'components_01',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q056',
      question:
          'A 60 W lamp replaced by 10 W LED saves how many watts per lamp?',
      options: ["50 W", "10 W", "60 W", "70 W"],
      correctIndex: 0,
      explanation: 'Saved power = 60 - 10 = 50 W per lamp.',
      category: 'calculations',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'modern_04',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q057',
      question:
          "If fault-loop impedance is 0.2 Ω on 230 V, what is the prospective fault current?",
      options: ["46 A", "115 A", "1150 A", "2300 A"],
      correctIndex: 2,
      explanation: 'Isc = V / Z = 230 / 0.2 = 1150 A.',
      category: 'calculations',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_08',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q058',
      question:
          "What is the THD when harmonic RMS current is 12 A and fundamental RMS current is 100 A?",
      options: ["12%", "1.2%", "88%", "112%"],
      correctIndex: 0,
      explanation: 'THD = harmonic RMS / fundamental × 100 = 12%.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_06',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q059',
      question:
          "At 100% usable capacity, approximately what battery capacity is required for 5 kWh at 48 V?",
      options: ["10 Ah", "104 Ah", "52 Ah", "5000 Ah"],
      correctIndex: 1,
      explanation:
          'Ah = Wh / V = 5000 / 48 ≈ 104 Ah before DoD/efficiency margins.',
      category: 'calculations',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_04',
      pecReference: '',
      tags: ['calculations'],
      keywords: ['calculations', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q060',
      question:
          "Which formula is used for adiabatic protective-conductor sizing?",
      options: ["S = I√t/k", "P = V/I", "R = V×I", "Ah = W/V only"],
      correctIndex: 0,
      explanation: 'Protective conductor adiabatic sizing uses S = I × √t / k.',
      category: 'calculations',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_05',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['calculations'],
      keywords: ['calculations', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q061',
      question: 'What does DOL stand for in motor starting?',
      options: [
        "Dual Output Load",
        "Direct On Line",
        "Delayed Open Line",
        "Drive Overload Link"
      ],
      correctIndex: 1,
      explanation: 'DOL means Direct-On-Line starting.',
      category: 'motors',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'motors_03',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q062',
      question:
          "Approximately what starting current is typical for a motor started direct-on-line?",
      options: ["0.1× FLC", "1× FLC", "6–8× FLC", "100× FLC always"],
      correctIndex: 2,
      explanation:
          'DOL starting current can commonly be 6–8 times full-load current.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_03',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q063',
      question: 'What device protects a motor from sustained overload?',
      options: [
        "Contactor main contacts",
        "Short-circuit fuse only",
        "Manual isolator only",
        "Overload relay"
      ],
      correctIndex: 3,
      explanation:
          'Overload relays trip when motor current exceeds set value for too long.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_06',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q064',
      question:
          "What should a motor overload-relay setting normally be based on?",
      options: [
        "Upstream breaker frame size only",
        "Motor nameplate full-load current",
        "Starter enclosure size only",
        "Conductor identification only"
      ],
      correctIndex: 1,
      explanation:
          'Set overload according to motor nameplate FLC and manufacturer instructions.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_06',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q065',
      question: 'What does a VFD mainly control to change AC motor speed?',
      options: [
        "Frequency and voltage",
        "Earth resistance only",
        "Wire color",
        "Fuse brand"
      ],
      correctIndex: 0,
      explanation:
          'VFD changes output frequency and voltage to control motor speed.',
      category: 'motors',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_05',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q066',
      question: 'What is synchronous speed for a 4-pole motor at 50 Hz?',
      options: ["750 rpm", "1500 rpm", "1000 rpm", "3000 rpm"],
      correctIndex: 1,
      explanation: 'Ns = 120f/P = 120×50/4 = 1500 rpm.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_01',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q067',
      question:
          "What is the condition called when one phase is missing from a three-phase motor supply?",
      options: [
        "Power factoring",
        "Neutral balancing",
        "Single phasing",
        "Loop testing"
      ],
      correctIndex: 2,
      explanation:
          'Single phasing can overheat and damage a three-phase motor.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_01',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q068',
      question:
          "Which connection is used first during conventional star-delta starting?",
      options: [
        "Delta then star",
        "DC then AC",
        "Reverse only",
        "Star then delta"
      ],
      correctIndex: 3,
      explanation:
          'Star-delta starters start in star and transition to delta for running.',
      category: 'motors',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_04',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q069',
      question: 'Why must star and delta contactors be interlocked?',
      options: [
        "To change wire color",
        "To prevent both closing together and causing a short circuit",
        "To remove overload relay",
        "To reduce label size"
      ],
      correctIndex: 1,
      explanation:
          'Star and delta contactors must never be energized together.',
      category: 'motors',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_04',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q070',
      question: 'What can wrong phase sequence cause on a three-phase motor?',
      options: [
        "Reverse rotation",
        "Zero slip at full load",
        "Lower supply frequency",
        "Higher insulation resistance"
      ],
      correctIndex: 0,
      explanation: 'Swapping two phases reverses many three-phase motors.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'power_03',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q071',
      question: 'Which contact is usually in the STOP button circuit?',
      options: [
        "Normally open only",
        "Earth electrode",
        "Timer coil",
        "Normally closed"
      ],
      correctIndex: 3,
      explanation:
          'STOP buttons are usually normally closed so pressing/opening stops the control circuit.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_03',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q072',
      question:
          'In the DOL starter diagram, which component switches the three motor phases?',
      options: [
        "Contactor",
        "Overload relay",
        "Control transformer",
        "Manual isolator"
      ],
      correctIndex: 0,
      explanation:
          'The contactor switches the three-phase motor supply in a DOL starter.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: 'assets/diagrams/motor_01.webp',
      relatedArticleId: 'motors_03',
      pecReference: '',
      tags: ['image', 'DOL'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q073',
      question:
          'Which motor fault is often indicated by excessive vibration and noise?',
      options: [
        "Perfect power factor",
        "Correct labeling",
        "Bearing/mechanical problem",
        "Low tariff"
      ],
      correctIndex: 2,
      explanation:
          'Vibration and noise often point to bearing, alignment, imbalance, or mechanical issues.',
      category: 'motors',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'motors_07',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q074',
      question:
          'What should be checked before selecting a VFD for an existing motor?',
      options: [
        "Motor insulation suitability and nameplate data",
        "Supply voltage only",
        "Motor cable length only",
        "Panel enclosure size only"
      ],
      correctIndex: 0,
      explanation:
          'Motor rating, insulation, load, environment, and cable/EMC needs should be checked.',
      category: 'motors',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_05',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q075',
      question:
          'Which starter is best suited for direction reversal using two interlocked contactors?',
      options: [
        "DOL starter",
        "Star-delta starter",
        "Soft starter without reversing contactors",
        "Reverse-forward starter"
      ],
      correctIndex: 3,
      explanation:
          'Forward/reverse starters swap two phases using interlocked contactors.',
      category: 'motors',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_07',
      pecReference: '',
      tags: ['motors'],
      keywords: ['motors', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q076',
      question: 'What type of electricity do PV panels produce?',
      options: ["AC directly only", "DC", "No voltage", "Only reactive power"],
      correctIndex: 1,
      explanation: 'Solar PV panels produce DC electricity.',
      category: 'solar',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'renewable_01',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q077',
      question: 'What does MPPT stand for?',
      options: [
        "Manual Phase Protection Trip",
        "Main Panel Polarity Test",
        "Motor Power Protection Timer",
        "Maximum Power Point Tracking"
      ],
      correctIndex: 3,
      explanation: 'MPPT means Maximum Power Point Tracking.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_05',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q078',
      question:
          'Which side of a solar system can remain energized in daylight even if AC is off?',
      options: [
        "PV DC side",
        "Battery terminals only",
        "Inverter AC output only",
        "Monitoring communication link only"
      ],
      correctIndex: 0,
      explanation: 'PV DC strings can remain live whenever illuminated.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_01',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q079',
      question:
          'What does a grid-tie inverter require to protect utility workers during outage?',
      options: [
        "Bigger fan only",
        "No earthing",
        "Open neutral",
        "Anti-islanding protection"
      ],
      correctIndex: 3,
      explanation:
          'Anti-islanding disconnects inverter output when grid supply is lost.',
      category: 'solar',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'renewable_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['solar'],
      keywords: ['solar', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q080',
      question: 'What does DoD mean for batteries?',
      options: [
        "Depth of Discharge",
        "Direction of Diode",
        "Drop of Distribution",
        "Duty of Device"
      ],
      correctIndex: 0,
      explanation: 'DoD is the portion of battery capacity used/discharged.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_04',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q081',
      question: 'Why must PV string Voc be checked?',
      options: [
        "To determine AC output frequency",
        "To eliminate the need for a DC isolator",
        "To ensure it does not exceed inverter maximum DC voltage",
        "To calculate battery ampere-hours"
      ],
      correctIndex: 2,
      explanation:
          'Cold/bright conditions can raise Voc; it must remain within inverter limits.',
      category: 'solar',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'renewable_02',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q082',
      question: 'What is the purpose of a DC isolator in a PV system?',
      options: [
        "Increase tariff",
        "Reduce roof load only",
        "Change AC frequency",
        "Safely disconnect PV DC supply"
      ],
      correctIndex: 3,
      explanation:
          'DC isolators provide a rated means of isolating PV DC circuits.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_01',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q083',
      question:
          'Which protection is commonly used for PV string overcurrent where required?',
      options: [
        "DC-rated fuse/breaker",
        "AC-only miniature circuit breaker",
        "RCD intended for AC residual current",
        "Surge protective device only"
      ],
      correctIndex: 0,
      explanation:
          'PV protection devices must be DC rated for the circuit voltage/current.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_01',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q084',
      question:
          "What sources and loads does a typical hybrid inverter system connect?",
      options: [
        "PV and grid only, with no storage or backup output",
        "PV, battery, grid/generator, and backup loads",
        "Battery and loads only, with no charging source",
        "A generator only, with no load output"
      ],
      correctIndex: 1,
      explanation:
          'Hybrid systems combine PV, battery storage, grid/generator input, and selected loads.',
      category: 'solar',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'renewable_07',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q085',
      question:
          'What should be separated in hybrid systems for backup planning?',
      options: [
        "Red and blue labels only",
        "Old and new screws",
        "Essential and non-essential loads",
        "North and south walls only"
      ],
      correctIndex: 2,
      explanation:
          'Essential loads should be separated so backup output is not overloaded.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_07',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q086',
      question:
          'Which meter supports crediting exported solar energy in grid-tie systems?',
      options: [
        "Import-only energy meter",
        "Bi-directional/net meter",
        "Clamp ammeter",
        "Voltmeter"
      ],
      correctIndex: 1,
      explanation:
          'Net metering uses a suitable meter to measure import/export energy.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q087',
      question:
          'In the grid-tie solar diagram, which device converts PV DC to synchronized grid AC?',
      options: [
        "Grid-tie inverter",
        "Solar charge controller",
        "DC combiner box",
        "Bi-directional energy meter"
      ],
      correctIndex: 0,
      explanation:
          'The inverter converts PV DC into synchronized AC for grid connection.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: 'assets/diagrams/solar_03.webp',
      relatedArticleId: 'renewable_06',
      pecReference: '',
      tags: ['image', 'grid-tie'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q088',
      question: 'Why are battery terminals a short-circuit hazard?',
      options: [
        "They have no voltage",
        "They are always AC",
        "They stop all current",
        "Batteries can deliver very high current"
      ],
      correctIndex: 3,
      explanation:
          'Battery banks can deliver extremely high fault current; use DC-rated protection.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_04',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q089',
      question: 'What can shading on one PV string cause?',
      options: [
        "Higher grid frequency",
        "Better insulation",
        "Reduced output and mismatch losses",
        "No current forever"
      ],
      correctIndex: 2,
      explanation: 'Shading reduces output and can create mismatch losses.',
      category: 'solar',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'renewable_02',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q090',
      question:
          'Which device protects sensitive solar electronics from transient surges?',
      options: [
        "MCB for overcurrent protection",
        "SPD",
        "RCD for residual-current protection",
        "DC isolator"
      ],
      correctIndex: 1,
      explanation:
          'Surge protection devices reduce transient overvoltage risk when correctly installed/earthed.',
      category: 'solar',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'components_08',
      pecReference: '',
      tags: ['solar'],
      keywords: ['solar', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q091',
      question:
          'What is the safest way to use PEC/local code information in this app?',
      options: [
        "As final legal approval",
        "As educational reference that must be verified with latest official requirements",
        "As a general reference without checking the adopted edition",
        "As a replacement for manufacturer instructions"
      ],
      correctIndex: 1,
      explanation:
          'App content is educational; final work must follow current official standards and authority requirements.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q092',
      question:
          "Who should verify final utility connection requirements in Pakistan?",
      options: [
        "Relevant DISCO, K-Electric, regulator, or local authority",
        "Equipment retailer",
        "Previous project documents without rechecking",
        "Online discussion forum"
      ],
      correctIndex: 0,
      explanation:
          'Utility connection, metering, and approval requirements must be verified with the responsible DISCO, K-Electric, regulator, or local authority.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'power_02',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q093',
      question:
          'Who should perform or supervise electrical installations where required by law/code?',
      options: [
        "Property owner regardless of competence",
        "Qualified/licensed person",
        "Equipment supplier",
        "Unsupervised trainee"
      ],
      correctIndex: 1,
      explanation:
          'Electrical work should be done by competent/licensed persons as required by local rules.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q094',
      question:
          "Where should current Pakistan grid-tie and net-metering approval requirements be verified?",
      options: [
        "Installer experience from a previous project",
        "Equipment supplier approval only",
        "Relevant DISCO/NEPRA process and latest rules",
        "A previous customer’s approval"
      ],
      correctIndex: 2,
      explanation:
          'Grid-tie/net metering requires compliance with current utility/regulatory process.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q095',
      question:
          'K-Electric-specific service or metering requirements apply mainly to which area?',
      options: [
        "All of Pakistan regardless of service provider",
        "Any off-grid system worldwide",
        "Every country using IEC standards",
        "Karachi/service territory"
      ],
      correctIndex: 3,
      explanation:
          'K-Electric requirements apply in its service territory, mainly Karachi and surrounding areas.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'power_02',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q096',
      question:
          'Why should manufacturer instructions be followed with breakers, RCDs, inverters, and ATS panels?',
      options: [
        "They replace all testing",
        "They are optional artwork",
        "They define safe ratings, wiring, settings, and limitations",
        "They lower voltage automatically"
      ],
      correctIndex: 2,
      explanation:
          'Manufacturer instructions are part of correct installation and safe operation.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'components_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q097',
      question:
          'Which document/source should be considered authoritative for current legal requirements?',
      options: [
        "An older superseded edition",
        "A manufacturer brochure only",
        "An app summary without source verification",
        "Latest official code/authority document"
      ],
      correctIndex: 3,
      explanation:
          'Always use the latest official documents and authority guidance for compliance.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q098',
      question: 'Why are labels important in DBs and solar/generator systems?',
      options: [
        "They increase current",
        "They help safe isolation, maintenance, and emergency response",
        "They replace earth wire",
        "They remove PPE need"
      ],
      correctIndex: 1,
      explanation:
          'Clear labels reduce mistakes during isolation, troubleshooting, and emergencies.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'power_04',
      pecReference: '',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q099',
      question: 'What is a good practice before energizing a new circuit?',
      options: [
        "Inspect and test continuity, insulation, polarity, and protection",
        "Guess and switch on",
        "Bypass breaker",
        "Remove earth"
      ],
      correctIndex: 0,
      explanation:
          'Pre-energization testing helps catch dangerous mistakes before power is applied.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_05',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q100',
      question: 'Why should cable sizing be verified with code tables?',
      options: [
        "All cables carry infinite current",
        "Color alone defines ampacity",
        "Breakers always protect any cable",
        "Installation method, grouping, ambient temperature, and insulation affect ampacity"
      ],
      correctIndex: 3,
      explanation:
          'Cable capacity depends on installation conditions and must be checked against tables/standards.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'safety_08',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q101',
      question:
          'In the distribution-board diagram, what should every outgoing circuit have?',
      options: [
        "Clear label and suitable protective device",
        "No breaker",
        "Shared random neutral",
        "Disconnected earth"
      ],
      correctIndex: 0,
      explanation:
          'DB circuits should be correctly protected and clearly labeled.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: 'assets/diagrams/dist_01.webp',
      relatedArticleId: 'power_04',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['image', 'DB'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q102',
      question: 'Why is backfeeding the utility from a generator dangerous?',
      options: [
        "It improves safety",
        "It lowers fuel use only",
        "It can energize lines and endanger workers/public",
        "It charges batteries automatically"
      ],
      correctIndex: 2,
      explanation:
          'Backfeed can energize utility lines; proper transfer equipment prevents it.',
      category: 'standards',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_07',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q103',
      question:
          'Which installations commonly require special approval/coordination with utility?',
      options: [
        "Replacing a like-for-like lamp within an existing circuit",
        "Grid-tie solar and service connection changes",
        "Routine visual cleaning with no electrical alteration",
        "Updating a local circuit label only"
      ],
      correctIndex: 1,
      explanation:
          'Utility-interactive systems and service changes require authority coordination.',
      category: 'standards',
      difficulty: 'journeyman',
      imageAsset: null,
      relatedArticleId: 'renewable_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'journeyman'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q104',
      question: 'Why are RCD types important for inverter/electronic loads?',
      options: [
        "All RCDs are identical",
        "RCD type changes cable color",
        "Some loads create DC/pulsed leakage requiring suitable RCD type",
        "It removes need for earthing"
      ],
      correctIndex: 2,
      explanation:
          'Electronic loads may need specific RCD types; follow manufacturer/code guidance.',
      category: 'standards',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'safety_06',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q105',
      question:
          'What should be done if app guidance conflicts with latest official requirements?',
      options: [
        "Follow latest official requirement and qualified professional judgment",
        "Follow app blindly",
        "Follow an older project note",
        "Follow equipment marketing material"
      ],
      correctIndex: 0,
      explanation:
          'Official current requirements and competent professional judgment take priority.',
      category: 'standards',
      difficulty: 'beginner',
      imageAsset: null,
      relatedArticleId: 'safety_01',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['standards'],
      keywords: ['standards', 'beginner'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q106',
      question: 'Why is protection coordination important?',
      options: [
        "It makes wires invisible",
        "Nearest protective device clears fault without unnecessary upstream shutdown",
        "It removes all faults",
        "It replaces testing"
      ],
      correctIndex: 1,
      explanation:
          'Coordination/selectivity limits outage area and improves safety/continuity.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_08',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q107',
      question:
          "What may high neutral current indicate in a three-phase four-wire system supplying many nonlinear loads?",
      options: [
        "Triplen harmonics",
        "Trip curve only",
        "Perfect balance",
        "No load"
      ],
      correctIndex: 0,
      explanation:
          'Triplen harmonics can add in the neutral and cause overheating.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_06',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q108',
      question:
          'What is a key risk of overcorrecting power factor with capacitors?',
      options: [
        "Better safety always",
        "No current",
        "Lower insulation class",
        "Leading PF/resonance issues"
      ],
      correctIndex: 3,
      explanation:
          'Overcorrection can create leading PF and resonance/harmonic problems.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'circuits_04',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q109',
      question:
          'For SPD effectiveness, which installation detail is very important?',
      options: [
        "Long coiled connection leads",
        "An undersized protective conductor",
        "Short, direct earth/connection leads",
        "A remote shared connection path"
      ],
      correctIndex: 2,
      explanation:
          'Long SPD leads increase let-through voltage; keep connections short and direct.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'components_08',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q110',
      question: 'What does prospective short-circuit current affect?',
      options: [
        "Load energy consumption",
        "RCD residual-current sensitivity only",
        "Cable identification color",
        "Breaking capacity selection"
      ],
      correctIndex: 3,
      explanation:
          'Protective device breaking capacity must exceed available fault current.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'components_07',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q111',
      question:
          'In ATS systems, what prevents utility and generator from being connected together?',
      options: [
        "Overload relay only",
        "Electrical/mechanical interlocking and transfer logic",
        "RCD test circuit only",
        "Phase-sequence indicator only"
      ],
      correctIndex: 1,
      explanation:
          'ATS must interlock sources so they cannot parallel unintentionally.',
      category: 'master',
      difficulty: 'master',
      imageAsset: 'assets/diagrams/generator_02.webp',
      relatedArticleId: 'modern_05',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q112',
      question: 'What is a major EMC practice for VFD/inverter installations?',
      options: [
        "Removing earth",
        "Bundling all signal and power randomly",
        "Correct shielding, grounding, and cable routing",
        "Using undersized cable"
      ],
      correctIndex: 2,
      explanation:
          'EMC control needs correct cable routing, shielding, filters, and grounding.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'modern_03',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q113',
      question:
          'Why is neutral-earth bonding in generator systems design-sensitive?',
      options: [
        "It affects only generator fuel use",
        "It affects only enclosure IP rating",
        "It is determined only by cable color",
        "Wrong bonding can affect fault clearing and shock protection"
      ],
      correctIndex: 3,
      explanation:
          'Neutral/earth arrangement affects protective device operation and touch voltage risk.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_07',
      pecReference:
          'Educational reference only. Verify latest PEC, local DISCO/WAPDA/K-Electric, manufacturer, and authority requirements before installation.',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q114',
      question: 'What is the main purpose of an earth fault loop path?',
      options: [
        "Allow sufficient fault current to disconnect protective device",
        "Increase tariff",
        "Stop all voltage readings",
        "Make neutral optional"
      ],
      correctIndex: 0,
      explanation:
          'A low-impedance fault path helps protective devices disconnect faults quickly.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_05',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q115',
      question:
          'Why should VFD output not be switched by ordinary contactors under load unless permitted?',
      options: [
        "It improves waveform",
        "It lowers harmonics always",
        "It increases insulation",
        "It can damage drive/motor and create transients"
      ],
      correctIndex: 3,
      explanation:
          'Switching VFD output under load can damage equipment; follow drive manual.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_05',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q116',
      question: 'What is discrimination/selectivity in protection?',
      options: [
        "All breakers trip together",
        "Downstream device trips before upstream for downstream faults",
        "No breaker trips",
        "Only RCD test button works"
      ],
      correctIndex: 1,
      explanation:
          'Selectivity means only the protective device nearest the fault should operate where possible.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_08',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q117',
      question:
          'In the solar DC protection diagram, which device is intended to limit transient overvoltage?',
      options: ["DC SPD", "DC fuse", "DC isolator", "AC RCD"],
      correctIndex: 0,
      explanation:
          'Solar DC protection commonly includes DC-rated SPD where required.',
      category: 'master',
      difficulty: 'master',
      imageAsset: 'assets/diagrams/solar_05.webp',
      relatedArticleId: 'renewable_01',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q118',
      question:
          'Why must motor reverse-forward contactors be mechanically/electrically interlocked?',
      options: [
        "To set overload current",
        "To control motor voltage",
        "To provide a start delay only",
        "To prevent simultaneous closing and phase-to-phase short"
      ],
      correctIndex: 3,
      explanation:
          'Both contactors closing can create a serious short circuit.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'motors_07',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q119',
      question:
          'Which measurement tool feature is needed for distorted harmonic-rich waveforms?',
      options: [
        "Average-responding meter without True RMS",
        "Insulation-resistance tester only",
        "True RMS / harmonic-capable meter",
        "Continuity buzzer only"
      ],
      correctIndex: 2,
      explanation:
          'True RMS and harmonic measurement capability are needed for distorted waveforms.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'power_06',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: 'q120',
      question:
          'What is the professional response to repeated protective device tripping?',
      options: [
        "Install larger breaker immediately",
        "Bypass protection",
        "Ignore it",
        "Investigate load/fault/cable/protection coordination"
      ],
      correctIndex: 3,
      explanation:
          'Repeated trips indicate a problem that must be diagnosed, not bypassed.',
      category: 'master',
      difficulty: 'master',
      imageAsset: null,
      relatedArticleId: 'components_07',
      pecReference: '',
      tags: ['master'],
      keywords: ['master', 'master'],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q121",
      question: "Which formula gives DC power from voltage and current?",
      options: ["P = V / I", "P = I / V", "P = V × I", "P = V + I"],
      correctIndex: 2,
      explanation:
          "For a DC or resistive circuit, electrical power in watts is voltage multiplied by current: P = V × I.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["power", "formula"],
      keywords: ["basics", "beginner", "power", "formula"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q122",
      question:
          "What is the total resistance of 2 Ω, 3 Ω, and 5 Ω connected in series?",
      options: ["1 Ω", "5 Ω", "30 Ω", "10 Ω"],
      correctIndex: 3,
      explanation: "Series resistances add directly: 2 + 3 + 5 = 10 Ω.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["series", "resistance"],
      keywords: ["basics", "beginner", "series", "resistance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q123",
      question:
          "Two equal 8 Ω resistors are connected in parallel. What is their equivalent resistance?",
      options: ["8 Ω", "4 Ω", "16 Ω", "64 Ω"],
      correctIndex: 1,
      explanation:
          "Two equal resistors in parallel have half the resistance of either resistor, so 8 Ω / 2 = 4 Ω.",
      category: "basics",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["parallel", "resistance"],
      keywords: ["basics", "journeyman", "parallel", "resistance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q124",
      question: "What does one kilowatt-hour represent?",
      options: [
        "1000 A flowing for one hour",
        "1 V applied for 1000 hours",
        "1000 Ω connected for one minute",
        "1 kW of power used for one hour"
      ],
      correctIndex: 3,
      explanation:
          "A kilowatt-hour is energy: a 1 kW load operating for one hour uses 1 kWh.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["energy", "kWh"],
      keywords: ["basics", "beginner", "energy", "kWh"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q125",
      question:
          "For the same material and length, what happens to conductor resistance when cross-sectional area increases?",
      options: [
        "It increases",
        "It becomes independent of area",
        "It decreases",
        "It always becomes zero"
      ],
      correctIndex: 2,
      explanation:
          "R = ρL/A, so increasing conductor cross-sectional area reduces resistance when material and length are unchanged.",
      category: "basics",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["conductor", "resistance"],
      keywords: ["basics", "journeyman", "conductor", "resistance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q126",
      question: "When should a continuity test normally be performed?",
      options: [
        "On an energized circuit",
        "On an isolated and proven-dead circuit",
        "Only while a motor is running",
        "Only after bypassing protection"
      ],
      correctIndex: 1,
      explanation:
          "Continuity and resistance tests are normally made on circuits that are isolated, proven dead, and discharged.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["continuity", "testing"],
      keywords: ["basics", "beginner", "continuity", "testing"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q127",
      question:
          "What is the normal function of a neutral conductor in a single-phase circuit?",
      options: [
        "Replace the protective earth",
        "Increase supply frequency",
        "Carry return current under normal operation",
        "Operate only during faults"
      ],
      correctIndex: 2,
      explanation:
          "The neutral normally completes the circuit and carries load return current; it is not a substitute for protective earth.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["neutral", "single-phase"],
      keywords: ["basics", "beginner", "neutral", "single-phase"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q128",
      question:
          "What is the main safety purpose of a protective earth conductor?",
      options: [
        "Carry normal load current continuously",
        "Increase equipment power",
        "Control motor speed",
        "Provide a fault-current path for automatic disconnection"
      ],
      correctIndex: 3,
      explanation:
          "Protective earth connects exposed conductive parts to a fault path so protective devices can disconnect dangerous faults.",
      category: "basics",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["earthing", "protection"],
      keywords: ["basics", "beginner", "earthing", "protection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q129",
      question:
          "Approximately what is the peak value of a 230 V RMS sine-wave supply?",
      options: ["325 V", "163 V", "230 V", "460 V"],
      correctIndex: 0,
      explanation:
          "For a sine wave, Vpeak = Vrms × √2, so 230 × 1.414 is approximately 325 V.",
      category: "basics",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["AC", "RMS"],
      keywords: ["basics", "journeyman", "AC", "RMS"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q130",
      question:
          "What is a key advantage of using a clamp meter to measure current?",
      options: [
        "It removes the need for isolation in every task",
        "It measures current without opening the conductor path",
        "It automatically tests insulation resistance",
        "It replaces all CAT-rating requirements"
      ],
      correctIndex: 1,
      explanation:
          "A clamp meter senses the magnetic field around a conductor, allowing current measurement without inserting the meter in series.",
      category: "basics",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["meter", "current"],
      keywords: ["basics", "journeyman", "meter", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q131",
      question:
          "Why should a voltage tester be checked on a known live source both before and after proving dead?",
      options: [
        "To confirm the tester worked throughout the test",
        "To increase circuit voltage",
        "To discharge the installation",
        "To measure earth resistance"
      ],
      correctIndex: 0,
      explanation:
          "A live-dead-live check confirms the tester functioned before and after the zero-voltage test.",
      category: "safety",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["safe-isolation", "tester"],
      keywords: ["safety", "journeyman", "safe-isolation", "tester"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q132",
      question:
          "Before work where arc-flash energy may be present, what should determine the required controls and PPE?",
      options: [
        "The worker’s preferred clothing color",
        "A documented risk assessment and applicable safety requirements",
        "The equipment brand alone",
        "The room temperature alone"
      ],
      correctIndex: 1,
      explanation:
          "Arc-flash controls and PPE must be selected from a competent risk assessment, equipment data, and applicable rules.",
      category: "safety",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["arc-flash", "PPE"],
      keywords: ["safety", "master", "arc-flash", "PPE"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q133",
      question: "Why can a disconnected capacitor still be hazardous?",
      options: [
        "It always produces mechanical rotation",
        "Its resistance becomes zero forever",
        "It changes AC frequency",
        "It may retain a dangerous stored charge"
      ],
      correctIndex: 3,
      explanation:
          "Capacitors can retain energy after disconnection and must be discharged and verified using the manufacturer’s safe procedure.",
      category: "safety",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["capacitor", "stored-energy"],
      keywords: ["safety", "journeyman", "capacitor", "stored-energy"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q134",
      question:
          "What should be done with an extension lead that has exposed conductors or a damaged plug?",
      options: [
        "Continue using it at lower current",
        "Remove it from service and have it properly repaired or replaced",
        "Cover it with paper",
        "Use it only outdoors in rain"
      ],
      correctIndex: 1,
      explanation:
          "Damaged leads can cause shock, short circuit, or fire and should be isolated from use until correctly repaired or replaced.",
      category: "safety",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["tools", "inspection"],
      keywords: ["safety", "beginner", "tools", "inspection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q135",
      question: "Why should metal jewelry be removed before electrical work?",
      options: [
        "It reduces power factor",
        "It increases insulation resistance",
        "It can bridge conductors, heat rapidly, and worsen injury",
        "It prevents lockout"
      ],
      correctIndex: 2,
      explanation:
          "Metal jewelry can cause a short circuit and severe burns if it contacts energized parts.",
      category: "safety",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["PPE", "burns"],
      keywords: ["safety", "beginner", "PPE", "burns"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q136",
      question:
          "Near a ground fault, what do touch and step potentials describe?",
      options: [
        "Two types of cable insulation",
        "Two motor speed settings",
        "Two breaker trip curves only",
        "Different voltages that can drive current through a person"
      ],
      correctIndex: 3,
      explanation:
          "Ground potential rise can create voltage between touched equipment and feet, or between a person’s feet, causing shock current.",
      category: "safety",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["earthing", "touch-voltage"],
      keywords: ["safety", "master", "earthing", "touch-voltage"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q137",
      question:
          "Before isolating a hybrid solar installation, which sources must be considered?",
      options: [
        "Only the utility supply",
        "Only the neutral conductor",
        "Utility, PV, battery, generator, and stored-energy sources as applicable",
        "Only the monitoring app"
      ],
      correctIndex: 2,
      explanation:
          "Hybrid systems can have multiple independent sources; every applicable source and stored-energy hazard must be identified and isolated.",
      category: "safety",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["solar", "multiple-sources"],
      keywords: ["safety", "journeyman", "solar", "multiple-sources"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q138",
      question: "Does an RCD remove the need for a protective earth conductor?",
      options: [
        "Yes, for every circuit",
        "Yes, if the load is small",
        "Only when the neutral is disconnected",
        "No, RCD protection and protective earthing serve different functions"
      ],
      correctIndex: 3,
      explanation:
          "An RCD provides residual-current protection but does not replace required protective earthing and bonding.",
      category: "safety",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["RCD", "earthing"],
      keywords: ["safety", "journeyman", "RCD", "earthing"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q139",
      question:
          "Who should normally remove a personal lock used for lockout/tagout?",
      options: [
        "Any available worker",
        "The person who applied it, following the site procedure",
        "The equipment supplier only",
        "A customer without authorization"
      ],
      correctIndex: 1,
      explanation:
          "Personal locks are normally removed by their owner; exceptional removal requires a controlled and documented site procedure.",
      category: "safety",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["LOTO", "procedure"],
      keywords: ["safety", "journeyman", "LOTO", "procedure"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q140",
      question:
          "After safely disconnecting power to an electrical-shock casualty, what is the next priority?",
      options: [
        "Re-energize the circuit",
        "Apply water to energized equipment",
        "Call emergency help and assess breathing/response using trained first aid",
        "Leave the casualty alone"
      ],
      correctIndex: 2,
      explanation:
          "After making the scene electrically safe, summon emergency assistance and provide trained first aid or CPR as required.",
      category: "safety",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["first-aid", "shock"],
      keywords: ["safety", "beginner", "first-aid", "shock"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q141",
      question: "What does Kirchhoff’s Voltage Law state for a closed loop?",
      options: [
        "The algebraic sum of voltages around the loop is zero",
        "All branch currents are equal",
        "Resistance is always zero",
        "Power factor is always one"
      ],
      correctIndex: 0,
      explanation:
          "Kirchhoff’s Voltage Law states that voltage rises and drops around a complete loop sum algebraically to zero.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["KVL", "circuits"],
      keywords: ["circuits", "journeyman", "KVL", "circuits"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q142",
      question:
          "At a node, 8 A enters while 3 A leaves through one branch. How much current must leave through the other branch?",
      options: ["2 A", "5 A", "8 A", "11 A"],
      correctIndex: 1,
      explanation:
          "By Kirchhoff’s Current Law, current entering equals current leaving: 8 = 3 + 5 A.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["KCL", "current"],
      keywords: ["circuits", "journeyman", "KCL", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q143",
      question:
          "For the same real power and voltage, what usually happens to current when power factor decreases?",
      options: [
        "It increases",
        "It decreases",
        "It remains exactly unchanged",
        "It becomes zero"
      ],
      correctIndex: 0,
      explanation:
          "For a given real power, lower power factor requires higher current, increasing losses and voltage drop.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["power-factor", "current"],
      keywords: ["circuits", "journeyman", "power-factor", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q144",
      question:
          "In a delta-connected load, how does phase voltage compare with line voltage?",
      options: [
        "Phase voltage is line voltage divided by √3",
        "Phase voltage is three times line voltage",
        "Phase voltage equals line voltage",
        "Phase voltage is always zero"
      ],
      correctIndex: 2,
      explanation:
          "Each delta phase is connected directly between two lines, so phase voltage equals line voltage.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["delta", "three-phase"],
      keywords: ["circuits", "journeyman", "delta", "three-phase"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q145",
      question:
          "In a balanced star-connected load, how does line current compare with phase current?",
      options: [
        "Line current is √3 times phase current",
        "Line current is phase current divided by three",
        "Line current is always zero",
        "Line current equals phase current"
      ],
      correctIndex: 3,
      explanation:
          "In a star connection, each line conductor carries the current of its associated phase, so Iline = Iphase.",
      category: "circuits",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["star", "three-phase"],
      keywords: ["circuits", "master", "star", "three-phase"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q146",
      question:
          "For a perfectly balanced three-phase four-wire load with sinusoidal currents, what is the neutral current?",
      options: [
        "Approximately zero",
        "Equal to one phase current",
        "Three times one phase current",
        "Always greater than line current"
      ],
      correctIndex: 0,
      explanation:
          "The three equal phase currents are 120 degrees apart and cancel vectorially in the neutral.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["load-balancing", "neutral"],
      keywords: ["circuits", "journeyman", "load-balancing", "neutral"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q147",
      question:
          "In an ideal inductive AC load, current has which phase relationship to voltage?",
      options: [
        "Current leads voltage",
        "Current is always zero",
        "Current doubles frequency",
        "Current lags voltage"
      ],
      correctIndex: 3,
      explanation:
          "Inductance opposes changes in current, so current lags voltage in an ideal inductive load.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["inductance", "phase-angle"],
      keywords: ["circuits", "journeyman", "inductance", "phase-angle"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q148",
      question:
          "In an ideal capacitive AC load, current has which phase relationship to voltage?",
      options: [
        "Current leads voltage",
        "Current lags voltage",
        "Current has no waveform",
        "Current becomes DC"
      ],
      correctIndex: 0,
      explanation:
          "In an ideal capacitor, current leads voltage by 90 degrees.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["capacitance", "phase-angle"],
      keywords: ["circuits", "journeyman", "capacitance", "phase-angle"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q149",
      question:
          "What is the equivalent resistance of 6 Ω and 3 Ω connected in parallel?",
      options: ["1 Ω", "2 Ω", "3 Ω", "9 Ω"],
      correctIndex: 1,
      explanation: "1/R = 1/6 + 1/3 = 3/6, so R = 2 Ω.",
      category: "circuits",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["parallel", "calculation"],
      keywords: ["circuits", "journeyman", "parallel", "calculation"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q150",
      question:
          "A load receives low voltage only when high current flows. What should be investigated first?",
      options: [
        "The breaker brand only",
        "The transformer ratio only",
        "The meter display brightness only",
        "Excessive circuit impedance, loose connections, and conductor voltage drop"
      ],
      correctIndex: 3,
      explanation:
          "A current-dependent voltage reduction commonly points to excessive impedance, undersized conductors, or high-resistance joints.",
      category: "circuits",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["voltage-drop", "troubleshooting"],
      keywords: ["circuits", "master", "voltage-drop", "troubleshooting"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q151",
      question: "What power is used by a 230 V resistive load drawing 10 A?",
      options: ["230 W", "1.0 kW", "23 kW", "2.3 kW"],
      correctIndex: 3,
      explanation: "P = V × I = 230 × 10 = 2300 W = 2.3 kW.",
      category: "calculations",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["power", "calculation"],
      keywords: ["calculations", "beginner", "power", "calculation"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q152",
      question: "How much energy does a 2 kW heater use in 3 hours?",
      options: ["6 kWh", "0.67 kWh", "5 kWh", "9 kWh"],
      correctIndex: 0,
      explanation: "Energy = power × time = 2 kW × 3 h = 6 kWh.",
      category: "calculations",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["energy", "calculation"],
      keywords: ["calculations", "beginner", "energy", "calculation"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q153",
      question:
          "Approximately what line current does a balanced 10 kW three-phase load draw at 400 V and 0.8 power factor?",
      options: ["9 A", "31 A", "18 A", "50 A"],
      correctIndex: 2,
      explanation: "I = P/(√3 × V × PF) = 10000/(1.732 × 400 × 0.8) ≈ 18 A.",
      category: "calculations",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["three-phase", "current"],
      keywords: ["calculations", "journeyman", "three-phase", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q154",
      question:
          "An 8 V drop occurs on a 230 V circuit. What is the approximate voltage-drop percentage?",
      options: ["1.7%", "3.5%", "8.0%", "28.8%"],
      correctIndex: 1,
      explanation:
          "Voltage-drop percentage = 8/230 × 100 ≈ 3.48%, which rounds to about 3.5%.",
      category: "calculations",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["voltage-drop", "percentage"],
      keywords: ["calculations", "beginner", "voltage-drop", "percentage"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q155",
      question:
          "What is the equivalent resistance of 12 Ω and 4 Ω in parallel?",
      options: ["2 Ω", "4 Ω", "16 Ω", "3 Ω"],
      correctIndex: 3,
      explanation: "R = (12 × 4)/(12 + 4) = 48/16 = 3 Ω.",
      category: "calculations",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["parallel", "resistance"],
      keywords: ["calculations", "journeyman", "parallel", "resistance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q156",
      question:
          "What is the nominal stored energy of a 48 V, 100 Ah battery bank?",
      options: ["0.48 kWh", "48 kWh", "4.8 kWh", "480 kWh"],
      correctIndex: 2,
      explanation:
          "Nominal energy = V × Ah = 48 × 100 = 4800 Wh = 4.8 kWh, before usable-depth and efficiency limits.",
      category: "calculations",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["battery", "energy"],
      keywords: ["calculations", "beginner", "battery", "energy"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q157",
      question: "How many 550 W panels provide a nominal 5.5 kW array?",
      options: ["5 panels", "10 panels", "8 panels", "12 panels"],
      correctIndex: 1,
      explanation: "Panel count = 5500 W / 550 W = 10 panels.",
      category: "calculations",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["solar", "panel-count"],
      keywords: ["calculations", "beginner", "solar", "panel-count"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q158",
      question:
          "Using a 125% planning factor, what design current results from a continuous 16 A load?",
      options: ["20 A", "12.8 A", "16 A", "25 A"],
      correctIndex: 0,
      explanation:
          "Design current = 16 A × 1.25 = 20 A; final cable and protection selection still requires applicable tables and conditions.",
      category: "calculations",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["design-current", "protection"],
      keywords: ["calculations", "journeyman", "design-current", "protection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q159",
      question:
          "For an ideal 230 V-to-23 V transformer, what secondary current corresponds to 2 A primary current?",
      options: ["0.2 A", "20 A", "2 A", "10 A"],
      correctIndex: 1,
      explanation:
          "For an ideal transformer, VpIp = VsIs, so Is = 230 × 2 / 23 = 20 A.",
      category: "calculations",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["transformer", "current"],
      keywords: ["calculations", "journeyman", "transformer", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q160",
      question: "How much heat is produced by 2 A through 5 Ω for 10 seconds?",
      options: ["200 J", "20 J", "50 J", "100 J"],
      correctIndex: 0,
      explanation: "Joule heating H = I²Rt = 2² × 5 × 10 = 200 J.",
      category: "calculations",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["joule-heating", "calculation"],
      keywords: ["calculations", "journeyman", "joule-heating", "calculation"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q161",
      question:
          "A 4-pole, 50 Hz induction motor runs at 1450 rpm. What is its approximate slip?",
      options: ["3.3%", "1.0%", "5.0%", "50%"],
      correctIndex: 0,
      explanation:
          "Synchronous speed is 1500 rpm, so slip = (1500 − 1450)/1500 × 100 ≈ 3.3%.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["motor", "slip"],
      keywords: ["motors", "journeyman", "motor", "slip"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q162",
      question:
          "Which fault is an overload relay not intended to clear by itself?",
      options: [
        "Sustained overload",
        "Phase-to-phase short circuit",
        "Locked-rotor overcurrent over time",
        "Single-phasing overload effect"
      ],
      correctIndex: 1,
      explanation:
          "Short circuits require correctly rated short-circuit protective devices; an overload relay is primarily for sustained motor overload.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["overload", "short-circuit"],
      keywords: ["motors", "journeyman", "overload", "short-circuit"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q163",
      question:
          "What is the purpose of the contactor auxiliary holding contact in a DOL starter?",
      options: [
        "Maintain coil energization after START is released",
        "Provide the main short-circuit protection",
        "Change motor frequency",
        "Replace the STOP contact"
      ],
      correctIndex: 0,
      explanation:
          "The normally open auxiliary contact seals around the momentary START button and keeps the contactor coil energized.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["DOL", "control-circuit"],
      keywords: ["motors", "journeyman", "DOL", "control-circuit"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q164",
      question:
          "Which combination commonly suggests phase loss on a running three-phase motor?",
      options: [
        "Balanced current and normal temperature",
        "Current imbalance, reduced torque, and overheating",
        "Zero slip at every load",
        "Higher insulation resistance only"
      ],
      correctIndex: 1,
      explanation:
          "Loss of one phase can cause severe current imbalance, low torque, vibration, and rapid motor overheating.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["phase-loss", "diagnostics"],
      keywords: ["motors", "journeyman", "phase-loss", "diagnostics"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q165",
      question:
          "Before insulation-resistance testing a motor circuit containing a VFD, what is essential?",
      options: [
        "Test through the connected VFD at any voltage",
        "Short all phases to live supply",
        "Remove protective earth permanently",
        "Disconnect or protect electronic equipment according to manufacturer instructions"
      ],
      correctIndex: 3,
      explanation:
          "Insulation-test voltage can damage drives and electronics, so isolate them and follow equipment-specific test instructions.",
      category: "motors",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["VFD", "insulation-test"],
      keywords: ["motors", "master", "VFD", "insulation-test"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q166",
      question:
          "A motor repeatedly trips its overload after running for several minutes. What should be checked?",
      options: [
        "Replace the overload relay without measurements",
        "Increase the breaker rating immediately",
        "Mechanical load, current on each phase, supply voltage, cooling, and overload setting",
        "Reset repeatedly without checking current"
      ],
      correctIndex: 2,
      explanation:
          "A delayed overload trip can result from excess load, voltage/current imbalance, cooling problems, or an incorrect relay setting.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["motor", "troubleshooting"],
      keywords: ["motors", "journeyman", "motor", "troubleshooting"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q167",
      question:
          "Which motor connection is normally required for a conventional star-delta starter on a 400 V supply?",
      options: [
        "A six-lead motor designed to run in delta at the line voltage",
        "A motor with only three inaccessible leads",
        "A single-phase capacitor motor",
        "A DC series motor"
      ],
      correctIndex: 0,
      explanation:
          "Star-delta starting requires access to both ends of all three windings and a motor rated to run in delta at the supply line voltage.",
      category: "motors",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["star-delta", "motor"],
      keywords: ["motors", "master", "star-delta", "motor"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q168",
      question:
          "Below base speed, which VFD output quantity primarily sets induction-motor speed?",
      options: [
        "Earth-electrode resistance",
        "Contactor coil color",
        "Frequency",
        "Bearing grease brand"
      ],
      correctIndex: 2,
      explanation:
          "Induction-motor synchronous speed is proportional to supply frequency; the VFD also manages voltage to maintain suitable flux.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["VFD", "frequency"],
      keywords: ["motors", "journeyman", "VFD", "frequency"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q169",
      question:
          "How is the rotation direction of a typical three-phase motor reversed?",
      options: [
        "Swap neutral and earth",
        "Increase all conductor sizes",
        "Open the overload contact permanently",
        "Swap any two phase conductors"
      ],
      correctIndex: 3,
      explanation:
          "Interchanging any two supply phases reverses the rotating magnetic field and normally reverses motor direction.",
      category: "motors",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["rotation", "phase-sequence"],
      keywords: ["motors", "beginner", "rotation", "phase-sequence"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q170",
      question:
          "Which maintenance finding most strongly suggests a deteriorating motor bearing?",
      options: [
        "Stable low vibration",
        "Normal bearing temperature",
        "Increasing vibration, noise, or bearing temperature",
        "Balanced phase currents alone"
      ],
      correctIndex: 2,
      explanation:
          "Trending vibration, acoustic noise, and bearing temperature can reveal bearing deterioration before failure.",
      category: "motors",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["bearing", "maintenance"],
      keywords: ["motors", "journeyman", "bearing", "maintenance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q171",
      question:
          "When identical PV modules are connected in series, what primarily increases?",
      options: ["Voltage", "Current only", "Module area", "Grid frequency"],
      correctIndex: 0,
      explanation:
          "Series-connected module voltages add while the string current is limited by the module/string current.",
      category: "solar",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["PV", "series"],
      keywords: ["solar", "beginner", "PV", "series"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q172",
      question:
          "When identical PV strings are connected in parallel, what primarily increases?",
      options: [
        "Voltage only",
        "Each module Voc",
        "AC frequency",
        "Current capacity"
      ],
      correctIndex: 3,
      explanation:
          "Parallel string currents add while the array voltage remains approximately the string voltage.",
      category: "solar",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["PV", "parallel"],
      keywords: ["solar", "beginner", "PV", "parallel"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q173",
      question:
          "How does cold module temperature normally affect PV open-circuit voltage?",
      options: [
        "It always reduces Voc to zero",
        "It normally increases Voc",
        "It changes DC into AC",
        "It has no possible effect"
      ],
      correctIndex: 1,
      explanation:
          "PV open-circuit voltage generally rises as cell temperature falls, so cold-condition Voc must be checked against inverter limits.",
      category: "solar",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["PV", "Voc"],
      keywords: ["solar", "journeyman", "PV", "Voc"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q174",
      question:
          "What should the operating Vmp of a PV string satisfy for reliable MPPT operation?",
      options: [
        "It must always equal zero",
        "It should exceed the inverter absolute maximum",
        "It should remain within the inverter MPPT voltage window",
        "It only needs to match grid frequency"
      ],
      correctIndex: 2,
      explanation:
          "The expected string operating voltage across temperature conditions should remain within the inverter’s MPPT operating range.",
      category: "solar",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["MPPT", "string-sizing"],
      keywords: ["solar", "journeyman", "MPPT", "string-sizing"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q175",
      question:
          "What mainly determines the minimum output-current rating of a battery charge controller?",
      options: [
        "The enclosure color",
        "Expected charging current with required design margin",
        "The AC socket count only",
        "The panel frame material only"
      ],
      correctIndex: 1,
      explanation:
          "Controller current rating must cover the calculated maximum charging current, applicable continuous factors, and manufacturer requirements.",
      category: "solar",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["charge-controller", "current"],
      keywords: ["solar", "journeyman", "charge-controller", "current"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q176",
      question:
          "What happens when identical batteries are connected in series?",
      options: [
        "Ampere-hour capacity adds while voltage stays the same",
        "Both voltage and Ah become zero",
        "The batteries produce AC",
        "Voltage adds while ampere-hour capacity remains the same"
      ],
      correctIndex: 3,
      explanation:
          "In a series bank, battery voltages add while the ampere-hour rating remains that of one identical series string.",
      category: "solar",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["battery", "series"],
      keywords: ["solar", "beginner", "battery", "series"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q177",
      question:
          "What happens when identical battery strings are connected in parallel?",
      options: [
        "Voltage adds and Ah stays the same",
        "Voltage stays the same while ampere-hour capacity adds",
        "Frequency doubles",
        "Polarity becomes irrelevant"
      ],
      correctIndex: 1,
      explanation:
          "Parallel battery strings retain the same nominal voltage and add their ampere-hour capacities.",
      category: "solar",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["battery", "parallel"],
      keywords: ["solar", "beginner", "battery", "parallel"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q178",
      question: "What is a primary function of a lithium-battery BMS?",
      options: [
        "Convert all DC directly to grid AC",
        "Replace every external fuse and isolator",
        "Monitor and protect cells against unsafe voltage, current, and temperature conditions",
        "Increase solar irradiance"
      ],
      correctIndex: 2,
      explanation:
          "A BMS monitors cells and applies limits or disconnection for unsafe voltage, current, temperature, and imbalance conditions.",
      category: "solar",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["battery", "BMS"],
      keywords: ["solar", "journeyman", "battery", "BMS"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q179",
      question:
          "Why is interruption of a DC arc generally more difficult than interruption of an AC arc?",
      options: [
        "DC has no natural current zero crossing each cycle",
        "DC has no voltage",
        "AC cannot arc",
        "DC conductors have no resistance"
      ],
      correctIndex: 0,
      explanation:
          "AC current crosses zero every cycle, helping extinguish an arc; DC requires devices specifically designed to interrupt sustained arcs.",
      category: "solar",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["DC", "arc"],
      keywords: ["solar", "journeyman", "DC", "arc"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q180",
      question:
          "When commissioning a hybrid inverter backup output, what must be verified?",
      options: [
        "Only the mobile-app theme",
        "Only the PV module color",
        "Output isolation, neutral-earth arrangement, transfer behavior, and protected-load limits",
        "That all building loads are connected regardless of rating"
      ],
      correctIndex: 2,
      explanation:
          "Backup outputs require verified isolation/transfer behavior, earthing and neutral design, protection, and load limits according to the system design.",
      category: "solar",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["hybrid", "commissioning"],
      keywords: ["solar", "master", "hybrid", "commissioning"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q181",
      question: "Which edition of a standard should be used for a new design?",
      options: [
        "Any old copy found online",
        "The currently applicable official edition and amendments accepted by the authority",
        "A social-media summary only",
        "The edition with the fewest pages"
      ],
      correctIndex: 1,
      explanation:
          "Design work should use the edition, amendments, and local requirements currently adopted by the responsible authority.",
      category: "standards",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["standards", "documents"],
      keywords: ["standards", "beginner", "standards", "documents"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q182",
      question: "Why should commissioning test results be recorded?",
      options: [
        "To replace the protective devices",
        "To avoid identifying circuits",
        "To demonstrate verification and provide a baseline for maintenance",
        "To make future testing impossible"
      ],
      correctIndex: 2,
      explanation:
          "Documented results support compliance, traceability, future maintenance, and comparison when faults develop.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["testing", "records"],
      keywords: ["standards", "journeyman", "testing", "records"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q183",
      question:
          "When coordinating a cable and an overcurrent protective device, what principle is essential?",
      options: [
        "The breaker may always be larger than the cable capacity",
        "Cable color determines the breaker rating",
        "The protective device is optional when a label is fitted",
        "The device rating and operating characteristics must protect the cable under the applicable conditions"
      ],
      correctIndex: 3,
      explanation:
          "Protection must be selected so the conductor is not subjected to damaging overload or fault energy under the applicable installation conditions.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["cable", "protection"],
      keywords: ["standards", "journeyman", "cable", "protection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q184",
      question:
          "Does pressing an RCD test button replace periodic instrument testing required by applicable rules?",
      options: [
        "Yes, in every installation",
        "Yes, if the button is colored blue",
        "No, the test button is a functional check and does not replace required verification",
        "Only when protective earth is absent"
      ],
      correctIndex: 2,
      explanation:
          "The built-in button checks a functional trip mechanism; required trip-time/current verification needs suitable test equipment and procedures.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["RCD", "testing"],
      keywords: ["standards", "journeyman", "RCD", "testing"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q185",
      question:
          "Can conductor color alone be accepted as proof that a circuit is dead?",
      options: [
        "Yes, color is conclusive",
        "Yes, when the cable is new",
        "Only for three-phase circuits",
        "No, identify, isolate, and test with suitable equipment"
      ],
      correctIndex: 3,
      explanation:
          "Colors can be incorrect, altered, or legacy; safe isolation requires proper identification and electrical testing.",
      category: "standards",
      difficulty: "beginner",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["identification", "safe-isolation"],
      keywords: ["standards", "beginner", "identification", "safe-isolation"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q186",
      question: "What does an equipment IP rating describe?",
      options: [
        "The maximum power factor",
        "Protection against access, solid objects, and water ingress",
        "The conductor material",
        "The utility tariff class"
      ],
      correctIndex: 1,
      explanation:
          "Ingress Protection ratings classify enclosure protection against access to hazardous parts, solids, and water.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["IP-rating", "enclosure"],
      keywords: ["standards", "journeyman", "IP-rating", "enclosure"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q187",
      question:
          "Why must a protective device’s breaking capacity be checked against prospective fault current?",
      options: [
        "The device must safely interrupt the available fault current",
        "Breaking capacity controls cable color",
        "A lower rating always trips faster and safely",
        "Fault current is unrelated to protective devices"
      ],
      correctIndex: 0,
      explanation:
          "A protective device must have adequate rated breaking capacity for the maximum prospective short-circuit current at its installation point.",
      category: "standards",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["fault-current", "breaking-capacity"],
      keywords: ["standards", "master", "fault-current", "breaking-capacity"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q188",
      question:
          "After a significant electrical modification, what documentation should be updated?",
      options: [
        "Only the customer’s wallpaper",
        "Nothing if the circuit operates",
        "Circuit schedules, drawings, labels, settings, and test records as applicable",
        "Only the invoice number"
      ],
      correctIndex: 2,
      explanation:
          "Accurate records and labels are needed for safe operation, future isolation, maintenance, inspection, and emergency response.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["documentation", "modification"],
      keywords: ["standards", "journeyman", "documentation", "modification"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q189",
      question:
          "What is an important requirement for an isolation device used during maintenance?",
      options: [
        "It must be suitable, identifiable, accessible, and capable of secure isolation where required",
        "It should be hidden and unlabeled",
        "It may depend only on software without design verification",
        "It should interrupt protective earth first"
      ],
      correctIndex: 0,
      explanation:
          "Maintenance isolation must use appropriately rated and identifiable means, with secure lockout where required by the procedure.",
      category: "standards",
      difficulty: "journeyman",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["isolation", "maintenance"],
      keywords: ["standards", "journeyman", "isolation", "maintenance"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q190",
      question:
          "For an EV charging installation, which sources should determine RCD type and earthing arrangements?",
      options: [
        "A generic extension-lead label only",
        "The vehicle color",
        "A domestic lamp-circuit diagram",
        "Applicable local rules, supply characteristics, charger instructions, and competent design"
      ],
      correctIndex: 3,
      explanation:
          "EV protection and earthing depend on the supply system, charger design, local requirements, and manufacturer instructions.",
      category: "standards",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["EV", "RCD"],
      keywords: ["standards", "master", "EV", "RCD"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q191",
      question:
          "What information is most useful when assessing selectivity between two circuit breakers?",
      options: [
        "Their enclosure colors",
        "Their time-current characteristics and manufacturer selectivity data",
        "Their purchase dates only",
        "The length of their labels"
      ],
      correctIndex: 1,
      explanation:
          "Selectivity assessment uses device curves, fault levels, settings, and tested manufacturer coordination tables.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["selectivity", "protection"],
      keywords: ["master", "master", "selectivity", "protection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q192",
      question:
          "Why must the secondary of an energized current transformer not be left open-circuit?",
      options: [
        "Dangerously high voltage can develop",
        "The primary current becomes zero safely",
        "It improves measurement accuracy",
        "It reduces insulation stress"
      ],
      correctIndex: 0,
      explanation:
          "An open CT secondary can develop hazardous voltage and overheat the core; use approved shorting and isolation procedures.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["CT", "safety"],
      keywords: ["master", "master", "CT", "safety"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q193",
      question:
          "In a harmonic-rich installation, why might a detuned reactor be used with a capacitor bank?",
      options: [
        "To increase neutral current intentionally",
        "To reduce harmonic resonance and protect capacitors",
        "To remove all overcurrent protection",
        "To convert the bank to DC"
      ],
      correctIndex: 1,
      explanation:
          "Detuned reactors shift the resonant frequency and limit harmful harmonic currents in power-factor correction equipment.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["harmonics", "capacitor-bank"],
      keywords: ["master", "master", "harmonics", "capacitor-bank"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q194",
      question:
          "A transformer causes nuisance instantaneous tripping only at energization. What phenomenon should be considered?",
      options: [
        "Magnetizing inrush current",
        "Normal earth continuity",
        "Improved power factor",
        "Reduced prospective fault current"
      ],
      correctIndex: 0,
      explanation:
          "Transformer energization can produce a high asymmetrical magnetizing inrush that must be considered in protection selection and coordination.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["transformer", "inrush"],
      keywords: ["master", "master", "transformer", "inrush"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q195",
      question:
          "Why may overcurrent protection alone fail to clear a high-impedance earth fault quickly?",
      options: [
        "Earth faults always have infinite current",
        "Overcurrent devices respond only to frequency",
        "Fault current may be below the overcurrent trip threshold",
        "Protective earth blocks all fault current"
      ],
      correctIndex: 2,
      explanation:
          "A high-impedance fault can limit current below the overcurrent device’s prompt operating level, requiring appropriate earth-fault/residual protection.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["earth-fault", "protection"],
      keywords: ["master", "master", "earth-fault", "protection"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q196",
      question:
          "What determines whether an ATS should switch the neutral conductor?",
      options: [
        "The ATS enclosure color",
        "The earthing system, source arrangement, equipment design, and applicable rules",
        "The generator fuel level only",
        "The number of outgoing labels"
      ],
      correctIndex: 1,
      explanation:
          "Neutral switching affects bonding, fault paths, and source separation and must follow the engineered earthing/source arrangement.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["ATS", "neutral"],
      keywords: ["master", "master", "ATS", "neutral"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q197",
      question:
          "Before two AC generators are paralleled, which conditions must be matched?",
      options: [
        "Only enclosure temperature",
        "Only fuel-tank size",
        "Voltage, frequency, phase sequence, and phase angle",
        "Only neutral-conductor color"
      ],
      correctIndex: 2,
      explanation:
          "Safe synchronization requires compatible voltage and frequency, the same phase sequence, and close phase-angle alignment.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["generator", "synchronization"],
      keywords: ["master", "master", "generator", "synchronization"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q198",
      question:
          "For a long VFD-to-motor cable, what issue may require an output reactor or dV/dt filter?",
      options: [
        "Reflected-wave voltage stress on motor insulation",
        "Lower utility tariff",
        "Loss of protective-earth color",
        "Mechanical shaft alignment only"
      ],
      correctIndex: 0,
      explanation:
          "Fast VFD voltage edges and long cables can create reflected-wave overvoltage at the motor; follow drive and motor guidance.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["VFD", "dvdt"],
      keywords: ["master", "master", "VFD", "dvdt"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q199",
      question:
          "Why can the neutral conductor need special consideration with many single-phase nonlinear loads?",
      options: [
        "All harmonic currents cancel completely",
        "The neutral carries no current by definition",
        "Triplen harmonic currents can add in the neutral",
        "Nonlinear loads always have unity power factor"
      ],
      correctIndex: 2,
      explanation:
          "Zero-sequence triplen harmonics from nonlinear loads can add rather than cancel in a shared neutral, causing overheating.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["harmonics", "neutral"],
      keywords: ["master", "master", "harmonics", "neutral"],
      contentVersion: '2.1.0-production-audit',
    ),
    QuizQuestion(
      id: "q200",
      question:
          "Before applying an insulation-resistance test voltage to a circuit with electronic equipment, what should be done?",
      options: [
        "Apply the highest available voltage without checking",
        "Short phase to protective earth permanently",
        "Leave every surge device connected regardless of instructions",
        "Disconnect or protect sensitive equipment and select the correct test voltage"
      ],
      correctIndex: 3,
      explanation:
          "Electronic controls, SPDs, drives, and appliances may be damaged by test voltage, so follow applicable procedures and manufacturer instructions.",
      category: "master",
      difficulty: "master",
      imageAsset: null,
      relatedArticleId: null,
      pecReference: '',
      tags: ["insulation-test", "electronics"],
      keywords: ["master", "master", "insulation-test", "electronics"],
      contentVersion: '2.1.0-production-audit',
    ),
  ];
}
