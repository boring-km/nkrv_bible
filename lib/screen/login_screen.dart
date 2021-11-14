import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDialogVisible = false; // 다이얼로그 visible
  final Logger logger = Logger();
  late String callbackURL;

  @override
  void initState() {
    callbackURL = dotenv.env['OAUTH_CALLBACK_URL']!;
    super.initState();
  }

  void _onLoading() {
    setState(() {
      _isDialogVisible = true;
    });
  }

  void _signGuest() {
    _onLoading();

    FirebaseAuth.instance.signInAnonymously();
  }

  void signInWithGoogle() async {
    _onLoading();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final credential = await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name');
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
    final credential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name');
    } else {
      logger.e('로그인 실패');
      setState(() {
        _isDialogVisible = false;
      });
    }
  }

  void signInWithKaKao() async {
    _onLoading();

    final clientState = const Uuid().v4();
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': dotenv.env['KAKAO_KAUTH_CLIENT_ID'],
      'response_mode': 'form_post',
      'redirect_uri':
      '$callbackURL/callbacks/kakao/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "webauthcallback");
    final body = Uri.parse(result).queryParameters;
    logger.d(body["code"]);

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
      'grant_type': 'authorization_code',
      'client_id': dotenv.env['KAKAO_KAUTH_CLIENT_ID'],
      'redirect_uri':
      '$callbackURL/callbacks/kakao/sign_in',
      'code': body["code"],
    });
    var responseTokens = await http.post(Uri.parse(tokenUrl.toString()));
    Map<String, dynamic> bodyMap = json.decode(responseTokens.body);
    var response = await http.post(
        Uri.parse(
            '$callbackURL/callbacks/kakao/token'),
        body: {"accessToken": bodyMap['access_token']});
    final credential = await FirebaseAuth.instance.signInWithCustomToken(response.body);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name');
    } else {
      logger.e('로그인 실패');
      setState(() {
        _isDialogVisible = false;
      });
    }
  }

  void signInWithNaver() async {
    _onLoading();

    final clientState = const Uuid().v4();
    final url = Uri.https('nid.naver.com', '/oauth2.0/authorize', {
      'response_type': 'code',
      'client_id': dotenv.env['NAVER_CLIENT_ID'],
      'redirect_uri':
      '$callbackURL/callbacks/naver/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "webauthcallback");
    final body = Uri.parse(result).queryParameters;

    final tokenUrl = Uri.https('nid.naver.com', '/oauth2.0/token', {
      'grant_type': 'authorization_code',
      'client_id': dotenv.env['NAVER_CLIENT_ID'],
      'client_secret': dotenv.env['NAVER_CLIENT_SECRET'],
      'code': body["code"],
      'state': clientState,
    });
    var responseTokens = await http.post(Uri.parse(tokenUrl.toString()));
    Map<String, dynamic> bodys = json.decode(responseTokens.body);
    var response = await http.post(
        Uri.parse(
            "$callbackURL/callbacks/naver/token"),
        body: {"accessToken": bodys['access_token']});
    final credential = await FirebaseAuth.instance.signInWithCustomToken(response.body);
    final user = credential.user;
    if (user != null) {
      final token = await user.getIdToken(false);
      final name = user.displayName;
      Get.offAllNamed('/main?token=$token&name=$name');
    } else {
      logger.e('로그인 실패');
      setState(() {
        _isDialogVisible = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child:
          !_isDialogVisible ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildElevatedButton(
                    signInWithGoogle, "assets/icon/icon_google.png", "구글 로그인", const Color(0xffffffff), Colors.black54
                ),
                buildElevatedButton(
                    signInWithFacebook, "assets/icon/icon_facebook.png", "페이스북 로그인", const Color(0xff3B5998), Colors.white
                ),
                // 테스트 모드에선 오류 발생 - 이메일 필수 동의가 아니기 때문에 정식 출시 시 이메일 필수 동의하기.
                // buildElevatedButton(
                //     signInWithKaKao, "assets/icon/icon_kakao.png", "카카오 로그인", const Color(0xffFEE500), Colors.black87
                // ),
                // buildElevatedButton(
                //     signInWithNaver, "assets/icon/icon_naver.png", "네이버 로그인", const Color(0xff1DC800), Colors.white
                // ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("또는"),
                ),
                buildElevatedButton(
                    _signGuest, "assets/icon/icon_guest.png", "게스트로 이용", const Color(0xffDCDCDC), Colors.black87
                ),
              ],
            ),
          ) : const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
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