import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/Core/Arguments.dart/Text_Field_Arguments.dart';
import 'package:todo_app/App/Core/widgets/Text_Field.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';

class DescriptionTextField extends GetWidget<HomeController> {
  const DescriptionTextField({Key? key}) : super(key: key);

  static const Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => CustomeTextField(
            textFieldArgument: TextFieldArgument(
              hintText: "Description",
              textInputAction: TextInputAction.newline,
              maxLine: 3,
              textEditingController: controller.descriptionController.value,
            ),
          ),
        ),
        Obx(
          () => IconButton(
            onPressed: () {
              controller.titleListening.value = false;
              controller.descriptionListening.value =
                  !controller.descriptionListening.value;

              controller.descriptionListening.value
                  ? controller.descriptionSpeechToText()
                  : controller.stop();
            },
            icon: controller.descriptionListening.value
                ? Icon(Icons.mic, color: _color)
                : Icon(Icons.mic_off, color: _color),
          ),
        ),
      ],
    );
  }
}
