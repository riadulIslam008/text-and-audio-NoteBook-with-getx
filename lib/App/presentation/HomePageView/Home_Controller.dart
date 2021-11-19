import 'dart:io';
import 'dart:math';

//? ============ Packages ===============
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

//? ================== AppError ===============
import 'package:todo_app/App/Core/errors/App_Error.dart';
import 'package:todo_app/App/Core/utils/permission.dart';

//? ================== Bottom Sheet ===============
import 'package:todo_app/App/Core/widgets/Bottom_Sheet.dart';
import 'package:todo_app/App/Core/widgets/Snack_Bar.dart';

//? ================== Notes Entity ===============
import 'package:todo_app/App/domain/entites/Notes_Entity.dart';

//? ================== Use Cases ===============
import 'package:todo_app/App/domain/useCases/Audio_Player_Cases/Pause_Audio.dart';
import 'package:todo_app/App/domain/useCases/Audio_Player_Cases/Play_Audio.dart';
import 'package:todo_app/App/domain/useCases/Audio_Player_Cases/Resume_Audio.dart';
import 'package:todo_app/App/domain/useCases/Audio_Player_Cases/Stop_Audio.dart';
import 'package:todo_app/App/domain/useCases/Audio_Recorder/Start_Recording.dart';
import 'package:todo_app/App/domain/useCases/Audio_Recorder/Stop_Recording.dart';
import 'package:todo_app/App/domain/useCases/Delete_Notes.dart';
import 'package:todo_app/App/domain/useCases/Fetch_All_Notes.dart';
import 'package:todo_app/App/domain/useCases/Save_Notes.dart';
import 'package:todo_app/App/domain/useCases/Update_Notes.dart';

//? ================= Params ===============
import 'package:todo_app/App/domain/useCases/Paramitters/Audio_Path_Param.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/No_Param.dart';
import 'package:todo_app/App/domain/useCases/Paramitters/Param_ID.dart';

class HomeController extends GetxController {
  final _notesRepository;
  final soundPlayer;
  HomeController(this._notesRepository, this.soundPlayer);

  SpeechToText speech = SpeechToText();

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  List<NotesEntity> notesModel = <NotesEntity>[];
  RxList audioNotes = <dynamic>[].obs;

  RxBool isRecording = false.obs;
  bool isListening = false;
  RxBool titleListening = false.obs;
  RxBool descriptionListening = false.obs;
  RxBool isAudioPlaying = false.obs;
  RxBool recorderColor = false.obs;
  RxBool showTooltip = false.obs;
  bool pausedAudio = false;
  int pausedAudioIndex = 4444444444444;

  RxDouble linearValue = 0.0.obs;
  RxInt seletedIndex = 9999999999999.obs;

