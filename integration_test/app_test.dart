// This is a basic Flutter integration test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:studying_bloc_cubit/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Counter increments smoke test', (tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trigger a frame.
    await tester.pumpAndSettle();

    var cityTextField = find.byKey(Key('city-field')).first;
    var searchIcon = find.byKey(Key('submit'));

    expect(searchIcon, findsOneWidget);

    await tester.enterText(cityTextField, 'City');
    await tester.pumpAndSettle();

    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    expect(find.text('25.5 °C'), findsOneWidget);
  });
}
