import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_simulator_app/data/content/content_quality.dart';
import 'package:electrician_simulator_app/data/content/search/search_index.dart';
import 'package:electrician_simulator_app/data/repositories/app_repository.dart';

void main() {
  test('bundled content passes Phase 2A.2 validation', () {
    final report = AppRepository.validateContent();
    expect(report.errors, isEmpty, reason: report.issues.join('\n'));
  });

  test('Phase 1 content is enriched with Phase 2 metadata', () {
    expect(AppRepository.contentQualityVersion, ContentQualityStandards.version);
    expect(AppRepository.theoryArticles.every((article) => article.summary.isNotEmpty), isTrue);
    expect(AppRepository.theoryArticles.every((article) => article.keywords.isNotEmpty), isTrue);
    expect(AppRepository.calculators.every((calculator) => calculator.accuracyNote.isNotEmpty), isTrue);
    expect(AppRepository.calculators.every((calculator) => calculator.professionalNotes.isNotEmpty), isTrue);
    expect(AppRepository.wiringDiagrams.every((diagram) => diagram.testingProcedure.isNotEmpty), isTrue);
  });

  test('search index covers all bundled content types', () {
    final index = AppRepository.searchIndex;
    expect(
      index.length,
      AppRepository.theoryArticles.length +
          AppRepository.calculators.length +
          AppRepository.wiringDiagrams.length +
          AppRepository.quizQuestions.length +
          AppRepository.pakistanStandards.length +
          AppRepository.tutorialVideos.length,
    );

    expect(index.any((entry) => entry.type == SearchContentType.theory), isTrue);
    expect(index.any((entry) => entry.type == SearchContentType.calculator), isTrue);
    expect(index.any((entry) => entry.type == SearchContentType.wiring), isTrue);
    expect(index.any((entry) => entry.type == SearchContentType.quiz), isTrue);
    expect(index.any((entry) => entry.type == SearchContentType.standards), isTrue);
    expect(index.any((entry) => entry.type == SearchContentType.video), isTrue);

    expect(SearchIndexBuilder.search(index, 'transformer'), isNotEmpty);
    expect(SearchIndexBuilder.search(index, 'EV charging'), isNotEmpty);
    expect(SearchIndexBuilder.search(index, 'K-Electric'), isNotEmpty);
    expect(SearchIndexBuilder.search(index, 'YouTube'), isNotEmpty);
  });

  test('Phase 2B Theory Academy expansion has 50 plus articles and accurate category counts', () {
    expect(AppRepository.theoryArticles.length, greaterThanOrEqualTo(50));
    expect(AppRepository.theoryCategories.any((category) => category.id == 'components'), isTrue);
    expect(AppRepository.theoryCategories.any((category) => category.id == 'modern'), isTrue);

    for (final category in AppRepository.theoryCategories) {
      final actualCount = AppRepository.theoryArticles.where((article) => article.category == category.id).length;
      expect(category.articleCount, actualCount, reason: 'Category ${category.id} article count mismatch');
    }
  });

  test('Phase 2C calculator expansion has 20 plus calculators with metadata', () {
    expect(AppRepository.calculators.length, greaterThanOrEqualTo(20));
    expect(AppRepository.calculators.every((calculator) => calculator.inputFields.isNotEmpty), isTrue);
    expect(AppRepository.calculators.every((calculator) => calculator.outputs.isNotEmpty), isTrue);
    expect(AppRepository.calculators.every((calculator) => calculator.formula.isNotEmpty), isTrue);
    expect(AppRepository.calculators.every((calculator) => calculator.safetyNotes.isNotEmpty), isTrue);
    expect(AppRepository.calculators.any((calculator) => calculator.id == 'conduit_fill'), isTrue);
    expect(AppRepository.calculators.any((calculator) => calculator.id == 'battery_bank'), isTrue);
    expect(AppRepository.calculators.any((calculator) => calculator.id == 'harmonics_thd'), isTrue);
  });

  test('Phase 2D wiring expansion has 25 plus offline SVG diagrams and accurate category counts', () {
    expect(AppRepository.wiringDiagrams.length, greaterThanOrEqualTo(20));
    
    
    expect(AppRepository.wiringCategories.any((category) => category.id == 'smart'), isTrue);

    for (final category in AppRepository.wiringCategories) {
      final actualCount = AppRepository.wiringDiagrams.where((diagram) => diagram.category == category.id).length;
      expect(category.diagramCount, actualCount, reason: 'Category ${category.id} diagram count mismatch');
    }

    for (final diagram in AppRepository.wiringDiagrams) {
      expect(diagram.svgPath, isNotNull, reason: '${diagram.id} must have an offline SVG path');
      expect(File(diagram.svgPath!).existsSync(), isTrue, reason: '${diagram.svgPath} must exist');
      expect(diagram.safetyWarnings, isNotEmpty);
      expect(diagram.testingProcedure, isNotEmpty);
      expect(diagram.commonMistakes, isNotEmpty);
      expect(diagram.professionalNotes, isNotEmpty);
    }
  });

  test('Phase 2H video tutorials are functional placeholders with valid links and category counts', () {
    expect(AppRepository.tutorialVideos.length, greaterThanOrEqualTo(20));
    expect(AppRepository.videoCategories.length, greaterThanOrEqualTo(5));

    for (final category in AppRepository.videoCategories) {
      final actualCount = AppRepository.tutorialVideos.where((video) => video.category == category.id).length;
      expect(category.videoCount, actualCount, reason: 'Category ${category.id} video count mismatch');
    }

    for (final video in AppRepository.tutorialVideos) {
      expect(video.title, isNotEmpty);
      expect(video.description, isNotEmpty);
      expect(video.youtubeUrl.startsWith('https://www.youtube.com/') || video.youtubeUrl.startsWith('https://youtu.be/'), isTrue);
      expect(video.tags, isNotEmpty);
      expect(video.keywords, isNotEmpty);
    }
  });

  test('Phase 2F Standards and Codes integration has global and local references', () {
    expect(AppRepository.pakistanStandards.length, greaterThanOrEqualTo(15));

    expect(AppRepository.pakistanStandardCategories.any((category) => category.id == 'iec'), isTrue);
    expect(AppRepository.pakistanStandardCategories.any((category) => category.id == 'nec'), isTrue);
    expect(AppRepository.pakistanStandardCategories.any((category) => category.id == 'bs7671'), isTrue);
    expect(AppRepository.pakistanStandardCategories.any((category) => category.id == 'pakistan'), isTrue);
    expect(AppRepository.pakistanStandardCategories.any((category) => category.id == 'solar_ev'), isTrue);

    for (final category in AppRepository.pakistanStandardCategories) {
      final actualCount = AppRepository.pakistanStandards.where((standard) => standard.category == category.id).length;
      expect(category.standardCount, actualCount, reason: 'Category ${category.id} standard count mismatch');
    }

    for (final standard in AppRepository.pakistanStandards) {
      expect(standard.disclaimer, contains('Educational reference only'));
      expect(standard.keyPoints, isNotEmpty);
      expect(standard.fieldChecklist, isNotEmpty);
      expect(standard.warnings, isNotEmpty);
      expect(standard.tags, isNotEmpty);
      expect(standard.keywords, isNotEmpty);
    }
  });

  test('Phase 2E quiz bank expansion has 100 plus questions with accurate categories and image assets', () {
    expect(AppRepository.quizQuestions.length, greaterThanOrEqualTo(100));
    expect(AppRepository.quizCategories.length, greaterThanOrEqualTo(8));
    expect(AppRepository.quizCategories.any((category) => category.id == 'motors'), isTrue);
    expect(AppRepository.quizCategories.any((category) => category.id == 'solar'), isTrue);
    expect(AppRepository.quizCategories.any((category) => category.id == 'standards'), isTrue);
    expect(AppRepository.quizCategories.any((category) => category.id == 'master'), isTrue);

    for (final category in AppRepository.quizCategories) {
      final actualCount = AppRepository.quizQuestions.where((question) => question.category == category.id).length;
      expect(category.totalQuestions, actualCount, reason: 'Category ${category.id} question count mismatch');
    }

    expect(AppRepository.quizQuestions.where((question) => question.difficulty == 'master').length, greaterThanOrEqualTo(15));
    expect(AppRepository.quizQuestions.where((question) => question.imageAsset != null).length, greaterThanOrEqualTo(5));

    for (final question in AppRepository.quizQuestions) {
      expect(question.options.length, greaterThanOrEqualTo(2));
      expect(question.correctIndex, inInclusiveRange(0, question.options.length - 1));
      expect(question.explanation, isNotEmpty);
      expect(question.tags, isNotEmpty);
      expect(question.keywords, isNotEmpty);

      if (question.imageAsset != null) {
        expect(File(question.imageAsset!).existsSync(), isTrue, reason: '${question.imageAsset} must exist');
      }
    }
  });
}