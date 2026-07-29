import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/ui_text.dart';
import 'home/home_screen.dart';
import 'theory/theory_screen.dart';
import 'calculators/calculators_screen.dart';
import 'wiring/wiring_screen.dart';
import 'quiz/quiz_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TheoryScreen(),
    CalculatorsScreen(),
    WiringScreen(),
    QuizScreen(),
  ];

  final List<BottomNavItem> _navItems = const [
    BottomNavItem(icon: Icons.home_rounded, labelKey: 'home'),
    BottomNavItem(icon: Icons.menu_book_rounded, labelKey: 'theory'),
    BottomNavItem(icon: Icons.calculate_rounded, labelKey: 'tools'),
    BottomNavItem(icon: Icons.account_tree_rounded, labelKey: 'wiring'),
    BottomNavItem(icon: Icons.quiz_rounded, labelKey: 'quiz'),
  ];

  /// Asks the user to confirm before the app exits.
  ///
  /// Returns true only when "Yes" is tapped. Tapping "No", tapping outside the
  /// dialog, or dismissing it any other way all return false, so the app stays
  /// open. barrierDismissible defaults to true, which is what makes the
  /// tap-outside-to-dismiss behaviour work; showDialog then completes with null
  /// and `?? false` turns that into "do not exit".
  Future<bool> _confirmExit(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(UiText.t(context, 'Exit')),
        content: Text(UiText.t(context, 'Are you sure you want to exit?')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(UiText.t(context, 'No')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(UiText.t(context, 'Yes')),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Banner is global via MaterialApp.builder in main.dart
    // so it appears on ALL screens and sub-screens.
    //
    // PopScope intercepts the system back gesture/button on this root screen so
    // the user is asked before the app closes. canPop is false so the framework
    // never pops automatically; onPopInvokedWithResult decides what happens.
    // Nested routes (article detail, calculators, etc.) are unaffected and pop
    // normally, because this only guards the root of the navigator stack.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _confirmExit(context);
        if (shouldExit) {
          // SystemNavigator.pop() is what actually closes the app on Android.
          // Navigator.pop() would be a no-op here: MainScaffold is the root
          // route, so there is nothing underneath it to pop back to.
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryBlue.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected
                              ? AppTheme.primaryBlue
                              : Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                          size: isSelected ? 26 : 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.t(item.labelKey),
                          style: TextStyle(
                            color: isSelected
                                ? AppTheme.primaryBlue
                                : Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String labelKey;
  const BottomNavItem({required this.icon, required this.labelKey});
}
