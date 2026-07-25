import '../../models/calculator_model.dart';
import '../../models/quiz_model.dart';
import '../../models/theory_article.dart';
import '../../models/wiring_diagram.dart';
import 'content_quality.dart';

/// Adds Phase 2A.2 metadata to Phase 1 bundled content without forcing the UI
/// to change. Later, this metadata can be moved into JSON/localized content
/// files one collection at a time.
class ContentEnrichment {
  static List<TheoryCategory> enrichTheoryCategories(List<TheoryCategory> categories) {
    return categories.map((category) {
      final metadata = _theoryCategoryMetadata[category.id];
      if (metadata == null) return category;
      return category.copyWith(
        description: metadata.description,
        keywords: metadata.keywords,
      );
    }).toList(growable: false);
  }

  static List<CalculatorCategory> enrichCalculatorCategories(List<CalculatorCategory> categories) {
    return categories.map((category) {
      final metadata = _calculatorCategoryMetadata[category.id];
      if (metadata == null) return category;
      return category.copyWith(
        description: metadata.description,
        keywords: metadata.keywords,
      );
    }).toList(growable: false);
  }

  static List<QuizCategory> enrichQuizCategories(List<QuizCategory> categories) {
    return categories.map((category) {
      final metadata = _quizCategoryMetadata[category.id];
      if (metadata == null) return category;
      return category.copyWith(keywords: metadata.keywords);
    }).toList(growable: false);
  }

  static List<WiringCategory> enrichWiringCategories(List<WiringCategory> categories) {
    return categories.map((category) {
      final metadata = _wiringCategoryMetadata[category.id];
      if (metadata == null) return category;
      return category.copyWith(
        description: metadata.description,
        keywords: metadata.keywords,
      );
    }).toList(growable: false);
  }

  static List<TheoryArticle> enrichTheoryArticles(List<TheoryArticle> articles) {
    return articles.map((article) {
      // Full professional theory articles already carry complete metadata in
      // theory_content.dart. Preserve authored content and only fill gaps for
      // older Phase 1-style records that still have empty summary/keywords.
      if (article.summary.isNotEmpty && article.keywords.isNotEmpty) {
        return article.copyWith(
          languageCode: article.languageCode.isEmpty ? 'en' : article.languageCode,
          contentVersion: article.contentVersion,
        );
      }

      final metadata = _articleMetadata[article.id];
      if (metadata == null) return article;
      return article.copyWith(
        summary: article.summary.isNotEmpty ? article.summary : metadata.summary,
        languageCode: 'en',
        keywords: article.keywords.isNotEmpty ? article.keywords : metadata.keywords,
        relatedArticleIds: article.relatedArticleIds.isNotEmpty
            ? article.relatedArticleIds
            : metadata.relatedArticleIds,
        pecReferences: article.pecReferences.isNotEmpty
            ? article.pecReferences
            : metadata.pecReferences,
        formulas: article.formulas.isNotEmpty ? article.formulas : metadata.formulas,
        safetyNotes: article.safetyNotes.isNotEmpty ? article.safetyNotes : metadata.safetyNotes,
        commonMistakes: article.commonMistakes.isNotEmpty
            ? article.commonMistakes
            : metadata.commonMistakes,
        professionalTips: article.professionalTips.isNotEmpty
            ? article.professionalTips
            : metadata.professionalTips,
        lastReviewed: article.lastReviewed,
        contentVersion: article.contentVersion,
      );
    }).toList(growable: false);
  }

  static List<CalculatorModel> enrichCalculators(List<CalculatorModel> calculators) {
    return calculators.map((calculator) {
      final metadata = _calculatorMetadata[calculator.id] ?? _buildCalculatorFallbackMetadata(calculator);
      return calculator.copyWith(
        languageCode: 'en',
        tags: metadata.tags,
        keywords: metadata.keywords,
        standardsReferences: metadata.standardsReferences,
        safetyNotes: metadata.safetyNotes,
        professionalNotes: metadata.professionalNotes,
        relatedArticleIds: metadata.relatedArticleIds,
        accuracyNote: metadata.accuracyNote,
        supportsSavedCalculations: true,
        contentVersion: ContentQualityStandards.version,
      );
    }).toList(growable: false);
  }

