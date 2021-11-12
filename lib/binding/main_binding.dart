import 'package:get/get.dart';
import 'package:nkrv_bible/controller/main_controller.dart';

class MainBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.put(MainController());
  }

}