import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/database_service.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/quiz_model.dart';

class QuizPlayScreen extends StatefulWidget {
  final QuizCategory category;
  final List<QuizQuestion> questions;
  const QuizPlayScreen({super.key, required this.category, required this.questions});

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _hasAnswered = false;
  int _score = 0;
  int _timerSeconds = 0;
  Timer? _timer;
  final List<bool> _results = [];

  QuizQuestion get currentQuestion => widget.questions[_currentIndex];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _timerSeconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_hasAnswered) return;
    
    setState(() {
      _selectedAnswer = index;
      _hasAnswered = true;
      final isCorrect = index == currentQuestion.correctIndex;
      if (isCorrect) _score++;
      _results.add(isCorrect);
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _hasAnswered = false;
      });
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    _timer?.cancel();
    DatabaseService.saveQuizResult({
      'category_id': widget.category.id,
      'score': _score,
      'total_questions': widget.questions.length,
      'time_seconds': _timerSeconds,
    });

    // Natural break: interstitial after quiz complete (test ads).
    await AdService.instance.onQuizCompleted();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          score: _score,
          total: widget.questions.length,
          timeSeconds: _timerSeconds,
          category: widget.category,
          results: _results,
          questions: widget.questions,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / widget.questions.length;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedContent.quizCategoryName(context, widget.category)),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                _formatTime(_timerSeconds),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentPurple),
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Counter and difficulty
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${l10n.t('question')} ${_currentIndex + 1} ${l10n.t('of')} ${widget.questions.length}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentPurple.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          LocalizedContent.quizDifficulty(context, currentQuestion.difficulty),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.accentPurple),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Question
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Text(
                      LocalizedContent.quizQuestion(context, currentQuestion),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  if (currentQuestion.imageAsset != null) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          currentQuestion.imageAsset!,
                          fit: BoxFit.contain,
                          height: 220,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  // Options
                  ...LocalizedContent.quizOptions(context, currentQuestion).asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    return _OptionTile(
                      option: option,
                      index: index,
                      isSelected: _selectedAnswer == index,
                      isCorrect: index == currentQuestion.correctIndex,
                      hasAnswered: _hasAnswered,
                      onTap: () => _selectAnswer(index),
                    );
                  }),
                  const SizedBox(height: 24),
                  // Explanation
                  if (_hasAnswered) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedAnswer == currentQuestion.correctIndex
                            ? AppTheme.accentGreen.withOpacity(0.1)
                            : AppTheme.accentRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _selectedAnswer == currentQuestion.correctIndex
                              ? AppTheme.accentGreen.withOpacity(0.3)
                              : AppTheme.accentRed.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _selectedAnswer == currentQuestion.correctIndex
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: _selectedAnswer == currentQuestion.correctIndex
                                    ? AppTheme.accentGreen
                                    : AppTheme.accentRed,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedAnswer == currentQuestion.correctIndex
                                    ? l10n.t('correct')
                                    : l10n.t('incorrect'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _selectedAnswer == currentQuestion.correctIndex
                                      ? AppTheme.accentGreen
                                      : AppTheme.accentRed,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            LocalizedContent.quizExplanation(context, currentQuestion),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (currentQuestion.pecReference.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              '${l10n.t('referenceNote')}: ${currentQuestion.pecReference}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        child: Text(
                          _currentIndex < widget.questions.length - 1
                              ? l10n.t('nextQuestion')
                              : l10n.t('seeResults'),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    Color bgColor = Theme.of(context).cardTheme.color ?? Colors.white;
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    if (hasAnswered) {
      if (isCorrect) {
        borderColor = AppTheme.accentGreen;
        bgColor = AppTheme.accentGreen.withOpacity(0.1);
        textColor = AppTheme.accentGreen;
      } else if (isSelected && !isCorrect) {
        borderColor = AppTheme.accentRed;
        bgColor = AppTheme.accentRed.withOpacity(0.1);
        textColor = AppTheme.accentRed;
      }
    } else if (isSelected) {
      borderColor = AppTheme.accentPurple;
      bgColor = AppTheme.accentPurple.withOpacity(0.1);
      textColor = AppTheme.accentPurple;
    }

    return GestureDetector(
      onTap: hasAnswered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: hasAnswered && (isCorrect || isSelected) ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: hasAnswered
                    ? (isCorrect
                        ? AppTheme.accentGreen.withOpacity(0.2)
                        : isSelected
                            ? AppTheme.accentRed.withOpacity(0.2)
                            : isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9))
                    : isSelected
                        ? AppTheme.accentPurple.withOpacity(0.2)
                        : isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (hasAnswered && isCorrect)
              const Icon(Icons.check_circle, color: AppTheme.accentGreen),
            if (hasAnswered && isSelected && !isCorrect)
              const Icon(Icons.cancel, color: AppTheme.accentRed),
          ],
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final int timeSeconds;
  final QuizCategory category;
  final List<bool> results;
  final List<QuizQuestion> questions;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.timeSeconds,
    required this.category,
    required this.results,
    required this.questions,
  });

  double get percentage => (score / total) * 100;

  String _message(BuildContext context) {
    if (percentage >= 90) return UiText.t(context, 'Outstanding! You\'re a Master Electrician!');
    if (percentage >= 70) return UiText.t(context, 'Great job! Solid knowledge.');
    if (percentage >= 50) return UiText.t(context, 'Good effort! Keep studying.');
    return UiText.t(context, 'Keep practicing! Review the theory section.');
  }

  Color get _resultColor {
    if (percentage >= 70) return AppTheme.accentGreen;
    if (percentage >= 50) return AppTheme.accentOrange;
    return AppTheme.accentRed;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('quizResults')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: _resultColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: _resultColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(
                    percentage >= 70 ? Icons.emoji_events : Icons.school,
                    size: 56,
                    color: _resultColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$score / $total',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: _resultColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _message(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Stats
            Row(
              children: [
                _StatCard(
                  label: UiText.t(context, 'Time'),
                  value: '${timeSeconds ~/ 60}m ${timeSeconds % 60}s',
                  icon: Icons.timer,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: AppLocalizations.of(context).t('correct').replaceAll('!', ''),
                  value: '$score',
                  icon: Icons.check_circle,
                  color: AppTheme.accentGreen,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: UiText.t(context, 'Wrong'),
                  value: '${total - score}',
                  icon: Icons.cancel,
                  color: AppTheme.accentRed,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Question Review
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).t('questionReview'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),
            ...questions.asMap().entries.map((entry) {
              final idx = entry.key;
              final q = entry.value;
              final correct = results[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: correct ? AppTheme.accentGreen.withOpacity(0.3) : AppTheme.accentRed.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      correct ? Icons.check_circle : Icons.cancel,
                      color: correct ? AppTheme.accentGreen : AppTheme.accentRed,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        LocalizedContent.quizQuestion(context, q),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context).t('backToQuiz')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizPlayScreen(
                            category: category,
                            questions: List.of(questions)..shuffle(),
                          ),
                        ),
                      );
                    },
                    child: Text(AppLocalizations.of(context).t('retry')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Opt-in rewarded: free quiz retry without forcing users.
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final nav = Navigator.of(context);
                  final category = this.category;
                  final questions = this.questions;

                  final earned = await AdService.instance.watchAdForQuizRetry(
                    onEarned: () {},
                  );
                  if (!context.mounted) return;

                  if (!earned) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          UiText.t(
                            context,
                            'Rewarded ad is not ready yet. Please try again in a moment.',
                          ),
                        ),
                      ),
                    );
                    return;
                  }

                  final fresh = List<QuizQuestion>.from(questions)..shuffle();
                  nav.pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayScreen(
                        category: category,
                        questions: fresh.isNotEmpty
                            ? fresh
                            : AppRepository.quizQuestions
                                .where((q) => q.category == category.id)
                                .toList(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.ondemand_video_outlined, size: 18),
                label: Text(UiText.t(context, 'Watch Ad to Retry Free')),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color ?? const Color(0xFF94A3B8), size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
