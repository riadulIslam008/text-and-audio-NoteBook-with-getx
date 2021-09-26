import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';
import 'package:todo_app/MyApp/utils/Colors.dart';
import 'package:todo_app/MyApp/utils/UniversalVeriable.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
  }) : super(key: key);

  static const Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textInputAction: TextInputAction.next,
                  controller: controller.titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: textFieldStyle,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: whiteColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: whiteColor, width: 1),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.titleListening
                      ? controller.stop()
                      : controller.titleSpeechToText();
                },
                icon: controller.titleListening
                    ? Icon(Icons.mic, color: _color)
                    : Icon(Icons.mic_off, color: _color),
              ),
            ],
          );
        });
  }
}
