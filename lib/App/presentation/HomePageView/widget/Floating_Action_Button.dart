import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';
import 'package:todo_app/App/Core/utils/Colors.dart';

class FloatingButton extends GetWidget<HomeController> {
 const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(
          () => FloatingActionButton(
            tooltip: "Recording Start...",
            heroTag: null,
            backgroundColor:
                controller.recorderColor.value ? indigoColor : whiteColor,
            onPressed: () {
             
              controller.recodingButton();
            },
            child: Icon(
              CupertinoIcons.mic,
              size: 30,
              color:
                  controller.recorderColor.value ? whiteColor : indigoColor,
            ),
          ),
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
    );
  }
}
