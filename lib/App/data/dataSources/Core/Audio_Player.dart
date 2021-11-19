import 'package:flutter_sound/flutter_sound.dart';

class SoundAudioPlayer {
  static final SoundAudioPlayer soundAudioPlayer = SoundAudioPlayer._init();
  SoundAudioPlayer._init();

  static final FlutterSoundPlayer flutterSoundPlayer = FlutterSoundPlayer();
}
