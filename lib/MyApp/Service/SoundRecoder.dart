import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  late FlutterSoundRecorder _soundRecorder;
  late String filePath;

  Future init() async {
    try {
      _soundRecorder = FlutterSoundRecorder();
      await _soundRecorder.openAudioSession();
    } catch (e) {
      print("SoundRecorder Exception $e");
    }
  }

  Future<void> dispose() async {
    _soundRecorder.closeAudioSession();
  }

  Future<void> startRecording() async {
    try {
      await init();
      Directory _appDirectory = await getApplicationDocumentsDirectory();

      filePath =
          "${_appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.wav";
      await _soundRecorder.startRecorder(
        toFile: filePath,
        codec: Codec.pcm16WAV,
      );
    } catch (e) {
      print("StartRecording Exception $e");
    }
  }

  Future<String> stopRecording() async {
    print("stopRecording");
    await _soundRecorder.stopRecorder();
    await dispose();
    return filePath;
  }

  permission() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
}
