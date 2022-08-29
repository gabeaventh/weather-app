import 'package:core/modules/constant/widget_key.dart';
import 'package:delosaqua_trial/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group("ent to end test for HOME List View", () {
    testWidgets('should show list screen and confirm at least 1 item available',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byKey(WidgetKey.LIST_APP_BAR), findsOneWidget);

      final firstItem = find.byKey(const Key("FORECAST-0"));

      expect(firstItem, findsOneWidget);
    });

    testWidgets(
        'onTap first item should show detail screen and confirm the content',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final firstItem = find.byKey(const Key("FORECAST-0"));

      await tester.tap(firstItem);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byKey(WidgetKey.DETAIL_APP_BAR), findsOneWidget);
      expect(find.byKey(WidgetKey.DETAIL_TITLE), findsOneWidget);
      expect(find.byKey(WidgetKey.DETAIL_INFO), findsOneWidget);
      expect(find.byKey(WidgetKey.DETAIL_TEMP), findsOneWidget);
    });
  });
}
