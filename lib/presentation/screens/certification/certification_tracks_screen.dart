import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';
import '../../../core/localization/localized_content.dart';
import '../../../data/database_service.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/certification_track.dart';
import '../../../models/quiz_model.dart';
import '../calculators/calculator_detail_screen.dart';
import '../quiz/quiz_play_screen.dart';
import '../theory/article_detail_screen.dart';
import '../wiring/diagram_detail_screen.dart';

class CertificationTracksScreen extends StatefulWidget {
  const CertificationTracksScreen({super.key});

  @override
  State<CertificationTracksScreen> createState() =>
      _CertificationTracksScreenState();
}

class _CertificationTracksScreenState extends State<CertificationTracksScreen> {
  late Future<Map<String, CertificationProgress>> _progressFuture;

  @override
  void initState() {
    super.initState();
    _progressFuture = DatabaseService.getCertificationProgressMap();
  }

  Future<void> _reload() async {
    setState(
      () => _progressFuture = DatabaseService.getCertificationProgressMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Certification Tracks'))),
      body: FutureBuilder<Map<String, CertificationProgress>>(
        future: _progressFuture,
        builder: (context, snapshot) {
          final progress =
              snapshot.data ?? const <String, CertificationProgress>{};
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _HeaderCard(isDark: isDark),
                const SizedBox(height: 18),
                ...AppRepository.certificationTracks.map(
                  (track) => _TrackCard(
                    track: track,
                    progress:
                        progress[track.id] ??
                        CertificationProgress(trackId: track.id),
                    isDark: isDark,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CertificationTrackDetailScreen(track: track),
                        ),
                      );
                      _reload();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CertificationTrackDetailScreen extends StatefulWidget {
  final CertificationTrack track;
  const CertificationTrackDetailScreen({super.key, required this.track});

  @override
  State<CertificationTrackDetailScreen> createState() =>
      _CertificationTrackDetailScreenState();
}

class _CertificationTrackDetailScreenState
    extends State<CertificationTrackDetailScreen> {
  late Future<CertificationProgress> _progressFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _progressFuture = DatabaseService.getCertificationProgress(widget.track.id);
  }

  List<QuizQuestion> get _trackQuestions {
    return AppRepository.quizQuestions
        .where((q) => widget.track.quizCategoryIds.contains(q.category))
        .toList()
      ..shuffle();
  }

  Future<void> _startTrackQuiz() async {
    final questions = _trackQuestions.take(25).toList();
    final category = QuizCategory(
      id: 'cert_${widget.track.id}',
      name: widget.track.title,
      description: widget.track.subtitle,
      iconName: widget.track.iconName,
      colorHex: widget.track.colorHex,
      totalQuestions: questions.length,
    );
    await DatabaseService.incrementCertificationAttempt(widget.track.id);
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            QuizPlayScreen(category: category, questions: questions),
      ),
    );
    _reload();
  }

  Future<void> _toggleModule(String moduleId, bool done) async {
    await DatabaseService.setCertificationModuleCompleted(
      widget.track.id,
      moduleId,
      done,
    );
    if (mounted) setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(widget.track.colorHex.replaceFirst('#', '0xFF')),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedContent.text(context, widget.track.title)),
      ),
      body: FutureBuilder<CertificationProgress>(
        future: _progressFuture,
        builder: (context, snapshot) {
          final progress =
              snapshot.data ?? CertificationProgress(trackId: widget.track.id);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _DetailHeader(
                track: widget.track,
                progress: progress,
                color: color,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startTrackQuiz,
                  icon: const Icon(Icons.quiz),
                  label: Text(
                    UiText.t(context, 'Start Track Exam (25 Questions)'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _SectionTitle(UiText.t(context, 'Study Modules')),
              ...widget.track.modules.map((module) {
                final completed = progress.completedModuleIds.contains(
                  module.id,
                );
                return _ModuleExpansionTile(
                  module: module,
                  completed: completed,
                  color: color,
                  onChanged: (value) =>
                      _toggleModule(module.id, value ?? false),
                );
              }),
              const SizedBox(height: 18),
              _SectionTitle(UiText.t(context, 'Recommended Articles')),
              ...widget.track.recommendedArticleIds.map((id) {
                final matches = AppRepository.theoryArticles
                    .where((a) => a.id == id)
                    .toList();
                if (matches.isEmpty) return const SizedBox.shrink();
                final article = matches.first;
                return _RelatedTile(
                  icon: Icons.menu_book,
                  title: LocalizedContent.articleTitle(context, article),
                  subtitle: UiText.t(context, 'Theory article'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailScreen(article: article),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 14),
              _SectionTitle(UiText.t(context, 'Recommended Calculators')),
              ...widget.track.recommendedCalculatorIds.map((id) {
                final matches = AppRepository.calculators
                    .where((c) => c.id == id)
                    .toList();
                if (matches.isEmpty) return const SizedBox.shrink();
                final calc = matches.first;
                return _RelatedTile(
                  icon: Icons.calculate,
                  title: LocalizedContent.calculatorName(context, calc),
                  subtitle: LocalizedContent.calculatorDescription(
                    context,
                    calc,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CalculatorDetailScreen(calculator: calc),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 14),
              _SectionTitle(UiText.t(context, 'Recommended Diagrams')),
              ...widget.track.recommendedDiagramIds.map((id) {
                final matches = AppRepository.wiringDiagrams
                    .where((d) => d.id == id)
                    .toList();
                if (matches.isEmpty) return const SizedBox.shrink();
                final diagram = matches.first;
                return _RelatedTile(
                  icon: Icons.account_tree,
                  title: LocalizedContent.wiringTitle(context, diagram),
                  subtitle: LocalizedContent.wiringDescription(
                    context,
                    diagram,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DiagramDetailScreen(diagram: diagram),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final bool isDark;
  const _HeaderCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.accentPurple, Color(0xFFA78BFA)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(Icons.workspace_premium, color: Colors.white, size: 42),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiText.t(context, 'Certification Prep'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  UiText.t(
                    context,
                    'Structured study tracks with modules, recommended content and track exams.',
                  ),
                  style: TextStyle(color: Colors.white70, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackCard extends StatelessWidget {
  final CertificationTrack track;
  final CertificationProgress progress;
  final bool isDark;
  final VoidCallback onTap;
  const _TrackCard({
    required this.track,
    required this.progress,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(track.colorHex.replaceFirst('#', '0xFF')));
    final pct = progress.completionPercent(track);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.11),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(_icon(track.iconName), color: color),
        ),
        title: Text(
          LocalizedContent.text(context, track.title),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              LocalizedContent.text(context, track.subtitle),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: pct / 100,
              color: color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(99),
            ),
            const SizedBox(height: 5),
            Text(
              '${UiText.digits(context, pct.toStringAsFixed(0))}% ${UiText.t(context, 'modules complete')} • '
              '${LocalizedContent.text(context, track.estimatedStudyTime)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final CertificationTrack track;
  final CertificationProgress progress;
  final Color color;
  const _DetailHeader({
    required this.track,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final pct = progress.completionPercent(track);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.72)]),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizedContent.text(context, track.title),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            LocalizedContent.text(context, track.description),
            style: const TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: pct / 100,
            backgroundColor: Colors.white24,
            color: Colors.white,
            minHeight: 8,
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 8),
          Text(
            '${UiText.digits(context, pct.toStringAsFixed(0))}% ${UiText.t(context, 'complete')} • '
            '${UiText.digits(context, '${track.modules.length}')} ${UiText.t(context, 'modules')} • '
            '${UiText.digits(context, '${track.totalLessons}')} ${UiText.t(context, 'lessons')}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${UiText.t(context, 'Attempts:')} ${UiText.digits(context, '${progress.attempts}')} • ${UiText.t(context, 'Best score:')} ${UiText.digits(context, '${progress.bestScore}')}%',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ModuleExpansionTile extends StatelessWidget {
  final CertificationModule module;
  final bool completed;
  final Color color;
  final ValueChanged<bool?> onChanged;
  const _ModuleExpansionTile({
    required this.module,
    required this.completed,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Checkbox(
          value: completed,
          onChanged: onChanged,
          activeColor: color,
        ),
        title: Text(
          LocalizedContent.text(context, module.title),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(LocalizedContent.text(context, module.description)),
        children: module.lessons
            .map(
              (lesson) => ListTile(
                dense: true,
                leading: Icon(Icons.check_circle_outline, color: color),
                title: Text(LocalizedContent.text(context, lesson)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _RelatedTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _RelatedTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      onTap: onTap,
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 4),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

IconData _icon(String name) {
  switch (name) {
    case 'badge':
      return Icons.badge;
    case 'workspace_premium':
      return Icons.workspace_premium;
    case 'wb_sunny':
      return Icons.wb_sunny;
    case 'engineering':
      return Icons.engineering;
    case 'ev_station':
      return Icons.ev_station;
    default:
      return Icons.school;
  }
}
