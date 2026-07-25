import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  String _category = 'Bug / Crash';
  int _rating = 5;
  bool _sending = false;

  static const List<String> _categories = [
    'Bug / Crash',
    'Wrong calculation',
    'Content correction',
    'Wiring diagram feedback',
    'Urdu translation feedback',
    'Standards & Codes feedback',
    'Feature request',
    'Closed beta general feedback',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _sendFeedback() async {
    final message = _messageController.text.trim();
    if (message.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(UiText.t(context, 'Please write at least 10 characters of feedback.'))),
      );
      return;
    }

    setState(() => _sending = true);
    try {
      final info = await PackageInfo.fromPlatform();
      final body = '''Hi VoltMaster Pro team,

Category: $_category
Rating: $_rating/5
Contact: ${_contactController.text.trim().isEmpty ? UiText.t(context, 'Not provided') : _contactController.text.trim()}

Feedback:
$message

--- App Info ---
App: ${info.appName}
Package: ${info.packageName}
Version: ${info.version}+${info.buildNumber}
Phase: 2I Closed Beta Candidate
''';

      final uri = Uri(
        scheme: 'mailto',
        path: 'koreappstek@gmail.com',
        queryParameters: {
          'subject': 'VoltMaster Pro Closed Beta Feedback - $_category',
          'body': body,
        },
      );

      final launched = await launchUrl(uri);
      if (!launched && mounted) {
        _showFallback(body);
      }
    } catch (_) {
      if (mounted) {
        _showFallback('Category: $_category\nRating: $_rating/5\n\n$message');
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _showFallback(String body) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(UiText.t(context, 'Email app unavailable')),
        content: SingleChildScrollView(
          child: SelectableText(
            'Please send this feedback to:\n\nkoreappstek@gmail.com\n\n$body',
            style: const TextStyle(fontSize: 13, height: 1.45),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(UiText.t(context, 'Close')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Send Beta Feedback'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.22)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.volunteer_activism, color: AppTheme.primaryBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      UiText.t(context, 'Your beta feedback helps make VoltMaster Pro safer, more accurate, and ready for Play Store release.'),
                      style: const TextStyle(height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(UiText.t(context, 'Feedback Category'), style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _category,
              items: _categories.map((category) => DropdownMenuItem(value: category, child: Text(UiText.t(context, category)))).toList(),
              onChanged: (value) => setState(() => _category = value ?? _category),
            ),
            const SizedBox(height: 18),
            Text(UiText.t(context, 'Overall Rating'), style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                final value = index + 1;
                return IconButton(
                  onPressed: () => setState(() => _rating = value),
                  icon: Icon(
                    value <= _rating ? Icons.star : Icons.star_border,
                    color: AppTheme.accentOrange,
                    size: 30,
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            Text(UiText.t(context, 'Feedback Details'), style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              minLines: 6,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: UiText.t(context, 'Describe the issue, correction, device model, screen name, expected result, or suggestion...'),
              ),
            ),
            const SizedBox(height: 18),
            Text(UiText.t(context, 'Contact / Tester Name (optional)'), style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(hintText: UiText.t(context, 'Name, WhatsApp, or email if you want follow-up')),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sending ? null : _sendFeedback,
                icon: _sending
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.send),
                label: Text(UiText.t(context, _sending ? 'Preparing...' : 'Send Beta Feedback')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              UiText.t(context, 'If your email app does not open, a copyable fallback message will be shown.'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
