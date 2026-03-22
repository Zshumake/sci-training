import 'package:flutter_test/flutter_test.dart';
import 'package:sci_training/main.dart';

void main() {
  testWidgets('SCI Training app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const SCITrainingApp());
    expect(find.text('SCI Training'), findsOneWidget);
  });
}
