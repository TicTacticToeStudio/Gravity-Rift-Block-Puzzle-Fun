import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App starts and shows main menu', (WidgetTester tester) async {
    // 1. Mock SharedPreferences so the app doesn't crash trying to read save files
    SharedPreferences.setMockInitialValues({});

    // 2. Build the app inside a ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: EnergyBlastApp(),
      ),
    );

    // 3. Pump a few frames to let FutureProviders resolve and UI render.
    // We CANNOT use pumpAndSettle because CosmicBackground has an infinite animation.
    await tester.pump(); // Start frame
    await tester.pump(const Duration(milliseconds: 500)); // Give async providers time to resolve

    // 4. Verify that the main title is displayed
    // FIXED: We use findsWidgets instead of findsOneWidget because the title is stacked 3 times
    // to create the neon outline and gradient effect.
    expect(find.text('SPACECORE'), findsWidgets);

    // 5. Verify the Play button exists
    expect(find.text('PLAY NOW'), findsOneWidget);
  });
}