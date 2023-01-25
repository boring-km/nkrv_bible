import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/utils/screen_util.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDialogVisible = false; // 다이얼로그 visible
  final Logger logger = Logger();

  void _onLoading() {
    setState(() {
      _isDialogVisible = true;
    });
  }

  void _signGuest() async {
    _onLoading();

    final credential = await FirebaseAuth.instance.signInAnonymously();
    final user = credential.user;
    if (user != null) {
      const token = '';
      const name = '게스트';
      Get.offAllNamed('/main?token=$token&name=$name&guest=true');
    } else {
      logger.e('로그인 실패');
      setState(() {
        _isDialogVisible = false;
      });
    }
  }

  void signInWithGoogle() async {
    _onLoading();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final credential =
        await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name&guest=false');
    }
  }

  void signInWithFacebook() async {
    _onLoading();

    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    final credential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name&guest=false');
    } else {
      logger.e('로그인 실패');
      setState(() {
        _isDialogVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setLightStatusBarIcon();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: !_isDialogVisible
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton(
                        signInWithGoogle,
                        "assets/icon/icon_google.png",
                        "구글 로그인",
                        const Color(0xffffffff),
                        Colors.black54),
                    buildElevatedButton(
                        signInWithFacebook,
                        "assets/icon/icon_facebook.png",
                        "페이스북 로그인",
                        const Color(0xff3B5998),
                        Colors.white),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("또는"),
                    ),
                    buildElevatedButton(
                        _signGuest,
                        "assets/icon/icon_guest.png",
                        "게스트로 이용",
                        const Color(0xffDCDCDC),
                        Colors.black87),
                  ],
                ),
              )
            : const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                ),
              ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(Function() portal, String imgSrc,
      String text, Color bgColor, Color textColor) {
    return ElevatedButton.icon(
      onPressed: portal,
      icon: Image.asset(
        imgSrc,
        height: 18,
      ),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: bgColor,
        fixedSize: const Size(280, 40),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
