import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
import 'package:nkrv_bible/screen/book_select_screen.dart';
import 'package:nkrv_bible/screen/login_screen.dart';
import 'package:nkrv_bible/screen/main_screen.dart';
import 'app.dart';

void main() {
  KakaoContext.clientId = "b17b8b41f1eed93570aaf9e64f53ded8";
  KakaoContext.javascriptClientId = "b7b85e862024c88423792cfb8d0ada4b";
  runApp(const BibleApp());
}

class BibleApp extends StatelessWidget {

  const BibleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '성경',
      debugShowCheckedModeBanner: false,  // debug, release 라벨 제거
      theme: ThemeData(
        fontFamily: 'NSRound',
        backgroundColor: Colors.black,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/bible/select', page: () => const BookSelectScreen()),
        GetPage(name: '/bible', page: () => const BibleScreen()),
      ],
    );
  }
}
