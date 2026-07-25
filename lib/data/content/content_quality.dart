/// Phase 2A.2 production content rules and reusable templates.
///
/// These constants make later content expansion consistent. They are used by
/// validation/tests and can also be used by future admin/import tooling.
class ContentQualityStandards {
  static const String version = '2.0.0-phase2i';
  static const String lastUpdated = '2026-07-10';

  static const List<String> supportedLanguages = ['en', 'ur', 'hi', 'ar', 'es', 'pt', 'fr', 'de', 'ru', 'zh', 'tr', 'id', 'bn', 'fa', 'ms'];
  static const List<String> articleDifficulties = ['beginner', 'journeyman', 'master'];
  static const List<String> quizDifficulties = ['easy', 'medium', 'hard', 'beginner', 'journeyman', 'master'];
  static const List<String> wiringDifficulties = ['beginner', 'journeyman', 'master'];

  static const String universalSafetyDisclaimer =
      'Educational reference only. Always isolate supply, verify zero energy, use proper PPE, and follow the latest PEC/IEC/local DISCO requirements.';

  static const List<String> requiredArticleSections = [
    'Introduction or overview',
    'Practical explanation',
    'Formula or technical note where applicable',
    'Safety notes where applicable',
    'Common mistakes',
    'Professional tips',
    'Related content links',
  ];

  static const List<String> requiredCalculatorSections = [
    'Inputs with units',
    'Validation rules',
    'Formula explanation',
    'Result outputs',
    'Accuracy/code warning',
    'Professional notes',
  ];

  static const List<String> requiredWiringSections = [
    'Required components',
    'Step-by-step wiring procedure',
    'Safety warning',
    'Common mistakes',
    'Testing procedure',
    'Professional notes',
  ];
}

class ContentTemplates {
  static const String theoryArticleTemplate = """
TheoryArticle(
  id: 'category_XX',
  title: 'Article Title',
  category: 'basics|components|circuits|power|motors|safety|renewable|modern',
  summary: 'One-sentence practical summary for cards/search.',
  difficulty: 'beginner|journeyman|master',
  readTimeMinutes: 6,
  tags: ['tag-one', 'tag-two'],
  keywords: ['search term', 'local term'],
  relatedArticleIds: ['basics_01'],
  pecReferences: ['Educational PEC/local authority reference note'],
  formulas: ['V = I × R'],
  safetyNotes: ['Safety instruction relevant to this topic'],
  commonMistakes: ['Common field mistake'],
  professionalTips: ['Professional field tip'],
  content: '''## Introduction\n...''',
)
""";

  static const String calculatorTemplate = """
CalculatorModel(
  id: 'calculator_id',
  name: 'Calculator Name',
  description: 'What it calculates',
  category: 'basic|cable|motor|power|renewable',
  iconName: 'calculate',
  colorHex: '#2563EB',
  inputFields: [CalculatorField(id: 'input', label: 'Input', unit: 'V', hint: 'Enter value')],
  outputs: [CalculatorOutput(id: 'output', label: 'Output', unit: 'A', description: 'Result meaning')],
  formula: 'Formula shown to the user',
  tags: ['tag'],
  keywords: ['search term'],
  standardsReferences: ['PEC/IEC educational reference note'],
  safetyNotes: ['Do not use calculator result without code/manufacturer verification'],
  professionalNotes: ['Field note'],
)
""";

  static const String wiringDiagramTemplate = """
WiringDiagram(
  id: 'diagram_id',
  title: 'Diagram Title',
  category: 'residential|distribution|motors|solar|generator|smart',
  difficulty: 'beginner|journeyman|master',
  description: 'Short user-facing description',
  components: ['Component 1'],
  steps: ['Step 1'],
  safetyWarnings: ['Isolate supply and verify zero energy'],
  commonMistakes: ['Common mistake'],
  testingProcedure: ['Test step'],
  professionalNotes: ['Field note'],
  standardsReferences: ['PEC/IEC educational reference note'],
)
""";
}
