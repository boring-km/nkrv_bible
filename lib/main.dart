import 'package:flutter/material.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
import 'package:nkrv_bible/screen/intro_screen.dart';
import 'package:nkrv_bible/screen/login_screen.dart';
import 'package:nkrv_bible/screen/main_screen.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() {
  KakaoContext.clientId = "b17b8b41f1eed93570aaf9e64f53ded8";
  KakaoContext.javascriptClientId = "b7b85e862024c88423792cfb8d0ada4b";
  runApp(BibleApp());
}

class BibleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '성경',
      debugShowCheckedModeBanner: false,  // debug, release 라벨 제거
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IntroScreen(),
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/bible': (context) => BibleScreen()
      },
    );
  }
}
