import 'package:permission_handler/permission_handler.dart';

permission() async {
  await Permission.microphone.request();
  await Permission.storage.request();
  await Permission.manageExternalStorage.request();
}