  static _CalculatorMetadata _buildCalculatorFallbackMetadata(CalculatorModel calculator) {
    return _CalculatorMetadata(
      tags: [calculator.category, calculator.id.replaceAll('_', '-')],
      keywords: [
        calculator.name.toLowerCase(),
        calculator.description.toLowerCase(),
        calculator.formula.toLowerCase(),
        ...calculator.inputFields.map((field) => field.label.toLowerCase()),
        ...calculator.outputs.map((output) => output.label.toLowerCase()),
      ],
      relatedArticleIds: const [],
      professionalNotes: const [
        'Use this calculator for planning and education. Final installation decisions must be verified against current standards, site conditions, and manufacturer data.',
      ],
    );
  }

  static List<QuizQuestion> enrichQuizQuestions(List<QuizQuestion> questions) {
    return questions.map((question) {
      // Phase 2E quiz content is authored with complete metadata. Preserve it
      // instead of replacing question-specific tags, image assets, PEC notes,
      // and related article links with older category defaults.
      if (question.tags.isNotEmpty && question.keywords.isNotEmpty) {
        return question.copyWith(
          languageCode: 'en',
          contentVersion: question.contentVersion,
        );
      }

      final metadata = _quizMetadata[question.id] ?? _quizCategoryDefaults[question.category];
      if (metadata == null) return question;
      return question.copyWith(
        languageCode: 'en',
        relatedArticleId: metadata.relatedArticleId,
        pecReference: metadata.pecReference,
        tags: metadata.tags,
        keywords: [...metadata.keywords, question.category, question.difficulty],
        contentVersion: ContentQualityStandards.version,
      );
    }).toList(growable: false);
  }

  static List<WiringDiagram> enrichWiringDiagrams(List<WiringDiagram> diagrams) {
    return diagrams.map((diagram) {
      // Phase 2D diagrams already carry complete professional metadata in
      // wiring_content.dart. Preserve explicit metadata and only enrich older
      // Phase 1-style records that still have empty tags/keywords.
      if (diagram.tags.isNotEmpty && diagram.keywords.isNotEmpty) {
        return diagram.copyWith(
          languageCode: 'en',
          contentVersion: diagram.contentVersion,
        );
      }

      final metadata = _wiringMetadata[diagram.id];
      if (metadata == null) return diagram;
      return diagram.copyWith(
        difficulty: metadata.difficulty,
        languageCode: 'en',
        tags: metadata.tags,
        keywords: metadata.keywords,
        safetyWarnings: metadata.safetyWarnings,
        commonMistakes: metadata.commonMistakes,
        testingProcedure: metadata.testingProcedure,
        professionalNotes: metadata.professionalNotes,
        standardsReferences: metadata.standardsReferences,
        relatedDiagramIds: metadata.relatedDiagramIds,
        contentVersion: ContentQualityStandards.version,
      );
    }).toList(growable: false);
  }
}

class _CategoryMetadata {
  final String description;
  final List<String> keywords;
  const _CategoryMetadata(this.description, this.keywords);
}

class _ArticleMetadata {
  final String summary;
  final List<String> keywords;
  final List<String> relatedArticleIds;
  final List<String> pecReferences;
  final List<String> formulas;
  final List<String> safetyNotes;
  final List<String> commonMistakes;
  final List<String> professionalTips;

  const _ArticleMetadata({
    required this.summary,
    required this.keywords,
    required this.relatedArticleIds,
    this.pecReferences = const [],
    this.formulas = const [],
    this.safetyNotes = const [],
    this.commonMistakes = const [],
    this.professionalTips = const [],
  });
}

class _CalculatorMetadata {
  final List<String> tags;
  final List<String> keywords;
  final List<String> standardsReferences;
  final List<String> safetyNotes;
  final List<String> professionalNotes;
  final List<String> relatedArticleIds;
  final String accuracyNote;

