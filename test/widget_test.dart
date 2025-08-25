import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilebuild/main.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // Ensure Firebase is initialized before tests run
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Welcome screen shows app name and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Look for the RichText containing FLASHBUDGET
    final richTextFinder = find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains('FLASHBUDGET'),
    );

    expect(richTextFinder, findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
