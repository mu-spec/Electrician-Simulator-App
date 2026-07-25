import '../../models/wiring_diagram.dart';

class WiringContent {
  // ==================== WIRING CATEGORIES ====================
  static const List<WiringCategory> wiringCategories = [
    WiringCategory(
        id: 'residential',
        name: 'Residential Wiring',
        iconName: 'home',
        colorHex: '#2563EB',
        diagramCount: 11,
        description:
            'Lighting, fans, sockets, bell circuits, and common room wiring used in residential installations.',
        keywords: ['home wiring', 'switch', 'socket', 'fan', 'lighting']),
    WiringCategory(
        id: 'distribution',
        name: 'Distribution Boards',
        iconName: 'account_tree',
        colorHex: '#8B5CF6',
        diagramCount: 9,
        description:
            'Single-phase and three-phase DB layouts, sub-DBs, RCD/SPD protection, and load balancing.',
        keywords: ['DB', 'MCB', 'RCD', 'SPD', 'busbar', 'load balancing']),
    WiringCategory(
        id: 'motors',
        name: 'Motor Control',
        iconName: 'settings',
        colorHex: '#F59E0B',
        diagramCount: 8,
        description:
            'DOL, star-delta, reversing, overload, and timer-based motor control wiring.',
        keywords: [
          'motor',
          'contactor',
          'overload',
          'DOL',
          'star delta',
          'timer'
        ]),
    WiringCategory(
        id: 'solar',
        name: 'Solar PV',
        iconName: 'wb_sunny',
        colorHex: '#06B6D4',
        diagramCount: 8,
        description:
            'Off-grid, hybrid, grid-tie, battery bank, and DC protection wiring concepts.',
        keywords: ['solar', 'PV', 'inverter', 'battery', 'DC protection']),
    WiringCategory(
        id: 'generator',
        name: 'Generator & ATS',
        iconName: 'power',
        colorHex: '#EF4444',
        diagramCount: 7,
        description:
            'Manual changeover, ATS, generator-to-DB connection, and generator earthing concepts.',
        keywords: ['generator', 'ATS', 'changeover', 'backup', 'earthing']),
    WiringCategory(
        id: 'smart',
        name: 'Smart Home',
        iconName: 'router',
        colorHex: '#0F766E',
        diagramCount: 7,
        description:
            'Smart switches, smart relays, and connected protection wiring concepts.',
        keywords: [
          'smart switch',
          'smart relay',
          'IoT',
          'automation',
          'neutral'
        ]),
  ];

