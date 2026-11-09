import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:energy_blast/core/providers/settings_provider.dart';

// Added perfectClear to the enum
enum AppSound { place, clear, combo, bonus, gameOver, click, perfectClear }

class AudioService {
  final Ref _ref;
  final Map<AppSound, AudioSource> _sources = {};
  final Map<AppSound, double> _volumes = {
    AppSound.place: 1.0,
    AppSound.clear: 1.0,
    AppSound.combo: 1.0,
    AppSound.bonus: 1.0,
    AppSound.gameOver: 1.0,
    AppSound.click: 0.6,
    AppSound.perfectClear: 1.0, // Maximum volume for the epic sound
  };

  AudioService(this._ref) {
    _initAudio();
  }

  Future<void> _initAudio() async {
    if (SoLoud.instance.isInitialized) return;

    try {
      await SoLoud.instance.init();

      _sources[AppSound.place] = await SoLoud.instance.loadAsset('assets/sounds/place.wav');
      _sources[AppSound.clear] = await SoLoud.instance.loadAsset('assets/sounds/clear.wav');
      _sources[AppSound.combo] = await SoLoud.instance.loadAsset('assets/sounds/combo.wav');
      _sources[AppSound.bonus] = await SoLoud.instance.loadAsset('assets/sounds/bonus.wav');
      _sources[AppSound.gameOver] = await SoLoud.instance.loadAsset('assets/sounds/game_over.wav');
      _sources[AppSound.click] = await SoLoud.instance.loadAsset('assets/sounds/click.wav');
      _sources[AppSound.perfectClear] = await SoLoud.instance.loadAsset('assets/sounds/perfect_clear.wav'); // Load the new sound

      debugPrint('SoLoud: All sounds loaded successfully.');
    } catch (e) {
      debugPrint('SoLoud initialization error: $e');
    }
  }

  void play(AppSound sound) {
    if (!_ref.read(settingsProvider).isSoundOn) return;

    final source = _sources[sound];
    if (source == null) return;

    try {
      SoLoud.instance.play(source, volume: _volumes[sound] ?? 1.0);
    } catch (e) {
      debugPrint('SoLoud play error: $e');
    }
  }
}

final audioServiceProvider = Provider((ref) => AudioService(ref));