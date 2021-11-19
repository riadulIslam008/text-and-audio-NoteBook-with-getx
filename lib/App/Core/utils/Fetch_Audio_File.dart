import 'package:path_provider/path_provider.dart';

Future<List<dynamic>> fetchAudioRecordedFile() async {
  List audioNotes = [];
  await getApplicationDocumentsDirectory().then((value) {
    value.list().listen((onData) {
      if (onData.path.contains(".wav")) {
        audioNotes.add(onData.path);
      }
    }).onDone(() {
      audioNotes = audioNotes.reversed.toList();
    });
  });
  return audioNotes;
}
