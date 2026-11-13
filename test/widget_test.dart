import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_electrolink/main.dart';

void main() {
  testWidgets('App renders auth screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ElectroLinkApp());
    await tester.pumpAndSettle();

    // La pantalla de autenticación debe mostrarse al iniciar.
    expect(find.text('ElectroLink'), findsOneWidget);
  });
}
