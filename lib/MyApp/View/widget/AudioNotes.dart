import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';
import 'package:todo_app/MyApp/Service/AudioPlayer.dart';
import 'package:todo_app/MyApp/utils/Colors.dart';
import 'package:todo_app/MyApp/utils/UniversalVeriable.dart';

class AudioNotes extends GetWidget<HomeController> {
  AudioNotes({Key? key}) : super(key: key);
  final Audioplayer _audioPlayer = Audioplayer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: screenHeight * 0.10),
        color: whiteColor60,
        child: ListView(
          children: [
            Text("Audio Notes", style: audioNotesText),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                primary: false,
                reverse: true,
                itemCount: controller.audioNotes.length,
                itemBuilder: (context, index) {
                  String filePath = controller.audioNotes[index].toString();
                  DateTime recorderDate =
                      _audioPlayer.getDateFromFilePath(filePath: filePath);
                  String date =
                      "${recorderDate.year}-${recorderDate.month}-${recorderDate.day}";
                  String time = "${recorderDate.hour}:${recorderDate.minute}";
                  return FocusedMenuHolder(
                    menuItemExtent: 50,
                    onPressed: () {},
                    menuItems: <FocusedMenuItem>[
                      FocusedMenuItem(
                        title: Text("DELETE"),
                        onPressed: () {
                          controller.deleteAudio(
                              filePath: filePath, index: index);
                        },
                        trailingIcon: Icon(Icons.delete, color: Colors.red),
                      )
                    ],
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: listCardColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            controller.playAndStopAudio(
                                filePath:
                                    controller.audioNotes.elementAt(index),
                                index: index);
                          },
                          icon: Obx(
                            () => controller.seletedIndex.value == index &&
                                    controller.isAudioPlaying.value
                                ? Icon(CupertinoIcons.pause, size: 25)
                                : Icon(CupertinoIcons.play, size: 25),
                          ),
                        ),
                        title: Obx(
                          () => LinearProgressIndicator(
                            value: controller.seletedIndex.value == index
                                ? controller.linearValue.value
                                : 0.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(indigoColor),
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(date),
                            Text(time),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            if(controller.isAudioPlaying.value) controller.stopAudio();
                           
                          },
                          child: CircleAvatar(
                            backgroundColor: indigoColor,
                            child: Icon(
                              Icons.music_note_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
