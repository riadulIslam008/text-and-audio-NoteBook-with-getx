import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class SoundPlayer {
  Future<void> play(
      {required String filePath, required VoidCallback whenFinished});
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
}

class SoundPlayerImpl extends SoundPlayer {
  final FlutterSoundPlayer _flutterSoundPlayer;

  SoundPlayerImpl(this._flutterSoundPlayer);
  @override
  Future<void> pause() async {
    await _flutterSoundPlayer.pausePlayer();
  }

  @override
  Future<void> play(
      {required String filePath, required VoidCallback whenFinished}) async {
    _flutterSoundPlayer.openAudioSession();

    await _flutterSoundPlayer.startPlayer(
      fromURI: filePath,
      whenFinished: whenFinished,
    );

   
  }

  @override
  Future<void> resume() async {
    await _flutterSoundPlayer.resumePlayer();
  }

  @override
  Future<void> stop() async {
    await _flutterSoundPlayer.stopPlayer();
    _flutterSoundPlayer.closeAudioSession();
  }
}
