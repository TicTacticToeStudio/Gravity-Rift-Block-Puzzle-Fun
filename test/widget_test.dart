import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energy_blast/app.dart';

void main() {
  testWidgets('App starts and shows placeholder', (WidgetTester tester) async {
    // Мы оборачиваем приложение в ProviderScope, так как используем Riverpod
    await tester.pumpWidget(const ProviderScope(child: EnergyBlastApp()));

    // Проверяем, что на экране есть наш текст-заглушка
    expect(find.text('Design system is ready. Next - logic.'), findsOneWidget);
  });
}