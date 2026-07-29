import '../../../core/localization/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../data/database_service.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/wiring_diagram.dart';

class DiagramDetailScreen extends StatefulWidget {
  final WiringDiagram diagram;
  const DiagramDetailScreen({super.key, required this.diagram});

  @override
  State<DiagramDetailScreen> createState() => _DiagramDetailScreenState();
}

class _DiagramDetailScreenState extends State<DiagramDetailScreen> {
  bool _isBookmarked = false;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _loadBookmarkState();
  }

  Future<void> _loadBookmarkState() async {
    final bookmarked = await DatabaseService.isBookmarked(widget.diagram.id);
    if (mounted) setState(() => _isBookmarked = bookmarked);
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await DatabaseService.removeBookmark(widget.diagram.id);
    } else {
      await DatabaseService.addBookmark(widget.diagram.id, 'diagram');
    }
    if (mounted) {
      setState(() => _isBookmarked = !_isBookmarked);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isBookmarked
                ? UiText.t(context, 'Diagram bookmarked')
                : UiText.t(context, 'Bookmark removed'),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _openFullScreenDiagram(BuildContext context) {
    if (widget.diagram.svgPath == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiagramViewerScreen(
          title: LocalizedContent.wiringTitle(context, widget.diagram),
          svgPath: widget.diagram.svgPath!,
        ),
      ),
    );
  }

  Future<void> _showNoteDialog() async {
    final existing =
        await DatabaseService.getNote(widget.diagram.id, 'diagram') ?? '';
    final controller = TextEditingController(text: existing);
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(UiText.t(context, 'Diagram Note')),
        content: TextField(
          controller: controller,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: UiText.t(
              context,
              'Write installation note, site condition, or reminder...',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(UiText.t(context, 'Cancel')),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseService.saveNote(
                widget.diagram.id,
                'diagram',
                controller.text,
              );
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (mounted)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(UiText.t(context, 'Note saved'))),
                );
            },
            child: Text(UiText.t(context, 'Save')),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  void _shareDiagram() {
    final title = LocalizedContent.wiringTitle(context, widget.diagram);
    final description = LocalizedContent.wiringDescription(
      context,
      widget.diagram,
    );
    final components = LocalizedContent.wiringComponents(
      context,
      widget.diagram,
    );
    final localizedSteps = LocalizedContent.wiringSteps(
      context,
      widget.diagram,
    );
    final steps = localizedSteps
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');
    final appTitle = AppLocalizations.of(context).t('appTitle');
    Share.share(
      '$title\n\n'
      '$description\n\n'
      '${UiText.t(context, 'Components:')}\n'
      '${components.map((item) => '• $item').join('\n')}\n\n'
      '${UiText.t(context, 'Steps:')}\n$steps\n\n'
      '${UiText.t(context, 'Shared from')} $appTitle - '
      '${UiText.t(context, 'Electrical Engineering Companion')}',
      subject: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final localizedTitle = LocalizedContent.wiringTitle(
      context,
      widget.diagram,
    );
    final localizedDescription = LocalizedContent.wiringDescription(
      context,
      widget.diagram,
    );
    final localizedComponents = LocalizedContent.wiringComponents(
      context,
      widget.diagram,
    );
    final localizedSteps = LocalizedContent.wiringSteps(
      context,
      widget.diagram,
    );
    final localizedSafety = LocalizedContent.wiringSafetyWarnings(
      context,
      widget.diagram,
    );
    final localizedMistakes = LocalizedContent.wiringCommonMistakes(
      context,
      widget.diagram,
    );
    final localizedTesting = LocalizedContent.wiringTestingProcedure(
      context,
      widget.diagram,
    );
    final localizedNotes = LocalizedContent.wiringProfessionalNotes(
      context,
      widget.diagram,
    );
    final category = AppRepository.wiringCategories.firstWhere(
      (c) => c.id == widget.diagram.category,
    );
    final primaryColor = Color(
      int.parse(category.colorHex.replaceFirst('#', '0xFF')),
    );

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      // Solid app bar — avoids FlexibleSpaceBar title/background color mixing on scroll.
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          localizedTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: Colors.white,
            ),
            tooltip: UiText.t(context, 'Bookmark'),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: const Icon(Icons.note_alt_outlined, color: Colors.white),
            tooltip: UiText.t(context, 'Personal note'),
            onPressed: _showNoteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            tooltip: UiText.t(context, 'Share'),
            onPressed: _shareDiagram,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        children: [
          // Description
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    localizedDescription,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? const Color(0xFFCBD5E1)
                          : const Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF422006) : const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isDark ? const Color(0xFF92400E) : const Color(0xFFF59E0B),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: AppTheme.accentOrange,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    UiText.t(
                      context,
                      'Concept diagram only - not an installation drawing. Do not copy conductor colors, terminal numbers, protection ratings, or connections without checking the actual equipment schematic, latest local requirements, and a qualified electrical professional.',
                    ),
                    style: const TextStyle(fontSize: 12.5, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Circuit Diagram
          if (widget.diagram.svgPath != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.t('circuitDiagram'),
                  style: const TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openFullScreenDiagram(context),
                  icon: const Icon(Icons.fullscreen, size: 20),
                  label: Text(
                    l10n.t('fullScreen'),
                    style: const TextStyle(fontFamily: AppTheme.fontFamily),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _openFullScreenDiagram(context),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildDiagramImage(widget.diagram.svgPath!),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: primaryColor.withOpacity(0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.zoom_in, size: 16, color: primaryColor),
                            const SizedBox(width: 6),
                            Text(
                              l10n.t('tapToZoom'),
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          // Components Needed
          Text(
            l10n.t('componentsNeeded'),
            style: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...localizedComponents.map((component) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      component,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
          // Step by Step
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.t('stepByStepGuide'),
                style: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${_currentStep + 1} / ${localizedSteps.length}',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Step Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: localizedSteps.isEmpty
                  ? 0
                  : (_currentStep + 1) / localizedSteps.length,
              backgroundColor:
                  isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          // Current Step Card
          if (localizedSteps.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${UiText.t(context, 'Step')} ${_currentStep + 1}",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localizedSteps[_currentStep],
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: isDark
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _currentStep > 0
                      ? () => setState(() => _currentStep--)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: Text(
                    l10n.t('previous'),
                    style: const TextStyle(fontFamily: AppTheme.fontFamily),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _currentStep < localizedSteps.length - 1
                      ? () => setState(() => _currentStep++)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                    l10n.t('next'),
                    style: const TextStyle(fontFamily: AppTheme.fontFamily),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _InfoListCard(
            title: l10n.t('safetyWarnings'),
            icon: Icons.warning_amber,
            color: AppTheme.accentRed,
            items: localizedSafety,
          ),
          const SizedBox(height: 12),
          _InfoListCard(
            title: l10n.t('commonMistakes'),
            icon: Icons.error_outline,
            color: AppTheme.accentOrange,
            items: localizedMistakes,
          ),
          const SizedBox(height: 12),
          _InfoListCard(
            title: l10n.t('testingProcedure'),
            icon: Icons.fact_check_outlined,
            color: AppTheme.accentGreen,
            items: localizedTesting,
          ),
          const SizedBox(height: 12),
          _InfoListCard(
            title: UiText.t(context, 'Professional Notes'),
            icon: Icons.engineering_outlined,
            color: primaryColor,
            items: [
              ...localizedNotes,
              ...LocalizedContent.textList(
                context,
                widget.diagram.standardsReferences,
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDiagramImage(String path) {
    return Image.asset(path, fit: BoxFit.contain);
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'toggle_on':
        return Icons.toggle_on;
      case 'power':
        return Icons.power;
      case 'settings':
        return Icons.settings;
      case 'account_tree':
        return Icons.account_tree;
      case 'home':
        return Icons.home_outlined;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'router':
        return Icons.router;
      default:
        return Icons.electrical_services;
    }
  }
}

class _InfoListCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const _InfoListCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 21),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text(
                '• $item',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(height: 1.45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen diagram viewer with pinch-to-zoom and pan.
class DiagramViewerScreen extends StatefulWidget {
  final String title;
  final String svgPath;

  const DiagramViewerScreen({
    super.key,
    required this.title,
    required this.svgPath,
  });

  @override
  State<DiagramViewerScreen> createState() => _DiagramViewerScreenState();
}

class _DiagramViewerScreenState extends State<DiagramViewerScreen> {
  final TransformationController _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildViewerImage(String path) {
    return Image.asset(path, fit: BoxFit.contain);
  }

  void _resetZoom() {
    _controller.value = Matrix4.identity();
  }

  void _zoomIn() {
    final zoom = _controller.value.getMaxScaleOnAxis();
    if (zoom < 5.0) {
      _controller.value = _controller.value.clone()..scale(1.4);
    }
  }

  void _zoomOut() {
    final zoom = _controller.value.getMaxScaleOnAxis();
    if (zoom > 0.7) {
      _controller.value = _controller.value.clone()..scale(1 / 1.4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: UiText.t(context, 'Reset zoom'),
            onPressed: _resetZoom,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              transformationController: _controller,
              minScale: 0.5,
              maxScale: 6.0,
              boundaryMargin: const EdgeInsets.all(80),
              child: Center(child: _buildViewerImage(widget.svgPath)),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            color: const Color(0xFFFFF7ED),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 18,
                  color: AppTheme.accentOrange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    UiText.t(
                      context,
                      'Concept only - verify the actual equipment schematic and local requirements before installation.',
                    ),
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF9A3412),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'zoom_in',
            onPressed: _zoomIn,
            backgroundColor: AppTheme.primaryBlue,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.small(
            heroTag: 'zoom_out',
            onPressed: _zoomOut,
            backgroundColor: AppTheme.primaryBlue,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
