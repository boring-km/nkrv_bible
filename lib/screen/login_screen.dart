import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nkrv_bible/screen/main_screen.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _isDialogVisible = false; // 다이얼로그 visible

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircularProgressIndicator(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("로그인 중..."),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
      Navigator.pop(context); //pop dialog
      // _login();
    });
  }

  void _signGuest() {
    _onLoading();
    FirebaseAuth.instance.signInAnonymously();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    _onLoading();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildElevatedButton(
                    signInWithGoogle, "assets/icon/icon_google.png", "구글 로그인", const Color(0xffffffff), Colors.black54
                ),
                ElevatedButton(onPressed: () {
                  Get.to(MainScreen());
                }, child: const Text("메인화면으로 이동")),
                Visibility(
                    visible: _isDialogVisible,
                    child: Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(Function() portal, String imgSrc, String text, Color bgColor, Color textColor) {
    return ElevatedButton.icon(
      onPressed: portal,
      icon: Image.asset(
        imgSrc,
        height: 18,
      ),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(280, 40),
        primary: bgColor,
        onPrimary: textColor,
        textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}