import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test environment smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Electrician Simulator App Test'),
        ),
      ),
    );

    expect(find.text('Electrician Simulator App Test'), findsOneWidget);
  });
}