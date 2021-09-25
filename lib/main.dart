import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
import 'package:nkrv_bible/screen/book_select_screen.dart';
import 'package:nkrv_bible/screen/intro_screen.dart';
import 'package:nkrv_bible/screen/login_screen.dart';
import 'package:nkrv_bible/screen/main_screen.dart';

void main() {
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
        GetPage(name: '/', page: () => IntroScreen(), transition: Transition.fade),
        GetPage(name: '/login', page: () => const LoginScreen(), transition: Transition.fade),
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/bible/select', page: () => const BookSelectScreen()),
        GetPage(name: '/bible', page: () => const BibleScreen()),
      ],
    );
  }
}
