import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

abstract class AudioRecorder {
  Future<void> startRecording();
  Future<String> stopRecording();
}

class AudioRecoderImpl extends AudioRecorder {
  final FlutterSoundRecorder _flutterSoundRecorder;
  AudioRecoderImpl(this._flutterSoundRecorder);

  late String filePath;

  @override
  Future<void> startRecording() async {
    await _flutterSoundRecorder.openAudioSession();

    Directory _appDirectory = await getApplicationDocumentsDirectory();

    filePath =
        "${_appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.wav";
    await _flutterSoundRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
  }

  @override
  Future<String> stopRecording() async {
    await _flutterSoundRecorder.stopRecorder();
    await _flutterSoundRecorder.closeAudioSession();
    return filePath;
  }
}
