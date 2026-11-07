import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:energy_blast/core/providers/settings_provider.dart';

enum AppHaptic { selection, light, medium, heavy, vibrate }

class HapticService {
  final Ref _ref;
  HapticService(this._ref);

  Future<void> trigger(AppHaptic haptic) async {
    if (!_ref.read(settingsProvider).isVibrationOn) return;
    if (await Vibration.hasVibrator() != true) return;

    bool hasAmplitude = await Vibration.hasAmplitudeControl() ?? false;

    switch (haptic) {
      case AppHaptic.selection:
        await Vibration.vibrate(duration: 40, amplitude: hasAmplitude ? 150 : -1);
        break;
      case AppHaptic.light:
        await Vibration.vibrate(duration: 100, amplitude: hasAmplitude ? 255 : -1);
        break;
      case AppHaptic.medium:
        await Vibration.vibrate(duration: 200, amplitude: hasAmplitude ? 255 : -1);
        break;
      case AppHaptic.heavy:
        await Vibration.vibrate(duration: 300, amplitude: hasAmplitude ? 255 : -1);
        break;
      case AppHaptic.vibrate:
      // Game Over: Three distinct pulses with guaranteed delays.
      // Delays (250ms) must be longer than the vibration (150ms)
      // so the motor has time to fully stop before the next pulse.
        await Vibration.vibrate(duration: 150, amplitude: hasAmplitude ? 255 : -1);
        await Future.delayed(const Duration(milliseconds: 250));

        await Vibration.vibrate(duration: 150, amplitude: hasAmplitude ? 255 : -1);
        await Future.delayed(const Duration(milliseconds: 250));

        await Vibration.vibrate(duration: 300, amplitude: hasAmplitude ? 255 : -1);
        break;
    }
  }
}

final hapticServiceProvider = Provider((ref) => HapticService(ref));