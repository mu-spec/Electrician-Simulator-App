import 'package:flutter_test/flutter_test.dart';

import '../lib/data/content/quiz_content.dart';
import '../lib/models/quiz_model.dart';

void main() {
  final questions = QuizContent.quizQuestions;

  test('production quiz bank has 200 unique, structurally valid questions', () {
    expect(questions, hasLength(200));
    expect(questions.map((question) => question.id).toSet(), hasLength(200));
    expect(
        questions.map((question) => question.question).toSet(), hasLength(200));

    for (final question in questions) {
      expect(question.options, hasLength(4), reason: question.id);
      expect(question.options.toSet(), hasLength(4), reason: question.id);
      expect(question.correctIndex, inInclusiveRange(0, 3),
          reason: question.id);
      expect(question.question.trim().endsWith('?'), isTrue,
          reason: question.id);
      expect(question.explanation.trim().length, greaterThanOrEqualTo(15),
          reason: question.id);
    }
  });

  test('each category has 25 questions and balanced answer positions', () {
    const categories = <String>{
      'basics',
      'safety',
      'circuits',
      'calculations',
      'motors',
      'solar',
      'standards',
      'master',
    };

    final globalPositions = List<int>.filled(4, 0);
    for (final category in categories) {
      final items = questions
          .where((question) => question.category == category)
          .toList()
        ..sort((left, right) => left.id.compareTo(right.id));
      expect(items, hasLength(25), reason: category);

      final positions = List<int>.filled(4, 0);
      for (var index = 0; index < items.length; index++) {
        final answerPosition = items[index].correctIndex;
        positions[answerPosition]++;
        globalPositions[answerPosition]++;
        if (index > 0) {
          expect(
            answerPosition,
            isNot(items[index - 1].correctIndex),
            reason: '$category: ${items[index - 1].id}/${items[index].id}',
          );
        }
      }
      expect(
          positions.reduce((a, b) => a > b ? a : b) -
              positions.reduce((a, b) => a < b ? a : b),
          lessThanOrEqualTo(1),
          reason: category);
    }

    expect(globalPositions, const [50, 50, 50, 50]);
  });

  test('demo templates and repeated option sets are absent', () {
    const banned = <String>{
      'basic electrical field question',
      'which practice is most correct for',
      'guess from cable color only',
      'bypass protection to finish faster',
      'ignore documentation and testing',
      'all planets',
    };

    final optionSets = <String>{};
    for (final question in questions) {
      final combined = <String>[
        question.question,
        ...question.options,
        question.explanation,
      ].join(' ').toLowerCase();
      for (final phrase in banned) {
        expect(combined.contains(phrase), isFalse, reason: question.id);
      }
      final normalizedOptions = [...question.options]..sort();
      expect(optionSets.add(normalizedOptions.join('\u0000')), isTrue,
          reason: question.id);
    }
  });

  test('reviewed numerical and technical answer keys are correct', () {
    final byId = <String, QuizQuestion>{
      for (final question in questions) question.id: question,
    };

    expect(byId['q009']!.options[byId['q009']!.correctIndex], '20 V');
    expect(byId['q049']!.options[byId['q049']!.correctIndex], '12.5 kVA');
    expect(byId['q050']!.options[byId['q050']!.correctIndex], '8.89 V');
    expect(byId['q057']!.options[byId['q057']!.correctIndex], '1150 A');
    expect(byId['q066']!.options[byId['q066']!.correctIndex], '1500 rpm');
    expect(byId['q129']!.options[byId['q129']!.correctIndex], '325 V');
    expect(byId['q142']!.options[byId['q142']!.correctIndex], '5 A');
    expect(byId['q149']!.options[byId['q149']!.correctIndex], '2 Ω');
    expect(byId['q153']!.options[byId['q153']!.correctIndex], '18 A');
    expect(byId['q154']!.options[byId['q154']!.correctIndex], '3.5%');
    expect(byId['q155']!.options[byId['q155']!.correctIndex], '3 Ω');
    expect(byId['q156']!.options[byId['q156']!.correctIndex], '4.8 kWh');
    expect(byId['q157']!.options[byId['q157']!.correctIndex], '10 panels');
    expect(byId['q158']!.options[byId['q158']!.correctIndex], '20 A');
    expect(byId['q159']!.options[byId['q159']!.correctIndex], '20 A');
    expect(byId['q160']!.options[byId['q160']!.correctIndex], '200 J');
    expect(byId['q161']!.options[byId['q161']!.correctIndex], '3.3%');
  });
}
