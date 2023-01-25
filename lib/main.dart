import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
import 'package:nkrv_bible/screen/book_select_screen.dart';
import 'package:nkrv_bible/screen/login_screen.dart';
import 'package:nkrv_bible/screen/main/main_screen.dart';
import 'package:nkrv_bible/screen/splash_screen.dart';

import 'binding/main_binding.dart';

Future main() async {
  await dotenv.load(fileName: 'dev.env');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const BibleApp());
}

class BibleApp extends StatelessWidget {
  const BibleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: '성경',
      debugShowCheckedModeBanner: false,
      // debug, release 라벨 제거
      theme: ThemeData(
        fontFamily: 'NSRound',
        colorScheme: const ColorScheme.light(
          background: Colors.black,
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
            name: '/main',
            page: () => const MainScreen(),
            binding: MainBindings(),
            transition: Transition.fade),
        GetPage(name: '/bible/select', page: () => const BookSelectScreen()),
        GetPage(name: '/bible', page: () => const BibleScreen()),
      ],
    );
  }
}
