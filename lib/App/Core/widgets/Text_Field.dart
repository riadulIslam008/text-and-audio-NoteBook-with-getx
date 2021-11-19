import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/Core/Arguments.dart/Text_Field_Arguments.dart';
import 'package:todo_app/App/presentation/HomePageView/Home_Controller.dart';
import 'package:todo_app/App/Core/utils/Colors.dart';

class CustomeTextField extends GetWidget<HomeController> {
  final TextFieldArgument textFieldArgument;
  const CustomeTextField({Key? key, required this.textFieldArgument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        textInputAction: textFieldArgument.textInputAction,
        controller: textFieldArgument.textEditingController,
        maxLines: textFieldArgument.maxLine,
        decoration: InputDecoration(
          hintText: textFieldArgument.hintText,
          hintStyle: Theme.of(context).textTheme.subtitle2,
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
    );
  }
}