  const _CalculatorMetadata({
    required this.tags,
    required this.keywords,
    required this.relatedArticleIds,
    this.standardsReferences = const ['Verify final design against PEC/IEC tables, manufacturer data, and local authority requirements.'],
    this.safetyNotes = const [ContentQualityStandards.universalSafetyDisclaimer],
    this.professionalNotes = const [],
    this.accuracyNote = 'Approximate engineering calculator. Use for planning/education, then verify with latest standards, site conditions, and manufacturer data.',
  });
}

class _QuizMetadata {
  final String? relatedArticleId;
  final String pecReference;
  final List<String> tags;
  final List<String> keywords;

  const _QuizMetadata({
    this.relatedArticleId,
    this.pecReference = '',
    this.tags = const [],
    this.keywords = const [],
  });
}

class _WiringMetadata {
  final String difficulty;
  final List<String> tags;
  final List<String> keywords;
  final List<String> safetyWarnings;
  final List<String> commonMistakes;
  final List<String> testingProcedure;
  final List<String> professionalNotes;
  final List<String> standardsReferences;
  final List<String> relatedDiagramIds;

  const _WiringMetadata({
    required this.difficulty,
    required this.tags,
    required this.keywords,
    required this.safetyWarnings,
    required this.commonMistakes,
    required this.testingProcedure,
    required this.professionalNotes,
    this.standardsReferences = const ['Educational reference only. Follow PEC/IEC and local DISCO requirements.'],
    this.relatedDiagramIds = const [],
  });
}

const Map<String, _CategoryMetadata> _theoryCategoryMetadata = {
  'basics': _CategoryMetadata('Foundational concepts every electrician must understand before calculations and installations.', ['voltage', 'current', 'resistance', 'power', 'units']),
  'circuits': _CategoryMetadata('Circuit laws, AC/DC behavior, phase relationships, and practical troubleshooting concepts.', ['series', 'parallel', 'AC', 'DC', 'Kirchhoff', 'RMS']),
  'power': _CategoryMetadata('Transformers, distribution, load planning, power factor, and protection concepts.', ['transformer', 'distribution', 'kVA', 'power factor']),
  'motors': _CategoryMetadata('Motor construction, operation, starters, protection, and industrial troubleshooting.', ['motor', 'starter', 'FLC', 'slip', 'overload']),
  'safety': _CategoryMetadata('Electrical safety practices, PPE, isolation, earthing, and code awareness.', ['PPE', 'LOTO', 'earthing', 'RCD', 'shock']),
  'renewable': _CategoryMetadata('Solar PV, battery, inverter, grid-tie, and modern renewable energy topics.', ['solar', 'PV', 'inverter', 'battery', 'net metering']),
};

const Map<String, _CategoryMetadata> _calculatorCategoryMetadata = {
  'basic': _CategoryMetadata('Core electrical formulas and quick field calculations.', ['ohms law', 'power', 'breaker', 'current']),
  'cable': _CategoryMetadata('Cable sizing, resistance, voltage drop, and conductor planning.', ['cable', 'conductor', 'voltage drop', 'ampacity']),
  'motor': _CategoryMetadata('Motor current, starter, protection, and drive calculations.', ['motor', 'FLC', 'starter', 'overload']),
  'power': _CategoryMetadata('Transformer, kVA, power factor, and distribution calculations.', ['transformer', 'kVA', 'power factor', 'load']),
  'renewable': _CategoryMetadata('Solar, lighting, battery, and energy-saving calculations.', ['solar', 'LED', 'battery', 'energy']),
};

const Map<String, _CategoryMetadata> _quizCategoryMetadata = {
  'basics': _CategoryMetadata('', ['voltage', 'current', 'resistance', 'ohms law']),
  'safety': _CategoryMetadata('', ['safety', 'PPE', 'RCD', 'earthing', 'LOTO']),
  'circuits': _CategoryMetadata('', ['AC', 'DC', 'three phase', 'motor', 'RMS']),
  'calculations': _CategoryMetadata('', ['formula', 'breaker', 'power', 'current']),
};