  @override
  void onInit() {
    fetachAllNotes();
    fetchAudioNotes();
    permission();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

//
// Todo─── FETCH ALL  NOTES ───────────────────────────────────────────────────────────
//
  void fetachAllNotes() async {
    FetchAllNotes fetchNotes = FetchAllNotes(_notesRepository);
    final Either<AppError, List<NotesEntity>> eitherRepo =
        await fetchNotes(NoParam());

    eitherRepo.fold(
      (l) => snackBar(l.errorMerrsage),
      (r) => notesModel = r,
    );
    update();
  }

  NotesEntity getNodeModels() => NotesEntity(
        color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
        time: DateTime.now(),
        title: titleController.value.text,
        description: descriptionController.value.text,
      );

//
// Todo─── SAVE NOTES ─────────────────────────────────────────────────────────────
//
  void saveNotes() async {
    NotesEntity notesModelItem = getNodeModels();

    SaveNotes saveNotes = SaveNotes(_notesRepository);
    final Either<AppError, int> either = await saveNotes(notesModelItem);
    either.fold((l) => snackBar(l.errorMerrsage), (r) {
      fetachAllNotes();
      update();
    });

    textEditingControllerClear();
    Get.back();
  }

//
//Todo ─── UPDATE NOTES ───────────────────────────────────────────────────────────────
//
  updateNotes({required int index}) async {
    UpdateNotes updateNote = UpdateNotes(_notesRepository);

    NotesEntity notesEntity = getNodeModels();
    notesEntity.id = index;

    final Either<AppError, void> either = await updateNote(notesEntity);
    either.fold((l) => snackBar(l.errorMerrsage), (r) {
      fetachAllNotes();
      update();
      textEditingControllerClear();
    });
    Get.back();
  }

//
// Todo ─── DELETE NOTES ───────────────────────────────────────────────────────────────
//
  deleteNotes({required int index}) async {
    DeleteNotes deleteNote = DeleteNotes(_notesRepository);
    final Either<AppError, void> either = await deleteNote(ParamID(index));

    either.fold((l) => snackBar(l.errorMerrsage), (r) {
      fetachAllNotes();
      update();
    });
  }

//
// Todo ─── CLEAR TEXT EDITING CONTROLLER ──────────────────────────────────────────────
//
  textEditingControllerClear() {
    titleController.value.clear();
    descriptionController.value.clear();
  }

  //
  // * ─── SPEECH TO TEXT FUNCTION ────────────────────────────────────────────────────
  //
  void titleSpeechToText() async {
    descriptionListening.value = false;
    stop();
    if (!isListening) {
      bool available = await speech.initialize(
        finalTimeout: Duration(seconds: 2),
        onStatus: (val) {
          if (val.toString() == "done") {
            titleListening.value = false;
          }
        },
      );
      if (available) {
        isListening = true;

        speech.listen(onResult: (val) {
          titleController.value.text = val.recognizedWords;
        });
      }
    }
  }

  stop() {
    speech.stop();
    isListening = false;
  }

  void descriptionSpeechToText() async {
    titleListening.value = false;
    stop();
    if (!isListening) {
      bool available = await speech.initialize(
        finalTimeout: Duration(seconds: 3),
        onStatus: (val) {
          if (val.toString() == "done") {
            descriptionListening.value = false;
          }
        },
      );
      if (available) {
        isListening = true;

        speech.listen(onResult: (val) {
       //   descriptionListening.value = true;
          descriptionController.value.text = val.recognizedWords;
        });
      }
    }
  }

  //
  // *** ─── BOTTOM SHEET ───────────────────────────────────────────────────────────────
  //
  void displaybottomSheet({
    required String headerName,
    required String buttonName,
    String? titleText,
    String? descriptionText,
    int? index,
  }) {
    if (titleText != null) titleController.value.text = titleText;
    if (descriptionText != null)
      descriptionController.value.text = descriptionText;
    bottomSheet(
        headerName: headerName,
        buttonName: buttonName,
        onPressed: () {
          onPressed(index);
        });
  }

  void onPressed(int? index) {
    index != null ? updateNotes(index: index) : saveNotes();
  }

  //
  // Todo─── AUDIO RECORDING ─────────────────────────────────────────────
  //

  recodingButton() async {
    isRecording.value = !isRecording.value;
    recorderColor.value = !recorderColor.value;
    if (isRecording.value) {
      showTooltip.value = true;
      StartRecording recordingStart = StartRecording(_notesRepository);
      await recordingStart(NoParam());
    } else {
      StopRecording recordingStop = StopRecording(_notesRepository);
      final Either<AppError, String> either = await recordingStop(NoParam());
      either.fold((l) => snackBar(l.errorMerrsage), (r) {
        showTooltip.value = false;
        String recordFilePath = r;
        audioNotes.add(recordFilePath);
        update();
      });
    }
  }

  //
  // Todo ─── FETCH AUDIO FILE ───────────────────────────────────────────────────────────
  //

  Future fetchAudioNotes() async {
    await getApplicationDocumentsDirectory().then((value) {
      value.list().listen((onData) {
        if (onData.path.contains(".wav")) {
          audioNotes.add(onData.path);
        }
      });
    });
  }

  //
  //! ─── AUDIO PLAYER ───────────────────────────────────────────────────────────────
  //

  Future playAndPauseAudio(
      {required String filePath, required int index}) async {
    seletedIndex.value = index;

    isAudioPlaying.value = !isAudioPlaying.value;

    if (pausedAudio && pausedAudioIndex == index) {
      ResumeAudio pauseaudio = ResumeAudio(_notesRepository);
      await pauseaudio(NoParam());
      pausedAudio = false;
    } else if (isAudioPlaying.value) {
      playAudio(filePath);
    } else {
      pausedAudio = true;
      PauseAudio pauseAudio = PauseAudio(_notesRepository);
      await pauseAudio(NoParam());
      pausedAudioIndex = index;
    }
  }

  playAudio(String filePath) async {
    PlayRecordedAudio playAudio = PlayRecordedAudio(_notesRepository);

    await playAudio(AudioPath(
      filePath,
      stopAudio,
    ));
    soundPlayer.setSubscriptionDuration(Duration(milliseconds: 50));

    soundPlayer.onProgress!.listen((d) {
      final maxDuration = d.duration.inMilliseconds;
      linearValue.value = d.position.inMilliseconds.toDouble() / maxDuration;
    });
  }

  stopAudio() async {
    isAudioPlaying.value = false;

    StopAudio stopaudio = StopAudio(_notesRepository);
    await stopaudio(NoParam());
  }

  deleteAudio({required String filePath, required int index}) async {
    final file = File(filePath);
    await file.delete();
    audioNotes.removeAt(index);
  }
}
