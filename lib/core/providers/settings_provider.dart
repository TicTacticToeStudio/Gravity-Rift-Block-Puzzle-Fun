import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final bool isSoundOn;
  final bool isVibrationOn;

  const SettingsState({
    this.isSoundOn = true,
    this.isVibrationOn = true,
  });

  SettingsState copyWith({bool? isSoundOn, bool? isVibrationOn}) {
    return SettingsState(
      isSoundOn: isSoundOn ?? this.isSoundOn,
      isVibrationOn: isVibrationOn ?? this.isVibrationOn,
    );
  }
}

// Overridden in main() with the persisted values to prevent a flash of default state.
final initialSettingsProvider = Provider<SettingsState>((ref) => const SettingsState());

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return ref.read(initialSettingsProvider);
  }

  void toggleSound() {
    state = state.copyWith(isSoundOn: !state.isSoundOn);
    _persist();
  }

  void toggleVibration() {
    state = state.copyWith(isVibrationOn: !state.isVibrationOn);
    _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_on', state.isSoundOn);
    await prefs.setBool('vibration_on', state.isVibrationOn);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);