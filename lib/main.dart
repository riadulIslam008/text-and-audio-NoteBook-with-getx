import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/App/theme/Theme_Data.dart';
import 'package:todo_app/di/Binding.dart';
import 'App/presentation/HomePageView/Home_View.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: textTheme,
      ),
      initialBinding: Binding(),
      home: HomeView(),
    );
  }
}