const Map<String, _CategoryMetadata> _wiringCategoryMetadata = {
  'switches': _CategoryMetadata('Lighting switch circuits with safe isolation, live, switched-live, neutral, and earth routing.', ['switch', 'light', 'traveller', 'switched live']),
  'sockets': _CategoryMetadata('Socket outlet circuits, polarity, earthing, and load protection.', ['socket', 'outlet', 'polarity', 'earth']),
  'motors': _CategoryMetadata('Motor starter wiring, contactors, overload relays, and control circuits.', ['DOL', 'star delta', 'contactor', 'overload']),
  'distribution': _CategoryMetadata('Distribution board layout, RCD/MCB protection, busbars, and circuit labeling.', ['DB', 'RCD', 'MCB', 'busbar', 'earth bar']),
};

const Map<String, _ArticleMetadata> _articleMetadata = {
  'basics_01': _ArticleMetadata(
    summary: 'A practical introduction to charge, current, voltage, resistance, AC, and DC.',
    keywords: ['electric charge', 'electron flow', '230V Pakistan', 'AC mains', 'DC battery'],
    relatedArticleIds: ['basics_02', 'circuits_02', 'basics_03'],
    formulas: ['I = Q / t', 'R = ρ × L / A', 'I = P / V'],
    safetyNotes: ['Household mains voltage can be lethal; never touch exposed conductors.'],
    commonMistakes: ['Confusing voltage with current.', 'Assuming low current circuits are always safe.'],
    professionalTips: ['Use correct symbols and units in field notes to avoid calculation mistakes.'],
  ),
  'basics_02': _ArticleMetadata(
    summary: 'Explains V = I × R with field examples and power relationships.',
    keywords: ['VIR triangle', 'resistor calculation', 'current calculation', 'resistance'],
    relatedArticleIds: ['basics_01', 'basics_03', 'circuits_01'],
    formulas: ['V = I × R', 'I = V / R', 'R = V / I', 'P = I² × R', 'P = V² / R'],
    safetyNotes: ['Do not use Ohm\'s Law alone for cable sizing or protection design.'],
    commonMistakes: ['Using Ohm\'s Law for non-linear devices without checking device behavior.'],
    professionalTips: ['Estimate current first, then verify conductor and breaker ratings from code tables.'],
  ),
  'basics_03': _ArticleMetadata(
    summary: 'Covers watts, kWh billing, power factor, and single/three-phase power formulas.',
    keywords: ['watts', 'kilowatt-hour', 'kWh bill', 'apparent power', 'reactive power'],
    relatedArticleIds: ['basics_02', 'power_01', 'circuits_02'],
    formulas: ['P = V × I', 'E = P × t', 'P = √3 × VL × IL × PF'],
    safetyNotes: ['High-power loads need verified circuit capacity and protection.'],
    commonMistakes: ['Ignoring power factor when sizing transformers and generators.'],
    professionalTips: ['Record load duty cycle; connected load and actual energy consumption are different.'],
  ),
  'circuits_01': _ArticleMetadata(
    summary: 'Series/parallel rules, Kirchhoff laws, and practical house wiring behavior.',
    keywords: ['series circuit', 'parallel circuit', 'KCL', 'KVL', 'branch current'],
    relatedArticleIds: ['basics_02', 'basics_03', 'circuits_02'],
    formulas: ['Rtotal(series) = R1 + R2 + R3', '1/Rtotal(parallel) = 1/R1 + 1/R2 + 1/R3'],
    safetyNotes: ['Parallel house circuits must still be protected by correctly rated breakers and cables.'],
    commonMistakes: ['Adding parallel resistances like series resistances.'],
    professionalTips: ['Use KCL at junctions to troubleshoot unexpected load currents.'],
  ),
  'circuits_02': _ArticleMetadata(
    summary: 'Compares AC and DC systems, RMS values, frequency, and three-phase advantages.',
    keywords: ['AC', 'DC', 'RMS', 'frequency 50Hz', 'three phase'],
    relatedArticleIds: ['basics_01', 'basics_03', 'motors_01'],
    formulas: ['Vrms = Vpeak / √2', 'T = 1 / f'],
    safetyNotes: ['AC mains peak voltage is higher than the RMS value shown on equipment labels.'],
    commonMistakes: ['Confusing 230V RMS with 230V peak.'],
    professionalTips: ['Check equipment frequency rating; Pakistan supply is 50Hz.'],
  ),
  'power_01': _ArticleMetadata(
    summary: 'Transformer principle, turns ratio, losses, sizing, cooling, and common tests.',
    keywords: ['transformer', 'turns ratio', 'kVA', 'ONAN', 'BDV test'],
    relatedArticleIds: ['basics_03', 'circuits_02', 'motors_01'],
    pecReferences: ['Use local utility/DISCO and applicable PEC requirements for transformer installation and earthing.'],
    formulas: ['V2 / V1 = N2 / N1', 'Transformer kVA = P / (1000 × PF)'],
    safetyNotes: ['Transformer work involves hazardous voltage and stored energy; qualified personnel only.'],
    commonMistakes: ['Sizing transformer on kW without considering power factor and future margin.'],
    professionalTips: ['Verify nameplate impedance, cooling class, and short-circuit duty before installation.'],
  ),
  'motors_01': _ArticleMetadata(
    summary: 'Induction motor operation, slip, starting methods, FLC formula, and protection.',
    keywords: ['induction motor', 'synchronous speed', 'slip', 'DOL', 'star delta'],
    relatedArticleIds: ['circuits_02', 'power_01', 'safety_01'],
    formulas: ['Ns = 120 × f / P', 'Slip = (Ns - Nr) / Ns', 'I = P × 746 / (√3 × V × η × PF)'],
    safetyNotes: ['Motor circuits require overload, short-circuit, earth fault, and isolation protection.'],
    commonMistakes: ['Replacing overload relays without setting them to motor nameplate current.'],
    professionalTips: ['Record motor nameplate data before selecting cable, breaker, starter, or VFD.'],
  ),
  'safety_01': _ArticleMetadata(
    summary: 'Golden rules for PPE, isolation, LOTO, earthing, fire response, and shock first aid.',
    keywords: ['electrical safety', 'LOTO', 'PPE', 'RCD', 'electric shock', 'earth resistance'],
    relatedArticleIds: ['basics_01', 'motors_01', 'renewable_01'],
    pecReferences: ['Always verify safety and inspection requirements with latest PEC and local authority guidance.'],
    formulas: [],
    safetyNotes: ['Always test your tester on a known live source before and after proving dead.'],
    commonMistakes: ['Skipping lockout/tagout after switching off a breaker.'],
    professionalTips: ['Make safety checks a written checklist, not a memory habit.'],
  ),
  'renewable_01': _ArticleMetadata(
    summary: 'Solar PV components, sizing steps, net metering, payback, and maintenance basics.',
    keywords: ['solar PV', 'panel sizing', 'inverter', 'net metering Pakistan', 'battery'],
    relatedArticleIds: ['basics_03', 'circuits_02', 'safety_01'],
    pecReferences: ['Verify net-metering and protection requirements with NEPRA, AEDB/Alternative Energy guidance, DISCO, and local authority rules.'],
    formulas: ['Array kWp = Daily kWh / (Sun Hours × Efficiency)', 'Panels = Array Wp / Panel Wp'],
    safetyNotes: ['PV strings can remain energized in daylight even when AC supply is off.'],
    commonMistakes: ['Ignoring shading, DC isolators, surge protection, and earthing in solar design.'],
    professionalTips: ['Design solar protection separately for DC and AC sides.'],
  ),
};

