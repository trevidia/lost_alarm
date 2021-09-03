import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class AudioPlayerTask {
  static AudioPlayer _player = AudioPlayer();
  static init() => _player;

  static onPlay() async {
    await _player.setAsset('assets/Sound/Alarm/Alarm.wav');
    _player.setVolume(1);
    _player.setLoopMode(LoopMode.all);
    Vibration.vibrate();
    _player.play();
  }

  static bool _isVibrating = false;
  static vibrate() {
    if (_isVibrating == false) {
      _isVibrating = true;
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (_isVibrating == true) {
          Vibration.vibrate();
        }
        if (_isVibrating == false) {
          Vibration.cancel();
          timer.cancel();
        }
      });
    }
  }

  static set shouldCancelVibration(bool value) {
    _isVibrating = value;
  }

  static onStop() {
    Vibration.cancel();
    _player.stop();
  }
}
