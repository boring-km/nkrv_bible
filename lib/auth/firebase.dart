import 'package:firebase_auth/firebase_auth.dart';
import 'package:nkrv_bible/screen/login_screen.dart';

class Auth {
  static Future <LoginScreen> signOut() async {
    await FirebaseAuth.instance.signOut();
    return LoginScreen();
  }
}