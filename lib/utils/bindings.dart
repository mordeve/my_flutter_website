import 'package:esmabatu/controllers/main_controller.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
