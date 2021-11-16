import 'package:get/get.dart';
import 'package:nkrv_bible/controller/bible_controller.dart';

class BibleBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(BibleController());
  }

}