const Map<String, _CalculatorMetadata> _calculatorMetadata = {
  'ohms_law': _CalculatorMetadata(tags: ['ohms-law', 'basic', 'formula'], keywords: ['voltage current resistance power'], relatedArticleIds: ['basics_02'], professionalNotes: ['Best for resistive/linear loads.']),
  'power_calc': _CalculatorMetadata(tags: ['power', 'pf', 'VA', 'VAR'], keywords: ['real power apparent power reactive power'], relatedArticleIds: ['basics_03'], professionalNotes: ['For AC loads, confirm power factor from nameplate or meter.']),
  'voltage_drop': _CalculatorMetadata(tags: ['cable', 'voltage-drop'], keywords: ['cable length resistance voltage loss'], relatedArticleIds: ['circuits_01'], professionalNotes: ['Check both voltage drop and ampacity; passing one does not guarantee the other.']),
  'cable_size': _CalculatorMetadata(tags: ['cable', 'ampacity'], keywords: ['minimum conductor size copper cable'], relatedArticleIds: ['safety_01'], professionalNotes: ['Installation method, ambient temperature, grouping, and insulation type affect ampacity.']),
  'motor_flc': _CalculatorMetadata(tags: ['motor', 'FLC', 'three-phase'], keywords: ['full load current motor starter'], relatedArticleIds: ['motors_01'], professionalNotes: ['Use motor nameplate data where available.']),
  'transformer_size': _CalculatorMetadata(tags: ['transformer', 'kVA'], keywords: ['transformer sizing safety margin'], relatedArticleIds: ['power_01'], professionalNotes: ['Include future expansion, harmonics, and diversity where applicable.']),
  'solar_array': _CalculatorMetadata(tags: ['solar', 'PV', 'array'], keywords: ['solar panel count kWp sun hours'], relatedArticleIds: ['renewable_01'], professionalNotes: ['Use site-specific irradiation, shading, roof orientation, and inverter limits.']),
  'breaker_size': _CalculatorMetadata(tags: ['breaker', 'MCB', 'protection'], keywords: ['circuit breaker rating cable matching'], relatedArticleIds: ['safety_01'], professionalNotes: ['Breaker protects cable first; load protection may require separate device settings.']),
};

