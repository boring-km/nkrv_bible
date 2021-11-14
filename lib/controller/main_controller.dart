import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {

  late Logger _logger;
  late String token;
  late String name;
  late bool isGuest;

  @override
  void onInit() {
    _logger = Logger();
    token = Get.parameters['token']!;
    name = Get.parameters['name']!;
    isGuest = Get.parameters['guest']! == 'true';
    _logger.i('token: $token, name: $name');
    super.onInit();
  }

}