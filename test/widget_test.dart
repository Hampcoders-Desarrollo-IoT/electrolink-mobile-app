import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_electrolink/main.dart';

void main() {
  testWidgets('Dashboard renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ElectroLinkApp());
    await tester.pumpAndSettle();
    expect(find.text('ElectroLink'), findsOneWidget);
  });
}
