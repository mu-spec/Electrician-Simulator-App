import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test environment smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Electrical Engineering Guide Test'),
        ),
      ),
    );

    expect(find.text('Electrical Engineering Guide Test'), findsOneWidget);
  });
}