import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/data/dataSources/Core/Sql_Lite.dart';
import 'package:todo_app/App/data/dataSources/local/Local_Data_Source.dart';
import 'package:todo_app/App/data/dataSources/local/Sound_Player.dart';
import 'package:todo_app/App/data/dataSources/local/Sound_Recorder.dart';
import 'package:todo_app/App/data/repositories/Notes_Repository_Impl.dart';
import 'package:todo_app/App/domain/repositories/Notes_Repository.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    LocalDatabase _localDatabase = LocalDatabase.localDatabase;
    LocalDataSource _localDataSource = LocalDataSourceImpl(_localDatabase);

    FlutterSoundPlayer flutterSoundPlayer = FlutterSoundPlayer();
    SoundPlayer soundPlayer = SoundPlayerImpl(flutterSoundPlayer);

    FlutterSoundRecorder _flutterSoundRecorder = FlutterSoundRecorder();
    AudioRecorder _audioRecorder = AudioRecoderImpl(_flutterSoundRecorder);

    NotesRepository _notesRepository =
        NotesRepositoryImpl(_localDataSource, soundPlayer, _audioRecorder);

    Get.put(HomeController(_notesRepository, flutterSoundPlayer));
  }
}
