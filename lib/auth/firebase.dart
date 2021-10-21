import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}