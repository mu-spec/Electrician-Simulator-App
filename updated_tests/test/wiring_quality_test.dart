import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../lib/data/content/wiring_content.dart';
import '../lib/models/wiring_diagram.dart';

void main() {
  final diagrams = WiringContent.wiringDiagrams;

  test('production wiring library contains 20 complete concept diagrams', () {
    expect(diagrams, hasLength(20));
    expect(diagrams.map((diagram) => diagram.id).toSet(), hasLength(20));
    expect(diagrams.map((diagram) => diagram.title).toSet(), hasLength(20));

    const expectedCategories = <String, int>{
      'residential': 11,
      'distribution': 9,
      'motors': 8,
      'solar': 8,
      'generator': 7,
      'smart': 7,
    };
    for (final entry in expectedCategories.entries) {
      expect(
        diagrams.where((diagram) => diagram.category == entry.key),
        hasLength(entry.value),
        reason: entry.key,
      );
    }

    for (final diagram in diagrams) {
      expect(diagram.svgPath, isNotNull, reason: diagram.id);
      expect(File(diagram.svgPath!).existsSync(), isTrue, reason: diagram.id);
      expect(diagram.steps.length, inInclusiveRange(5, 9), reason: diagram.id);
      expect(diagram.components.length, greaterThanOrEqualTo(3),
          reason: diagram.id);
      expect(diagram.components.toSet(), hasLength(diagram.components.length),
          reason: diagram.id);
      expect(diagram.safetyWarnings, isNotEmpty, reason: diagram.id);
      expect(diagram.commonMistakes, isNotEmpty, reason: diagram.id);
      expect(diagram.testingProcedure, isNotEmpty, reason: diagram.id);
      expect(diagram.professionalNotes, isNotEmpty, reason: diagram.id);
      expect(diagram.standardsReferences, isNotEmpty, reason: diagram.id);
      expect(diagram.contentVersion, '2.1.0-production-wiring-audit',
          reason: diagram.id);
    }
  });

  test('generated image-prompt contamination is absent', () {
    const banned = <String>[
      'refer to ultra-realistic png',
      'as in png',
      'thermal overload relay tor with dial',
      'red arrow marked live',
      'blue arrow to neutral bar',
      'green-yellow striped top left',
    ];

    for (final diagram in diagrams) {
      final content = <String>[
        diagram.title,
        diagram.description,
        ...diagram.steps,
        ...diagram.components,
        ...diagram.safetyWarnings,
        ...diagram.commonMistakes,
        ...diagram.testingProcedure,
        ...diagram.professionalNotes,
      ].join(' ').toLowerCase();
      for (final phrase in banned) {
        expect(content.contains(phrase), isFalse,
            reason: '${diagram.id}: $phrase');
      }
    }
  });


}
