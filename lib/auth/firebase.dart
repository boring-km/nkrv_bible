import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/screen/login_screen.dart';

class Auth {
  static void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }
}