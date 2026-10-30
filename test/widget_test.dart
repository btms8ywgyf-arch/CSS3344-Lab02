import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Student profile card shows name, ID, and goal', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentInfoApp());

    expect(find.text('JANE HO'), findsOneWidget);
    expect(find.text('Student ID: BCS24020004'), findsOneWidget);
    expect(find.textContaining('Ms Marcella'), findsOneWidget);
  });
}
