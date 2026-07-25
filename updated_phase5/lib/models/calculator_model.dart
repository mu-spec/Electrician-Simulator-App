class CalculatorModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String iconName;
  final String colorHex;
  final List<CalculatorField> inputFields;
  final List<CalculatorOutput> outputs;
  final String formula;

  // Phase 2A metadata for validation, search, localization, and standards.
  final String languageCode;
  final List<String> tags;
  final List<String> keywords;
  final List<String> standardsReferences;
  final List<String> safetyNotes;
  final List<String> professionalNotes;
  final List<String> relatedArticleIds;
  final String accuracyNote;
  final bool supportsSavedCalculations;
  final String contentVersion;

  const CalculatorModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.iconName,
    required this.colorHex,
    required this.inputFields,
    required this.outputs,
    required this.formula,
    this.languageCode = 'en',
    this.tags = const [],
    this.keywords = const [],
    this.standardsReferences = const [],
    this.safetyNotes = const [],
    this.professionalNotes = const [],
    this.relatedArticleIds = const [],
    this.accuracyNote = 'PRELIMINARY ESTIMATE ONLY: This tool uses simplified mathematical models and does not account for complex real-world variables (e.g., thermal insulation, conductor material, grouping factors, specific local codes). Results are conceptual estimates and MUST NOT be used for final installation, purchasing, or safety certification. Always verify with full standard tables (NEC/IEC/PEC) and a licensed professional.',
    this.supportsSavedCalculations = true,
    this.contentVersion = '2.0.0-phase2a',
  });

  String get searchableText => [
        id,
        name,
        description,
        category,
        formula,
        ...tags,
        ...keywords,
        ...standardsReferences,
        ...inputFields.map((field) => '${field.label} ${field.unit} ${field.hint}'),
        ...outputs.map((output) => '${output.label} ${output.unit} ${output.description}'),
      ].join(' ').toLowerCase();

  CalculatorModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? iconName,
    String? colorHex,
    List<CalculatorField>? inputFields,
    List<CalculatorOutput>? outputs,
    String? formula,
    String? languageCode,
    List<String>? tags,
    List<String>? keywords,
    List<String>? standardsReferences,
    List<String>? safetyNotes,
    List<String>? professionalNotes,
    List<String>? relatedArticleIds,
    String? accuracyNote,
    bool? supportsSavedCalculations,
    String? contentVersion,
  }) {
    return CalculatorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      inputFields: inputFields ?? this.inputFields,
      outputs: outputs ?? this.outputs,
      formula: formula ?? this.formula,
      languageCode: languageCode ?? this.languageCode,
      tags: tags ?? this.tags,
      keywords: keywords ?? this.keywords,
      standardsReferences: standardsReferences ?? this.standardsReferences,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      professionalNotes: professionalNotes ?? this.professionalNotes,
      relatedArticleIds: relatedArticleIds ?? this.relatedArticleIds,
      accuracyNote: accuracyNote ?? this.accuracyNote,
      supportsSavedCalculations: supportsSavedCalculations ?? this.supportsSavedCalculations,
      contentVersion: contentVersion ?? this.contentVersion,
    );
  }
}

class CalculatorField {
  final String id;
  final String label;
  final String unit;
  final String hint;
  final FieldType type;
  final double? minValue;
  final double? maxValue;
  final bool isRequired;
  final List<String> options;
  final String validationMessage;

  const CalculatorField({
    required this.id,
    required this.label,
    required this.unit,
    required this.hint,
    this.type = FieldType.number,
    this.minValue,
    this.maxValue,
    this.isRequired = true,
    this.options = const [],
    this.validationMessage = '',
  });
}

class CalculatorOutput {
  final String id;
  final String label;
  final String unit;
  final String description;
  final int precision;

  const CalculatorOutput({
    required this.id,
    required this.label,
    required this.unit,
    required this.description,
    this.precision = 2,
  });
}

enum FieldType { number, dropdown, toggle }

class CalculatorCategory {
  final String id;
  final String name;
  final String iconName;
  final String colorHex;
  final String description;
  final List<String> keywords;

  const CalculatorCategory({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    this.description = '',
    this.keywords = const [],
  });

  CalculatorCategory copyWith({
    String? id,
    String? name,
    String? iconName,
    String? colorHex,
    String? description,
    List<String>? keywords,
  }) {
    return CalculatorCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
    );
  }
}
