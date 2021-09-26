import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:todo_app/MyApp/Model/NotesModel.dart';
import 'package:todo_app/MyApp/Service/AudioPlayer.dart';
import 'package:todo_app/MyApp/Service/LocalDatabase.dart';
import 'package:todo_app/MyApp/Service/SoundRecoder.dart';
import 'package:todo_app/MyApp/View/widget/DescriptionTextField.dart';
import 'package:todo_app/MyApp/View/widget/TitleTextField.dart';
import 'package:todo_app/MyApp/utils/Colors.dart';
import 'package:todo_app/MyApp/utils/UniversalVeriable.dart';

class HomeController extends GetxController {
  final Audioplayer _audioPlayer = Audioplayer();
  final SoundRecorder _soundRecorder = SoundRecorder();
  bool isRecording = false;
  late TextEditingController titleController, descriptionController;
  List notesModel = [];
  final LocalDatabase _localDatabase = LocalDatabase.localDatabase;
  late stt.SpeechToText speech;
  bool isListening = false;
  bool titleListening = false;
  bool descriptionListening = false;
  RxList audioNotes = <String>[].obs;
  RxDouble linearValue = 0.0.obs;
  RxBool isAudioPlaying = false.obs;
  bool recorderColor = false;
  RxInt seletedIndex = 9999999999999.obs;

  @override
  void onInit() {
    fetachAllNotes();
    speech = stt.SpeechToText();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    fetchAudioNotes();
    _soundRecorder.permission();
    super.onInit();
  }

  @override
  void onClose() {
    _soundRecorder.dispose();
    titleController.dispose();
    descriptionController.dispose();

    super.onClose();
  }

//
// Todo─── FETCH ALL  NOTES ───────────────────────────────────────────────────────────
//
  void fetachAllNotes() async {
    print("Data Collecting");
    await _localDatabase.readData().then((value) {
      notesModel = value;
    });
    print("Data Collecting Complete");
    update();
  }

//
// Todo─── SAVE NOTES ─────────────────────────────────────────────────────────────
//
  saveNotes() async {
    NotesModel notesModelItem = NotesModel(
      titile: titleController.text,
      description: descriptionController.text,
      time: DateTime.now(),
      color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
    );

    var _id = await _localDatabase.createDb(notesModel: notesModelItem);
    notesModelItem.id = _id;
    notesModel.add(notesModelItem);
    update();
    textEditingControllerClear();
    Get.back();
  }

//
//Todo ─── UPDATE NOTES ───────────────────────────────────────────────────────────────
//
  updateNotes({required int index}) async {
    print("index: $index");
    await _localDatabase.updateData(
      id: index,
      title: titleController.text,
      description: descriptionController.text,
    );
    fetachAllNotes();
    update();
    textEditingControllerClear();
    Get.back();
  }

//
// Todo ─── DELETE NOTES ───────────────────────────────────────────────────────────────
//
  deleteNotes({required int index}) async {
    await _localDatabase.delete(id: index);
    fetachAllNotes();
    update();
  }

//
// Todo ─── CLEAR TEXT EDITING CONTROLLER ──────────────────────────────────────────────
//
  textEditingControllerClear() {
    titleController.clear();
    descriptionController.clear();
  }

  //
  // ?─── SPEECH TO TEXT FUNCTION ────────────────────────────────────────────────────
  //
  void titleSpeechToText() async {
    if (!isListening) {
      bool available = await speech.initialize(
        finalTimeout: Duration(seconds: 2),
        onStatus: (val) {
          print("onStatus: $val");
          if (val.toString() == "listening") {
            titleListening = true;
            update();
          }
          if (val.toString() == "notListening") {
            titleListening = false;
            update();
          }
        },
        onError: (val) => print("onError: $val"),
      );
      if (available) {
        isListening = true;

        speech.listen(onResult: (val) {
          titleListening = true;
          titleController.text = val.recognizedWords;
          update();
        });
      }
    }
  }

  stop() {
    speech.stop();
    isListening = false;
    descriptionListening = false;
    titleListening = false;
    update();
  }

  void descriptionSpeechToText() async {
    if (!isListening) {
      bool available = await speech.initialize(
        finalTimeout: Duration(seconds: 2),
        onStatus: (val) {
          print("onStatus: $val");
          if (val.toString() == "listening") {
            descriptionListening = true;
            update();
          }
          if (val.toString() == "notListening") {
            descriptionListening = false;
            update();
          }
        },
        onError: (val) => print("onError: $val"),
      );
      if (available) {
        isListening = true;

        speech.listen(onResult: (val) {
          descriptionListening = true;
          descriptionController.text = val.recognizedWords;
          update();
        });
      }
    }
  }

  //
  // *** ─── BOTTOM SHEET ───────────────────────────────────────────────────────────────
  //
  void displaybottomSheet(
      {required String headerName,
      required String buttonName,
      String? titleText,
      String? descriptionText,
      int? index}) {
    textEditingControllerClear();
    if (titleText != null && descriptionText != null) {
      print("Edit Notes");
      titleController.text = titleText;
      descriptionController.text = descriptionText;
      update();
    }
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: indigoColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: ListView(
          children: [
            Text(headerName, style: titleStyle),
            SizedBox(height: 20),
            TitleTextField(),
            SizedBox(height: 10),
            DescriptionTextField(),
            SizedBox(height: 30),
            MaterialButton(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 10),
              minWidth: screenWidth,
              onPressed: () {
                if (index != null) {
                  print("Update Calling");
                  updateNotes(index: index);
                } else {
                  saveNotes();
                }
              },
              child: Text(buttonName, style: titleStyle),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  //
  // Todo─── AUDIO RECORDING ─────────────────────────────────────────────
  //

  recodingButton() async {
    isRecording = !isRecording;
    recorderColor = !recorderColor;
    update();
    if (isRecording) {
      await _soundRecorder.startRecording();
    } else {
      String recordFilePath = await _soundRecorder.stopRecording();
      audioNotes.add(recordFilePath);
      update();
    }
  }

  //
  // Todo ─── FETCH AUDIO FILE ───────────────────────────────────────────────────────────
  //

  Future fetchAudioNotes() async {
    print("Audio Notes Searching");
    await getApplicationDocumentsDirectory().then((value) {
      value.list().listen((onData) {
        if (onData.path.contains(".wav")) {
          audioNotes.add(onData.path);
        }
      }).onDone(() {
        audioNotes.value = audioNotes.reversed.toList();
      });
    });
    update();
  }

  //
  //! ─── AUDIO PLAYER ───────────────────────────────────────────────────────────────
  //

  Future playAndStopAudio(
      {required String filePath, required int index}) async {
    seletedIndex.value = index;
    print(seletedIndex);

    isAudioPlaying.value = !isAudioPlaying.value;

    if (isAudioPlaying.value) {
      await _audioPlayer.playAudio(filePath: filePath, index: index);
    } else {
      _audioPlayer.pauseAudio();
    }
  }

  stopAudio() {
    isAudioPlaying.value = false;
    _audioPlayer.stopAudio();
  }

  deleteAudio({required String filePath, required int index}) async {
    final file = File(filePath);
    await file.delete();
    audioNotes.removeAt(index);
  }
}
