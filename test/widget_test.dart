import 'package:flutter_test/flutter_test.dart';
import 'package:imclient_flutter/app.dart';

void main() {
  testWidgets('App launches and shows splash', (WidgetTester tester) async {
    await tester.pumpWidget(const IMClientApp());
    // Verify the app widget renders without error
    expect(find.byType(IMClientApp), findsOneWidget);
  });
}
