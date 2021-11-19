import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/Core/Arguments.dart/Text_Field_Arguments.dart';
import 'package:todo_app/App/Core/widgets/Text_Field.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';

class TitleTextField extends GetWidget<HomeController> {
  const TitleTextField({
    Key? key,
  }) : super(key: key);

  static const Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => CustomeTextField(
            textFieldArgument: TextFieldArgument(
              hintText: "Title",
              textInputAction: TextInputAction.next,
              maxLine: 1,
              textEditingController: controller.titleController.value,
            ),
          ),
        ),
        Obx(
          () => IconButton(
            onPressed: () {
              controller.descriptionListening.value = false;
              controller.titleListening.value =
                  !controller.titleListening.value;
              controller.titleListening.value
                  ? controller.titleSpeechToText()
                  : controller.stop();
            },
            icon: controller.titleListening.value
                ? Icon(Icons.mic, color: _color)
                : Icon(Icons.mic_off, color: _color),
          ),
        ),
      ],
    );
  }
}
