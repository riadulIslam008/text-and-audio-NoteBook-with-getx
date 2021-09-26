import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/MyApp/utils/Colors.dart';

final screenHeight = Get.height;
final screenWidth = Get.width;


 //
 // ─── TEXT STYLE ─────────────────────────────────────────────────────────────────
 //
final TextStyle notesStyle = TextStyle(
  color: whiteColor,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final TextStyle audioNotesText = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

final TextStyle dateStyle = TextStyle(
  color: whiteColor,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

final TextStyle titleStyle = TextStyle(
  color: whiteColor,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

final TextStyle descriptionStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: whiteColor,
);

final TextStyle editButtonStyle = TextStyle(
  color: whiteColor,
  fontSize: 10,
  fontWeight: FontWeight.bold,
);
final TextStyle textFieldStyle = TextStyle(
  color: Colors.grey,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
