import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/quiz_model.dart';
import 'quiz_play_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('quizPractice')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.accentPurple, Color(0xFFA78BFA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.t('testYourKnowledge'),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${UiText.digits(context, '${AppRepository.quizQuestions.length}')} ${l10n.t('questions')} • ${UiText.digits(context, '${AppRepository.quizCategories.length}')} ${UiText.t(context, 'categories')}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.emoji_events, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.t('selectCategory'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            ...AppRepository.quizCategories.map((category) {
              final questions = AppRepository.quizQuestions
                  .where((q) => q.category == category.id)
                  .toList();
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPlayScreen(
                      category: category,
                      questions: questions,
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(int.parse(category.colorHex.replaceFirst('#', '0xFF'))).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _getIconData(category.iconName),
                          color: Color(int.parse(category.colorHex.replaceFirst('#', '0xFF'))),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedContent.quizCategoryName(context, category),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              LocalizedContent.quizCategoryDescription(context, category),
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.help_outline, size: 14, color: Theme.of(context).textTheme.bodySmall?.color),
                                const SizedBox(width: 4),
                                Text(
                                  '${category.totalQuestions} ${l10n.t('questions')}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF94A3B8)),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            // Quick Random Quiz
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final allQuestions = List.of(AppRepository.quizQuestions)..shuffle();
                  final category = QuizCategory(
                    id: 'random',
                    name: UiText.t(context, 'Random Mix'),
                    description: UiText.t(context, 'Questions from all categories'),
                    iconName: 'shuffle',
                    colorHex: '#EF4444',
                    totalQuestions: 10,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizPlayScreen(
                        category: category,
                        questions: allQuestions.take(10).toList(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.shuffle),
                label: Text(l10n.t('startRandomQuiz')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'bolt': return Icons.bolt;
      case 'shield': return Icons.shield;
      case 'electrical_services': return Icons.electrical_services;
      case 'calculate': return Icons.calculate;
      case 'settings': return Icons.settings;
      case 'wb_sunny': return Icons.wb_sunny;
      case 'gavel': return Icons.gavel;
      case 'workspace_premium': return Icons.workspace_premium;
      case 'shuffle': return Icons.shuffle;
      default: return Icons.quiz;
    }
  }
}