  // ==================== WIRING DIAGRAMS ====================
  static const List<WiringDiagram> wiringDiagrams = [
    WiringDiagram(
      id: 'res_01',
      svgPath: 'assets/diagrams/res_01.webp',
      title: 'Single Pole Light Switch',
      category: 'residential',
      description:
          'Basic one-way switch controlling one light from one location.',
      difficulty: 'beginner',
      steps: [
        "Isolate the lighting circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester.",
        "Connect the identified permanent phase conductor to the switch common or line terminal specified by the accessory manufacturer.",
        "Connect the identified switched-live conductor from the switch output to the luminaire live terminal.",
        "Connect neutral directly to the luminaire neutral terminal without routing it through a standard single-pole switch.",
        "Maintain protective-conductor continuity to every required metal box and luminaire earth terminal.",
        "Torque terminals, refit covers, complete dead tests, energize through the designed protection, and confirm ON/OFF operation."
      ],
      components: [
        '1× one-way switch',
        '1× light fixture',
        '1.5 mm² phase/neutral/earth cable',
        'PVC conduit or approved wiring method',
        'MCB/RCD protected supply'
      ],
      tags: ['Educational Concept', 'switch', 'lighting', 'residential'],
      keywords: [
        'single pole',
        'one way switch',
        'switched live',
        'single pole light switch',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Single Pole Light Switch only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_02', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_02',
      svgPath: 'assets/diagrams/res_02.webp',
      title: 'Two-Way Staircase Switch',
      category: 'residential',
      description:
          'Control one light from two locations using two two-way switches.',
      difficulty: 'journeyman',
      steps: [
        "Isolate the lighting circuit, lock out where practicable, prove the tester, verify dead, and identify COM/L1/L2 on the actual two-way switches.",
        "Connect the permanent phase conductor to the COM terminal of the first two-way switch.",
        "Connect two identified traveller conductors between corresponding L1 and L2 terminals of the two switches.",
        "Connect COM of the second two-way switch to the switched-live terminal of the luminaire.",
        "Run neutral directly to the luminaire and maintain protective-conductor continuity to every required box and fitting.",
        "Test polarity, protective-conductor continuity, insulation resistance, and all four switch combinations before handover."
      ],
      components: [
        '2× two-way switches',
        '1× light fixture',
        'traveller wires',
        '1.5 mm² CPC/earth',
        'approved switch boxes'
      ],
      tags: ['Educational Concept', 'two-way', 'staircase', 'residential'],
      keywords: [
        'travellers',
        'common terminal',
        'staircase light',
        'two-way staircase switch',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Two-Way Staircase Switch only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_01', 'res_03'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_03',
      svgPath: 'assets/diagrams/res_03.webp',
      title: 'Intermediate Multi-Way Lighting',
      category: 'residential',
      description:
          'Control one light from three locations using two two-way switches and one intermediate switch.',
      difficulty: 'journeyman',
      steps: [
        "Install two-way switches at the end positions and intermediate switch in the middle.",
        "Feed permanent phase to common of first two-way switch.",
        "Connect travellers from first two-way switch to input pair of intermediate switch.",
        "Connect output pair of intermediate switch to travellers of second two-way switch.",
        "Connect second common to light live; neutral goes directly to light.",
        "Verify earth continuity and test all switch combinations."
      ],
      components: [
        '2× two-way switches',
        '1× intermediate switch',
        '1× light fixture',
        'traveller cables',
        'earth continuity conductor'
      ],
      tags: ['Educational Concept', 'intermediate', 'lighting', 'residential'],
      keywords: [
        'multi way switching',
        'crossover switch',
        'intermediate multi-way lighting',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Intermediate Multi-Way Lighting only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_04',
      svgPath: 'assets/diagrams/res_04.webp',
      title: 'Single Socket Outlet',
      category: 'residential',
      description:
          'Standard grounded socket outlet with live, neutral, and earth conductors.',
      difficulty: 'beginner',
      steps: [
        "Isolate the socket circuit and verify dead.",
        "Connect live/phase conductor to socket L terminal.",
        "Connect neutral conductor to socket N terminal.",
        "Connect earth conductor to E terminal and metal box if required.",
        "Tighten terminals to manufacturer torque guidance.",
        "Test polarity, earth continuity, and socket operation."
      ],
      components: [
        '1× 13A/16A socket outlet',
        '2.5 mm² cable or code-approved size',
        'wall box',
        'socket tester',
        'MCB/RCD protection'
      ],
      tags: ['Educational Concept', 'socket', 'outlet', 'residential'],
      keywords: [
        'L N E',
        'polarity',
        'earth',
        'single socket outlet',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Single Socket Outlet only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_05', 'dist_04'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_05',
      svgPath: 'assets/diagrams/res_05.webp',
      title: 'Ring Main Socket Circuit',
      category: 'residential',
      description:
          'Ring-style socket circuit with return conductors to the distribution board.',
      difficulty: 'journeyman',
      steps: [
        "Start phase, neutral, and earth from the DB protective device/bars.",
        "Loop to each socket outlet using correct L/N/E terminals.",
        "Return final socket conductors back to the DB to complete the ring.",
        "Keep earth continuity through every accessory.",
        "Test ring continuity, polarity, insulation resistance, and earth continuity.",
        "Label the circuit and record test results."
      ],
      components: [
        'Multiple socket outlets',
        '2.5 mm² cable or local equivalent',
        '32A MCB/RCBO where permitted',
        'earth continuity conductor',
        'socket tester'
      ],
      tags: ['Educational Concept', 'ring', 'socket', 'residential'],
      keywords: [
        'ring main',
        'socket circuit',
        'continuity',
        'ring main socket circuit',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Ring Main Socket Circuit only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_04', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_06',
      svgPath: 'assets/diagrams/res_06.webp',
      title: 'Ceiling Fan with Regulator',
      category: 'residential',
      description:
          'Ceiling fan controlled by wall switch/regulator with neutral and earth at fan point.',
      difficulty: 'journeyman',
      steps: [
        "Isolate the fan circuit and verify zero energy.",
        "Feed phase to switch/regulator input.",
        "Connect regulator output/switched live to fan live terminal.",
        "Connect neutral directly to fan neutral terminal.",
        "Connect earth to fan body/box where provided.",
        "Secure mechanical mounting before energizing and test all speeds."
      ],
      components: [
        '1× ceiling fan',
        '1× fan regulator or speed controller',
        '1× switch',
        'fan-rated ceiling hook/box',
        '1.5/2.5 mm² conductors per code'
      ],
      tags: ['Educational Concept', 'fan', 'regulator', 'residential'],
      keywords: [
        'ceiling fan',
        'speed controller',
        'switched live',
        'ceiling fan with regulator',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Ceiling Fan with Regulator only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_07',
      svgPath: 'assets/diagrams/res_07.webp',
      title: 'Doorbell Circuit',
      category: 'residential',
      description:
          'Low-voltage doorbell wiring using transformer, push button, and chime.',
      difficulty: 'beginner',
      steps: [
        "Isolate transformer primary supply.",
        "Connect transformer primary to protected mains supply as per manufacturer instructions.",
        "Run transformer secondary to push button.",
        "Connect push button output to chime input and return to transformer secondary.",
        "Keep low-voltage bell wiring separated from mains wiring.",
        "Energize and test push button/chime operation."
      ],
      components: [
        'doorbell transformer',
        'push button',
        'chime/bell unit',
        'low-voltage bell wire',
        'primary MCB/fuse protection'
      ],
      tags: ['Educational Concept', 'doorbell', 'low-voltage', 'residential'],
      keywords: [
        'bell transformer',
        'push button',
        'chime',
        'doorbell circuit',
        'residential'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Doorbell Circuit only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['res_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_01',
      svgPath: 'assets/diagrams/dist_01.webp',
      title: 'Single Phase Distribution Board',
      category: 'distribution',
      description:
          'Home/small office DB with main isolator, RCD, MCBs, neutral bar, and earth bar.',
      difficulty: 'journeyman',
      steps: [
        "Identify every source, isolate upstream supplies, lock out, verify all incoming conductors and busbars dead, and re-prove the tester.",
        "Confirm the enclosure, main isolator, RCD/RCBO arrangement, busbar, neutral bar, earth bar, and outgoing devices are rated for the engineered design.",
        "Connect incoming phase and neutral conductors through the correctly poled main isolator as required, and terminate the protective conductor on the main earth bar.",
        "Distribute phase through an approved rated busbar and keep each circuit neutral associated with its correct RCD/RCBO group.",
        "Terminate outgoing phase conductors through correctly selected protective devices, neutrals on the designated neutral bar, and protective conductors on the earth bar.",
        "Torque to manufacturer values, fit barriers/blanks, label every circuit, complete required dead/live tests, and record results before handover."
      ],
      components: [
        'DB enclosure',
        'DP main isolator/MCB',
        '30 mA RCD/RCBO as required',
        'SP MCBs',
        'neutral bar',
        'earth bar',
        'busbar links'
      ],
      tags: ['Educational Concept', 'DB', 'single phase', 'distribution'],
      keywords: [
        'main isolator',
        'RCD',
        'MCB',
        'neutral bar',
        'single phase distribution board',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use Single Phase Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_04', 'res_04'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_02',
      svgPath: 'assets/diagrams/dist_02.webp',
      title: 'Three Phase Distribution Board',
      category: 'distribution',
      description:
          'Three-phase DB with L1/L2/L3 busbars, neutral, earth, and balanced outgoing circuits.',
      difficulty: 'master',
      steps: [
        "Isolate upstream three-phase supply and verify all phases dead.",
        "Connect L1/L2/L3/N to main incomer in correct sequence.",
        "Install phase busbars and protective devices as per DB design.",
        "Distribute single-phase circuits across L1, L2, and L3 for balance.",
        "Terminate neutral and earth conductors on correct bars.",
        "Check phase rotation, insulation, earth continuity, and circuit labels."
      ],
      components: [
        '3-phase DB enclosure',
        '4-pole main isolator/MCCB',
        'TP/SP MCBs',
        'neutral bar',
        'earth bar',
        'phase busbars',
        'phase labels'
      ],
      tags: ['Educational Concept', 'three-phase', 'DB', 'distribution'],
      keywords: [
        'L1 L2 L3',
        'phase sequence',
        'load balancing',
        'three phase distribution board',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use Three Phase Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_06', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_03',
      svgPath: 'assets/diagrams/dist_03.webp',
      title: 'Sub-Distribution Board',
      category: 'distribution',
      description:
          'Sub-DB fed from a main DB using correctly protected feeder and local outgoing circuits.',
      difficulty: 'journeyman',
      steps: [
        "Calculate feeder load and voltage drop before installation.",
        "Protect feeder at source with correctly rated device.",
        "Run feeder phase(s), neutral, and protective earth to sub-DB.",
        "Install local main switch and outgoing protection.",
        "Keep neutrals matched to their RCD/RCBO group.",
        "Test feeder continuity, insulation, polarity, and earth fault path."
      ],
      components: [
        'sub-DB enclosure',
        'feeder cable',
        'upstream MCCB/MCB',
        'main switch',
        'outgoing MCBs/RCBOs',
        'earth conductor'
      ],
      tags: ['Educational Concept', 'sub DB', 'feeder', 'distribution'],
      keywords: [
        'sub distribution',
        'feeder protection',
        'voltage drop',
        'sub-distribution board',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use Sub-Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_01', 'dist_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_04',
      svgPath: 'assets/diagrams/dist_04.webp',
      title: 'RCD Protected DB',
      category: 'distribution',
      description:
          'Distribution board arrangement using RCD/RCBO protection for shock/leakage protection.',
      difficulty: 'journeyman',
      steps: [
        "Isolate and verify DB is dead.",
        "Install RCD downstream of main isolator or use RCBOs per circuit.",
        "Route phase and matching neutral through the same RCD/RCBO group.",
        "Do not share neutrals between RCD groups.",
        "Connect earths to earth bar only.",
        "Test RCD test button and leakage trip with approved tester where available."
      ],
      components: [
        'RCD/RCCB or RCBOs',
        'main isolator',
        'MCBs',
        'neutral bars per RCD group',
        'test button access',
        'earth bar'
      ],
      tags: ['Educational Concept', 'RCD', 'RCCB', 'RCBO', 'distribution'],
      keywords: [
        'earth leakage',
        'shared neutral',
        '30mA',
        'rcd protected db',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use RCD Protected DB only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_01', 'res_04'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_05',
      svgPath: 'assets/diagrams/dist_05.webp',
      title: 'SPD Protected Distribution Board',
      category: 'distribution',
      description:
          'DB with surge protection device connected with short leads and proper earthing.',
      difficulty: 'journeyman',
      steps: [
        "Confirm SPD type and system earthing arrangement.",
        "Isolate DB and verify dead.",
        "Install SPD close to incomer/main busbars.",
        "Connect phase(s), neutral, and earth according to SPD wiring diagram.",
        "Keep SPD leads short and direct to reduce let-through voltage.",
        "Record SPD status indicator and inspect during maintenance."
      ],
      components: [
        'Type 2 SPD or required SPD type',
        'backup fuse/MCB if required',
        'main DB',
        'earth bar',
        'short SPD conductors',
        'status indicator'
      ],
      tags: ['Educational Concept', 'SPD', 'surge', 'distribution'],
      keywords: [
        'surge protection',
        'Type 2 SPD',
        'earthing',
        'spd protected distribution board',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use SPD Protected Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_01', 'solar_05'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_06',
      svgPath: 'assets/diagrams/dist_06.webp',
      title: 'Three-Phase Load Balancing Example',
      category: 'distribution',
      description:
          'Example arrangement for spreading single-phase loads across a three-phase DB.',
      difficulty: 'journeyman',
      steps: [
        "List all single-phase loads with estimated current.",
        "Assign circuits across L1, L2, and L3 to keep total current similar.",
        "Place high-demand circuits on different phases where practical.",
        "Measure actual current after energizing under realistic load.",
        "Move non-critical circuits if imbalance is excessive and allowed.",
        "Update DB schedule and labels."
      ],
      components: [
        'three-phase DB',
        'single-phase MCBs',
        'load schedule',
        'clamp meter',
        'phase labels',
        'neutral conductor'
      ],
      tags: ['Educational Concept', 'load balancing', 'three-phase', 'distribution'],
      keywords: [
        'phase balance',
        'neutral current',
        'load schedule',
        'three-phase load balancing example',
        'distribution'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use Three-Phase Load Balancing Example only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['dist_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_01',
      svgPath: 'assets/diagrams/motor_01.webp',
      title: 'DOL Motor Starter',
      category: 'motors',
      description:
          'Direct-On-Line starter with contactor, overload relay, start/stop buttons, and holding contact.',
      difficulty: 'journeyman',
      steps: [
        "Isolate and lock out the motor feeder and control supply, prevent rotation, verify dead, and confirm the intended control voltage.",
        "Connect L1/L2/L3 through correctly rated short-circuit protection, the main contactor, and the overload relay to motor U/V/W; connect protective earth to the motor frame.",
        "Select a contactor coil, control transformer or supply, overload range, and control-circuit protection suitable for the actual design.",
        "Wire the control supply through the normally closed STOP contact and overload 95-96 contact, then through the normally open START contact to contactor coil A1/A2.",
        "Wire the contactor normally open auxiliary holding contact in parallel with START so STOP or overload operation always de-energizes the coil.",
        "Set the overload from motor and manufacturer data, test stop/start/overload logic, verify rotation, and measure phase currents under controlled load."
      ],
      components: [
        '3-pole contactor',
        'thermal/electronic overload relay',
        'start NO pushbutton',
        'stop NC pushbutton',
        'MCCB/fuses',
        'motor isolator'
      ],
      tags: ['Educational Concept', 'DOL', 'motor starter', 'motors'],
      keywords: [
        'contactor',
        'overload relay',
        'holding contact',
        'dol motor starter',
        'motors'
      ],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use DOL Motor Starter only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['motor_04'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_02',
      svgPath: 'assets/diagrams/motor_02.webp',
      title: 'Star-Delta Starter',
      category: 'motors',
      description:
          'Reduced-voltage starting using main, star, and delta contactors with timer and interlocks.',
      difficulty: 'master',
      steps: [
        "Verify motor is suitable for star-delta at supply voltage.",
        "Wire main contactor to motor U1/V1/W1.",
        "Wire star contactor to short U2/V2/W2 during start.",
        "Wire delta contactor to form delta connection after timer transition.",
        "Interlock star and delta contactors so they cannot close together.",
        "Test unloaded first, verify rotation, then commission under controlled load."
      ],
      components: [
        'main contactor',
        'star contactor',
        'delta contactor',
        'timer relay',
        'overload relay',
        'six-terminal motor',
        'mechanical/electrical interlocks'
      ],
      tags: ['Educational Concept', 'star-delta', 'motor starter', 'motors'],
      keywords: [
        'reduced voltage',
        'timer',
        'interlock',
        'star-delta starter',
        'motors'
      ],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Star-Delta Starter only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['motor_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_03',
      svgPath: 'assets/diagrams/motor_03.webp',
      title: 'Reverse Forward Motor Starter',
      category: 'motors',
      description:
          'Forward/reverse motor control using two contactors with electrical and mechanical interlocking.',
      difficulty: 'master',
      steps: [
        "Isolate and verify motor supply dead.",
        "Wire forward contactor with normal phase sequence to motor.",
        "Wire reverse contactor with two phases swapped.",
        "Install mechanical interlock between contactors.",
        "Wire electrical NC interlocks in each opposite coil circuit.",
        "Test forward, stop, reverse sequence and verify direction safely."
      ],
      components: [
        '2× 3-pole contactors',
        'mechanical interlock',
        'overload relay',
        'forward/reverse pushbuttons',
        'stop button',
        'control fuses'
      ],
      tags: ['Educational Concept', 'reverse-forward', 'motor', 'motors'],
      keywords: [
        'phase reversal',
        'interlock',
        'direction control',
        'reverse forward motor starter',
        'motors'
      ],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Reverse Forward Motor Starter only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['motor_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_04',
      svgPath: 'assets/diagrams/motor_04.webp',
      title: 'Motor with Overload Relay',
      category: 'motors',
      description:
          'Motor feeder showing overload relay placement and control circuit trip contact.',
      difficulty: 'journeyman',
      steps: [
        "Connect supply protection to contactor input.",
        "Install overload relay after contactor before motor output.",
        "Route all motor phases through the overload relay.",
        "Wire overload NC auxiliary contact in series with contactor coil.",
        "Set overload current to motor nameplate FLC.",
        "Test overload trip resets and control circuit drops out."
      ],
      components: [
        'motor',
        'contactor',
        'overload relay',
        'MCCB/fuses',
        'NC overload auxiliary contact',
        'start/stop controls'
      ],
      tags: ['Educational Concept', 'overload', 'motor protection', 'motors'],
      keywords: [
        'FLC setting',
        'thermal overload',
        'trip contact',
        'motor with overload relay',
        'motors'
      ],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Motor with Overload Relay only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['motor_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_05',
      svgPath: 'assets/diagrams/motor_05.webp',
      title: 'Timer-Based Motor Control',
      category: 'motors',
      description:
          'Motor controlled by timer relay for delayed start, delayed stop, or cyclic operation.',
      difficulty: 'journeyman',
      steps: [
        "Choose timer mode: on-delay, off-delay, or cyclic according to process.",
        "Wire control supply through protection and STOP/enable contact.",
        "Connect timer output contact to contactor coil circuit.",
        "Keep overload NC trip contact in series with coil.",
        "Set delay/cycle time and test without load first.",
        "Commission under load and verify safe manual stop."
      ],
      components: [
        'timer relay',
        'contactor',
        'overload relay',
        'selector switch',
        'start/stop controls',
        'motor protection'
      ],
      tags: ['Educational Concept', 'timer', 'motor control', 'motors'],
      keywords: [
        'on delay',
        'off delay',
        'cyclic timer',
        'timer-based motor control',
        'motors'
      ],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Timer-Based Motor Control only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['motor_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_01',
      svgPath: 'assets/diagrams/solar_01.webp',
      title: 'Off-Grid Solar Wiring',
      category: 'solar',
      description:
          'PV array feeding charge controller, battery bank, inverter, and dedicated AC loads.',
      difficulty: 'master',
      steps: [
        "Isolate all DC and AC sources before wiring.",
        "Connect PV strings through DC fuses/combiner to charge controller PV input.",
        "Connect charge controller battery terminals to fused battery bank.",
        "Connect inverter DC input to battery through DC breaker/fuse.",
        "Feed inverter AC output to dedicated load DB with protection.",
        "Check polarity, battery settings, and grounding before energizing."
      ],
      components: [
        'PV panels',
        'DC combiner/fuses',
        'charge controller',
        'battery bank',
        'DC isolators',
        'off-grid inverter',
        'AC load DB'
      ],
      tags: ['Educational Concept', 'off-grid', 'solar', 'solar'],
      keywords: [
        'charge controller',
        'battery bank',
        'off grid inverter',
        'off-grid solar wiring',
        'solar'
      ],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Off-Grid Solar Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['solar_04', 'solar_05'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_02',
      svgPath: 'assets/diagrams/solar_02.webp',
      title: 'Hybrid Solar Wiring',
      category: 'solar',
      description:
          'Hybrid inverter connected to PV, batteries, grid/generator input, and essential loads.',
      difficulty: 'master',
      steps: [
        "Verify inverter manual, battery compatibility, and approval requirements.",
        "Wire PV strings to inverter MPPT through DC isolator/protection.",
        "Connect battery through correct DC breaker/fuse and communication where required.",
        "Connect grid/generator AC input through suitable breaker.",
        "Connect backup output to essential-load DB only.",
        "Configure charging, export, battery limits, and test backup transfer."
      ],
      components: [
        'hybrid inverter',
        'PV strings',
        'battery bank/BMS',
        'AC input breaker',
        'backup load DB',
        'DC/AC isolators',
        'SPD'
      ],
      tags: ['Educational Concept', 'hybrid', 'solar', 'solar'],
      keywords: [
        'MPPT',
        'battery BMS',
        'essential loads',
        'hybrid solar wiring',
        'solar'
      ],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Hybrid Solar Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['solar_01', 'generator_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_03',
      svgPath: 'assets/diagrams/solar_03.webp',
      title: 'Grid-Tie Solar Wiring',
      category: 'solar',
      description:
          'Grid-tie inverter connected to PV strings and AC distribution with approved protection.',
      difficulty: 'master',
      steps: [
        "Confirm utility/DISCO approval and inverter compliance before connection.",
        "Connect PV strings to inverter MPPT through DC isolator and protection.",
        "Connect inverter AC output to dedicated breaker/isolator in DB.",
        "Install SPD and earthing according to inverter and local requirements.",
        "Label AC/DC isolators and warning notices.",
        "Commission anti-islanding/export settings as required by authority."
      ],
      components: [
        'grid-tie inverter',
        'PV strings',
        'DC isolator',
        'AC isolator',
        'AC breaker',
        'net meter interface',
        'SPD/earthing'
      ],
      tags: ['Educational Concept', 'grid-tie', 'solar', 'solar'],
      keywords: [
        'net metering',
        'anti islanding',
        'AC isolator',
        'grid-tie solar wiring',
        'solar'
      ],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Grid-Tie Solar Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['solar_05', 'dist_05'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_04',
      svgPath: 'assets/diagrams/solar_04.webp',
      title: 'Solar Battery Bank Wiring',
      category: 'solar',
      description:
          'Battery series/parallel arrangement for target DC voltage and capacity.',
      difficulty: 'journeyman',
      steps: [
        "Confirm all batteries are same type, voltage, capacity, and health.",
        "Plan series strings for required voltage and parallel strings for capacity.",
        "Use equal-length links for parallel current sharing.",
        "Install fuse/breaker close to battery positive.",
        "Observe polarity carefully and cover exposed terminals.",
        "Configure charger/inverter battery settings and test voltage before connection."
      ],
      components: [
        'matched batteries',
        'battery links',
        'DC fuse/breaker',
        'battery isolator',
        'BMS for lithium',
        'insulated tools',
        'terminal covers'
      ],
      tags: ['Educational Concept', 'battery', 'solar storage', 'solar'],
      keywords: [
        'series parallel',
        'BMS',
        'DC fuse',
        'solar battery bank wiring',
        'solar'
      ],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Solar Battery Bank Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['solar_01', 'solar_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_05',
      svgPath: 'assets/diagrams/solar_05.webp',
      title: 'Solar DC Protection Wiring',
      category: 'solar',
      description:
          'PV DC protection with fuses, isolators, SPD, and earthing before inverter input.',
      difficulty: 'master',
      steps: [
        "Identify PV string voltage/current and select DC-rated devices.",
        "Route each string through correct fuse where required.",
        "Install DC isolator between array/combiner and inverter.",
        "Connect DC SPD to positive/negative and earth with short leads.",
        "Bond frames and support structure as required.",
        "Verify polarity and open-circuit voltage before connecting inverter."
      ],
      components: [
        'PV string fuses',
        'DC isolator',
        'DC SPD',
        'combiner box',
        'earth conductor',
        'PV cable/connectors',
        'warning labels'
      ],
      tags: ['Educational Concept', 'DC protection', 'solar', 'solar'],
      keywords: [
        'PV fuse',
        'DC SPD',
        'isolator',
        'earthing',
        'solar dc protection wiring',
        'solar'
      ],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Solar DC Protection Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['solar_03', 'dist_05'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_01',
      svgPath: 'assets/diagrams/generator_01.webp',
      title: 'Manual Changeover Switch',
      category: 'generator',
      description:
          'Manual transfer between utility and generator with mechanical interlock to prevent backfeed.',
      difficulty: 'master',
      steps: [
        "Isolate all sources before installation.",
        "Connect utility supply to normal/source-1 terminals.",
        "Connect generator supply to generator/source-2 terminals.",
        "Connect load DB to changeover output terminals.",
        "Ensure switch mechanically prevents both sources being connected together.",
        "Test utility, off, and generator positions without backfeed."
      ],
      components: [
        'manual changeover switch',
        'utility supply',
        'generator supply',
        'load DB',
        'correct cable/protection',
        'earth/neutral arrangement per code'
      ],
      tags: ['Educational Concept', 'changeover', 'generator', 'generator'],
      keywords: [
        'manual transfer',
        'backfeed prevention',
        'manual changeover switch',
        'generator'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Manual Changeover Switch only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['generator_02', 'generator_03'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_02',
      svgPath: 'assets/diagrams/generator_02.webp',
      title: 'Generator ATS Wiring',
      category: 'generator',
      description:
          'Automatic transfer switch sensing utility failure and starting/transferring generator supply.',
      difficulty: 'master',
      steps: [
        "Confirm ATS rating, pole configuration, and neutral switching requirements.",
        "Connect utility incomer to ATS normal source terminals.",
        "Connect generator output to ATS emergency source terminals.",
        "Connect ATS load output to protected DB/load.",
        "Wire generator start/stop control contacts as per controller manual.",
        "Test utility fail, generator start, transfer, retransfer, and cooldown sequence."
      ],
      components: [
        'ATS panel',
        'generator controller',
        'utility incomer',
        'generator incomer',
        'load output',
        'control cable',
        'battery charger'
      ],
      tags: ['Educational Concept', 'ATS', 'generator', 'generator'],
      keywords: [
        'automatic transfer',
        'generator start',
        'interlock',
        'generator ats wiring',
        'generator'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Generator ATS Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['generator_01', 'generator_03'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_03',
      svgPath: 'assets/diagrams/generator_03.webp',
      title: 'Generator Feeding Distribution Board',
      category: 'generator',
      description:
          'Generator connected to a DB through transfer equipment, protection, and correct earthing arrangement.',
      difficulty: 'master',
      steps: [
        "Never connect generator directly to DB without transfer equipment.",
        "Install generator breaker and cable sized for output current.",
        "Route generator output to changeover/ATS input.",
        "Connect transfer output to DB main/load side as designed.",
        "Verify earthing/neutral bonding arrangement according to local rules.",
        "Test voltage, frequency, phase sequence, and load response."
      ],
      components: [
        'generator',
        'changeover/ATS',
        'generator breaker',
        'DB incomer',
        'earth conductor',
        'neutral arrangement labels'
      ],
      tags: ['Educational Concept', 'generator', 'DB', 'generator'],
      keywords: [
        'backup supply',
        'DB incomer',
        'phase sequence',
        'generator feeding distribution board',
        'generator'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Generator Feeding Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['generator_01', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_04',
      svgPath: 'assets/diagrams/generator_04.webp',
      title: 'Generator Earthing Diagram',
      category: 'generator',
      description:
          'Generator frame earthing, bonding, and neutral-earth considerations for safe backup operation.',
      difficulty: 'master',
      steps: [
        "Review generator manual and local earthing system requirements.",
        "Bond generator frame to protective earth.",
        "Connect generator earthing conductor to approved earth terminal/electrode as required.",
        "Apply neutral-earth bond only where permitted by the earthing design.",
        "Test earth continuity and fault path before operation.",
        "Document earthing arrangement for maintenance and inspections."
      ],
      components: [
        'earth electrode/system earth',
        'generator frame earth terminal',
        'bonding conductor',
        'neutral-earth link if required by design',
        'earth test instrument',
        'labels'
      ],
      tags: ['Educational Concept', 'generator earthing', 'bonding', 'generator'],
      keywords: [
        'neutral earth bond',
        'frame earth',
        'fault path',
        'generator earthing diagram',
        'generator'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Generator Earthing Diagram only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['generator_03', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_01',
      svgPath: 'assets/diagrams/smart_01.webp',
      title: 'Smart Switch Without Neutral',
      category: 'smart',
      description:
          'Smart switch wiring where no neutral is available at the switch box, using compatible no-neutral devices.',
      difficulty: 'journeyman',
      steps: [
        "Confirm the smart switch is rated for no-neutral installation.",
        "Isolate lighting circuit and verify dead.",
        "Connect permanent phase to smart switch L input.",
        "Connect switched output to light live conductor.",
        "Install bypass at load only if manufacturer requires it.",
        "Pair device and test manual and app control after safe energizing."
      ],
      components: [
        'no-neutral smart switch',
        'compatible bypass/capacitor if required',
        'light load',
        'phase conductor',
        'switched live',
        'earth conductor'
      ],
      tags: ['Educational Concept', 'smart switch', 'no neutral', 'smart'],
      keywords: [
        'automation',
        'bypass capacitor',
        'Wi-Fi switch',
        'smart switch without neutral',
        'smart'
      ],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Smart Switch Without Neutral only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['smart_02', 'res_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_02',
      svgPath: 'assets/diagrams/smart_02.webp',
      title: 'Smart Switch With Neutral',
      category: 'smart',
      description:
          'Preferred smart switch wiring using live, neutral, switched live, and earth in the switch box.',
      difficulty: 'journeyman',
      steps: [
        "Isolate and verify the circuit is dead.",
        "Connect permanent live to smart switch L terminal.",
        "Connect neutral to smart switch N terminal.",
        "Connect switched live/output to light fixture live.",
        "Maintain earth continuity in box and fixture.",
        "Configure device and test local/app operation."
      ],
      components: [
        'smart switch with neutral',
        'neutral conductor in switch box',
        'light fixture',
        'phase conductor',
        'switched live',
        'earth conductor'
      ],
      tags: ['Educational Concept', 'smart switch', 'neutral', 'smart'],
      keywords: [
        'neutral required',
        'smart lighting',
        'automation',
        'smart switch with neutral',
        'smart'
      ],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Smart Switch With Neutral only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['smart_01', 'res_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_03',
      svgPath: 'assets/diagrams/smart_03.webp',
      title: 'Smart Relay Module',
      category: 'smart',
      description:
          'Smart relay installed behind a switch or near load for app-controlled switching.',
      difficulty: 'journeyman',
      steps: [
        "Confirm relay contact rating suits the load type.",
        "Isolate supply and verify dead.",
        "Connect live and neutral supply to relay power terminals.",
        "Connect relay output contact in series with load live conductor.",
        "Connect manual switch input according to relay mode.",
        "Secure module in suitable enclosure and test app/manual control."
      ],
      components: [
        'smart relay module',
        'manual switch input',
        'phase and neutral supply',
        'load output',
        'enclosure with space',
        'approved connectors'
      ],
      tags: ['Educational Concept', 'smart relay', 'automation', 'smart'],
      keywords: [
        'relay module',
        'manual switch input',
        'load output',
        'smart relay module',
        'smart'
      ],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Smart Relay Module only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['smart_02'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_04',
      svgPath: 'assets/diagrams/smart_04.webp',
      title: 'Smart Breaker Concept',
      category: 'smart',
      description:
          'Connected breaker/monitoring concept with load measurement, trip logging, and remote status.',
      difficulty: 'master',
      steps: [
        "Verify device rating, breaking capacity, and approvals before use.",
        "Isolate DB and verify dead before installation.",
        "Install smart breaker on correct busbar/rail per manufacturer instructions.",
        "Connect outgoing load conductor and neutral/reference as required.",
        "Configure app/gateway and label circuit clearly.",
        "Use remote features for monitoring only; apply physical lockout for maintenance."
      ],
      components: [
        'smart breaker or monitor',
        'DB space',
        'line/load terminals',
        'neutral reference if required',
        'communication gateway',
        'manufacturer app'
      ],
      tags: ['Educational Concept', 'smart breaker', 'monitoring', 'smart'],
      keywords: [
        'connected protection',
        'trip log',
        'remote monitoring',
        'smart breaker concept',
        'smart'
      ],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Smart Breaker Concept only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: ['smart_03', 'dist_01'],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_08',
      svgPath: 'assets/diagrams/res_08.webp',
      title: 'Dimmer Light Circuit',
      category: 'residential',
      description: 'Light dimmer controlling compatible dimmable lamp.',
      difficulty: 'journeyman',
      steps: [
        "Isolate lighting circuit.",
        "Confirm lamp and dimmer compatibility.",
        "Connect phase to dimmer input.",
        "Connect dimmer output to lamp live.",
        "Connect neutral directly to lamp.",
        "Test dimming without flicker."
      ],
      components: [
        'Dimmer switch',
        'Dimmable LED/lamp',
        '1.5 mm² cable',
        'Earth conductor'
      ],
      tags: ['Educational Concept', 'residential', 'prd-diagram'],
      keywords: ['dimmer light circuit', 'residential', 'wiring diagram'],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Dimmer Light Circuit only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_09',
      svgPath: 'assets/diagrams/res_09.webp',
      title: 'Two Gang Switch Wiring',
      category: 'residential',
      description:
          'Two independent switches in one plate controlling two loads.',
      difficulty: 'journeyman',
      steps: [
        "Isolate the lighting circuit, lock out where practicable, prove the tester, verify dead, and identify the two COM and switched-output terminals on the actual two-gang switch.",
        "Connect the identified permanent phase conductor to both switch COM terminals using an approved loop or link arrangement.",
        "Connect the first switch output to the switched-live terminal of luminaire 1 and the second switch output to luminaire 2.",
        "Connect neutral directly to both luminaires without routing it through either standard single-pole switch.",
        "Maintain protective-conductor continuity to the switch box and both luminaires as required by the installation design.",
        "Complete protective-conductor continuity, insulation-resistance, polarity, functional, and applicable RCD/RCBO tests before handover."
      ],
      components: [
        '2-gang switch',
        'two light loads',
        'phase loop',
        'neutral/earth conductors'
      ],
      tags: ['Educational Concept', 'residential', 'prd-diagram'],
      keywords: ['two gang switch wiring', 'residential', 'wiring diagram'],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Two Gang Switch Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_10',
      svgPath: 'assets/diagrams/res_10.webp',
      title: 'Light with Socket Combination',
      category: 'residential',
      description:
          'Combined light and socket point with separate protection considerations.',
      difficulty: 'journeyman',
      steps: [
        "Plan separate lighting/socket ratings.",
        "Isolate supply.",
        "Wire socket L/N/E through suitable cable/protection.",
        "Wire light through switch live and neutral.",
        "Maintain earth continuity.",
        "Test socket polarity and light function."
      ],
      components: [
        'Light fixture',
        'socket outlet',
        'switch',
        'correct cable sizes',
        'MCB/RCD protection'
      ],
      tags: ['Educational Concept', 'residential', 'prd-diagram'],
      keywords: [
        'light with socket combination',
        'residential',
        'wiring diagram'
      ],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Light with Socket Combination only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'res_11',
      svgPath: 'assets/diagrams/res_11.webp',
      title: 'Room Wiring Layout',
      category: 'residential',
      description:
          'Typical room wiring layout with light, fan, socket, and switchboard.',
      difficulty: 'journeyman',
      steps: [
        "Design the room layout and circuit routes from the distribution board, keeping lighting, fan, and socket circuits correctly protected and identified.",
        "Run the designed lighting and socket conductors using sizes and installation methods verified for load, voltage drop, grouping, and local rules.",
        "Connect the light and fan switched-live conductors through their switches or regulator while taking neutral directly to the loads.",
        "Connect socket phase, neutral, and protective conductors to the correct terminals and maintain continuity through every point.",
        "Keep neutrals associated with their correct circuit/RCD group and connect protective conductors to the designated earth terminals.",
        "Before handover, test polarity, continuity, insulation resistance, RCD/RCBO operation where applicable, fan speeds, lighting, and socket function."
      ],
      components: [
        'switchboard',
        'ceiling light',
        'fan point',
        'socket outlet',
        'junction box/DB feed'
      ],
      tags: ['Educational Concept', 'residential', 'prd-diagram'],
      keywords: ['room wiring layout', 'residential', 'wiring diagram'],
      safetyWarnings: [
        "Isolate every supply to the circuit, lock out where practicable, prove the tester, verify dead, and re-prove the tester before touching conductors.",
        "Do not rely on conductor colors in the illustration; identify every conductor and verify accessory terminal markings for the actual installation.",
        "Confirm circuit protection, RCD/RCBO requirements, cable capacity, earthing, and bonding against the latest adopted local rules before energizing."
      ],
      commonMistakes: [
        "Switching the neutral instead of the phase conductor or mixing permanent and switched live conductors.",
        "Leaving the protective conductor disconnected at metal boxes, luminaires, fans, or socket outlets.",
        "Copying illustrative breaker ratings or conductor sizes without a load, voltage-drop, fault-level, and installation-method check."
      ],
      testingProcedure: [
        "Before energizing, verify protective-conductor continuity, insulation resistance, polarity, and separation of neutral and protective earth.",
        "Confirm switches interrupt the intended phase conductor and test every operating combination or speed setting.",
        "Test applicable RCD/RCBO operation with suitable instruments and record the commissioning results."
      ],
      professionalNotes: [
        "Use Room Wiring Layout only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_07',
      svgPath: 'assets/diagrams/dist_07.webp',
      title: 'Split Load DB',
      category: 'distribution',
      description:
          'DB with separate RCD groups for lighting and power circuits.',
      difficulty: 'journeyman',
      steps: [
        "Isolate incoming supply.",
        "Install main switch and two RCD groups.",
        "Route matching neutrals to each group.",
        "Avoid shared neutral between groups.",
        "Label circuits clearly.",
        "Test RCDs and outgoing circuits."
      ],
      components: [
        'main isolator',
        'two RCDs',
        'MCBs',
        'separate neutral bars'
      ],
      tags: ['Educational Concept', 'distribution', 'prd-diagram'],
      keywords: ['split load db', 'distribution', 'wiring diagram'],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use Split Load DB only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_08',
      svgPath: 'assets/diagrams/dist_08.webp',
      title: 'RCBO Distribution Board',
      category: 'distribution',
      description:
          'Distribution board using individual RCBOs for each outgoing circuit.',
      difficulty: 'journeyman',
      steps: [
        "Mount RCBOs correctly.",
        "Connect each circuit phase and neutral through its RCBO.",
        "Connect earths to earth bar.",
        "Avoid neutral mixing.",
        "Test every RCBO.",
        "Record circuit labels."
      ],
      components: ['RCBOs', 'main isolator', 'earth bar', 'neutral tails'],
      tags: ['Educational Concept', 'distribution', 'prd-diagram'],
      keywords: ['rcbo distribution board', 'distribution', 'wiring diagram'],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use RCBO Distribution Board only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'dist_09',
      svgPath: 'assets/diagrams/dist_09.webp',
      title: 'DB Surge and RCD Combined Layout',
      category: 'distribution',
      description:
          'DB layout combining RCD/RCBO protection with SPD at incomer.',
      difficulty: 'journeyman',
      steps: [
        "Install SPD near incomer.",
        "Keep SPD earth lead short.",
        "Install RCD/RCBO protection.",
        "Route neutrals correctly.",
        "Label SPD/RCD devices.",
        "Test and inspect status indicators."
      ],
      components: [
        'SPD',
        'RCD/RCBOs',
        'main isolator',
        'earth bar',
        'backup protection'
      ],
      tags: ['Educational Concept', 'distribution', 'prd-diagram'],
      keywords: [
        'db surge and rcd combined layout',
        'distribution',
        'wiring diagram'
      ],
      safetyWarnings: [
        "Distribution-board work presents shock and arc-flash hazards; isolate upstream sources, lock out, verify every pole dead, and use competent persons and appropriate PPE.",
        "Check for alternate, generator, solar, battery, and backfeed sources before assuming the busbars or neutral are de-energized.",
        "Device ratings, busbars, conductor sizes, fault levels, neutral arrangements, and earthing must be engineered for the actual board and adopted rules."
      ],
      commonMistakes: [
        "Sharing or mixing neutrals between RCD/RCBO groups, or terminating neutral and protective earth on the wrong bars.",
        "Using an isolator, busbar, SPD, RCD, RCBO, or breaker with inadequate voltage, current, fault, or coordination ratings.",
        "Poor terminal torque, missing blanks/barriers, weak labeling, and unbalanced single-phase loads across phases."
      ],
      testingProcedure: [
        "Complete dead tests for protective-conductor continuity, insulation resistance, polarity, and neutral separation before energizing.",
        "Verify phase sequence, prospective fault current, earth-fault path, protective-device settings, and RCD/RCBO operation as applicable.",
        "Energize in a controlled sequence, measure phase and neutral currents, inspect SPD status, and record the final circuit schedule and test results."
      ],
      professionalNotes: [
        "Use DB Surge and RCD Combined Layout only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_06',
      svgPath: 'assets/diagrams/motor_06.webp',
      title: 'Soft Starter Wiring',
      category: 'motors',
      description: 'Three-phase motor wired through electronic soft starter.',
      difficulty: 'journeyman',
      steps: [
        "Verify motor/soft starter ratings.",
        "Connect supply to soft starter input.",
        "Connect output to motor.",
        "Wire start/stop control.",
        "Configure ramp and current limits.",
        "Test unloaded then loaded."
      ],
      components: [
        'soft starter',
        'MCCB',
        'bypass contactor optional',
        'overload/protection',
        'motor'
      ],
      tags: ['Educational Concept', 'motors', 'prd-diagram'],
      keywords: ['soft starter wiring', 'motors', 'wiring diagram'],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Soft Starter Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_07',
      svgPath: 'assets/diagrams/motor_07.webp',
      title: 'VFD Motor Wiring',
      category: 'motors',
      description:
          'Motor connected to VFD with input protection and EMC-aware output wiring.',
      difficulty: 'journeyman',
      steps: [
        "Install input protection.",
        "Connect supply to VFD input.",
        "Connect VFD output to motor terminals.",
        "Bond earth/shield correctly.",
        "Enter motor nameplate data.",
        "Test rotation and ramp settings."
      ],
      components: [
        'VFD',
        'MCCB/isolator',
        'motor cable',
        'earth/shield',
        'motor'
      ],
      tags: ['Educational Concept', 'motors', 'prd-diagram'],
      keywords: ['vfd motor wiring', 'motors', 'wiring diagram'],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use VFD Motor Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'motor_08',
      svgPath: 'assets/diagrams/motor_08.webp',
      title: 'Pump Float Switch Control',
      category: 'motors',
      description: 'Pump motor controlled by float switch and contactor.',
      difficulty: 'journeyman',
      steps: [
        "Isolate supply.",
        "Wire motor through contactor and overload.",
        "Wire float switch in control circuit.",
        "Add manual/auto selector if required.",
        "Set overload.",
        "Test float operation safely."
      ],
      components: [
        'float switch',
        'contactor',
        'overload relay',
        'pump motor',
        'control fuse'
      ],
      tags: ['Educational Concept', 'motors', 'prd-diagram'],
      keywords: ['pump float switch control', 'motors', 'wiring diagram'],
      safetyWarnings: [
        "Isolate and lock out power and control supplies, prevent unexpected rotation, and discharge stored energy in drives or capacitors before work.",
        "Use correctly rated short-circuit protection, contactors, overload protection, control voltage, earthing, and enclosures for the motor duty.",
        "Follow the motor, starter, soft-starter, VFD, and driven-machine manufacturer instructions; qualified commissioning is required."
      ],
      commonMistakes: [
        "Setting the overload without the motor nameplate current, service factor, starting method, ambient conditions, and manufacturer guidance.",
        "Missing electrical/mechanical interlocks, using the wrong phase sequence, or bypassing stop and overload contacts.",
        "Switching a VFD output under load, insulation-testing through connected electronics, or using unsuitable motor cable and EMC practices."
      ],
      testingProcedure: [
        "With electronics isolated as required, verify protective-conductor continuity, insulation resistance, control-circuit continuity, and interlocks.",
        "Test stop, emergency-stop, overload, permissive, timer, float, and direction logic before coupling or loading the machine.",
        "Confirm rotation, acceleration, current balance, overload setting, noise, vibration, and loaded operation while recording commissioning values."
      ],
      professionalNotes: [
        "Use Pump Float Switch Control only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_06',
      svgPath: 'assets/diagrams/solar_06.webp',
      title: 'PV String Combiner Box',
      category: 'solar',
      description:
          'Multiple PV strings combined through fuses and DC isolator.',
      difficulty: 'journeyman',
      steps: [
        "Verify string voltage/current.",
        "Connect each string through DC fuse.",
        "Combine outputs to DC isolator.",
        "Install DC SPD to earth.",
        "Label polarity and hazards.",
        "Test Voc before inverter connection."
      ],
      components: [
        'PV string fuses',
        'combiner box',
        'DC isolator',
        'DC SPD',
        'PV cable'
      ],
      tags: ['Educational Concept', 'solar', 'prd-diagram'],
      keywords: ['pv string combiner box', 'solar', 'wiring diagram'],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use PV String Combiner Box only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_07',
      svgPath: 'assets/diagrams/solar_07.webp',
      title: 'Microinverter Solar Wiring',
      category: 'solar',
      description:
          'AC microinverter PV system with trunk cable and AC protection.',
      difficulty: 'journeyman',
      steps: [
        "Mount microinverters per module.",
        "Connect PV modules to microinverters.",
        "Connect AC trunk cable.",
        "Install AC isolator/breaker.",
        "Bond frames/earth.",
        "Commission monitoring and AC output."
      ],
      components: [
        'microinverters',
        'AC trunk cable',
        'AC isolator',
        'AC breaker',
        'PV modules'
      ],
      tags: ['Educational Concept', 'solar', 'prd-diagram'],
      keywords: ['microinverter solar wiring', 'solar', 'wiring diagram'],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Microinverter Solar Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'solar_08',
      svgPath: 'assets/diagrams/solar_08.webp',
      title: 'Solar Inverter AC DB Connection',
      category: 'solar',
      description:
          'Solar inverter AC output connected to distribution board through protection.',
      difficulty: 'journeyman',
      steps: [
        "Verify inverter AC rating.",
        "Install dedicated AC isolator.",
        "Connect output to DB breaker.",
        "Install labels and warning notices.",
        "Check earthing/SPD.",
        "Commission inverter settings."
      ],
      components: ['solar inverter', 'AC isolator', 'MCB/RCBO', 'SPD', 'DB'],
      tags: ['Educational Concept', 'solar', 'prd-diagram'],
      keywords: ['solar inverter ac db connection', 'solar', 'wiring diagram'],
      safetyWarnings: [
        "PV strings can remain energized whenever illuminated; identify and isolate PV, battery, inverter, grid, generator, and backup sources independently.",
        "Use DC-rated isolators, fuses/breakers, SPDs, connectors, test equipment, and PPE suitable for the maximum voltage and fault current.",
        "Battery banks can deliver extreme short-circuit current; protect each required conductor/string, prevent accidental bridging, and follow BMS/manufacturer rules."
      ],
      commonMistakes: [
        "Reversing DC polarity or exceeding inverter maximum Voc, MPPT window, input current, or connector/cable ratings under temperature extremes.",
        "Using AC-only protection on DC, mixing incompatible connectors, omitting string protection where required, or using long SPD leads.",
        "Assuming neutral-earth, backup-output, anti-islanding, and grid interconnection arrangements without approved design and utility requirements."
      ],
      testingProcedure: [
        "Verify string polarity and calculated cold-condition Voc before connection; perform insulation and protective-conductor tests using an approved PV procedure.",
        "Confirm isolator operation, fuse/breaker and SPD ratings, battery/BMS communication, inverter settings, and AC protection.",
        "Commission shutdown, backup transfer, export limitation, anti-islanding, and monitoring functions with the responsible authority and manufacturer procedure where applicable."
      ],
      professionalNotes: [
        "Use Solar Inverter AC DB Connection only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_05',
      svgPath: 'assets/diagrams/generator_05.webp',
      title: 'Portable Generator Changeover',
      category: 'generator',
      description:
          'Portable generator connected through inlet and changeover device.',
      difficulty: 'journeyman',
      steps: [
        "Install approved generator inlet.",
        "Connect inlet to changeover generator input.",
        "Connect changeover output to load DB.",
        "Prevent backfeed mechanically.",
        "Verify earthing arrangement.",
        "Test under controlled load."
      ],
      components: [
        'generator inlet',
        'manual changeover',
        'generator cable',
        'DB connection',
        'earthing'
      ],
      tags: ['Educational Concept', 'generator', 'prd-diagram'],
      keywords: [
        'portable generator changeover',
        'generator',
        'wiring diagram'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Portable Generator Changeover only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_06',
      svgPath: 'assets/diagrams/generator_06.webp',
      title: 'Three Phase Generator ATS',
      category: 'generator',
      description: 'Three-phase generator automatic transfer arrangement.',
      difficulty: 'journeyman',
      steps: [
        "Verify ATS rating and pole count.",
        "Connect utility L1/L2/L3/N.",
        "Connect generator L1/L2/L3/N.",
        "Connect load output.",
        "Wire start signal.",
        "Test phase rotation and transfer."
      ],
      components: [
        '4-pole ATS',
        '3-phase generator',
        'utility incomer',
        'load DB',
        'control wiring'
      ],
      tags: ['Educational Concept', 'generator', 'prd-diagram'],
      keywords: ['three phase generator ats', 'generator', 'wiring diagram'],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Three Phase Generator ATS only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'generator_07',
      svgPath: 'assets/diagrams/generator_07.webp',
      title: 'Generator Battery Charger Circuit',
      category: 'generator',
      description:
          'Battery charger/maintainer circuit for standby generator starting battery.',
      difficulty: 'journeyman',
      steps: [
        "Isolate charger supply.",
        "Install AC breaker/fuse.",
        "Connect charger DC through fuse to battery.",
        "Observe polarity.",
        "Secure cables.",
        "Test charging voltage."
      ],
      components: [
        'battery charger',
        'generator battery',
        'AC supply breaker',
        'DC fuse',
        'battery leads'
      ],
      tags: ['Educational Concept', 'generator', 'prd-diagram'],
      keywords: [
        'generator battery charger circuit',
        'generator',
        'wiring diagram'
      ],
      safetyWarnings: [
        "Never connect a generator to installation or utility wiring without correctly rated transfer equipment that prevents backfeed and unintended paralleling.",
        "Isolate utility and generator sources, lock out, verify dead, and account for automatic start, battery, stored energy, fuel, exhaust, and hot surfaces.",
        "Neutral switching, neutral-earth bonding, earthing electrodes, phase sequence, and fault protection require a system-specific competent design."
      ],
      commonMistakes: [
        "Using an undersized or incorrectly poled changeover/ATS, defeating interlocks, or connecting a portable generator through an unsafe backfeed lead.",
        "Adding or removing a neutral-earth link without confirming the supply/earthing arrangement and protective-device operation.",
        "Ignoring generator fault level, phase sequence, voltage/frequency stability, load steps, ventilation, and fuel/exhaust requirements."
      ],
      testingProcedure: [
        "Verify transfer-device mechanical/electrical interlocks and prove that utility and generator sources cannot connect together unintentionally.",
        "Check phase sequence, voltage, frequency, neutral/earth arrangement, protective-conductor continuity, insulation, and fault protection.",
        "Test manual and automatic transfer, fail-to-start alarms, return-to-utility timing, emergency stop, and controlled load performance while recording results."
      ],
      professionalNotes: [
        "Use Generator Battery Charger Circuit only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_05',
      svgPath: 'assets/diagrams/smart_05.webp',
      title: 'Zigbee Smart Relay Lighting',
      category: 'smart',
      description:
          'Zigbee relay controlling lighting circuit with manual switch input.',
      difficulty: 'journeyman',
      steps: [
        "Confirm relay rating.",
        "Connect L/N supply.",
        "Connect relay output to lamp live.",
        "Connect manual switch input.",
        "Pair with hub.",
        "Test manual and app control."
      ],
      components: [
        'Zigbee relay',
        'manual switch',
        'neutral/live supply',
        'light load',
        'hub'
      ],
      tags: ['Educational Concept', 'smart', 'prd-diagram'],
      keywords: ['zigbee smart relay lighting', 'smart', 'wiring diagram'],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Zigbee Smart Relay Lighting only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_06',
      svgPath: 'assets/diagrams/smart_06.webp',
      title: 'Smart Contactor for Heavy Load',
      category: 'smart',
      description:
          'Smart relay driving contactor coil for high-power load control.',
      difficulty: 'journeyman',
      steps: [
        "Use smart relay only for contactor coil.",
        "Protect power circuit with MCB.",
        "Wire load through contactor contacts.",
        "Wire relay output to coil.",
        "Keep manual isolation.",
        "Test remote and local stop."
      ],
      components: [
        'smart relay',
        'contactor',
        'MCB',
        'heavy load',
        'control supply'
      ],
      tags: ['Educational Concept', 'smart', 'prd-diagram'],
      keywords: ['smart contactor for heavy load', 'smart', 'wiring diagram'],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Smart Contactor for Heavy Load only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
    WiringDiagram(
      id: 'smart_07',
      svgPath: 'assets/diagrams/smart_07.webp',
      title: 'Energy Monitor CT Wiring',
      category: 'smart',
      description:
          'CT-based energy monitor installed in DB for load monitoring.',
      difficulty: 'journeyman',
      steps: [
        "Isolate the distribution board, identify all sources, verify dead, and confirm the energy monitor voltage category, CT type, ratio, and wiring instructions.",
        "Install each CT around only its assigned phase conductor with the polarity or direction mark oriented as required by the manufacturer.",
        "Route CT secondary leads safely to the matching CT inputs; never leave a conventional CT secondary open while primary current flows.",
        "Connect the monitor voltage-reference inputs only through correctly rated protection to the phase or phases and neutral exactly as shown in the manufacturer schematic.",
        "Configure phase mapping, CT ratio, direction, voltage system, and communication settings before relying on readings.",
        "Energize under controlled conditions and compare voltage, current, power, and direction against a calibrated meter or known load."
      ],
      components: [
        'energy monitor',
        'CT clamps',
        'voltage reference',
        'communication module',
        'DB'
      ],
      tags: ['Educational Concept', 'smart', 'prd-diagram'],
      keywords: ['energy monitor ct wiring', 'smart', 'wiring diagram'],
      safetyWarnings: [
        "Remote control can energize a load without a person at the switch; provide physical isolation and lockout for maintenance.",
        "Verify whether the device requires a neutral, bypass component, external contactor, CT shorting method, and specific load type before wiring.",
        "Smart functions do not replace correctly rated overcurrent, residual-current, earthing, isolation, and local manual-control requirements."
      ],
      commonMistakes: [
        "Driving a heavy load directly from a small smart relay instead of using a correctly rated contactor or interface.",
        "Using an incompatible no-neutral bypass, mixing supply and switched terminals, or omitting protective-conductor continuity.",
        "Treating network connectivity, software, or remote trip commands as a safety isolation function."
      ],
      testingProcedure: [
        "Verify terminal identification, protective-conductor continuity, insulation, polarity, CT direction/ratio, and load current before energizing.",
        "Test local manual control, remote control, loss and restoration of power/network, safe default state, and contactor/relay fail-safe behavior.",
        "Compare monitoring values with a known calibrated load or meter and confirm physical isolation remains effective without network access."
      ],
      professionalNotes: [
        "Use Energy Monitor CT Wiring only as a conceptual planning reference, not as a terminal-level installation drawing.",
        "Verify actual terminal designations, conductor identification, device ratings, protection, earthing/neutral arrangement, and manufacturer schematics before work.",
        "The illustration is not to scale and its colors and numeric ratings are examples only; document the final engineered installation and test results."
      ],
      standardsReferences: [
        "Conceptual educational reference only. Final design and installation must follow the latest adopted local rules, responsible utility or distribution-company requirements, equipment manufacturer instructions, and competent-person approval."
      ],
      relatedDiagramIds: [],
      contentVersion: '2.1.0-production-wiring-audit',
    ),
  ];
}
