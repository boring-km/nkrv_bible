import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MainProvider extends GetConnect {

  late Logger _logger;
  var token = "".obs;
  var name = "".obs;
  var userStatus = UserStatus.NONE.obs;

  @override
  Future<void> onInit() async {
    _logger = Logger();
    await _getUser();
    super.onInit();
  }

  _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      userStatus = UserStatus.NONE.obs;
      _logger.i("로그인 된 유저 없음");
    } else if (user.displayName == null || user.displayName == "") {
      userStatus = UserStatus.GUEST.obs;
      _logger.i("게스트 로그인");
    } else {
      token = (await user.getIdToken()).obs;
      userStatus = UserStatus.USER.obs;
      name = (user.displayName != null ? user.displayName! : "").obs;
      _logger.i("로그인한 유저 : $name");
    }
  }

  void withToken(String token) {
    httpClient.addAuthenticator<Object?>((request) async {
      request.headers['x-access-token'] = token;
      return request;
    });
  }
}

enum UserStatus {
  NONE, GUEST, USER
}