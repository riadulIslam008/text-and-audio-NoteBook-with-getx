import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';
import 'package:todo_app/MyApp/View/widget/AudioNotes.dart';
import 'package:todo_app/MyApp/View/widget/SwiperCard.dart';
import 'package:todo_app/MyApp/utils/Colors.dart';
import 'package:todo_app/MyApp/utils/UniversalVeriable.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return FloatingActionButton(
                heroTag: null,
                backgroundColor:
                    controller.recorderColor ? indigoColor : whiteColor,
                tooltip: "Audio Recorder",
                onPressed: () {
                  controller.recodingButton();
                },
                child: Icon(
                  CupertinoIcons.mic,
                  size: 30,
                  color: controller.recorderColor ? whiteColor : indigoColor,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: null,
            tooltip: "Open Bottom Model",
            onPressed: () {
              controller.displaybottomSheet(
                  headerName: "Add notes", buttonName: "Save Notes");
            },
            child: Icon(CupertinoIcons.add),
            backgroundColor: indigoColor,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                color: indigoColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Notes",
                        style: notesStyle,
                      ),
                    ),
                  ],
                ),
              ),
              AudioNotes()
            ],
          ),
          SwipperCard(),
        ],
      ),
    );
  }
}
