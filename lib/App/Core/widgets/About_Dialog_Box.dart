//? ================= Packages ========================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//? ================ Colors Util, Button Utils, main page====
import 'package:todo_app/App/Core/utils/Colors.dart';
import 'package:todo_app/App/Core/widgets/Button_Widget.dart';

//* Utils File

//* Button Widget

void aboutDialogBox({required String description}) {
  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  Get.defaultDialog(
    barrierDismissible: false,
    title: "Todo App",
    titleStyle: textStyle,
    backgroundColor: indigoColor,
    radius: 8,
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(description,
                textAlign: TextAlign.center, style: textStyle),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonWidget(
                buttonText: "Okey",
                buttonStyle: textStyle,
                buttonWidth: 80,
                onPressed: () {
                  Get.back();
                },
              ),
              // ButtonWidget(
              //   buttonText: "FeedBack",
              //   buttonStyle: textStyle,
              //   onPressed: () {
              //     Get.back();
              //     Wiredash.of(MyApp.navigatorKey.currentContext!)!.show();
              //   },
              //   buttonWidth: 115,
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}