const Map<String, _QuizMetadata> _quizCategoryDefaults = {
  'basics': _QuizMetadata(relatedArticleId: 'basics_01', tags: ['basics'], keywords: ['fundamentals']),
  'safety': _QuizMetadata(relatedArticleId: 'safety_01', pecReference: 'Educational safety/code awareness; verify latest PEC/local authority rules.', tags: ['safety'], keywords: ['PPE', 'earthing', 'RCD']),
  'circuits': _QuizMetadata(relatedArticleId: 'circuits_02', tags: ['circuits'], keywords: ['AC', 'DC', 'three phase']),
  'calculations': _QuizMetadata(relatedArticleId: 'basics_03', tags: ['calculation'], keywords: ['formula', 'power', 'current']),
};

const Map<String, _QuizMetadata> _quizMetadata = {
  'q1': _QuizMetadata(relatedArticleId: 'basics_01', tags: ['units'], keywords: ['ohm resistance']),
  'q2': _QuizMetadata(relatedArticleId: 'basics_02', tags: ['ohms-law'], keywords: ['voltage current resistance']),
  'q3': _QuizMetadata(relatedArticleId: 'basics_01', tags: ['Pakistan'], keywords: ['230V 50Hz mains']),
  'q6': _QuizMetadata(relatedArticleId: 'basics_03', tags: ['power calculation'], keywords: ['P divided by V']),
  'q10': _QuizMetadata(relatedArticleId: 'circuits_02', tags: ['RMS'], keywords: ['peak voltage RMS']),
  'q14': _QuizMetadata(relatedArticleId: 'safety_01', pecReference: 'Educational earthing target reference; verify latest PEC/local authority requirements.', tags: ['earthing'], keywords: ['earth resistance']),
  'q16': _QuizMetadata(relatedArticleId: 'motors_01', tags: ['motor'], keywords: ['synchronous speed poles frequency']),
  'q19': _QuizMetadata(relatedArticleId: 'basics_03', tags: ['three-phase power'], keywords: ['sqrt 3 power factor']),
  'q20': _QuizMetadata(relatedArticleId: 'safety_01', tags: ['breaker sizing'], keywords: ['125 percent load breaker']),
};

const List<String> _standardWiringSafety = [
  ContentQualityStandards.universalSafetyDisclaimer,
  'Confirm conductor color coding, polarity, continuity, insulation resistance, and earth connection before energizing.',
];

