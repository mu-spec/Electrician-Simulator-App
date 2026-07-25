import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/ui_text.dart';
import '../../../core/theme/app_theme.dart';
import '../calculators/calculators_screen.dart';
import '../projects/projects_screen.dart';
import '../certification/certification_tracks_screen.dart';
import '../tools/resistor_scanner_screen.dart';
import '../quiz/quiz_screen.dart';
import '../search/global_search_screen.dart';
import '../settings/settings_screen.dart';
import '../standards/pakistan_standards_screen.dart';
import '../theory/theory_screen.dart';
import '../videos/videos_screen.dart';
import '../wiring/wiring_screen.dart';

/// Clean home: welcome header + module grid only (user-friendly, less clutter).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HomeHeader(isDark: isDark, l10n: l10n),
                    const SizedBox(height: 24),
                    _SectionTitle(
                      title: UiText.t(context, 'Choose Module'),
                      subtitle: '',
                    ),
                    const SizedBox(height: 12),
                    _ModuleGrid(isDark: isDark),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final bool isDark;
  final AppLocalizations l10n;

  const _HomeHeader({required this.isDark, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UiText.t(context, 'Welcome Back,'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                UiText.t(context, 'Electrician Simulator App'),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  fontSize: 28, // slightly smaller to fit the longer word
                ),
              ),
            ],
          ),
        ),
        _HeaderIconButton(
          icon: Icons.search,
          tooltip: l10n.t('globalSearch'),
          isDark: isDark,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GlobalSearchScreen()),
          ),
        ),
        const SizedBox(width: 8),
        _HeaderIconButton(
          icon: Icons.settings_outlined,
          tooltip: l10n.t('settings'),
          isDark: isDark,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool isDark;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.icon,
    required this.tooltip,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
        ],
      ],
    );
  }
}

class _ModuleGrid extends StatelessWidget {
  final bool isDark;
  const _ModuleGrid({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final modules = [
      _ModuleItem(
        UiText.t(context, 'Theory Academy'),
        UiText.t(context, 'Learn Electrical Topics'),
        Icons.menu_book_rounded,
        AppTheme.primaryBlue,
        () => const TheoryScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Calculators'),
        '50 ${UiText.t(context, 'Practical Tools')}',
        Icons.calculate_rounded,
        AppTheme.accentGreen,
        () => const CalculatorsScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Wiring Diagrams'),
        '50 ${UiText.t(context, 'SVG Diagrams')}',
        Icons.account_tree_rounded,
        AppTheme.accentOrange,
        () => const WiringScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Quiz & Practice'),
        '200 ${UiText.t(context, 'Questions')}',
        Icons.quiz_rounded,
        AppTheme.accentPurple,
        () => const QuizScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Standards & Codes'),
        UiText.t(context, 'IEC / NEC / PEC Notes'),
        Icons.gavel_rounded,
        const Color(0xFF0F766E),
        () => const PakistanStandardsScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Video Tutorials'),
        UiText.t(context, 'YouTube Links'),
        Icons.play_circle_fill_rounded,
        AppTheme.accentRed,
        () => const VideosScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Global Search'),
        UiText.t(context, 'Find Anything Fast'),
        Icons.search_rounded,
        AppTheme.accentCyan,
        () => const GlobalSearchScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Resistor Scanner'),
        UiText.t(context, 'Color Code Tool'),
        Icons.palette_rounded,
        const Color(0xFF0F766E),
        () => const ResistorScannerScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Certifications'),
        UiText.t(context, 'Study Tracks'),
        Icons.workspace_premium_rounded,
        AppTheme.accentOrange,
        () => const CertificationTracksScreen(),
      ),
      _ModuleItem(
        UiText.t(context, 'Job Manager'),
        UiText.t(context, 'Jobs And Site Notes'),
        Icons.work_rounded,
        const Color(0xFF7C3AED),
        () => const ProjectsScreen(),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final item = modules[index];
        return _ModuleCard(item: item, isDark: isDark);
      },
    );
  }
}

class _ModuleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget Function() builder;
  const _ModuleItem(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.builder,
  );
}

class _ModuleCard extends StatelessWidget {
  final _ModuleItem item;
  final bool isDark;
  const _ModuleCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.builder()),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.color, size: 24),
              ),
              const Spacer(),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 3),
              Text(
                item.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
