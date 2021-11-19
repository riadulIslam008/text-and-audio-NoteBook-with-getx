import 'package:flutter/material.dart';

class TextFieldArgument {
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLine;

  TextFieldArgument({
    required this.textInputAction,
    required this.textEditingController,
    required this.hintText,
    required this.maxLine,
  });
}