const Map<String, _WiringMetadata> _wiringMetadata = {
  'sw_01': _WiringMetadata(
    difficulty: 'beginner',
    tags: ['switch', 'lighting'],
    keywords: ['single pole switch live neutral earth switched live'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Switching the neutral instead of the phase conductor.', 'Leaving earth disconnected at a metal fixture.'],
    testingProcedure: ['Verify switch interrupts phase conductor.', 'Test light operation and earth continuity.'],
    professionalNotes: ['Use brown/red for phase and a clearly identified switched-live conductor.'],
    relatedDiagramIds: ['sw_02', 'dist_01'],
  ),
  'sw_02': _WiringMetadata(
    difficulty: 'journeyman',
    tags: ['two-way', 'staircase', 'lighting'],
    keywords: ['two way switch staircase travellers common L1 L2'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Mixing common with traveller terminals.', 'Not sleeving/identifying switched-live conductors.'],
    testingProcedure: ['Operate both switches through all combinations.', 'Verify phase is switched, not neutral.'],
    professionalNotes: ['Label common and traveller wires before closing switch boxes.'],
    relatedDiagramIds: ['sw_01', 'sw_03'],
  ),
  'sw_03': _WiringMetadata(
    difficulty: 'journeyman',
    tags: ['intermediate', 'multi-way', 'lighting'],
    keywords: ['intermediate switch crossover three locations'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Reversing intermediate input/output pairs.', 'Using undersized or poorly identified traveller wiring.'],
    testingProcedure: ['Test switching from all three locations.', 'Check all terminals are tight.'],
    professionalNotes: ['Draw terminal mapping before connecting intermediate switches.'],
    relatedDiagramIds: ['sw_02'],
  ),
  'sock_01': _WiringMetadata(
    difficulty: 'beginner',
    tags: ['socket', 'outlet'],
    keywords: ['single socket outlet L N E polarity earth'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Reversed live/neutral polarity.', 'Loose terminal screws causing heating.'],
    testingProcedure: ['Use a socket tester for polarity and earth.', 'Check insulation resistance where required.'],
    professionalNotes: ['Use correct cable size and breaker rating for the socket load.'],
    relatedDiagramIds: ['sock_02', 'dist_01'],
  ),
  'sock_02': _WiringMetadata(
    difficulty: 'journeyman',
    tags: ['ring-main', 'socket'],
    keywords: ['ring circuit return cable socket radial'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Broken ring continuity hidden behind apparently working sockets.', 'Too many high-load appliances on one circuit.'],
    testingProcedure: ['Verify ring continuity end-to-end.', 'Test polarity and earth loop/continuity as applicable.'],
    professionalNotes: ['Radial circuits are common in many installations; choose topology according to local practice/code.'],
    relatedDiagramIds: ['sock_01', 'dist_01'],
  ),
  'motor_01': _WiringMetadata(
    difficulty: 'journeyman',
    tags: ['DOL', 'motor', 'contactor'],
    keywords: ['direct online starter overload relay start stop holding contact'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Omitting overload relay.', 'Wiring stop button as normally open instead of normally closed.'],
    testingProcedure: ['Test STOP opens control circuit.', 'Verify overload trip operation and motor rotation direction.'],
    professionalNotes: ['Set overload relay according to motor nameplate FLC.'],
    relatedDiagramIds: ['motor_02', 'dist_01'],
  ),
  'motor_02': _WiringMetadata(
    difficulty: 'master',
    tags: ['star-delta', 'motor', 'starter'],
    keywords: ['star delta timer interlock six terminal motor'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Allowing star and delta contactors to energize together.', 'Incorrect motor terminal bridging.'],
    testingProcedure: ['Verify electrical/mechanical interlocks.', 'Test transition timing with motor unloaded first.'],
    professionalNotes: ['Confirm motor is delta-rated for supply voltage before using star-delta starting.'],
    relatedDiagramIds: ['motor_01'],
  ),
  'dist_01': _WiringMetadata(
    difficulty: 'journeyman',
    tags: ['distribution-board', 'MCB', 'RCD'],
    keywords: ['single phase DB busbar neutral bar earth bar RCD MCB'],
    safetyWarnings: _standardWiringSafety,
    commonMistakes: ['Mixing neutrals across RCD groups.', 'Poor labeling of outgoing circuits.', 'Loose busbar connections.'],
    testingProcedure: ['Test RCD trip button and leakage trip where equipment is available.', 'Verify circuit labels and earth continuity.'],
    professionalNotes: ['Keep neutral and earth bars correctly separated except at approved bonding points.'],
    relatedDiagramIds: ['sw_01', 'sock_01', 'motor_01'],
  ),
};
