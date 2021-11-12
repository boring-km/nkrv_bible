import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/provider/main_provider.dart';

class MainController extends GetxController {

  late Logger _logger;
  final MainProvider _bibleProvider = Get.put(MainProvider());
  var token = ''.obs;
  var name = ''.obs;
  late Rx userStatus = UserStatus.NONE.obs;

  @override
  void onInit() {
    _logger = Logger();
    setStatus();
    super.onInit();
  }

  setStatus() async {
    await Future.delayed(Duration(milliseconds: 800), () {
      token = _bibleProvider.token;
      name = _bibleProvider.name;
      userStatus = _bibleProvider.userStatus;
    });
  }

}