import 'package:get/get.dart';
import 'package:todo_app/MyApp/Controller/HomeController.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
