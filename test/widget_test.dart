import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Student profile card shows name, ID, and goal', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 2800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const StudentInfoApp());

    expect(find.text('LING YEW HAN'), findsOneWidget);
    expect(find.text('Student ID: BCS24020034'), findsOneWidget);
    expect(find.textContaining('buffet'), findsOneWidget);
  });
}
