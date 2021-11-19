import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/Core/utils/Screen_hight.dart';
import 'package:todo_app/App/presentation/HomePageView/widget/DescriptionTextField.dart';
import 'package:todo_app/App/presentation/HomePageView/widget/TitleTextField.dart';
import 'package:todo_app/App/Core/utils/Colors.dart';

final TextStyle titleStyle = TextStyle(
  color: whiteColor,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

void bottomSheet(
    {required String headerName,
    required String buttonName,
    required VoidCallback onPressed,
    String? titleText,
    String? descriptionText,
    int? index}) {
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
            onPressed: onPressed,
            child: Text(buttonName, style: titleStyle),
          ),
          SizedBox(height: 30),
        ],
      ),
    ),
  );
}
