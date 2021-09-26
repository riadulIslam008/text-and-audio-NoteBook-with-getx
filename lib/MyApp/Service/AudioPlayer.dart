import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';

class Audioplayer {
  late AudioPlayer audioPlayer;
  late int currentDuration;
  late int totalDuration;

  Future<void> playAudio({required String filePath, required int index}) async {
    
  final controller = Get.find<HomeController>();
    audioPlayer = AudioPlayer();

    audioPlayer.play(filePath, isLocal: true);
    audioPlayer.onDurationChanged.listen((event) {
      totalDuration = event.inMilliseconds;
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      currentDuration = event.inMilliseconds;
      controller.linearValue.value =
          currentDuration.toDouble() / totalDuration.toDouble();
    });

    audioPlayer.onPlayerCompletion.listen((_) {
      controller.isAudioPlaying.value = false;

      stopAudio();
    });
  }

  Future stopAudio() async {
    await audioPlayer.stop();
    await audioPlayer.dispose();
  }

  Future pauseAudio() async {
    await audioPlayer.pause();
  }

  getDateFromFilePath({required String filePath}) {
    String fromEpoch = filePath.substring(
        filePath.lastIndexOf("/") + 1, filePath.lastIndexOf("."));

    print(fromEpoch);

    DateTime recorderDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));

    return recorderDate;
  }
}
