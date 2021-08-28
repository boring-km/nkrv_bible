import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/bible': (context) => const BibleScreen()
      },
    );
  }
}
