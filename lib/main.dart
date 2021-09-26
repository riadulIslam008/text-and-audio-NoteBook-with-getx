import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/MyApp/Controller/Binding/Bindings.dart';
import 'package:todo_app/MyApp/View/HomeView.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // await LocalDatabase.database();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      theme: ThemeData(
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      home: HomeView(),
    );
  }
}
